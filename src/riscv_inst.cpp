/*
 * riscv-simulator: A simulator for RISCV, supporing RV32I now
 * riscv_inst -- Instruction execution part
 *
 * Yangcheng Luo	<lyc.eecs@pku.edu.cn>
 * Haoze Wu		<wuhaoze@mprc.pku.edu.cn>
 *
 * Copyright (C) 2014-2015 Microprocessor R&D Center (MPRC), Peking University
 */

#include <stdio.h>
#include <iostream>
#include <stdlib.h>
#include <string.h>
#include <string>
#include <map>
#include <sys/time.h>

#include "riscv_inst.h"
#include "elf_format.h"

using namespace std;

extern uint32_t reg[];
extern uint64_t f_reg[];
extern uint32_t PC;
extern map<uint32_t, uint8_t> mem;
uint8_t retrieve_or_error(uint32_t addr);

#define Rd(inst) ((inst >> 7) & 0x1f)
#define Rs1(inst) ((inst >> 15) & 0x1f)
#define Rs2(inst) ((inst >> 20) & 0x1f)

// 80 sys_fstat ; 214 sys_brk; 57 sys_close unimplemented
static void sys_write()
{
	Elf32_Addr cur_addr = reg[11];
	Elf32_Addr limit_addr = reg[12]+reg[11];
	//printf("entered\n");
	for(int i = cur_addr; i < limit_addr; i++)
	{
		char a = retrieve_or_error(i);
		printf("%c", a);

	}
	reg[10] = reg[12];
}
 
static void sys_gettimeofday()
{
	struct timeval t;
	if (gettimeofday(&t, NULL) == 0)
	{
		reg[10] = t.tv_sec;
		reg[11] = t.tv_usec;
	}
	else
	{
		printf("The call to func gettimeofday error.\n");
		exit(EXIT_FAILURE);
	}
}

/* not used in this edit.
static char *get_str(Elf32_Addr start)
{
	map<uint32_t, uint8_t>::iterator iter;
	Elf32_Addr cur = start;
	char *str;
	int count = 0;

	while(true)
	{
		iter = mem.find(cur);
		if(iter == mem.end())
		{
			printf("in func get_str, cannot find addr: %x\n", cur);
			exit(EXIT_FAILURE);
		}
		else if(iter->second != 0)
		{	
			count++;
			cur++;
		}
		else
			break;
	}
	str = new char[count+1];
	cur = start;
	for (int i = 0; i < count; ++i)
	{
		iter = mem.find(cur);
		str[i] = iter->second;
		cur++;
	}
	str[count] = 0;
	return str;
}

static const char *parse_str(const char *str)
{
	string parsed_str(str);
	int len = parsed_str.length();
	int count = 1;
	for (int i = 0; i < len;)
	{
		if(parsed_str[i] == '%'  && i+1 < len)
		{
			if (parsed_str[i+1] == 'd')
			{
				char num_str[20];
				sprintf(num_str, "%d", reg[10+count]);
				parsed_str.replace(i, 2, num_str);
				len = parsed_str.length();
				i += 2;
				count++;
			}
			else if (parsed_str[i+1] == 'u')
			{
				char num_str[20];
				sprintf(num_str, "%u", reg[10+count]);
				parsed_str.replace(i, 2, num_str);
				len = parsed_str.length();
				i += 2;
				count++;
			}
			else if(parsed_str[i+1] == 'x')
			{
				char num_str[20];
				sprintf(num_str, "%x", reg[10+count]);
				parsed_str.replace(i, 2, num_str);
				len = parsed_str.length();
				i += 2;
				count++;
			}
			else if (parsed_str[i+1] == 's')
			{
				parsed_str.replace(i, 2,get_str(reg[10+count]));
				len = parsed_str.length();
				i += 2;
				count ++;
			}
			else
			{
				printf("format :%c unsuported!\n", parsed_str[i+1]);
				i += 2;
			}
		
		}
		else
			i++;
	}

	const char *tmp =  parsed_str.c_str();
	return tmp;
}
*/
static int32_t sign_ext(int32_t imm, uint32_t width)
{
	int sign_bit = imm >> (width - 1);
	if (sign_bit)
	{
		imm = imm | (0xffffffff << width);
	}

	return imm;
}

static uint32_t unsign_add_sign(uint32_t unsign, int32_t sign)
{
	if (sign >= 0)
		return unsign + sign;
	else
		return unsign - (uint32_t)(~sign + 1);
}

