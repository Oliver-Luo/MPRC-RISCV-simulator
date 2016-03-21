
test1:     file format elf32-littleriscv


Disassembly of section .text:

00011054 <do_no_thing>:
   11054:	ff010113          	addi	sp,sp,-16
   11058:	00812623          	sw	s0,12(sp)
   1105c:	01010413          	addi	s0,sp,16
   11060:	00000013          	nop
   11064:	00c12403          	lw	s0,12(sp)
   11068:	01010113          	addi	sp,sp,16
   1106c:	00008067          	ret

00011070 <main>:
   11070:	fe010113          	addi	sp,sp,-32
   11074:	00112e23          	sw	ra,28(sp)
   11078:	00812c23          	sw	s0,24(sp)
   1107c:	02010413          	addi	s0,sp,32
   11080:	fe042623          	sw	zero,-20(s0)
   11084:	00500793          	li	a5,5
   11088:	fef42223          	sw	a5,-28(s0)
   1108c:	00a00793          	li	a5,10
   11090:	fef42423          	sw	a5,-24(s0)
   11094:	fc1ff0ef          	jal	11054 <do_no_thing>
   11098:	fec42703          	lw	a4,-20(s0)
   1109c:	fe442783          	lw	a5,-28(s0)
   110a0:	00f707b3          	add	a5,a4,a5
   110a4:	fef42623          	sw	a5,-20(s0)
   110a8:	fe842783          	lw	a5,-24(s0)
   110ac:	fff78793          	addi	a5,a5,-1
   110b0:	fef42423          	sw	a5,-24(s0)
   110b4:	fe842783          	lw	a5,-24(s0)
   110b8:	fe07d0e3          	bgez	a5,11098 <main+0x28>
   110bc:	00000793          	li	a5,0
   110c0:	00078513          	mv	a0,a5
   110c4:	01c12083          	lw	ra,28(sp)
   110c8:	01812403          	lw	s0,24(sp)
   110cc:	02010113          	addi	sp,sp,32
   110d0:	00008067          	ret
