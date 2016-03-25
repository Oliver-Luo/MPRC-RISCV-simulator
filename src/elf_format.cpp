#include <stdlib.h>
#include <string.h>
#include <map>
#include <set>

#include "elf_format.h"

using namespace std;

#define	REGSIZE	32

extern uint32_t reg[];
extern uint32_t PC;
extern map<uint32_t, uint8_t> mem;

static Elf32_Ehdr elf_header;
static Elf32_Phdr *prog_hdrs = NULL;
static Elf32_Shdr *sec_hdrs = NULL;
static Elf32_Sym  *symbol_table = NULL;
static char *sh_str_tbl = NULL;
static char *str_tbl = NULL;
static int index_strtab = -1;
static int index_symtab = -1;

static Elf32_Ehdr read_elf_header(FILE *file);
static Elf32_Phdr* read_prog_headers(FILE *file);
static Elf32_Shdr* read_sec_headers(FILE *file);
static Elf32_Sym*  read_sym_tbls(FILE *file);
static int find_data_sec(int begin);
static void load_data(FILE *file, int data_index);
static void load_prog(FILE *file, int pnum);
static void print_mem(void);
static int init_reg(FILE *file);
static void print_as_char(Elf32_Addr start_addr, uint32_t size);
static void print_as_hex(Elf32_Addr start_addr, uint32_t size);

Elf32_Addr get_func_addr(const char *func_name)
{
	if (symbol_table == NULL || str_tbl == NULL || sec_hdrs == NULL)
	{	printf("elf header info not inited!!\n");return 0;}
	
	int sym_num;
	sym_num = sec_hdrs[index_symtab].sh_size/sec_hdrs[index_symtab].sh_entsize;

	for (int i = 0; i < sym_num; ++i)
		if (strcmp(func_name, &str_tbl[symbol_table[i].st_name]) == 0)
			return symbol_table[i].st_value;

	return 0;
}

const char *get_func_name(Elf32_Addr func_addr)
{

	if (symbol_table == NULL || str_tbl == NULL || sec_hdrs == NULL)
	{	printf("elf header info not inited!!\n");	return NULL;   }
	
	int sym_num;
	sym_num = sec_hdrs[index_symtab].sh_size/sec_hdrs[index_symtab].sh_entsize;

	for (int i = 0; i < sym_num; ++i)
		if (ELF32_ST_TYPE(symbol_table[i].st_info) == STT_FUNC && func_addr ==  symbol_table[i].st_value)
			return &str_tbl[symbol_table[i].st_name];

	return NULL;
}

void print_mem_data()
{

	for (int i = 0; i < elf_header.e_shnum; ++i)
	{

		if (strstr(&sh_str_tbl[sec_hdrs[i].sh_name], "data") != NULL ||
			strcmp(&sh_str_tbl[sec_hdrs[i].sh_name], ".bss") == 0)
		{
			printf("\n\n");
			printf("the content of %s, print as char: \n", 
				    &sh_str_tbl[sec_hdrs[i].sh_name]);
			print_as_char(sec_hdrs[i].sh_addr, sec_hdrs[i].sh_size);

			printf("the content of %s, print as hex: \n", 
					&sh_str_tbl[sec_hdrs[i].sh_name]);
			print_as_hex(sec_hdrs[i].sh_addr, sec_hdrs[i].sh_size);
			printf("\n\n");
		}
	}

}

Elf32_Addr read_elf(FILE *file)
{
	int data_index = -1;
	int begin = 0;

	read_elf_header(file);
	read_prog_headers(file);
	read_sec_headers(file);
	read_sym_tbls(file);
	init_reg(file);

	begin = 0;
	while(true)
	{
		data_index = find_data_sec(begin);
		
		if(data_index != -1)
			load_data(file, data_index);
		begin += 1;

		if(begin >= elf_header.e_shnum)
			break;
	}

	load_prog(file, elf_header.e_phnum);

	//return elf_header.e_entry;
	printf("main: %x\n", get_func_addr("main"));
	return get_func_addr("main");
}