void lui(uint32_t inst)
{
        uint32_t rd = Rd(inst);
        uint32_t imm = (inst & 0xfffff000);

        reg[rd] = imm;

#ifdef DEBUG_EXECUTION
        printf("PC: %x, inst: LUI, rd: %d(%d), imm: %d\n", PC, rd, reg[rd], imm);
#endif
}

void auipc(uint32_t inst)
{
        uint32_t rd = Rd(inst);
        uint32_t imm = (inst & 0xfffff000);

        reg[rd] = PC + imm;

#ifdef DEBUG_EXECUTION
        printf("PC: %x, inst: AUIPC, rd: %d(%d), imm: %d\n", PC, rd, reg[rd], imm);
#endif
}

void jal(uint32_t inst)
{
	uint32_t rd = Rd(inst);
	int32_t imm = ((inst & 0x80000000) >> 12) | ((inst & 0x7fe00000) >> 21)
		| ((inst & 0x00100000) >> 10) | ((inst & 0x000ff000) >> 1);
	imm = sign_ext(imm, 20);
	uint32_t tmp_pc = PC;
	uint32_t target = unsign_add_sign(PC, imm * 2);

	reg[rd] = PC + 4;
	PC = target;

#ifdef DEBUG_EXECUTION
	printf("PC: %x, New PC: %x, inst: JAL, rd: %d(%d), imm: %d\n", tmp_pc, PC, rd,reg[rd],imm);
#endif
}
//?? whz why set the least-significant bit not the two?
void jalr(uint32_t inst)
{
	uint32_t rd = Rd(inst);
	uint32_t rs1 = Rs1(inst);
	int32_t imm = sign_ext((inst >> 20), 12);
	int32_t target = ((int32_t)reg[rs1] + imm) & 0xfffffffe;
	uint32_t tmp_pc = PC;

	reg[rd] = PC + 4;
	PC = target;

#ifdef DEBUG_EXECUTION
	printf("PC: %x, New PC: %x, inst: JALR, rd: %d(%d), rs1: %d(%d), imm: %d\n", tmp_pc, PC, rd,reg[rd],rs1,reg[rs1],imm);
#endif
}

void beq(uint32_t inst)
{
	uint32_t rs1 = Rs1(inst);
	uint32_t rs2 = Rs2(inst);
	int32_t imm = ((inst & 0x80000000) >> 20) | ((inst & 0x7e000000) >> 21)
		| ((inst & 0x00000f00) >> 8) | ((inst & 0x00000080) << 3);
	uint32_t tmp_pc = PC;

	imm = sign_ext(imm, 12);

	if((int32_t)reg[rs1] == (int32_t)reg[rs2])
		PC = unsign_add_sign(PC, imm * 2);
	else
		PC += 4;

#ifdef DEBUG_EXECUTION
	printf("PC: %x, New PC: %x, inst: BEQ, rs1: %d(%d), rs2: %d(%d), imm: %d\n", tmp_pc, PC, rs1,reg[rs1], rs2,reg[rs2], imm);
#endif
}

void bne(uint32_t inst)
{
	uint32_t rs1 = Rs1(inst);
	uint32_t rs2 = Rs2(inst);
	int32_t imm = ((inst & 0x80000000) >> 20) | ((inst & 0x7e000000) >> 21)
		| ((inst & 0x00000f00) >> 8) | ((inst & 0x00000080) << 3);
	uint32_t tmp_pc = PC;

	imm = sign_ext(imm, 12);

	if((int32_t)reg[rs1] != (int32_t)reg[rs2])
		PC = unsign_add_sign(PC, imm * 2);
	else
		PC += 4;

#ifdef DEBUG_EXECUTION
	printf("PC: %x, New PC: %x, inst: BNE, rs1: %d(%d), rs2: %d(%d), imm: %d\n", tmp_pc, PC, rs1,reg[rs1], rs2,reg[rs2], imm);
#endif
}

void blt(uint32_t inst)
{
	uint32_t rs1 = Rs1(inst);
	uint32_t rs2 = Rs2(inst);
	int32_t imm = ((inst & 0x80000000) >> 20) | ((inst & 0x7e000000) >> 21)
		| ((inst & 0x00000f00) >> 8) | ((inst & 0x00000080) << 3);
	uint32_t tmp_pc = PC;

	imm = sign_ext(imm, 12);

	if((int32_t)reg[rs1] < (int32_t)reg[rs2])
		PC = unsign_add_sign(PC, imm * 2);
	else
		PC += 4;

#ifdef DEBUG_EXECUTION
	printf("PC: %x, New PC: %x, inst: BLT, rs1: %d(%d), rs2: %d(%d), imm: %d\n", tmp_pc, PC, rs1,reg[rs1], rs2,reg[rs2],imm);
#endif
}

