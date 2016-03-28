/*
 * riscv-simulator: A simulator for RISCV, supporing RV32I now
 * simulator -- Main file of the simulator
 *
 * Yangcheng Luo	<lyc.eecs@pku.edu.cn>
 * Haoze Wu		<wuhaoze@mprc.pku.edu.cn>
 *
 * Copyright (C) 2014-2015 Microprocessor R&D Center (MPRC), Peking University
 */
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

static void exec_prog(Elf32_Addr main_entry);
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



static void exec_prog(Elf32_Addr main_entry)
{
	uint32_t cmd = 0;
	uint32_t opcode = 0;
		
#ifdef DEBUG_EXECUTION
	printf("\n\nContent of Execution\n\n");
#endif

#ifdef DEBUG
	single_step = true;	
#endif

	PC = main_entry;
		
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
			case JAL: jal(cmd); continue;
			case JALR: jalr(cmd); continue;
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

			case SCALL:
			{
				if (scall() == 0)
				{
					#ifdef DEBUG_EXECUTION
					printf("\nExecution end.\n");
					#endif

					#ifdef DEBUG_CONTENT
					print_reg();
					print_mem_data();
					#endif

					return;
				}

				break;
			}

			case UIMP:
			{
				printf("Encountered unimplemented instruction: 0x%x\n", cmd);
				exit(EXIT_FAILURE);
			}
			case ILL: 
			{
				printf("Illegal instruction: 0x%x\n", cmd);
				exit(EXIT_FAILURE);
			}
		}
		#ifdef DEBUG_MEMORY
			print_mem();
		#endif

		PC += 4;
	}

	
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
		case 0xf: inst_type = UIMP; break;
		case 0x73:
		{
			if ((single_inst & 0xffffff80) == 0)
			{
				inst_type = SCALL;
				break;
			}
			else
			{
				inst_type = UIMP;
				break;
			}
		}
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
				
			map<uint32_t, uint8_t>::iterator iter;
			iter = mem.find(addr);
			if ((addr != 0) && (iter != mem.end()))
			{
				printf("%s: %x\n", token, addr);
				breakpoints.insert(addr);
				return;

			}
			else if (get_func_addr(token))
			{
				printf("%s: %x\n", token, get_func_addr(token));
				breakpoints.insert(get_func_addr(token));
				return;
			}
			else
			{
				printf("Wrong use of breakpoint, please see help.\n");
				continue;
			}
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
		//TODO
		printf("Access address not in the memory.\n");
		return 0;
		//exit(EXIT_FAILURE);
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
