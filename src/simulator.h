/*
 * riscv-simulator: A simulator for RISCV, supporing RV32I now
 * simulator -- Main part of the simulator
 *
 * Yangcheng Luo	<lyc.eecs@pku.edu.cn>
 * Haoze Wu		<wuhaoze@mprc.pku.edu.cn>
 *
 * Copyright (C) 2014-2015 Microprocessor R&D Center (MPRC), Peking University
 */

#ifndef __SIMULATOR_H
#define __SIMULATOR_H

#define LUI 0
#define AUIPC 1
#define JAL 2
#define JALR 3
#define BEQ 4
#define BNE 5
#define BLT 6
#define BGE 7
#define BLTU 8
#define BGEU 9
#define LB 10
#define LH 11
#define LW 12
#define LBU 13
#define LHU 14
#define SB 15
#define SH 16
#define SW 17
#define ADDI 18
#define SLTI 19
#define SLTIU 20
#define XORI 21
#define ORI 22
#define ANDI 23
#define SLLI 24
#define SRLI 25
#define SRAI 26
#define ADD 27
#define SUB 28
#define SLL 29
#define SLT 30
#define SLTU 31
#define XOR 32
#define SRL 33
#define SRA 34
#define OR 35
#define AND 36
#define FLW 37
#define FLD 38
#define FSW 39
#define FSD 40
#if 0
#define FENCE 37
#define FENCE_I 38
#endif

#define SCALL 45

#if 0
#define SBREAK 40
#define RDCYCLE 41
#define RDCYCLEH 42
#define RDTIME 43
#define RDTIMEH 44
#define RDINSERT 45
#define RDINSERTH 46
#endif

#define UIMP 47
#define ILL 48


#endif /* __SIMULATOR_H */
