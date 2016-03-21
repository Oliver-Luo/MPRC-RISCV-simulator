
qsort:     file format elf32-littleriscv


Disassembly of section .text:

00800074 <quicksort>:
  800074:	fd010113          	addi	sp,sp,-48
  800078:	02112623          	sw	ra,44(sp)
  80007c:	02812423          	sw	s0,40(sp)
  800080:	03010413          	addi	s0,sp,48
  800084:	fca42e23          	sw	a0,-36(s0)
  800088:	fcb42c23          	sw	a1,-40(s0)
  80008c:	fcc42a23          	sw	a2,-44(s0)
  800090:	fd842703          	lw	a4,-40(s0)
  800094:	fd442783          	lw	a5,-44(s0)
  800098:	1af75063          	ble	a5,a4,800238 <quicksort+0x1c4>
  80009c:	fd842783          	lw	a5,-40(s0)
  8000a0:	00279793          	slli	a5,a5,0x2
  8000a4:	fdc42703          	lw	a4,-36(s0)
  8000a8:	00f707b3          	add	a5,a4,a5
  8000ac:	0007a783          	lw	a5,0(a5)
  8000b0:	fef42223          	sw	a5,-28(s0)
  8000b4:	fd842783          	lw	a5,-40(s0)
  8000b8:	00178793          	addi	a5,a5,1
  8000bc:	fef42623          	sw	a5,-20(s0)
  8000c0:	fd442783          	lw	a5,-44(s0)
  8000c4:	fef42423          	sw	a5,-24(s0)
  8000c8:	fe042023          	sw	zero,-32(s0)
  8000cc:	0ec0006f          	j	8001b8 <quicksort+0x144>
  8000d0:	fec42783          	lw	a5,-20(s0)
  8000d4:	00178793          	addi	a5,a5,1
  8000d8:	fef42623          	sw	a5,-20(s0)
  8000dc:	fec42703          	lw	a4,-20(s0)
  8000e0:	fe842783          	lw	a5,-24(s0)
  8000e4:	02e7c863          	blt	a5,a4,800114 <quicksort+0xa0>
  8000e8:	fec42783          	lw	a5,-20(s0)
  8000ec:	00279793          	slli	a5,a5,0x2
  8000f0:	fdc42703          	lw	a4,-36(s0)
  8000f4:	00f707b3          	add	a5,a4,a5
  8000f8:	0007a703          	lw	a4,0(a5)
  8000fc:	fe442783          	lw	a5,-28(s0)
  800100:	fce7d8e3          	ble	a4,a5,8000d0 <quicksort+0x5c>
  800104:	0100006f          	j	800114 <quicksort+0xa0>
  800108:	fe842783          	lw	a5,-24(s0)
  80010c:	fff78793          	addi	a5,a5,-1
  800110:	fef42423          	sw	a5,-24(s0)
  800114:	fec42703          	lw	a4,-20(s0)
  800118:	fe842783          	lw	a5,-24(s0)
  80011c:	02e7c063          	blt	a5,a4,80013c <quicksort+0xc8>
  800120:	fe842783          	lw	a5,-24(s0)
  800124:	00279793          	slli	a5,a5,0x2
  800128:	fdc42703          	lw	a4,-36(s0)
  80012c:	00f707b3          	add	a5,a4,a5
  800130:	0007a703          	lw	a4,0(a5)
  800134:	fe442783          	lw	a5,-28(s0)
  800138:	fcf758e3          	ble	a5,a4,800108 <quicksort+0x94>
  80013c:	fec42703          	lw	a4,-20(s0)
  800140:	fe842783          	lw	a5,-24(s0)
  800144:	06f75a63          	ble	a5,a4,8001b8 <quicksort+0x144>
  800148:	fec42783          	lw	a5,-20(s0)
  80014c:	00279793          	slli	a5,a5,0x2
  800150:	fdc42703          	lw	a4,-36(s0)
  800154:	00f707b3          	add	a5,a4,a5
  800158:	0007a783          	lw	a5,0(a5)
  80015c:	fef42023          	sw	a5,-32(s0)
  800160:	fec42783          	lw	a5,-20(s0)
  800164:	00279793          	slli	a5,a5,0x2
  800168:	fdc42703          	lw	a4,-36(s0)
  80016c:	00f707b3          	add	a5,a4,a5
  800170:	fe842703          	lw	a4,-24(s0)
  800174:	00271713          	slli	a4,a4,0x2
  800178:	fdc42683          	lw	a3,-36(s0)
  80017c:	00e68733          	add	a4,a3,a4
  800180:	00072703          	lw	a4,0(a4)
  800184:	00e7a023          	sw	a4,0(a5)
  800188:	fe842783          	lw	a5,-24(s0)
  80018c:	00279793          	slli	a5,a5,0x2
  800190:	fdc42703          	lw	a4,-36(s0)
  800194:	00f707b3          	add	a5,a4,a5
  800198:	fe042703          	lw	a4,-32(s0)
  80019c:	00e7a023          	sw	a4,0(a5)
  8001a0:	fec42783          	lw	a5,-20(s0)
  8001a4:	00178793          	addi	a5,a5,1
  8001a8:	fef42623          	sw	a5,-20(s0)
  8001ac:	fe842783          	lw	a5,-24(s0)
  8001b0:	fff78793          	addi	a5,a5,-1
  8001b4:	fef42423          	sw	a5,-24(s0)
  8001b8:	fec42703          	lw	a4,-20(s0)
  8001bc:	fe842783          	lw	a5,-24(s0)
  8001c0:	f0e7dee3          	ble	a4,a5,8000dc <quicksort+0x68>
  8001c4:	fd842783          	lw	a5,-40(s0)
  8001c8:	00279793          	slli	a5,a5,0x2
  8001cc:	fdc42703          	lw	a4,-36(s0)
  8001d0:	00f707b3          	add	a5,a4,a5
  8001d4:	fe842703          	lw	a4,-24(s0)
  8001d8:	00271713          	slli	a4,a4,0x2
  8001dc:	fdc42683          	lw	a3,-36(s0)
  8001e0:	00e68733          	add	a4,a3,a4
  8001e4:	00072703          	lw	a4,0(a4)
  8001e8:	00e7a023          	sw	a4,0(a5)
  8001ec:	fe842783          	lw	a5,-24(s0)
  8001f0:	00279793          	slli	a5,a5,0x2
  8001f4:	fdc42703          	lw	a4,-36(s0)
  8001f8:	00f707b3          	add	a5,a4,a5
  8001fc:	fe442703          	lw	a4,-28(s0)
  800200:	00e7a023          	sw	a4,0(a5)
  800204:	fe842783          	lw	a5,-24(s0)
  800208:	fff78793          	addi	a5,a5,-1
  80020c:	00078613          	mv	a2,a5
  800210:	fd842583          	lw	a1,-40(s0)
  800214:	fdc42503          	lw	a0,-36(s0)
  800218:	e5dff0ef          	jal	800074 <quicksort>
  80021c:	fe842783          	lw	a5,-24(s0)
  800220:	00178793          	addi	a5,a5,1
  800224:	fd442603          	lw	a2,-44(s0)
  800228:	00078593          	mv	a1,a5
  80022c:	fdc42503          	lw	a0,-36(s0)
  800230:	e45ff0ef          	jal	800074 <quicksort>
  800234:	0080006f          	j	80023c <quicksort+0x1c8>
  800238:	00000013          	nop
  80023c:	02c12083          	lw	ra,44(sp)
  800240:	02812403          	lw	s0,40(sp)
  800244:	03010113          	addi	sp,sp,48
  800248:	00008067          	ret

