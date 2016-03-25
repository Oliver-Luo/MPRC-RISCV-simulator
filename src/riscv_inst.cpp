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
#include <stdlib.h>
#include <string.h>
#include <map>

#include "riscv_inst.h"
#include "elf_format.h"

using namespace std;

extern uint32_t reg[];
extern uint32_t PC;
extern map<uint32_t, uint8_t> mem;
uint8_t retrieve_or_error(uint32_t addr);

#define Rd(inst) ((inst >> 7) & 0x1f)
#define Rs1(inst) ((inst >> 15) & 0x1f)
#define Rs2(inst) ((inst >> 20) & 0x1f)

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

int jal(uint32_t inst)
{
	uint32_t rd = Rd(inst);
	int32_t imm = ((inst & 0x80000000) >> 12) | ((inst & 0x7fe00000) >> 21)
		| ((inst & 0x00100000) >> 10) | ((inst & 0x000ff000) >> 1);
	imm = sign_ext(imm, 20);
	uint32_t tmp_pc = PC;
	uint32_t target = unsign_add_sign(PC, imm * 2);
	int ret = 0;

	if ((get_func_name(target)) && (strcmp(get_func_name(target), "putchar") == 0))
	{
		printf("%c", reg[10]);
		PC += 4;
		ret = 1;
	}
	
	else
	{
		reg[rd] = PC + 4;
		PC = target;
	}

#ifdef DEBUG_EXECUTION
	printf("PC: %x, New PC: %x, inst: JAL, rd: %d(%d), imm: %d\n", tmp_pc, PC, rd,reg[rd],imm);
#endif

	return ret;
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
	iter = mem.find(addr);
	if (iter == mem.end())
		mem.insert(pair<uint32_t, uint8_t>(++addr, (value & 0xff00) >> 8));
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

