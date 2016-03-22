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

static Elf32_Ehdr read_elf_header(FILE *file);
static Elf32_Phdr* read_prog_headers(FILE *file, Elf32_Ehdr elf_header);
static Elf32_Shdr* read_sec_headers(FILE *file, Elf32_Ehdr elf_header);
static void load_data(FILE *file, Elf32_Shdr *sec_hdrs, int data_index);
static void load_prog(FILE *file, Elf32_Phdr *prog_hdrs, int pnum);
static void print_mem(void);
static int init_reg(FILE *file, Elf32_Ehdr elf_header, Elf32_Shdr *sec_hdrs, int snum);

Elf32_Addr read_elf(FILE *file)
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

	return elf_header;
}

static Elf32_Phdr* read_prog_headers(FILE *file, Elf32_Ehdr elf_header)
{
	Elf32_Phdr *prog_headers = new Elf32_Phdr[elf_header.e_phnum];

	fseek(file,elf_header.e_phoff ,SEEK_SET);
	fread(prog_headers, sizeof(Elf32_Phdr), elf_header.e_phnum, file);

#ifdef DEBUG_HEADER
	if (elf_header.e_phnum > 0)
	{
		printf("\n\nContent of Program header:\n");
		printf("%-10s  %-8s  %-10s  %-10s  %-8s  %-8s  %-3s  %s\n", 
			   "Type", "Offset", "VirtAddr", "PhysAddr", "FileSize", "MemSize", "Flg", "Align");
		for (int i = 0; i < elf_header.e_phnum; ++i)
			printf("%-10x  0x%06x  0x%08x  0x%08x  0x%06x  0x%06x  %-3x  0x%x\n", 
				   prog_headers[i].p_type, prog_headers[i].p_offset, prog_headers[i].p_vaddr,
				   prog_headers[i].p_paddr, prog_headers[i].p_filesz, prog_headers[i].p_memsz,
				   prog_headers[i].p_flags, prog_headers[i].p_align);
	}
	else
		printf("No prog_header found!!!\n");

#endif

	return prog_headers;
}

static Elf32_Shdr* read_sec_headers(FILE *file, Elf32_Ehdr elf_header)
{
	char *sh_str_tbl = NULL;

	Elf32_Shdr *sec_headers = new Elf32_Shdr[elf_header.e_shnum];
	fseek(file, elf_header.e_shoff, SEEK_SET);
	fread(sec_headers, sizeof(Elf32_Shdr), elf_header.e_shnum, file);

	sh_str_tbl = new char[sec_headers[elf_header.e_shstrndx].sh_size];
	fseek(file, sec_headers[elf_header.e_shstrndx].sh_offset, SEEK_SET);
	fread(sh_str_tbl, sizeof(char), sec_headers[elf_header.e_shstrndx].sh_size, file);

#ifdef DEBUG_HEADER
	if (elf_header.e_shnum > 0)
	{
		printf("\n\nContent of section header \n");
		printf("%4s  %-20s  %-20s  %-8s  %-6s  %-6s  %2s  %3s  %2s  %3s  %2s\n",
			   "[Nr]", "Name", "Type", "Addr", "Off", "Size", "ES", "Flg", "Lk", "Inf", "Al");
	
		for (int i = 0; i < elf_header.e_shnum ; ++i)
			printf("[%2d]  %-20s  %-20x  %08x  %06x  %06x  %02x  %-3x  %2d  %3d  %2d\n", 
				   i, &sh_str_tbl[sec_headers[i].sh_name], sec_headers[i].sh_type, sec_headers[i].sh_addr,
				   sec_headers[i].sh_offset, sec_headers[i].sh_size, sec_headers[i].sh_entsize,
				   sec_headers[i].sh_flags, sec_headers[i].sh_link, sec_headers[i].sh_info,
				   sec_headers[i].sh_addralign);
	
	}
	else
		printf("No sec_header found!!!\n");
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
	if( index_symtab == -1 ||  index_strtab == -1)
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
#ifdef DEBUG_HEADER
	printf("\n\nContent of symbol table entry:\n");	
	printf("Num:  %8s  Size  %-10s  %-6s  %-10s  Ndx  Name\n", 
				"Value", "Type", "Bind", "Vis");
#endif
	for (int i = 0; i < sym_num; ++i)
	{
#ifdef DEBUG_HEADER
		printf("%3d:  %8x  %4d  %-10x  %-6x  %-10x  %3x  %s\n", 
				i, symbol_table[i].st_value, symbol_table[i].st_size, symbol_table[i].st_info,
				symbol_table[i].st_info, symbol_table[i].st_info, symbol_table[i].st_shndx,
				&str_content[symbol_table[i].st_name]);
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

static void print_mem(void)
{
	map<uint32_t, uint8_t>::iterator iter;

	printf("\n\nContent of Memory:\n\n");
	for(iter = mem.begin(); iter != mem.end(); iter++)
		printf("addr:%x\tinst:%x\n", iter->first, iter->second);

	return;
}