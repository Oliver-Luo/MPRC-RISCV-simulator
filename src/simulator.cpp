/*
 * riscv-simulator: A simulator for RISCV, supporing RV32I now
 * simulator -- Main file of the simulator
 *
 * Yangcheng Luo	<lyc.eecs@pku.edu.cn>
 * Haoze Wu		<wuhaoze@mprc.pku.edu.cn>
 *
 * Copyright (C) 2014-2015 Microprocessor R&D Center (MPRC), Peking University
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <map>
#include <set>

#include "simulator.h"
#include "elf_format.h"
#include "riscv_inst.h"

using namespace std;

#define ERROR -1

#define	BUFFSIZE 1024
#define	REGSIZE	32

uint32_t reg[REGSIZE];
Elf32_Addr PC;
map<Elf32_Addr, uint8_t> mem;
set<uint32_t> breakpoints;

static bool single_step;

uint8_t retrieve_or_error(uint32_t addr);

static Elf32_Addr read_elf(FILE *file);
static Elf32_Ehdr read_elf_header(FILE *file);
static Elf32_Phdr* read_prog_headers(FILE *file, Elf32_Ehdr elf_header);
static Elf32_Shdr* read_sec_headers(FILE *file, Elf32_Ehdr elf_header);
static void load_data(FILE *file, Elf32_Shdr *sec_hdrs, int data_index);
static void load_prog(FILE *file, Elf32_Phdr *prog_hdrs, int pnum);
static void exec_prog(Elf32_Addr main_entry);
static int init_reg(FILE *file, Elf32_Ehdr elf_header, Elf32_Shdr *sec_hdrs, int snum);
static unsigned int decode(unsigned int single_inst);
static uint32_t fetch(uint32_t pc);
static void debug(uint32_t pc, uint32_t cmd);
static void print_reg(void);
static void print_mem(void);

int main(int argc, char const *argv[])
{


	FILE *file = NULL;
	Elf32_Addr main_entry = 0;

	if (argc < 2)
	{
		printf("Usage: %s filename\n",argv[0]);
		return ERROR;
	}
	
	if ((file = fopen(argv[1], "r")) == NULL)
	{
		printf("fopen error\n");
		return ERROR;
	}

	main_entry = read_elf(file);
	exec_prog(main_entry);

#ifdef DEBUG_MEMORY
	print_mem();
#endif

	return 0;
}

static Elf32_Addr read_elf(FILE *file)
{
	Elf32_Ehdr elf_header;
	Elf32_Phdr *prog_hdrs;
	Elf32_Shdr *sec_hdrs;
	int data_index = -1;

	elf_header = read_elf_header(file);
	prog_hdrs = read_prog_headers(file, elf_header);
	sec_hdrs = read_sec_headers(file, elf_header);
	data_index = init_reg(file, elf_header, sec_hdrs, elf_header.e_shnum);
	if(data_index != -1)
		load_data(file, sec_hdrs, data_index);

	load_prog(file, prog_hdrs, elf_header.e_phnum);

	return elf_header.e_entry;
}

static Elf32_Ehdr read_elf_header(FILE *file)
{
	int i = 0;
	Elf32_Ehdr elf_header;

	(void)fread(&elf_header, sizeof(elf_header), 1, file);
	if (ferror(file))
	{
		printf("Error while reading ELF header.\n");
		exit(EXIT_FAILURE);
	}

#ifdef DEBUG_HEADER
	printf("\n\nContent of ELF header:\n\ne_ident:\n\t");
	for (i = 0; i < EI_NIDENT; i++)
		printf("0x%x  ",elf_header.e_ident[i]);
	printf("\n");
	printf("e_type:\t\t%d\n", elf_header.e_type);
	if (elf_header.e_machine == 243)
		printf("e_machine:\tRISC-V\n");
	else
		printf("e_machine:\t%d\n", elf_header.e_machine);
	printf("e_version:\t%d\n", elf_header.e_version);
	printf("e_entry:\t0x%x\n", elf_header.e_entry);
	printf("e_phoff:\t%d\n", elf_header.e_phoff);
	printf("e_shoff:\t%d\n", elf_header.e_shoff);
	printf("e_flags:\t0x%x\n", elf_header.e_flags);
	printf("e_ehsize:\t%d\n", elf_header.e_ehsize);
	printf("e_phentsize:\t%d\n", elf_header.e_phentsize);
	printf("e_phnum:\t%d\n", elf_header.e_phnum);
	printf("e_shentsize:\t%d\n", elf_header.e_shentsize);
	printf("e_shnum:\t%d\n", elf_header.e_shnum);
	printf("e_shstrndx:\t%d\n", elf_header.e_shstrndx);
#endif

	return elf_header;
}

static Elf32_Phdr* read_prog_headers(FILE *file, Elf32_Ehdr elf_header)
{
	Elf32_Phdr *prog_headers = new Elf32_Phdr[elf_header.e_phnum];

	fseek(file,elf_header.e_phoff ,SEEK_SET);
	fread(prog_headers, sizeof(Elf32_Phdr), elf_header.e_phnum, file);

#ifdef DEBUG_HEADER

	for (int i = 0; i < elf_header.e_phnum; ++i)
	{
		printf("\n\nContent of Program header %d\n\n", i);
		printf("p_type:\t\t%x\n", prog_headers[i].p_type);
		printf("p_offset:\t%d\n", prog_headers[i].p_offset);
		printf("p_vaddr:\t0x%x\n", prog_headers[i].p_vaddr);
		printf("p_filesz:\t%d\n", prog_headers[i].p_filesz);
		printf("p_memsz:\t%d\n", prog_headers[i].p_memsz);
		printf("p_flags:\t%x\n", prog_headers[i].p_flags);
		printf("p_align:\t%d\n", prog_headers[i].p_align);
	}

#endif

	return prog_headers;
}

static Elf32_Shdr* read_sec_headers(FILE *file, Elf32_Ehdr elf_header)
{
	Elf32_Shdr *sec_headers = new Elf32_Shdr[elf_header.e_shnum];
	fseek(file, elf_header.e_shoff, SEEK_SET);
	fread(sec_headers, sizeof(Elf32_Shdr), elf_header.e_shnum, file);

#ifdef DEBUG_HEADER
	for (int i = 0; i < elf_header.e_shnum ; ++i)
	{
		printf("\n\nContent of section header %d\n\n", i);
		printf("sh_name:\t%x\n", sec_headers[i].sh_name);
		printf("sh_type:\t%x\n", sec_headers[i].sh_type);
		printf("sh_flags:\t%x\n", sec_headers[i].sh_flags);
		printf("sh_addr:\t%x\n", sec_headers[i].sh_addr);
		printf("sh_offset:\t%x\n", sec_headers[i].sh_offset);
		printf("sh_size:\t%x\n", sec_headers[i].sh_size);
		printf("sh_link:\t%x\n", sec_headers[i].sh_link);
		printf("sh_info:\t%x\n", sec_headers[i].sh_info);
		printf("sh_addralign:\t%x\n", sec_headers[i].sh_addralign);
		printf("sh_entsize:\t%x\n", sec_headers[i].sh_entsize);
	}
#endif

	return sec_headers;
}

static void load_prog(FILE *file, Elf32_Phdr *prog_hdrs, int pnum)
{
	Elf32_Addr cur_addr;
	uint8_t cur_inst;

	for (int i = 0; i < pnum; ++i)
	{
		fseek(file, prog_hdrs[i].p_offset, SEEK_SET);
		cur_addr = prog_hdrs[i].p_vaddr;
		for (int j = 0; j < prog_hdrs[i].p_filesz; j++)
		{
			fread(&cur_inst, sizeof(char), 1, file);
			mem.insert(pair<uint32_t, uint8_t>(cur_addr, cur_inst));
			cur_addr ++;
			/* code */
		}
	}