static Elf32_Ehdr read_elf_header(FILE *file)
{
	int i = 0;

	(void)fread(&elf_header, sizeof(elf_header), 1, file);
	if (ferror(file))
	{
		printf("Error while reading ELF header.\n");
		exit(EXIT_FAILURE);
	}

#ifdef DEBUG_HEADER
	printf("\n\nContent of ELF header:\ne_ident:\n\t");
	for (i = 0; i < EI_NIDENT; i++)
		printf("0x%x  ",elf_header.e_ident[i]);
	printf("\n");
	printf("%-20s\t\t%d\n", "e_type:", elf_header.e_type);
	if (elf_header.e_machine == 243)
		printf("e_machine:\tRISC-V\n");
	else
		printf("%-20s\t%d\n", "e_machine:", elf_header.e_machine);
	printf("%-20s\t%d\n", "e_version:", elf_header.e_version);
	printf("%-20s\t0x%x\n", "e_entry:", elf_header.e_entry);
	printf("%-20s\t%d\n", "e_phoff:", elf_header.e_phoff);
	printf("%-20s\t%d\n", "e_shoff:", elf_header.e_shoff);
	printf("%-20s\t0x%x\n", "e_flags:", elf_header.e_flags);
	printf("%-20s\t%d\n", "e_ehsize:", elf_header.e_ehsize);
	printf("%-20s\t%d\n", "e_phentsize:", elf_header.e_phentsize);
	printf("%-20s\t%d\n", "e_phnum:", elf_header.e_phnum);
	printf("%-20s\t%d\n", "e_shentsize:", elf_header.e_shentsize);
	printf("%-20s\t%d\n", "e_shnum:", elf_header.e_shnum);
	printf("%-20s\t%d\n", "e_shstrndx:", elf_header.e_shstrndx);
#endif

}

static Elf32_Phdr* read_prog_headers(FILE *file)
{
	prog_hdrs = new Elf32_Phdr[elf_header.e_phnum];

	fseek(file,elf_header.e_phoff ,SEEK_SET);
	fread(prog_hdrs, sizeof(Elf32_Phdr), elf_header.e_phnum, file);

#ifdef DEBUG_HEADER
	if (elf_header.e_phnum > 0)
	{
		printf("\n\nContent of Program header:\n");
		printf("%-10s  %-8s  %-10s  %-10s  %-8s  %-8s  %-3s  %s\n", 
			   "Type", "Offset", "VirtAddr", "PhysAddr", "FileSize", "MemSize", "Flg", "Align");
		for (int i = 0; i < elf_header.e_phnum; ++i)
			printf("%-10x  0x%06x  0x%08x  0x%08x  0x%06x  0x%06x  %-3x  0x%x\n", 
				   prog_hdrs[i].p_type, prog_hdrs[i].p_offset, prog_hdrs[i].p_vaddr,
				   prog_hdrs[i].p_paddr, prog_hdrs[i].p_filesz, prog_hdrs[i].p_memsz,
				   prog_hdrs[i].p_flags, prog_hdrs[i].p_align);
	}
	else
		printf("No prog_header found!!!\n");

#endif
}

static Elf32_Shdr* read_sec_headers(FILE *file)
{

	sec_hdrs = new Elf32_Shdr[elf_header.e_shnum];
	fseek(file, elf_header.e_shoff, SEEK_SET);
	fread(sec_hdrs, sizeof(Elf32_Shdr), elf_header.e_shnum, file);

	sh_str_tbl = new char[sec_hdrs[elf_header.e_shstrndx].sh_size];
	fseek(file, sec_hdrs[elf_header.e_shstrndx].sh_offset, SEEK_SET);
	fread(sh_str_tbl, sizeof(char), sec_hdrs[elf_header.e_shstrndx].sh_size, file);

#ifdef DEBUG_HEADER
	if (elf_header.e_shnum > 0)
	{
		printf("\n\nContent of section header \n");
		printf("%4s  %-20s  %-20s  %-8s  %-6s  %-6s  %2s  %3s  %2s  %3s  %2s\n",
			   "[Nr]", "Name", "Type", "Addr", "Off", "Size", "ES", "Flg", "Lk", "Inf", "Al");
	
		for (int i = 0; i < elf_header.e_shnum ; ++i)
			printf("[%2d]  %-20s  %-20x  %08x  %06x  %06x  %02x  %-3x  %2d  %3d  %2d\n", 
				   i, &sh_str_tbl[sec_hdrs[i].sh_name], sec_hdrs[i].sh_type, sec_hdrs[i].sh_addr,
				   sec_hdrs[i].sh_offset, sec_hdrs[i].sh_size, sec_hdrs[i].sh_entsize,
				   sec_hdrs[i].sh_flags, sec_hdrs[i].sh_link, sec_hdrs[i].sh_info,
				   sec_hdrs[i].sh_addralign);
	
	}
	else
		printf("No sec_header found!!!\n");
#endif
}