void bge(uint32_t inst)
{
	uint32_t rs1 = Rs1(inst);
	uint32_t rs2 = Rs2(inst);
	int32_t imm = ((inst & 0x80000000) >> 20) | ((inst & 0x7e000000) >> 21)
		| ((inst & 0x00000f00) >> 8) | ((inst & 0x00000080) << 3);
	uint32_t tmp_pc = PC;

	imm = sign_ext(imm, 12);

	if((int32_t)reg[rs1] >= (int32_t)reg[rs2])
		PC = unsign_add_sign(PC, imm * 2);
	else
		PC += 4;

#ifdef DEBUG_EXECUTION
	printf("PC: %x, New PC: %x, inst: BGE, rs1: %d(%d), rs2: %d(%d), imm: %d\n", tmp_pc, PC, rs1,reg[rs1], rs2,reg[rs2], imm);
#endif
}

void bltu(uint32_t inst)
{
	uint32_t rs1 = Rs1(inst);
	uint32_t rs2 = Rs2(inst);
	int32_t imm = ((inst & 0x80000000) >> 20) | ((inst & 0x7e000000) >> 21)
		| ((inst & 0x00000f00) >> 8) | ((inst & 0x00000080) << 3);
	uint32_t tmp_pc = PC;

	imm = sign_ext(imm, 12);

	if((uint32_t)reg[rs1] < (uint32_t)reg[rs2])
		PC = unsign_add_sign(PC, imm * 2);
	else
		PC += 4;

#ifdef DEBUG_EXECUTION
	printf("PC: %x, New PC: %x, inst: BLTU, rs1: %d(%d), rs2: %d(%d), imm: %d\n", tmp_pc, PC, rs1,reg[rs1], rs2,reg[rs2], imm);
#endif
}

void bgeu(uint32_t inst)
{
	uint32_t rs1 = Rs1(inst);
	uint32_t rs2 = Rs2(inst);
	int32_t imm = ((inst & 0x80000000) >> 20) | ((inst & 0x7e000000) >> 21)
		| ((inst & 0x00000f00) >> 8) | ((inst & 0x00000080) << 3);
	uint32_t tmp_pc = PC;

	imm = sign_ext(imm, 12);

	if((uint32_t)reg[rs1] >= (uint32_t)reg[rs2])
		PC = unsign_add_sign(PC, imm * 2);
	else
		PC += 4;

#ifdef DEBUG_EXECUTION
	printf("PC: %x, New PC: %x, inst: BGEU, rs1: %d(%d), rs2: %d(%d), imm: %d\n", tmp_pc, PC, rs1,reg[rs1], rs2,reg[rs2], imm);
#endif
}

void lb(uint32_t inst)
{
	uint32_t rd = Rd(inst);
	uint32_t rs1 = Rs1(inst);
	int32_t imm = sign_ext((inst >> 20), 12);
	uint32_t addr = unsign_add_sign(reg[rs1], imm);

	reg[rd] = sign_ext(retrieve_or_error(addr), 8);

#ifdef DEBUG_EXECUTION
	printf("PC: %x, inst: LB, rd: %d(%d), rs1: %d(%d), imm %d\n", PC, rd,reg[rd], rs1,reg[rs1], imm);
#endif	
}

void lh(uint32_t inst)
{
	uint32_t rd = Rd(inst);
	uint32_t rs1 = Rs1(inst);
	int32_t imm = sign_ext((inst >> 20), 12);
	uint32_t addr = unsign_add_sign(reg[rs1], imm);
	uint32_t value = 0;

	value = retrieve_or_error(addr);
	value = value | (retrieve_or_error(++addr)) << 8;

	reg[rd] = sign_ext(value, 16);

#ifdef DEBUG_EXECUTION
	printf("PC: %x, inst: LH, rd: %d(%d), rs1: %d(%d), imm %d\n", PC, rd,reg[rd], rs1,reg[rs1], imm);
#endif	
}