#ifdef DEBUG_MEMORY
	print_mem();
#endif
}

static void load_data(FILE *file, Elf32_Shdr *sec_hdrs, int data_index)
{
	uint32_t offset_from_file = sec_hdrs[data_index].sh_offset;
	uint32_t size = sec_hdrs[data_index].sh_size;
	Elf32_Addr start_vaddr = sec_hdrs[data_index].sh_addr;
	uint8_t	 cur_data;

	Elf32_Addr cur_addr = start_vaddr;
	fseek(file, offset_from_file, SEEK_SET);

	for (int i = 0; i < size; ++i)
	{
		fread(&cur_data, sizeof(char), 1, file);
		mem.insert(pair<uint32_t, uint8_t>(cur_addr, cur_data));
		cur_addr++;
	}
}	

static void exec_prog(Elf32_Addr main_entry)
{
	uint32_t cmd = 0;
	uint32_t opcode = 0;
	uint32_t func_stack = 1;
		
#ifdef DEBUG_EXECUTION
	printf("\n\nContent of Execution\n\n");
#endif

	#ifdef DEBUG
		single_step = true;	
	#endif
		
	while(true)
	{
		cmd = fetch(PC);

		set<uint32_t>::iterator breakpoints_iter;
		breakpoints_iter = breakpoints.find(PC);
		if ((single_step) || (breakpoints_iter != breakpoints.end()))
			debug(PC, cmd);

		opcode = decode(cmd);

		reg[0] = 0; //Make sure x0 = 0 after every execution.

		switch(opcode)
		{
			//TODO finish execute	
			case LUI: lui(cmd); break;
			case AUIPC: auipc(cmd); break;
			case JAL:
			{
				//If it is j instead of jal, then this is not a call
				if (((cmd >> 7) & 0x1f) != 0)
					func_stack++;
				jal(cmd);
				continue;
			}
			case JALR: 
			{
				func_stack--;

				if (func_stack == 0)
				{
					#ifdef DEBUG_EXECUTION
					printf("\nMain function end.\n");
					#endif

					#ifdef DEBUG_REGISTER
					print_reg();
					#endif

					return;
				}
				jalr(cmd);
				continue;
			}
			case BEQ: beq(cmd); continue;
			case BNE: bne(cmd); continue;
			case BLT: blt(cmd); continue;
			case BGE: bge(cmd); continue;
			case BLTU: bltu(cmd); continue;
			case BGEU: bgeu(cmd); continue;
			case LB: lb(cmd); break;
			case LH: lh(cmd); break;
			case LW: lw(cmd); break;
			case LBU: lbu(cmd); break;
			case LHU: lhu(cmd); break;
			case SB: sb(cmd); break;
			case SH: sh(cmd); break;
			case SW: sw(cmd); break;
			case ADDI: addi(cmd); break;
			case SLTI: slti(cmd); break;
			case SLTIU: sltiu(cmd); break;
			case XORI: xori(cmd); break;
			case ORI: ori(cmd); break;
			case ANDI: andi(cmd); break;
			case SLLI: slli(cmd); break;
			case SRLI: srli(cmd); break;
			case SRAI: srai(cmd); break;
			case ADD: add(cmd); break;
			case SUB: sub(cmd); break;
			case SLL: sll(cmd); break;
			case SLT: slt(cmd); break;
			case SLTU: sltu(cmd); break;
			case XOR: riscv_xor(cmd); break;
			case SRL: srl(cmd); break;
			case SRA: sra(cmd); break;
			case OR: riscv_or(cmd); break;
			case AND: riscv_and(cmd); break;

			case UIMP:
			{
				printf("Encountered unimplemented instruction.\n");
				exit(EXIT_FAILURE);
			}
			case ILL: 
			{
				printf("Illegal instruction.\n");
				exit(EXIT_FAILURE);
			}
		}
		#ifdef DEBUG_MEMORY
			print_mem();
		#endif

		PC += 4;
	}

	
}