static Elf32_Sym* read_sym_tbls(FILE *file)
{
	
	int sym_num = -1;
	int snum = elf_header.e_shnum;

	/* find strtab and symtab index of sec_hdrs */
	for (int i = 0; i < snum; ++i)
	{
		if(strcmp(".strtab", &sh_str_tbl[sec_hdrs[i].sh_name])==0)
			index_strtab = i;
		else if(strcmp(".symtab",&sh_str_tbl[sec_hdrs[i].sh_name]) == 0)
			index_symtab = i;
		else
			continue;
	}

	//FIXME
	if( index_symtab == -1 ||  index_strtab == -1)
	{
		printf("Cannot find systab or strtab!\n");
		exit(EXIT_FAILURE);
	}

	/*init string table */
	str_tbl = new char[sec_hdrs[index_strtab].sh_size];
	fseek(file, sec_hdrs[index_strtab].sh_offset, SEEK_SET);
	fread(str_tbl, sizeof(char), sec_hdrs[index_strtab].sh_size, file);

	/* init symbol table*/
	sym_num = sec_hdrs[index_symtab].sh_size/sec_hdrs[index_symtab].sh_entsize;
	symbol_table = new Elf32_Sym[sym_num];
	fseek(file, sec_hdrs[index_symtab].sh_offset, SEEK_SET);
	fread(symbol_table, sizeof(Elf32_Sym), sym_num, file);
#ifdef DEBUG_HEADER
	printf("\n\nContent of symbol table entry:\n");	
	printf("Num:  %8s  Size  %-10s  %-6s  %-10s  Ndx  Name\n", 
				"Value", "Type", "Bind", "Vis");
	for (int i = 0; i < sym_num; ++i)
		printf("%3d:  %8x  %4d  %-10x  %-6x  %-10x  %3x  %s\n", 
				i, symbol_table[i].st_value, symbol_table[i].st_size, symbol_table[i].st_info,
				symbol_table[i].st_info, symbol_table[i].st_info, symbol_table[i].st_shndx,
				&str_tbl[symbol_table[i].st_name]);
#endif
}

static void load_prog(FILE *file, int pnum)
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
	//FIXME
	// uint8_t tmp = 0;
	// for (int i = 0; i < 4; ++i)
	// {
	// 	mem.insert(pair<uint32_t, uint8_t>(reg[2]+i, tmp));
	// }
#ifdef DEBUG_MEMORY
	print_mem();
#endif
}

static void load_data(FILE *file, int data_index)
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

static int find_data_sec(int begin)
{
	int data_index = -1;
	int snum = elf_header.e_shnum;

	if (begin >= snum)
		return -1;

	for (int i = begin; i < snum; ++i)
		if (strstr(&sh_str_tbl[sec_hdrs[i].sh_name], "data") != NULL)
			{data_index = i;break;}

	return data_index;
}

static int init_reg(FILE *file)
{	
	for (int i = 0; i < REGSIZE; i++)
		reg[i] = 0;

	PC = elf_header.e_entry;

	/*the following code is init gp and sp */
	//FIXME sp	
	reg[2] = 20000;
	
	/* init gp register */
	int sym_num = sec_hdrs[index_symtab].sh_size/sec_hdrs[index_symtab].sh_entsize;

	for (int i = 0; i < sym_num; ++i)
		if (strcmp("_gp", &str_tbl[symbol_table[i].st_name]) == 0)
			{reg[3] = symbol_table[i].st_value;break;}

}

static void print_mem(void)
{
	map<uint32_t, uint8_t>::iterator iter;

	printf("\n\nContent of Memory:\n\n");
	for(iter = mem.begin(); iter != mem.end(); iter++)
		printf("addr:%x\tinst:%x\n", iter->first, iter->second);

	return;
}

static void print_as_char(Elf32_Addr start_addr, uint32_t size)
{
	Elf32_Addr cur_addr = start_addr;
	Elf32_Addr end_addr = start_addr + size;
	Elf32_Addr lim_addr;
	map<uint32_t,uint8_t>::iterator iter;

	while(true)
	{	
		lim_addr = (cur_addr+20 < end_addr)?(cur_addr+20):end_addr;
		
		printf("content from 0x%x to 0x%x\n", cur_addr, lim_addr-1);
		for (int i = cur_addr; i < lim_addr; ++i)
		{
			iter = mem.find(i);
			if (iter != mem.end())
				printf("%c", iter->second);
			else
				printf("in func print_as_char, Cannot find addr %x\n", i);
		}
		printf("\n");

		if(lim_addr < end_addr)
			cur_addr = lim_addr;
		else
			break;
	}

}

static void print_as_hex(Elf32_Addr start_addr, uint32_t size)
{
	uint32_t tmp_out;
	Elf32_Addr cur_addr = start_addr;
	Elf32_Addr end_addr = start_addr + size;
	Elf32_Addr lim_addr;
	map<uint32_t,uint8_t>::iterator iter;

	while(true)
	{
		tmp_out = 0;
		int shift = 0;
		lim_addr = (cur_addr+4 < end_addr)?(cur_addr+4):end_addr;

		for (int i = cur_addr; i < lim_addr; ++i)
		{
			iter = mem.find(i);
			if (iter != mem.end())
				tmp_out = tmp_out | ((iter->second)<<shift);
			else
				printf("in func print_as_hex, Cannot find addr %x\n", i);
			shift += 8;
		}

		printf("content of addr %x: %x\n", cur_addr, tmp_out);
		if (lim_addr < end_addr)
			cur_addr = lim_addr;
		else
			break;
	}
}