void lw(uint32_t inst)
{
	uint32_t rd = Rd(inst);
	uint32_t rs1 = Rs1(inst);
	int32_t imm = sign_ext((inst >> 20), 12);
	uint32_t addr = unsign_add_sign(reg[rs1], imm);
	uint32_t value = 0;
	int i = 0;
	
	for (i = 0; i < 4; i++)
		value = value | ((retrieve_or_error(addr++)) << (i * 8));

	reg[rd] = value;

#ifdef DEBUG_EXECUTION
	printf("PC: %x, inst: LW, rd: %d(%d), rs1: %d(%d), imm %d\n", PC, rd,reg[rd], rs1,reg[rs1], imm);
#endif	
}

void lbu(uint32_t inst)
{
	uint32_t rd = Rd(inst);
	uint32_t rs1 = Rs1(inst);
	int32_t imm = sign_ext((inst >> 20), 12);
	uint32_t addr = unsign_add_sign(reg[rs1], imm);

	reg[rd] = retrieve_or_error(addr);

#ifdef DEBUG_EXECUTION
	printf("PC: %x, inst: LBU, rd: %d(%d), rs1: %d(%d), imm %d\n", PC, rd,reg[rd], rs1,reg[rs1], imm);
#endif	
}

void lhu(uint32_t inst)
{
	uint32_t rd = Rd(inst);
	uint32_t rs1 = Rs1(inst);
	int32_t imm = sign_ext((inst >> 20), 12);
	uint32_t addr = unsign_add_sign(reg[rs1], imm);
	uint32_t value = 0;

	value = retrieve_or_error(addr);
	value = value | (retrieve_or_error(++addr)) << 8;

	reg[rd] = value;

#ifdef DEBUG_EXECUTION
	printf("PC: %x, inst: LHU, rd: %d(%d), rs1: %d(%d), imm %d\n", PC, rd,reg[rd], rs1,reg[rs1], imm);
#endif	
}

void sb(uint32_t inst)
{
	uint32_t rs1 = Rs1(inst);
	uint32_t rs2 = Rs2(inst);
	int32_t imm = sign_ext((((inst >> 20) & 0x00000fe0) | ((inst >> 7) & 0x0000001f)), 12);
	uint32_t addr = unsign_add_sign(reg[rs1], imm);
	uint8_t value = reg[rs2] & 0x000000ff;

	map<uint32_t, uint8_t>::iterator iter;
	iter = mem.find(addr);
	if (iter == mem.end())
		mem.insert(pair<uint32_t, uint32_t>(addr, (uint32_t)value));
	else
		iter->second = value;

#ifdef DEBUG_EXECUTION
	printf("PC: %x, inst: SB, rs1: %d(%d), rs2: %d(%d), imm: %d\n", PC, rs1,reg[rs1], rs2,reg[rs2], imm);
#endif
}
// whz ?? something wrong with the memeory.if <ea0, ffffffff>,and we access addr. e9f
void sh(uint32_t inst)
{
	uint32_t rs1 = Rs1(inst);
	uint32_t rs2 = Rs2(inst);
	int32_t imm = sign_ext((((inst >> 20) & 0x00000fe0) | ((inst >> 7) & 0x0000001f)), 12);
	uint32_t addr = unsign_add_sign(reg[rs1], imm);
	int32_t value = reg[rs2] & 0x0000ffff;

	map<uint32_t, uint8_t>::iterator iter;
	iter = mem.find(addr);
	if (iter == mem.end())
		mem.insert(pair<uint32_t, uint8_t>(addr, value & 0xff));
	else
		iter->second = value & 0xff;
	iter = mem.find(++addr);
	if (iter == mem.end())
		mem.insert(pair<uint32_t, uint8_t>(addr, (value & 0xff00) >> 8));
	else
		iter->second = (value & 0xff00) >> 8;
	

#ifdef DEBUG_EXECUTION
	printf("PC: %x, inst: SH, rs1: %d(%d), rs2: %d(%d), imm: %d\n", PC, rs1,reg[rs1], rs2,reg[rs2], imm);
#endif
}

void sw(uint32_t inst)
{
	uint32_t rs1 = Rs1(inst);
	uint32_t rs2 = Rs2(inst);
	int32_t imm = sign_ext((((inst >> 20) & 0x00000fe0) | ((inst >> 7) & 0x0000001f)), 12);
	uint32_t addr = unsign_add_sign(reg[rs1], imm);
	int value = reg[rs2];
	int i = 0;

	for (i = 0; i < 4; i++)
	{
		map<uint32_t, uint8_t>::iterator iter;
		iter = mem.find(addr);
		if (iter == mem.end())
			mem.insert(pair<uint32_t, uint8_t>(addr, (reg[rs2] & (0xff << (i * 8))) >> (i * 8)));
		else
			iter->second = (reg[rs2] & (0xff << (i * 8))) >> (i * 8);
		addr++;
	}

#ifdef DEBUG_EXECUTION
	printf("PC: %x, inst: SW, rs1: %d(%d), rs2: %d(%d), imm: %d\n", PC, rs1,reg[rs1], rs2,reg[rs2], imm);
#endif
}

