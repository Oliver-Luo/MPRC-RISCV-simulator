#include <stdint.h>
#include <stdio.h>

#define EI_NIDENT 16
#define Elf32_Addr uint32_t
#define Elf32_Half uint16_t
#define Elf32_Off uint32_t
#define Elf32_Sword int32_t
#define Elf32_Word uint32_t


#define SHT_NULL        0               /* Section header table entry unused */
#define SHT_PROGBITS    1               /* Program data */
#define SHT_SYMTAB      2               /* Symbol table */
#define SHT_STRTAB      3               /* String table */
#define SHT_RELA        4               /* Relocation entries with addends */
#define SHT_HASH        5               /* Symbol hash table */
#define SHT_DYNAMIC     6               /* Dynamic linking information */
#define SHT_NOTE        7               /* Notes */
#define SHT_NOBITS      8               /* Program space with no data (bss) */
#define SHT_REL         9               /* Relocation entries, no addends */
#define SHT_SHLIB       10              /* Reserved */
#define SHT_DYNSYM      11              /* Dynamic linker symbol table */
#define SHT_NUM         12              /* Number of defined types.  */
#define SHT_LOSUNW      0x6ffffffd      /* Sun-specific low bound.  */
#define SHT_GNU_verdef  0x6ffffffd      /* Version definition section.  */
#define SHT_GNU_verneed 0x6ffffffe      /* Version needs section.  */
#define SHT_GNU_versym  0x6fffffff      /* Version symbol table.  */
#define SHT_HISUNW      0x6fffffff      /* Sun-specific high bound.  */
#define SHT_LOPROC      0x70000000      /* Start of processor-specific */
#define SHT_HIPROC      0x7fffffff      /* End of processor-specific */
#define SHT_LOUSER      0x80000000      /* Start of application-specific */
#define SHT_HIUSER      0x8fffffff      /* End of application-specific */

#define SHN_UNDEF       0

typedef struct {
    unsigned char  e_ident[EI_NIDENT];
    Elf32_Half     e_type;
    Elf32_Half     e_machine;
    Elf32_Word     e_version;
    Elf32_Addr     e_entry;
    Elf32_Off      e_phoff;
    Elf32_Off      e_shoff;
    Elf32_Word     e_flags;
    Elf32_Half     e_ehsize;
    Elf32_Half     e_phentsize;
    Elf32_Half     e_phnum;
    Elf32_Half     e_shentsize;
    Elf32_Half     e_shnum;
    Elf32_Half     e_shstrndx;
} Elf32_Ehdr;

typedef struct {
    Elf32_Word    p_type;
    Elf32_Off     p_offset;
    Elf32_Addr    p_vaddr;
    Elf32_Addr    p_paddr;
    Elf32_Word    p_filesz;
    Elf32_Word    p_memsz;
    Elf32_Word    p_flags;
    Elf32_Word    p_align;
} Elf32_Phdr;

typedef struct 
{
    Elf32_Word  sh_name;
    Elf32_Word  sh_type;
    Elf32_Word  sh_flags;
    Elf32_Addr  sh_addr;
    Elf32_Off   sh_offset;
    Elf32_Word  sh_size;
    Elf32_Word  sh_link;
    Elf32_Word  sh_info;
    Elf32_Word  sh_addralign;
    Elf32_Word  sh_entsize;
    
}Elf32_Shdr;

typedef struct 
{
    Elf32_Word  st_name;
    Elf32_Addr  st_value;
    Elf32_Word  st_size;
    unsigned char st_info;
    unsigned char st_other;
    Elf32_Half st_shndx;
}Elf32_Sym;

Elf32_Addr read_elf(FILE *file);
Elf32_Addr get_func_addr(char *func_name);
const char *get_func_name(Elf32_Addr func_addr);
void print_mem_data();