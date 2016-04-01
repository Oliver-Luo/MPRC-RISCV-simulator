/*
 * riscv-simulator: A simulator for RISCV, supporing RV32I now
 * riscv_inst -- Instruction execution part
 *
 * Yangcheng Luo	<lyc.eecs@pku.edu.cn>
 * Haoze Wu		<wuhaoze@mprc.pku.edu.cn>
 *
 * Copyright (C) 2014-2015 Microprocessor R&D Center (MPRC), Peking University
 */

#ifndef __RISCV_INST_H
#define __RISCV_INST_H

#include <stdint.h>

void lui(uint32_t inst);
void auipc(uint32_t inst);
void jal(uint32_t inst);
void jalr(uint32_t inst);
void beq(uint32_t inst);
void bne(uint32_t inst);
void blt(uint32_t inst);
void bge(uint32_t inst);
void bltu(uint32_t inst);
void bgeu(uint32_t inst);
void lb(uint32_t inst);
void lh(uint32_t inst);
void lw(uint32_t inst);
void lbu(uint32_t inst);
void lhu(uint32_t inst);
void sb(uint32_t inst);
void sh(uint32_t inst);
void sw(uint32_t inst);
void addi(uint32_t inst);
void slti(uint32_t inst);
void sltiu(uint32_t inst);
void xori(uint32_t inst);
void ori(uint32_t inst);
void andi(uint32_t inst);
void slli(uint32_t inst);
void srli(uint32_t inst);
void srai(uint32_t inst);
void add(uint32_t inst);
void sub(uint32_t inst);
void sll(uint32_t inst);
void slt(uint32_t inst);
void sltu(uint32_t inst);
void riscv_xor(uint32_t inst);
void srl(uint32_t inst);
void sra(uint32_t inst);
void riscv_or(uint32_t inst);
void riscv_and(uint32_t inst);
void flw(uint32_t inst);
void fld(uint32_t inst);
void fsw(uint32_t inst);
void fsd(uint32_t inst);
void remu(uint32_t inst);
void divu(uint32_t inst);
void div(uint32_t inst);
void mul(uint32_t inst);
void fcvt_s_w(uint32_t inst);
void fcvt_d_s(uint32_t inst);
void fcvt_s_d(uint32_t inst);
void fmul_d(uint32_t inst);
void fdiv_d(uint32_t inst);
void fdiv_s(uint32_t inst);
void fsgnj_d(uint32_t inst);
void fmv_s_x(uint32_t inst);
// fcvt.s.w	fa
// fcvt.d.s	fa
// lui	a4,0x1b
// fld	fa4,155
// fmul.d	fa5,
// lui	a4,0x1b
// fld	fa4,156
// fdiv.d	fa5,
// fcvt.s.d	fa
// fsw	fa5,-18
// flw	fa5,156
// fdiv.s	fa5,
// fsw	fa5,-18
// flw	fa5,-18
// fcvt.d.s	fa

#endif /* __RISCV_INST_H */
