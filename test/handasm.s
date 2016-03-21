
whztest:     file format elf32-littleriscv


Disassembly of section .text:

00011054 <main>:
   11054:	00064a37          	lui	s4,0x64
   11058:	0000a9b7          	lui	s3,0xa
   1105c:	0006ea97          	auipc	s5,0x6e
   11060:	008000ef          	jal	11068 <test1>
   11064:	064a0a13          	addi	s4,s4,100 # 64064 <__bss_start+0x51f04>

00011068 <test1>:
   11068:	0c8a0a13          	addi	s4,s4,200
   1106c:	01408093          	addi	ra,ra,20
   11070:	00008067          	ret
   11074:	00a00a13          	li	s4,10
   11078:	01400a13          	li	s4,20
   1107c:	01400a93          	li	s5,20
   11080:	015a0463          	beq	s4,s5,11088 <test2>
   11084:	00b00993          	li	s3,11

00011088 <test2>:
   11088:	00c00993          	li	s3,12
   1108c:	01300993          	li	s3,19
   11090:	01500993          	li	s3,21
   11094:	01600993          	li	s3,22
   11098:	0ef00a13          	li	s4,239
   1109c:	40302ab7          	lui	s5,0x40302
   110a0:	0f0aea93          	ori	s5,s5,240
   110a4:	015a0023          	sb	s5,0(s4)
   110a8:	0f000a13          	li	s4,240
   110ac:	015a1023          	sh	s5,0(s4)
   110b0:	0f400a13          	li	s4,244
   110b4:	015a2023          	sw	s5,0(s4)
   110b8:	000a0a83          	lb	s5,0(s4)
   110bc:	000a1a83          	lh	s5,0(s4)
   110c0:	000a2a83          	lw	s5,0(s4)
   110c4:	000a4a83          	lbu	s5,0(s4)
   110c8:	000a5a83          	lhu	s5,0(s4)
   110cc:	00100a13          	li	s4,1
   110d0:	00100a93          	li	s5,1
   110d4:	002a0a13          	addi	s4,s4,2
   110d8:	001a2a93          	slti	s5,s4,1
   110dc:	ffc00a13          	li	s4,-4
   110e0:	00100a93          	li	s5,1
   110e4:	001a3a93          	seqz	s5,s4
   110e8:	00000a93          	li	s5,0
   110ec:	00a00a13          	li	s4,10
   110f0:	00fa4a93          	xori	s5,s4,15
   110f4:	00faea93          	ori	s5,s5,15
   110f8:	004afa93          	andi	s5,s5,4
   110fc:	002a9a93          	slli	s5,s5,0x2
   11100:	001ada93          	srli	s5,s5,0x1
   11104:	ff800a93          	li	s5,-8
   11108:	402ada93          	srai	s5,s5,0x2
   1110c:	00200a93          	li	s5,2
   11110:	00300a13          	li	s4,3
   11114:	014a8ab3          	add	s5,s5,s4
   11118:	414a8ab3          	sub	s5,s5,s4
   1111c:	014a9ab3          	sll	s5,s5,s4
   11120:	014adab3          	srl	s5,s5,s4
   11124:	ff000a93          	li	s5,-16
   11128:	414adab3          	sra	s5,s5,s4
   1112c:	00a00a93          	li	s5,10
   11130:	00500a13          	li	s4,5
   11134:	014aeab3          	or	s5,s5,s4
   11138:	00a00a93          	li	s5,10
   1113c:	014afab3          	and	s5,s5,s4
   11140:	ff010113          	addi	sp,sp,-16
   11144:	00812623          	sw	s0,12(sp)
   11148:	01010413          	addi	s0,sp,16
   1114c:	00000793          	li	a5,0
   11150:	00078513          	mv	a0,a5
   11154:	00c12403          	lw	s0,12(sp)
   11158:	01010113          	addi	sp,sp,16
   1115c:	00008067          	ret
