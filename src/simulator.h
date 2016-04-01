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

#include <stdint.h>

//RV32I
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

//Not used here
#if 0
#define FLW 37
#define FLD 38
#define FSW 39
#define FSD 40
#define REMU 41
# define DIVU 42
#endif

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

//RV64I
#define LWU 47
#define LD 48
#define SD 49

//Repeted to RV32I
#if 0
#define SLLI 50
#define SRLI 51
#define SRAI 52
#endif

#define ADDIW 53
#define SLLIW 54
#define SRLIW 55
#define SRAIW 56
#define ADDW 57
#define SUBW 58
#define SLLW 59
#define SRLW 60
#define SRAW 61

//RV32M
#define MUL 62
#define MULH 63
#define MULHSU 64
#define MULHU 65
#define DIV 66
#define DIVU 67
#define REM 68
#define REMU 69

//RV64M
#define MULW 70
#define DIVW 71
#define DIVUW 72
#define REMW 73
#define REMUW 74

//RV32F
#define FLW 75
#define FSW 76
#define FMADD_S 77
#define FMSUB_S 78
#define FNMSUB_S 79
#define FNMADD_S 80
#define FADD_S 81
#define FSUB_S 82
#define FMUL_S 83
#define FDIV_S 84
#define FSQRT_S 85
#define FSGNJ_S 86
#define FSGNJN_S 87
#define FSGNJX_S 88
#define FMIN_S 89
#define FMAX_S 90
#define FCVT_W_S 91
#define FCVT_WU_S 92
#define FMV_X_S 93
#define FEQ_S 94
#define FLT_S 95
#define FLE_S 96
#define FCLASS_S 97
#define FCVT_S_W 98
#define FCVT_S_WU 99
#define FMV_S_X 100
#define FRCSR 101
#define FRRM 102
#define FRFLAGS 103
#define FSCSR 104
#define FSRM 105
#define FSFLAGS 106
#define FSRMI 107
#define FSFLAGSI 108

//RV64F
#define FCVT_L_S 109
#define FCVT_LU_S 110
#define FCVT_S_L 111
#define FCVT_S_LU 112

//RV32D
#define FLD 113
#define FSD 114
#define FMADD_D 115
#define FMSUB_D 116
#define FNMSUB_D 117
#define FNMADD_D 118
#define FADD_D 119
#define FSUB_D 120
#define FMUL_D 121
#define FDIV_D 122
#define FSQRT_D 123
#define FSGNJ_D 124
#define FSGNJN_D 125
#define FSGNJX_D 126
#define FMIN_D 127
#define FMAX_D 128
#define FCVT_S_D 129
#define FCVT_D_S 130
#define FEQ_D 131
#define FLT_D 132
#define FLE_D 133
#define FCLASS_D 134
#define FCVT_W_D 135
#define FCVT_WU_D 136
#define FCVT_D_W 137
#define FCVT_D_WU 138

//RV64D
#define FCVT_L_D 139
#define FCVT_LU_D 140
#define FMV_X_D 141
#define FCVT_D_L 142
#define FCVT_D_LU 143
#define FMV_D_X 144

//Other instructions
#define UIMP -1
#define ILL -2 

uint8_t retrieve_or_error(uint32_t addr);

#endif /* __SIMULATOR_H */