void addi(uint32_t inst)
{
	uint32_t rd = Rd(inst);
	uint32_t rs = Rs1(inst);
	int32_t imm = sign_ext((inst >> 20), 12);

	reg[rd] = reg[rs] + imm;

#ifdef DEBUG_EXECUTION
	printf("PC: %x, inst: ADDI, rd: %d(%d), rs: %d(%d) , imm: %d\n", PC, rd,reg[rd], rs,reg[rs], imm);
#endif
}

void slti(uint32_t inst)
{
	uint32_t rd = Rd(inst);
	uint32_t rs1 = Rs1(inst);

	int cmp1 = (int) (reg[rs1]);
	int cmp2 = sign_ext((inst >> 20), 12);

	if (cmp1 < cmp2)
		reg[rd] = 1;
	else
		reg[rd] = 0;

#ifdef DEBUG_EXECUTION
	printf("PC: %x, inst: SLTI, rd: %d(%d), rs1: %d(%d) , imm: %d\n", PC, rd,reg[rd], rs1,reg[rs1], cmp2);
#endif
}

/*some confusion with the spec whz??*/
void sltiu(uint32_t inst)
{
	uint32_t rd = Rd(inst);
	uint32_t rs1 = Rs1(inst);

	int cmp1 = (unsigned int) (reg[rs1]);
	int cmp2 = (unsigned int) sign_ext((inst >> 20), 12);

	if (cmp1 < cmp2)
		reg[rd] = 1;
	else
		reg[rd] = 0;

#ifdef DEBUG_EXECUTION
	printf("PC: %x, inst: SLTIU, rd: %d(%d), rs1: %d(%d) , imm: %d\n", PC, rd,reg[rd], rs1,reg[rs1], cmp2);
#endif
}

void xori(uint32_t inst)
{
	uint32_t rd = Rd(inst);
	uint32_t rs1 = Rs1(inst);
	int32_t	imm = sign_ext((inst >> 20), 12);

	reg[rd] = reg[rs1] ^ imm;

#ifdef DEBUG_EXECUTION
	printf("PC: %x, inst: XORI, rd: %d(%d), rs1: %d(%d) , imm: %d\n", PC, rd,reg[rd], rs1,reg[rs1], imm);
#endif
}

void ori(uint32_t inst)
{
	uint32_t rd = Rd(inst);
	uint32_t rs1 = Rs1(inst);
	int32_t	imm = sign_ext((inst >> 20), 12);

	reg[rd] = reg[rs1] | imm;

#ifdef DEBUG_EXECUTION
	printf("PC: %x, inst: ORI, rd: %d(%d), rs1: %d(%d) , imm: %d\n", PC, rd,reg[rd], rs1,reg[rs1], imm);
#endif
}

void andi(uint32_t inst)
{
	uint32_t rd = Rd(inst);
	uint32_t rs1 = Rs1(inst);
	int32_t	imm = sign_ext((inst >> 20), 12);

	reg[rd] = reg[rs1] & imm;

#ifdef DEBUG_EXECUTION
	printf("PC: %x, inst: ANDI, rd: %d(%d), rs1: %d(%d) , imm: %d\n", PC, rd,reg[rd], rs1,reg[rs1], imm);
#endif
}

void slli(uint32_t inst)
{
	uint32_t rd = Rd(inst);
	uint32_t rs1 = Rs1(inst);
	uint32_t shift_width = (inst >> 20) & 0x1f;

	reg[rd] = reg[rs1] << shift_width;

#ifdef DEBUG_EXECUTION
	printf("PC: %x, inst: SLLI, rd: %d(%d), rs1: %d(%d) , imm: %d\n", PC, rd,reg[rd], rs1,reg[rs1], shift_width);
#endif
}

void srli(uint32_t inst)
{
	uint32_t rd = Rd(inst);
	uint32_t rs1 = Rs1(inst);
	uint32_t shift_width = (inst >> 20) & 0x1f;

	reg[rd] = reg[rs1] >> shift_width;

#ifdef DEBUG_EXECUTION
	printf("PC: %x, inst: SRLI, rd: %d(%d), rs1: %d(%d) , imm: %d\n", PC, rd,reg[rd], rs1,reg[rs1], shift_width);
#endif
}

