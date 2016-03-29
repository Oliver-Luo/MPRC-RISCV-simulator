/*
 * riscv-simulator: A simulator for RISCV, supporing RV32I now
 * riscv_inst -- Instruction execution part
 *
 * Yangcheng Luo	<lyc.eecs@pku.edu.cn>
 * Haoze Wu		<wuhaoze@mprc.pku.edu.cn>
 *
 * Copyright (C) 2014-2015 Microprocessor R&D Center (MPRC), Peking University
 */

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
int scall(void);