static int init_reg(FILE *file, Elf32_Ehdr elf_header, Elf32_Shdr *sec_hdrs, int snum)
{
	int index;
	for (index = 0; index < REGSIZE; index++)
		reg[index] = 0;
	PC = elf_header.e_entry;

	/*the following code is init gp and sp */
	//FIXME sp	
	reg[2] = 20000;

	/* init shstrtab */
	char *sh_str_content = NULL;
	sh_str_content = new char[sec_hdrs[elf_header.e_shstrndx].sh_size];
	fseek(file, sec_hdrs[elf_header.e_shstrndx].sh_offset, SEEK_SET);
	fread(sh_str_content, sizeof(char), sec_hdrs[elf_header.e_shstrndx].sh_size, file);

	int index_strtab = -1;
	int index_symtab = -1;
	int sym_num = -1;
	char *str_content = NULL;
	for (int i = 0; i < snum; ++i)
	{
		if(strcmp(".strtab",& sh_str_content[sec_hdrs[i].sh_name])==0)
			index_strtab = i;
		else if(sec_hdrs[i].sh_type == SHT_SYMTAB)
			index_symtab = i;
		else
			continue;
	}

	//FIXME
	if( index_symtab == -1 | index_strtab == -1)
	{
		printf("Cannot find systab or strtab!\n");
		exit(EXIT_FAILURE);
	}

	/*init string table */
	str_content = new char[sec_hdrs[index_strtab].sh_size];
	fseek(file, sec_hdrs[index_strtab].sh_offset, SEEK_SET);
	fread(str_content, sizeof(char), sec_hdrs[index_strtab].sh_size, file);

	/* init symbol table*/
	sym_num = sec_hdrs[index_symtab].sh_size/sec_hdrs[index_symtab].sh_entsize;
	Elf32_Sym *symbol_table = new Elf32_Sym[sym_num];
	fseek(file, sec_hdrs[index_symtab].sh_offset, SEEK_SET);
	fread(symbol_table, sizeof(Elf32_Sym), sym_num, file);

	/* init gp register */

	for (int i = 0; i < sym_num; ++i)
	{
#ifdef DEBUG_HEADER
		printf("\n\nContent of symbol table entry %d\n\n", i);	
		printf("st_name:\t%s\n", &str_content[symbol_table[i].st_name]);
		printf("st_value:\t%x\n", symbol_table[i].st_value);
		printf("st_size:\t%x\n", symbol_table[i].st_size);
		printf("st_info:\t%x\n", symbol_table[i].st_info);
		printf("st_other:\t%x\n", symbol_table[i].st_other);
		printf("st_shndx:\t%x\n", symbol_table[i].st_shndx);	
#endif

		if (strcmp("_gp", &str_content[symbol_table[i].st_name]) == 0)
			reg[3] = symbol_table[i].st_value;
	}

	/*find data section*/
	int data_index = -1;
	for (int i = 0; i < snum; ++i)
	{
		if (strcmp(".data", &sh_str_content[sec_hdrs[i].sh_name]) == 0)
		{
			data_index = i;
			break;
		}
	}
	return data_index;
}