void srai(uint32_t inst)
{
	uint32_t rd = Rd(inst);
	uint32_t rs1 = Rs1(inst);
	uint32_t shift_width = (inst >> 20) & 0x1f;

	reg[rd] = reg[rs1] >> shift_width;
	reg[rd] = sign_ext(reg[rd], 32 - shift_width);

#ifdef DEBUG_EXECUTION
	printf("PC: %x, inst: SRAI, rd: %d(%d), rs1: %d(%d) , imm: %d\n", PC, rd,reg[rd], rs1,reg[rs1], shift_width);
#endif
}

void add(uint32_t inst)
{
	uint32_t rd = Rd(inst);
	uint32_t rs1 = Rs1(inst);
	uint32_t rs2 = Rs2(inst);

	reg[rd] = reg[rs1] + reg[rs2];

#ifdef DEBUG_EXECUTION
	printf("PC: %x, inst: ADD, rd: %d(%d), rs1: %d(%d) , rs2: %d(%d)\n", PC, rd,reg[rd] ,rs1,reg[rs1], rs2,reg[rs2]);
#endif
}

void sub(uint32_t inst)
{
	uint32_t rd = Rd(inst);
	uint32_t rs1 = Rs1(inst);
	uint32_t rs2 = Rs2(inst);
	
	reg[rd] = reg[rs1] - reg[rs2];

#ifdef DEBUG_EXECUTION
	printf("PC: %x, inst: SUB, rd: %d(%d), rs1: %d(%d) , rs2: %d(%d)\n", PC, rd,reg[rd] ,rs1,reg[rs1], rs2,reg[rs2]);
#endif
}

void sll(uint32_t inst)
{
	uint32_t rd = Rd(inst);
	uint32_t rs1 = Rs1(inst);
	uint32_t rs2 = Rs2(inst);
	uint32_t shift_width = reg[rs2] & 0x1f;

	reg[rd] = reg[rs1] << shift_width;

#ifdef DEBUG_EXECUTION
	printf("PC: %x, inst: SLL, rd: %d(%d), rs1: %d(%d) , rs2: %d(%d)\n", PC, rd,reg[rd] ,rs1,reg[rs1], rs2,reg[rs2]);
#endif
}

void slt(uint32_t inst)
{
	uint32_t rd = Rd(inst);
	uint32_t rs1 = Rs1(inst);
	uint32_t rs2 = Rs2(inst);

	int cmp1 = (int) (reg[rs1]);
	int cmp2 = (int) (reg[rs2]);

	if (cmp1 < cmp2)
		reg[rd] = 1;
	else
		reg[rd] = 0;

#ifdef DEBUG_EXECUTION
	printf("PC: %x, inst: SLT, rd: %d(%d), rs1: %d(%d) , rs2: %d(%d)\n", PC, rd,reg[rd] ,rs1,reg[rs1], rs2,reg[rs2]);
#endif
}

void sltu(uint32_t inst)
{
	uint32_t rd = Rd(inst);
	uint32_t rs1 = Rs1(inst);
	uint32_t rs2 = Rs2(inst);

	unsigned int cmp1 = (unsigned int) (reg[rs1]);
	unsigned int cmp2 = (unsigned int) (reg[rs2]);

	if (cmp1 < cmp2)
		reg[rd] = 1;
	else
		reg[rd] = 0;

#ifdef DEBUG_EXECUTION
	printf("PC: %x, inst: SLTU, rd: %d(%d), rs1: %d(%d) , rs2: %d(%d)\n", PC, rd,reg[rd] ,rs1,reg[rs1], rs2,reg[rs2]);
#endif
}

void riscv_xor(uint32_t inst)
{
	uint32_t rd = Rd(inst);
	uint32_t rs1 = Rs1(inst);
	uint32_t rs2 = Rs2(inst);
	
	reg[rd] = reg[rs1] ^ reg[rs2];


#ifdef DEBUG_EXECUTION
	printf("PC: %x, inst: XOR, rd: %d(%d), rs1: %d(%d) , rs2: %d(%d)\n", PC, rd,reg[rd] ,rs1,reg[rs1], rs2,reg[rs2]);
#endif
}