0080024c <main>:
  80024c:	ff010113          	addi	sp,sp,-16
  800250:	00112623          	sw	ra,12(sp)
  800254:	00812423          	sw	s0,8(sp)
  800258:	01010413          	addi	s0,sp,16
  80025c:	00900613          	li	a2,9
  800260:	00000593          	li	a1,0
  800264:	008017b7          	lui	a5,0x801
  800268:	28878513          	addi	a0,a5,648 # 801288 <a>
  80026c:	e09ff0ef          	jal	800074 <quicksort>
  800270:	00000793          	li	a5,0
  800274:	00078513          	mv	a0,a5
  800278:	00c12083          	lw	ra,12(sp)
  80027c:	00812403          	lw	s0,8(sp)
  800280:	01010113          	addi	sp,sp,16
  800284:	00008067          	ret

Disassembly of section .data:

00801288 <a>:
  801288:	0022                	j	801290 <a+0x8>
  80128a:	0000                	unimp
  80128c:	0015                	0x15
  80128e:	0000                	unimp
  801290:	0000002b          	custom1	0,0,0,0
  801294:	00000003          	lb	zero,0(zero)
  801298:	0000002b          	custom1	0,0,0,0
  80129c:	0001                	0x1
  80129e:	0000                	unimp
  8012a0:	0005                	0x5
  8012a2:	0000                	unimp
  8012a4:	0008                	0x8
  8012a6:	0000                	unimp
  8012a8:	0009                	0x9
  8012aa:	0000                	unimp
  8012ac:	000a                	j	8012ae <a+0x26>
	...

Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347          	fmsub.d	ft6,ft6,ft4,ft7,rmm
   4:	2820                	srai	a6,a6,0x8
   6:	29554e47          	fmsub.s	ft8,fa0,fs5,ft5,rmm
   a:	3520                	srai	a0,a0,0x28
   c:	322e                	jal	fffff936 <_gp+0xff7fde86>
   e:	302e                	jal	fffff838 <_gp+0xff7fdd88>
	...