static uint32_t fetch(uint32_t pc)
{
	int i = 0;
	uint32_t cmd = 0;
	map<uint32_t, uint8_t>::iterator iter;

	for (i = 0; i < 4; i++)
	{
		cmd |= ((retrieve_or_error(pc++))  << (i * 8));
	}

	return cmd;
}

static unsigned int decode(unsigned int single_inst)
{
	unsigned int inst_type;

	switch (single_inst & 0x7f)
	{
		case 0x37: inst_type = LUI; break;
		case 0x17: inst_type = AUIPC; break;
		case 0x6f: inst_type = JAL; break;
		case 0x67: inst_type = JALR; break;
		case 0x63:
		{
			switch ((single_inst & 0x7000) >> 12)
			{
				case 0x0: inst_type = BEQ; break;
				case 0x1: inst_type = BNE; break;
				case 0x4: inst_type = BLT; break;
				case 0x5: inst_type = BGE; break;
				case 0x6: inst_type = BLTU; break;
				case 0x7: inst_type = BGEU; break;
			}
			break;
		}
		case 0x3:
		{
			switch ((single_inst & 0x7000) >> 12)
			{
				case 0x0: inst_type = LB; break;
				case 0x1: inst_type = LH; break;
				case 0x2: inst_type = LW; break;	
				case 0x4: inst_type = LBU; break;
				case 0x5: inst_type = LHU; break;
			}
			break;
		}
		case 0x23:
		{
			switch ((single_inst & 0x7000) >> 12)
			{
				case 0x0: inst_type = SB; break;
				case 0x1: inst_type = SH; break;
				case 0x2: inst_type = SW; break;
			}
			break;
		}
		case 0x13:
		{
			switch ((single_inst & 0x7000) >> 12)
			{
				case 0x0: inst_type = ADDI; break;
				case 0x2: inst_type = SLTI; break;
				case 0x3: inst_type = SLTIU; break;
				case 0x4: inst_type = XORI; break;
				case 0x6: inst_type = ORI; break;
				case 0x7: inst_type = ANDI; break;
				case 0x1: inst_type = SLLI; break;
				case 0x5: 
				{
					if (!(single_inst & 0x40000000))
						inst_type = SRLI;
					else
						inst_type = SRAI; 
					break;
				}
			}
			break;
		}
		case 0x33:
		{
			switch ((single_inst & 0x7000) >> 12)
			{
				case 0x0:	
				{
					if (!(single_inst & 0x40000000))
						inst_type = ADD;
					else
						inst_type = SUB; 
					break;
				}
				case 0x1: inst_type = SLL; break;
				case 0x2: inst_type = SLT; break;
				case 0x3: inst_type = SLTU; break;
				case 0x4: inst_type = XOR; break;
				case 0x5:
				{
					if (!(single_inst & 0x40000000))
						inst_type = SRL;
					else
						inst_type = SRA; 
					break;
				}
				case 0x6: inst_type = OR; break;
				case 0x7: inst_type = AND; break;
			}
			break;	
		}
		case 0xf:
		case 0x73: inst_type = UIMP; break;
		default: inst_type = ILL; break; 
	}
	
	return inst_type;
}