/* logical right shift */
void srl(uint32_t inst)
{
	uint32_t rd = Rd(inst);
	uint32_t rs1 = Rs1(inst);
	uint32_t rs2 = Rs2(inst);
	uint32_t shift_width = reg[rs2] & 0x1f;

	reg[rd] = reg[rs1] >> shift_width;

#ifdef DEBUG_EXECUTION
	printf("PC: %x, inst: SRL, rd: %d(%d), rs1: %d(%d) , rs2: %d(%d)\n", PC, rd,reg[rd] ,rs1,reg[rs1], rs2,reg[rs2]);
#endif
}

/* arithmetic right shift */
void sra(uint32_t inst)
{
	uint32_t rd = Rd(inst);
	uint32_t rs1 = Rs1(inst);
	uint32_t rs2 = Rs2(inst);
	uint32_t shift_width = reg[rs2] & 0x1f;

	reg[rd] = reg[rs1] >> shift_width;
	reg[rd] = sign_ext(reg[rd], 32 - shift_width);

#ifdef DEBUG_EXECUTION
	printf("PC: %x, inst: SRA, rd: %d(%d), rs1: %d(%d) , rs2: %d(%d)\n", PC, rd,reg[rd] ,rs1,reg[rs1], rs2,reg[rs2]);
#endif
}

void riscv_or(uint32_t inst)
{
	uint32_t rd = Rd(inst);
	uint32_t rs1 = Rs1(inst);
	uint32_t rs2 = Rs2(inst);

	reg[rd] = reg[rs1] | reg[rs2];


#ifdef DEBUG_EXECUTION
	printf("PC: %x, inst: OR, rd: %d(%d), rs1: %d(%d) , rs2: %d(%d)\n", PC, rd,reg[rd] ,rs1,reg[rs1], rs2,reg[rs2]);
#endif
}

void riscv_and(uint32_t inst)
{
	uint32_t rd = Rd(inst);
	uint32_t rs1 = Rs1(inst);
	uint32_t rs2 = Rs2(inst);

	reg[rd] = reg[rs1] & reg[rs2];

#ifdef DEBUG_EXECUTION
	printf("PC: %x, inst: AND, rd: %d(%d), rs1: %d(%d) , rs2: %d(%d)\n", PC, rd,reg[rd] ,rs1,reg[rs1], rs2,reg[rs2]);
#endif
}

int scall(void)
{
	if (reg[17] == 93)
		return 0;
	// for (int i = 10; i < 18; ++i)
	// {
	// 	printf("%x    ", reg[i]);
	// }
	// printf("\n");
	switch(reg[17])
	{
		case 64: sys_write(); break;
		case 169: sys_gettimeofday; break;
		default: 
		{
			printf("System call %d in addr: %x unimplemented.\n", reg[17], PC);
			printf("PC: %x, inst: SCALL num: %d\n", PC, reg[17]);
			break;
		}
	}
#ifdef DEBUG_EXECUTION
	printf("SCALL, num:%x  executed!	\n", reg[17]);
#endif

}

void flw(uint32_t inst)
{
	printf("FLW called, but unimplemented\n");
#ifdef DEBUG_EXECUTION
	printf("PC: %x", PC);
#endif
}

void fld(uint32_t inst)
{
	uint32_t rd = Rd(inst);
	uint32_t rs1 = Rs1(inst);
	int32_t imm = sign_ext((inst >> 20), 12);
	uint32_t addr = unsign_add_sign(reg[rs1], imm);
	uint64_t value = 0;
	int i = 0;
	
	for (i = 0; i < 8; i++)
		value = value | ((retrieve_or_error(addr++)) << (i * 8));

	f_reg[rd] = value;
	
#ifdef DEBUG_EXECUTION
	printf("PC: %x, inst: FLD, rd(f_reg): %d(%lld), rs1: %d(%d), imm: %d\n", PC, rd, f_reg[rd], rs1, reg[rs1], imm);
#endif
}

void fsw(uint32_t inst)
{
	printf("FSW called, but unimplemented\n");
#ifdef DEBUG_EXECUTION
	printf("PC: %x", PC);
#endif
}

void fsd(uint32_t inst)
{
	uint32_t rs1 = Rs1(inst);
	uint32_t rs2 = Rs2(inst);
	int32_t imm = sign_ext((((inst >> 20) & 0x00000fe0) | ((inst >> 7) & 0x0000001f)), 12);
	uint32_t addr = unsign_add_sign(reg[rs1], imm);
	uint64_t value = f_reg[rs2];
	int i = 0;

	for (i = 0; i < 8; i++)
	{
		map<uint32_t, uint8_t>::iterator iter;
		iter = mem.find(addr);
		if (iter == mem.end())
			mem.insert(pair<uint32_t, uint8_t>(addr, (f_reg[rs2] & (0xff << (i * 8))) >> (i * 8)));
		else
			iter->second = (f_reg[rs2] & (0xff << (i * 8))) >> (i * 8);
		addr++;
	}

	//printf("FSD called, but unimplemented\n");
#ifdef DEBUG_EXECUTION
	printf("PC: %x, inst: FSD, rs1(reg): %d(%d), rs2(f_reg): %d(%lld), imm: %d\n", PC, rs1, reg[rs1], rs2, f_reg[rs2], imm);
#endif
}

void remu(uint32_t inst)
{
	uint32_t rd = Rd(inst);
	uint32_t rs1 = Rs1(inst);
	uint32_t rs2 = Rs2(inst);

	reg[rd] = reg[rs1] % reg[rs2];

#ifdef DEBUG_EXECUTION
	printf("PC: %x, inst: REMU, rd: %d(%d), rs1: %d(%d) , rs2: %d(%d)\n", PC, rd,reg[rd] ,rs1,reg[rs1], rs2,reg[rs2]);
#endif	

}

void div(uint32_t inst)
{

	uint32_t rd = Rd(inst);
	uint32_t rs1 = Rs1(inst);
	uint32_t rs2 = Rs2(inst);

	int value_rs1 = reg[rs1];
	int value_rs2 = reg[rs2];
	int value_rd = value_rs1 / value_rs2;

	reg[rd] = value_rd;

#ifdef DEBUG_EXECUTION
	printf("PC: %x, inst: DIV, rd: %d(%d), rs1: %d(%d) , rs2: %d(%d)\n", PC, rd,reg[rd] ,rs1,reg[rs1], rs2,reg[rs2]);
#endif
}

void divu(uint32_t inst)
{
	uint32_t rd = Rd(inst);
	uint32_t rs1 = Rs1(inst);
	uint32_t rs2 = Rs2(inst);

	reg[rd] = reg[rs1] / reg[rs2];
#ifdef DEBUG_EXECUTION
	printf("PC: %x, inst: DIVU, rd: %d(%d), rs1: %d(%d) , rs2: %d(%d)\n", PC, rd,reg[rd] ,rs1,reg[rs1], rs2,reg[rs2]);
#endif
}

void mul(uint32_t inst)
{
	uint32_t rd = Rd(inst);
	uint32_t rs1 = Rs1(inst);
	uint32_t rs2 = Rs2(inst);
	uint64_t value = reg[rs1] * reg[rs2];
	reg[rd] = value & 0xffffffff;
#ifdef DEBUG_EXECUTION
	printf("PC: %x, inst: MUL, rd: %d(%d), rs1: %d(%d) , rs2: %d(%d)\n", PC, rd,reg[rd] ,rs1,reg[rs1], rs2,reg[rs2]);
#endif
}
void fcvt_s_w(uint32_t inst)
{
	printf("FCVT_S_W called, but unimplemented\n");
#ifdef DEBUG_EXECUTION
	printf("PC: %x", PC);
#endif
}

void fcvt_d_s(uint32_t inst)
{
	printf("FCVT_D_S called, but unimplemented\n");
#ifdef DEBUG_EXECUTION
	printf("PC: %x", PC);
#endif
}

void fcvt_s_d(uint32_t inst)
{
	printf("FCVT_S_D called, but unimplemented\n");
#ifdef DEBUG_EXECUTION
	printf("PC: %x", PC);
#endif
}

void fmul_d(uint32_t inst)
{
	printf("FMUL_D called, but unimplemented\n");
#ifdef DEBUG_EXECUTION
	printf("PC: %x", PC);
#endif
}

void fdiv_d(uint32_t inst)
{
	printf("FDIV_D called, but unimplemented\n");
#ifdef DEBUG_EXECUTION
	printf("PC: %x", PC);
#endif
}

void fdiv_s(uint32_t inst)
{
	printf("FDIV_S called, but unimplemented\n");
#ifdef DEBUG_EXECUTION
	printf("PC: %x", PC);
#endif
}

void fsgnj_d(uint32_t inst)
{

}

void fmv_s_x(uint32_t inst)
{
	printf("FMV.S.X called, but unimplemented\n");
#ifdef DEBUG_EXECUTION
	printf("PC: %x", PC);
#endif
}
	
//printf("PC: %x, inst: SH, frs1: %d(%d), frs2: %d(%d), imm: %d\n", PC, rs1,freg[rs1], rs2,freg[rs2], imm);