static void debug(uint32_t pc, uint32_t cmd)
{
	char input[100];
	char *token;
	uint32_t addr;

	set<uint32_t>::iterator breakpoints_iter;
	breakpoints_iter = breakpoints.find(PC);
	if (breakpoints_iter != breakpoints.end())
		printf("Breakpoint reached!\n");

	printf("Please input an action. Input \'h\' for help.\n");
	while(1)
	{	
		(void)fgets(input, 100, stdin);
		token = strtok(input, " \t\n");
	
		if (strcmp(token, "n") == 0)
		{
			single_step = true;
			return;
		}
		else if (strcmp(token, "p") == 0)
			print_reg();
		else if (strcmp(token, "exit") == 0)
			exit(0);
		else if (strcmp(token, "r") == 0)
		{
			single_step = false;
			return;
		}
		else if (strcmp(token, "b") == 0)
		{
			token = strtok(NULL, " \t\n");
			if (strtok == NULL)
				continue;
			addr = strtoll(token, NULL, 16);
			breakpoints.insert(addr);
			return;	
		}
		else if (strcmp(token, "h") == 0)
		{
			printf("help:\n");
			printf("n: next command.\n");
			printf("p: print registers information.\n");
			printf("exit: exit.\n");
			printf("b addr: set a breakpoint.\n");
			printf("r: run until next breakpoint or end of the program.\n");
		}
		else
		{
			printf("Wrong action. Input \'h\' for help.\n");
		}
	}
}

uint8_t retrieve_or_error(uint32_t addr)
{
	map<uint32_t, uint8_t>::iterator iter;
	iter = mem.find(addr);
	if (iter == mem.end())
	{
		printf("Access address not in the memory.\n");
		exit(EXIT_FAILURE);
	}
	
	return iter->second;
}

static void print_reg(void)
{
	int i = 0;

	printf("\n\nContent of Register:\n\n");
	for (i = 0; i < 32; i++)
		printf("Reg[%d] = %d\n", i, reg[i]);
	
	return;
}

static void print_mem(void)
{
	map<uint32_t, uint8_t>::iterator iter;

	printf("\n\nContent of Memory:\n\n");
	for(iter = mem.begin(); iter != mem.end(); iter++)
		printf("addr:%x\tinst:%x\n", iter->first, iter->second);

	return;
}
