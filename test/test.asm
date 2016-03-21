
test:     file format elf64-littleriscv


Disassembly of section .text:

0000000000010000 <_ftext>:
   10000:	00004197          	auipc	gp,0x4
   10004:	63018193          	addi	gp,gp,1584 # 14630 <_gp>
   10008:	00004297          	auipc	t0,0x4
   1000c:	e5028293          	addi	t0,t0,-432 # 13e58 <__malloc_max_total_mem>
   10010:	00004317          	auipc	t1,0x4
   10014:	ed830313          	addi	t1,t1,-296 # 13ee8 <_end>
   10018:	0002b023          	sd	zero,0(t0)
   1001c:	00828293          	addi	t0,t0,8
   10020:	fe62ece3          	bltu	t0,t1,10018 <_ftext+0x18>
   10024:	00000517          	auipc	a0,0x0
   10028:	23050513          	addi	a0,a0,560 # 10254 <__libc_fini_array>
   1002c:	144000ef          	jal	10170 <atexit>
   10030:	184000ef          	jal	101b4 <__libc_init_array>
   10034:	00012503          	lw	a0,0(sp)
   10038:	00810593          	addi	a1,sp,8
   1003c:	00000613          	li	a2,0
   10040:	100000ef          	jal	10140 <main>
   10044:	1400006f          	j	10184 <exit>

0000000000010048 <_fini>:
   10048:	00008067          	ret

000000000001004c <deregister_tm_clones>:
   1004c:	80018713          	addi	a4,gp,-2048 # 13e30 <_edata>
   10050:	80718793          	addi	a5,gp,-2041 # 13e37 <_edata+0x7>
   10054:	40e787b3          	sub	a5,a5,a4
   10058:	00e00713          	li	a4,14
   1005c:	00f77c63          	bleu	a5,a4,10074 <deregister_tm_clones+0x28>
   10060:	00000293          	li	t0,0
   10064:	00028863          	beqz	t0,10074 <deregister_tm_clones+0x28>
   10068:	80018513          	addi	a0,gp,-2048 # 13e30 <_edata>
   1006c:	00028313          	mv	t1,t0
   10070:	00030067          	jr	t1
   10074:	00008067          	ret

0000000000010078 <register_tm_clones>:
   10078:	80018593          	addi	a1,gp,-2048 # 13e30 <_edata>
   1007c:	80018793          	addi	a5,gp,-2048 # 13e30 <_edata>
   10080:	40b787b3          	sub	a5,a5,a1
   10084:	4037d793          	srai	a5,a5,0x3
   10088:	03f7d593          	srli	a1,a5,0x3f
   1008c:	00f585b3          	add	a1,a1,a5
   10090:	4015d593          	srai	a1,a1,0x1
   10094:	00058c63          	beqz	a1,100ac <register_tm_clones+0x34>
   10098:	00000293          	li	t0,0
   1009c:	00028863          	beqz	t0,100ac <register_tm_clones+0x34>
   100a0:	80018513          	addi	a0,gp,-2048 # 13e30 <_edata>
   100a4:	00028313          	mv	t1,t0
   100a8:	00030067          	jr	t1
   100ac:	00008067          	ret

00000000000100b0 <__do_global_dtors_aux>:
   100b0:	ff010113          	addi	sp,sp,-16
   100b4:	00813023          	sd	s0,0(sp)
   100b8:	8481c783          	lbu	a5,-1976(gp) # 13e78 <_bss_start>
   100bc:	00113423          	sd	ra,8(sp)
   100c0:	02079263          	bnez	a5,100e4 <__do_global_dtors_aux+0x34>
   100c4:	f89ff0ef          	jal	1004c <deregister_tm_clones>
   100c8:	00000793          	li	a5,0
   100cc:	00078863          	beqz	a5,100dc <__do_global_dtors_aux+0x2c>
   100d0:	00012537          	lui	a0,0x12
   100d4:	5f850513          	addi	a0,a0,1528 # 125f8 <__fini_array_end>
   100d8:	f29ef0ef          	jal	0 <_ftext-0x10000>
   100dc:	00100793          	li	a5,1
   100e0:	84f18423          	sb	a5,-1976(gp) # 13e78 <_bss_start>
   100e4:	00813083          	ld	ra,8(sp)
   100e8:	00013403          	ld	s0,0(sp)
   100ec:	01010113          	addi	sp,sp,16
   100f0:	00008067          	ret

00000000000100f4 <frame_dummy>:
   100f4:	ff010113          	addi	sp,sp,-16
   100f8:	00000793          	li	a5,0
   100fc:	00113423          	sd	ra,8(sp)
   10100:	00078a63          	beqz	a5,10114 <frame_dummy+0x20>
   10104:	00012537          	lui	a0,0x12
   10108:	85018593          	addi	a1,gp,-1968 # 13e80 <object.3089>
   1010c:	5f850513          	addi	a0,a0,1528 # 125f8 <__fini_array_end>
   10110:	ef1ef0ef          	jal	0 <_ftext-0x10000>
   10114:	00013537          	lui	a0,0x13
   10118:	ee050513          	addi	a0,a0,-288 # 12ee0 <__JCR_END__>
   1011c:	00053783          	ld	a5,0(a0)
   10120:	00079863          	bnez	a5,10130 <frame_dummy+0x3c>
   10124:	00813083          	ld	ra,8(sp)
   10128:	01010113          	addi	sp,sp,16
   1012c:	f4dff06f          	j	10078 <register_tm_clones>
   10130:	00000793          	li	a5,0
   10134:	fe0788e3          	beqz	a5,10124 <frame_dummy+0x30>
   10138:	000780e7          	jalr	a5
   1013c:	fe9ff06f          	j	10124 <frame_dummy+0x30>

0000000000010140 <main>:
   10140:	ff010113          	addi	sp,sp,-16
   10144:	00113423          	sd	ra,8(sp)
   10148:	00813023          	sd	s0,0(sp)
   1014c:	01010413          	addi	s0,sp,16
   10150:	03100513          	li	a0,49
   10154:	164000ef          	jal	102b8 <putchar>
   10158:	00000793          	li	a5,0
   1015c:	00078513          	mv	a0,a5
   10160:	00813083          	ld	ra,8(sp)
   10164:	00013403          	ld	s0,0(sp)
   10168:	01010113          	addi	sp,sp,16
   1016c:	00008067          	ret

0000000000010170 <atexit>:
   10170:	00050593          	mv	a1,a0
   10174:	00000693          	li	a3,0
   10178:	00000613          	li	a2,0
   1017c:	00000513          	li	a0,0
   10180:	5980006f          	j	10718 <__register_exitproc>

0000000000010184 <exit>:
   10184:	ff010113          	addi	sp,sp,-16
   10188:	00000593          	li	a1,0
   1018c:	00813023          	sd	s0,0(sp)
   10190:	00113423          	sd	ra,8(sp)
   10194:	00050413          	mv	s0,a0
   10198:	680000ef          	jal	10818 <__call_exitprocs>
   1019c:	8081b503          	ld	a0,-2040(gp) # 13e38 <_global_impure_ptr>
   101a0:	05853783          	ld	a5,88(a0)
   101a4:	00078463          	beqz	a5,101ac <exit+0x28>
   101a8:	000780e7          	jalr	a5
   101ac:	00040513          	mv	a0,s0
   101b0:	408020ef          	jal	125b8 <_exit>

00000000000101b4 <__libc_init_array>:
   101b4:	fe010113          	addi	sp,sp,-32
   101b8:	00813823          	sd	s0,16(sp)
   101bc:	000127b7          	lui	a5,0x12
   101c0:	00012437          	lui	s0,0x12
   101c4:	01213023          	sd	s2,0(sp)
   101c8:	5e878793          	addi	a5,a5,1512 # 125e8 <_etext>
   101cc:	5e840913          	addi	s2,s0,1512 # 125e8 <_etext>
   101d0:	41278933          	sub	s2,a5,s2
   101d4:	40395913          	srai	s2,s2,0x3
   101d8:	00913423          	sd	s1,8(sp)
   101dc:	00113c23          	sd	ra,24(sp)
   101e0:	5e840413          	addi	s0,s0,1512
   101e4:	00000493          	li	s1,0
   101e8:	00090c63          	beqz	s2,10200 <__libc_init_array+0x4c>
   101ec:	00043783          	ld	a5,0(s0)
   101f0:	00148493          	addi	s1,s1,1
   101f4:	00840413          	addi	s0,s0,8
   101f8:	000780e7          	jalr	a5
   101fc:	fe9918e3          	bne	s2,s1,101ec <__libc_init_array+0x38>
   10200:	00012437          	lui	s0,0x12
   10204:	e45ff0ef          	jal	10048 <_fini>
   10208:	000127b7          	lui	a5,0x12
   1020c:	5e840913          	addi	s2,s0,1512 # 125e8 <_etext>
   10210:	5f078793          	addi	a5,a5,1520 # 125f0 <__init_array_end>
   10214:	41278933          	sub	s2,a5,s2
   10218:	40395913          	srai	s2,s2,0x3
   1021c:	5e840413          	addi	s0,s0,1512
   10220:	00000493          	li	s1,0
   10224:	00090c63          	beqz	s2,1023c <__libc_init_array+0x88>
   10228:	00043783          	ld	a5,0(s0)
   1022c:	00148493          	addi	s1,s1,1
   10230:	00840413          	addi	s0,s0,8
   10234:	000780e7          	jalr	a5
   10238:	fe9918e3          	bne	s2,s1,10228 <__libc_init_array+0x74>
   1023c:	01813083          	ld	ra,24(sp)
   10240:	01013403          	ld	s0,16(sp)
   10244:	00813483          	ld	s1,8(sp)
   10248:	00013903          	ld	s2,0(sp)
   1024c:	02010113          	addi	sp,sp,32
   10250:	00008067          	ret

0000000000010254 <__libc_fini_array>:
   10254:	fe010113          	addi	sp,sp,-32
   10258:	00813823          	sd	s0,16(sp)
   1025c:	00913423          	sd	s1,8(sp)
   10260:	00012437          	lui	s0,0x12
   10264:	000124b7          	lui	s1,0x12
   10268:	5f048493          	addi	s1,s1,1520 # 125f0 <__init_array_end>
   1026c:	5f840413          	addi	s0,s0,1528 # 125f8 <__fini_array_end>
   10270:	40940433          	sub	s0,s0,s1
   10274:	ff840793          	addi	a5,s0,-8
   10278:	40345413          	srai	s0,s0,0x3
   1027c:	00113c23          	sd	ra,24(sp)
   10280:	009784b3          	add	s1,a5,s1
   10284:	00040c63          	beqz	s0,1029c <__libc_fini_array+0x48>
   10288:	0004b783          	ld	a5,0(s1)
   1028c:	fff40413          	addi	s0,s0,-1
   10290:	ff848493          	addi	s1,s1,-8
   10294:	000780e7          	jalr	a5
   10298:	fe0418e3          	bnez	s0,10288 <__libc_fini_array+0x34>
   1029c:	01813083          	ld	ra,24(sp)
   102a0:	01013403          	ld	s0,16(sp)
   102a4:	00813483          	ld	s1,8(sp)
   102a8:	02010113          	addi	sp,sp,32
   102ac:	d9dff06f          	j	10048 <_fini>

00000000000102b0 <_putchar_r>:
   102b0:	01053603          	ld	a2,16(a0)
   102b4:	0180006f          	j	102cc <_putc_r>

00000000000102b8 <putchar>:
   102b8:	8101b783          	ld	a5,-2032(gp) # 13e40 <_impure_ptr>
   102bc:	00050593          	mv	a1,a0
   102c0:	0107b603          	ld	a2,16(a5)
   102c4:	00078513          	mv	a0,a5
   102c8:	0040006f          	j	102cc <_putc_r>

00000000000102cc <_putc_r>:
   102cc:	fe010113          	addi	sp,sp,-32
   102d0:	00813823          	sd	s0,16(sp)
   102d4:	00113c23          	sd	ra,24(sp)
   102d8:	00050413          	mv	s0,a0
   102dc:	00050663          	beqz	a0,102e8 <_putc_r+0x1c>
   102e0:	05052783          	lw	a5,80(a0)
   102e4:	06078863          	beqz	a5,10354 <_putc_r+0x88>
   102e8:	00c62783          	lw	a5,12(a2)
   102ec:	fff7879b          	addiw	a5,a5,-1
   102f0:	00f62623          	sw	a5,12(a2)
   102f4:	0207c663          	bltz	a5,10320 <_putc_r+0x54>
   102f8:	00063783          	ld	a5,0(a2)
   102fc:	00b78023          	sb	a1,0(a5)
   10300:	00063783          	ld	a5,0(a2)
   10304:	01813083          	ld	ra,24(sp)
   10308:	00178713          	addi	a4,a5,1
   1030c:	00e63023          	sd	a4,0(a2)
   10310:	0007c503          	lbu	a0,0(a5)
   10314:	01013403          	ld	s0,16(sp)
   10318:	02010113          	addi	sp,sp,32
   1031c:	00008067          	ret
   10320:	02862703          	lw	a4,40(a2)
   10324:	00e7ce63          	blt	a5,a4,10340 <_putc_r+0x74>
   10328:	00063783          	ld	a5,0(a2)
   1032c:	00a00713          	li	a4,10
   10330:	00b78023          	sb	a1,0(a5)
   10334:	00063783          	ld	a5,0(a2)
   10338:	0007c583          	lbu	a1,0(a5)
   1033c:	fce594e3          	bne	a1,a4,10304 <_putc_r+0x38>
   10340:	00040513          	mv	a0,s0
   10344:	01813083          	ld	ra,24(sp)
   10348:	01013403          	ld	s0,16(sp)
   1034c:	02010113          	addi	sp,sp,32
   10350:	0e00006f          	j	10430 <__swbuf_r>
   10354:	00b13423          	sd	a1,8(sp)
   10358:	00c13023          	sd	a2,0(sp)
   1035c:	421000ef          	jal	10f7c <__sinit>
   10360:	00013603          	ld	a2,0(sp)
   10364:	00813583          	ld	a1,8(sp)
   10368:	f81ff06f          	j	102e8 <_putc_r+0x1c>

000000000001036c <putc>:
   1036c:	fd010113          	addi	sp,sp,-48
   10370:	02813023          	sd	s0,32(sp)
   10374:	8101b783          	ld	a5,-2032(gp) # 13e40 <_impure_ptr>
   10378:	00913c23          	sd	s1,24(sp)
   1037c:	02113423          	sd	ra,40(sp)
   10380:	00050493          	mv	s1,a0
   10384:	00078663          	beqz	a5,10390 <putc+0x24>
   10388:	0507a703          	lw	a4,80(a5)
   1038c:	06070863          	beqz	a4,103fc <putc+0x90>
   10390:	00c5a783          	lw	a5,12(a1)
   10394:	fff7879b          	addiw	a5,a5,-1
   10398:	00f5a623          	sw	a5,12(a1)
   1039c:	0207c863          	bltz	a5,103cc <putc+0x60>
   103a0:	0005b783          	ld	a5,0(a1)
   103a4:	00978023          	sb	s1,0(a5)
   103a8:	0005b783          	ld	a5,0(a1)
   103ac:	02813083          	ld	ra,40(sp)
   103b0:	00178713          	addi	a4,a5,1
   103b4:	00e5b023          	sd	a4,0(a1)
   103b8:	0007c503          	lbu	a0,0(a5)
   103bc:	02013403          	ld	s0,32(sp)
   103c0:	01813483          	ld	s1,24(sp)
   103c4:	03010113          	addi	sp,sp,48
   103c8:	00008067          	ret
   103cc:	0285a703          	lw	a4,40(a1)
   103d0:	04e7c063          	blt	a5,a4,10410 <putc+0xa4>
   103d4:	0005b783          	ld	a5,0(a1)
   103d8:	00a00693          	li	a3,10
   103dc:	00978023          	sb	s1,0(a5)
   103e0:	0005b783          	ld	a5,0(a1)
   103e4:	0007c703          	lbu	a4,0(a5)
   103e8:	fcd712e3          	bne	a4,a3,103ac <putc+0x40>
   103ec:	00058613          	mv	a2,a1
   103f0:	8101b503          	ld	a0,-2032(gp) # 13e40 <_impure_ptr>
   103f4:	00070593          	mv	a1,a4
   103f8:	0240006f          	j	1041c <putc+0xb0>
   103fc:	00078513          	mv	a0,a5
   10400:	00b13423          	sd	a1,8(sp)
   10404:	379000ef          	jal	10f7c <__sinit>
   10408:	00813583          	ld	a1,8(sp)
   1040c:	f85ff06f          	j	10390 <putc+0x24>
   10410:	8101b503          	ld	a0,-2032(gp) # 13e40 <_impure_ptr>
   10414:	00058613          	mv	a2,a1
   10418:	00048593          	mv	a1,s1
   1041c:	02813083          	ld	ra,40(sp)
   10420:	02013403          	ld	s0,32(sp)
   10424:	01813483          	ld	s1,24(sp)
   10428:	03010113          	addi	sp,sp,48
   1042c:	0040006f          	j	10430 <__swbuf_r>

0000000000010430 <__swbuf_r>:
   10430:	fd010113          	addi	sp,sp,-48
   10434:	02813023          	sd	s0,32(sp)
   10438:	00913c23          	sd	s1,24(sp)
   1043c:	01313423          	sd	s3,8(sp)
   10440:	02113423          	sd	ra,40(sp)
   10444:	01213823          	sd	s2,16(sp)
   10448:	00050493          	mv	s1,a0
   1044c:	00058993          	mv	s3,a1
   10450:	00060413          	mv	s0,a2
   10454:	00050663          	beqz	a0,10460 <__swbuf_r+0x30>
   10458:	05052783          	lw	a5,80(a0)
   1045c:	12078e63          	beqz	a5,10598 <__swbuf_r+0x168>
   10460:	01041683          	lh	a3,16(s0)
   10464:	02842603          	lw	a2,40(s0)
   10468:	03069713          	slli	a4,a3,0x30
   1046c:	03075713          	srli	a4,a4,0x30
   10470:	00877793          	andi	a5,a4,8
   10474:	00c42623          	sw	a2,12(s0)
   10478:	0e078e63          	beqz	a5,10574 <__swbuf_r+0x144>
   1047c:	01843783          	ld	a5,24(s0)
   10480:	0e078a63          	beqz	a5,10574 <__swbuf_r+0x144>
   10484:	03271613          	slli	a2,a4,0x32
   10488:	0ff9f913          	andi	s2,s3,255
   1048c:	06065663          	bgez	a2,104f8 <__swbuf_r+0xc8>
   10490:	00043703          	ld	a4,0(s0)
   10494:	02042683          	lw	a3,32(s0)
   10498:	40f707bb          	subw	a5,a4,a5
   1049c:	08d7d663          	ble	a3,a5,10528 <__swbuf_r+0xf8>
   104a0:	0017879b          	addiw	a5,a5,1
   104a4:	00c42683          	lw	a3,12(s0)
   104a8:	00170613          	addi	a2,a4,1
   104ac:	00c43023          	sd	a2,0(s0)
   104b0:	fff6869b          	addiw	a3,a3,-1
   104b4:	00d42623          	sw	a3,12(s0)
   104b8:	01370023          	sb	s3,0(a4)
   104bc:	02042703          	lw	a4,32(s0)
   104c0:	08f70263          	beq	a4,a5,10544 <__swbuf_r+0x114>
   104c4:	01045783          	lhu	a5,16(s0)
   104c8:	00090513          	mv	a0,s2
   104cc:	0017f793          	andi	a5,a5,1
   104d0:	00078663          	beqz	a5,104dc <__swbuf_r+0xac>
   104d4:	00a00793          	li	a5,10
   104d8:	06f90663          	beq	s2,a5,10544 <__swbuf_r+0x114>
   104dc:	02813083          	ld	ra,40(sp)
   104e0:	02013403          	ld	s0,32(sp)
   104e4:	01813483          	ld	s1,24(sp)
   104e8:	01013903          	ld	s2,16(sp)
   104ec:	00813983          	ld	s3,8(sp)
   104f0:	03010113          	addi	sp,sp,48
   104f4:	00008067          	ret
   104f8:	0a442583          	lw	a1,164(s0)
   104fc:	ffffe737          	lui	a4,0xffffe
   10500:	fff7071b          	addiw	a4,a4,-1
   10504:	00e5f733          	and	a4,a1,a4
   10508:	00002637          	lui	a2,0x2
   1050c:	00c6e6b3          	or	a3,a3,a2
   10510:	0ae42223          	sw	a4,164(s0)
   10514:	00043703          	ld	a4,0(s0)
   10518:	00d41823          	sh	a3,16(s0)
   1051c:	02042683          	lw	a3,32(s0)
   10520:	40f707bb          	subw	a5,a4,a5
   10524:	f6d7cee3          	blt	a5,a3,104a0 <__swbuf_r+0x70>
   10528:	00040593          	mv	a1,s0
   1052c:	00048513          	mv	a0,s1
   10530:	474000ef          	jal	109a4 <_fflush_r>
   10534:	06051663          	bnez	a0,105a0 <__swbuf_r+0x170>
   10538:	00043703          	ld	a4,0(s0)
   1053c:	00100793          	li	a5,1
   10540:	f65ff06f          	j	104a4 <__swbuf_r+0x74>
   10544:	00040593          	mv	a1,s0
   10548:	00048513          	mv	a0,s1
   1054c:	458000ef          	jal	109a4 <_fflush_r>
   10550:	04051863          	bnez	a0,105a0 <__swbuf_r+0x170>
   10554:	02813083          	ld	ra,40(sp)
   10558:	00090513          	mv	a0,s2
   1055c:	02013403          	ld	s0,32(sp)
   10560:	01813483          	ld	s1,24(sp)
   10564:	01013903          	ld	s2,16(sp)
   10568:	00813983          	ld	s3,8(sp)
   1056c:	03010113          	addi	sp,sp,48
   10570:	00008067          	ret
   10574:	00040593          	mv	a1,s0
   10578:	00048513          	mv	a0,s1
   1057c:	058000ef          	jal	105d4 <__swsetup_r>
   10580:	02051463          	bnez	a0,105a8 <__swbuf_r+0x178>
   10584:	01041683          	lh	a3,16(s0)
   10588:	01843783          	ld	a5,24(s0)
   1058c:	03069713          	slli	a4,a3,0x30
   10590:	03075713          	srli	a4,a4,0x30
   10594:	ef1ff06f          	j	10484 <__swbuf_r+0x54>
   10598:	1e5000ef          	jal	10f7c <__sinit>
   1059c:	ec5ff06f          	j	10460 <__swbuf_r+0x30>
   105a0:	fff00513          	li	a0,-1
   105a4:	f39ff06f          	j	104dc <__swbuf_r+0xac>
   105a8:	01045783          	lhu	a5,16(s0)
   105ac:	fff00513          	li	a0,-1
   105b0:	0407e793          	ori	a5,a5,64
   105b4:	00f41823          	sh	a5,16(s0)
   105b8:	00900793          	li	a5,9
   105bc:	00f4a023          	sw	a5,0(s1)
   105c0:	f1dff06f          	j	104dc <__swbuf_r+0xac>

00000000000105c4 <__swbuf>:
   105c4:	00058613          	mv	a2,a1
   105c8:	00050593          	mv	a1,a0
   105cc:	8101b503          	ld	a0,-2032(gp) # 13e40 <_impure_ptr>
   105d0:	e61ff06f          	j	10430 <__swbuf_r>

00000000000105d4 <__swsetup_r>:
   105d4:	8101b783          	ld	a5,-2032(gp) # 13e40 <_impure_ptr>
   105d8:	fe010113          	addi	sp,sp,-32
   105dc:	00813823          	sd	s0,16(sp)
   105e0:	00913423          	sd	s1,8(sp)
   105e4:	00113c23          	sd	ra,24(sp)
   105e8:	00050493          	mv	s1,a0
   105ec:	00058413          	mv	s0,a1
   105f0:	00078663          	beqz	a5,105fc <__swsetup_r+0x28>
   105f4:	0507a703          	lw	a4,80(a5)
   105f8:	0c070c63          	beqz	a4,106d0 <__swsetup_r+0xfc>
   105fc:	01041703          	lh	a4,16(s0)
   10600:	03071793          	slli	a5,a4,0x30
   10604:	0307d793          	srli	a5,a5,0x30
   10608:	0087f693          	andi	a3,a5,8
   1060c:	04068263          	beqz	a3,10650 <__swsetup_r+0x7c>
   10610:	01843683          	ld	a3,24(s0)
   10614:	06068663          	beqz	a3,10680 <__swsetup_r+0xac>
   10618:	0017f713          	andi	a4,a5,1
   1061c:	08071463          	bnez	a4,106a4 <__swsetup_r+0xd0>
   10620:	0027f793          	andi	a5,a5,2
   10624:	00000713          	li	a4,0
   10628:	00079463          	bnez	a5,10630 <__swsetup_r+0x5c>
   1062c:	02042703          	lw	a4,32(s0)
   10630:	00e42623          	sw	a4,12(s0)
   10634:	00000513          	li	a0,0
   10638:	08068263          	beqz	a3,106bc <__swsetup_r+0xe8>
   1063c:	01813083          	ld	ra,24(sp)
   10640:	01013403          	ld	s0,16(sp)
   10644:	00813483          	ld	s1,8(sp)
   10648:	02010113          	addi	sp,sp,32
   1064c:	00008067          	ret
   10650:	0107f693          	andi	a3,a5,16
   10654:	06068a63          	beqz	a3,106c8 <__swsetup_r+0xf4>
   10658:	0047f793          	andi	a5,a5,4
   1065c:	08079063          	bnez	a5,106dc <__swsetup_r+0x108>
   10660:	01843683          	ld	a3,24(s0)
   10664:	00876793          	ori	a5,a4,8
   10668:	0107979b          	slliw	a5,a5,0x10
   1066c:	4107d79b          	sraiw	a5,a5,0x10
   10670:	00f41823          	sh	a5,16(s0)
   10674:	03079793          	slli	a5,a5,0x30
   10678:	0307d793          	srli	a5,a5,0x30
   1067c:	f8069ee3          	bnez	a3,10618 <__swsetup_r+0x44>
   10680:	2807f713          	andi	a4,a5,640
   10684:	20000613          	li	a2,512
   10688:	f8c708e3          	beq	a4,a2,10618 <__swsetup_r+0x44>
   1068c:	00040593          	mv	a1,s0
   10690:	00048513          	mv	a0,s1
   10694:	6a5000ef          	jal	11538 <__smakebuf_r>
   10698:	01045783          	lhu	a5,16(s0)
   1069c:	01843683          	ld	a3,24(s0)
   106a0:	f79ff06f          	j	10618 <__swsetup_r+0x44>
   106a4:	02042783          	lw	a5,32(s0)
   106a8:	00042623          	sw	zero,12(s0)
   106ac:	00000513          	li	a0,0
   106b0:	40f007bb          	negw	a5,a5
   106b4:	02f42423          	sw	a5,40(s0)
   106b8:	f80692e3          	bnez	a3,1063c <__swsetup_r+0x68>
   106bc:	01045783          	lhu	a5,16(s0)
   106c0:	0807f793          	andi	a5,a5,128
   106c4:	f6078ce3          	beqz	a5,1063c <__swsetup_r+0x68>
   106c8:	fff00513          	li	a0,-1
   106cc:	f71ff06f          	j	1063c <__swsetup_r+0x68>
   106d0:	00078513          	mv	a0,a5
   106d4:	0a9000ef          	jal	10f7c <__sinit>
   106d8:	f25ff06f          	j	105fc <__swsetup_r+0x28>
   106dc:	05843583          	ld	a1,88(s0)
   106e0:	00058e63          	beqz	a1,106fc <__swsetup_r+0x128>
   106e4:	07440793          	addi	a5,s0,116
   106e8:	00f58863          	beq	a1,a5,106f8 <__swsetup_r+0x124>
   106ec:	00048513          	mv	a0,s1
   106f0:	1e5000ef          	jal	110d4 <_free_r>
   106f4:	01041703          	lh	a4,16(s0)
   106f8:	04043c23          	sd	zero,88(s0)
   106fc:	01843683          	ld	a3,24(s0)
   10700:	fdb77713          	andi	a4,a4,-37
   10704:	0107171b          	slliw	a4,a4,0x10
   10708:	4107571b          	sraiw	a4,a4,0x10
   1070c:	00042423          	sw	zero,8(s0)
   10710:	00d43023          	sd	a3,0(s0)
   10714:	f51ff06f          	j	10664 <__swsetup_r+0x90>

0000000000010718 <__register_exitproc>:
   10718:	fc010113          	addi	sp,sp,-64
   1071c:	02813823          	sd	s0,48(sp)
   10720:	8081b403          	ld	s0,-2040(gp) # 13e38 <_global_impure_ptr>
   10724:	02913423          	sd	s1,40(sp)
   10728:	00050493          	mv	s1,a0
   1072c:	1f843503          	ld	a0,504(s0)
   10730:	02113c23          	sd	ra,56(sp)
   10734:	0c050863          	beqz	a0,10804 <__register_exitproc+0xec>
   10738:	00852703          	lw	a4,8(a0)
   1073c:	01f00793          	li	a5,31
   10740:	0017089b          	addiw	a7,a4,1
   10744:	04e7d863          	ble	a4,a5,10794 <__register_exitproc+0x7c>
   10748:	00000793          	li	a5,0
   1074c:	0c078263          	beqz	a5,10810 <__register_exitproc+0xf8>
   10750:	31800513          	li	a0,792
   10754:	00b13c23          	sd	a1,24(sp)
   10758:	00c13823          	sd	a2,16(sp)
   1075c:	00d13423          	sd	a3,8(sp)
   10760:	8a1ef0ef          	jal	0 <_ftext-0x10000>
   10764:	01813583          	ld	a1,24(sp)
   10768:	01013603          	ld	a2,16(sp)
   1076c:	00813683          	ld	a3,8(sp)
   10770:	0a050063          	beqz	a0,10810 <__register_exitproc+0xf8>
   10774:	1f843783          	ld	a5,504(s0)
   10778:	00100893          	li	a7,1
   1077c:	00052423          	sw	zero,8(a0)
   10780:	00f53023          	sd	a5,0(a0)
   10784:	00000713          	li	a4,0
   10788:	1ea43c23          	sd	a0,504(s0)
   1078c:	30052823          	sw	zero,784(a0)
   10790:	30052a23          	sw	zero,788(a0)
   10794:	00070793          	mv	a5,a4
   10798:	02049863          	bnez	s1,107c8 <__register_exitproc+0xb0>
   1079c:	00278793          	addi	a5,a5,2
   107a0:	00379793          	slli	a5,a5,0x3
   107a4:	00f507b3          	add	a5,a0,a5
   107a8:	01152423          	sw	a7,8(a0)
   107ac:	00000513          	li	a0,0
   107b0:	00b7b023          	sd	a1,0(a5)
   107b4:	03813083          	ld	ra,56(sp)
   107b8:	03013403          	ld	s0,48(sp)
   107bc:	02813483          	ld	s1,40(sp)
   107c0:	04010113          	addi	sp,sp,64
   107c4:	00008067          	ret
   107c8:	00371813          	slli	a6,a4,0x3
   107cc:	01050833          	add	a6,a0,a6
   107d0:	10c83823          	sd	a2,272(a6)
   107d4:	31052283          	lw	t0,784(a0)
   107d8:	00100613          	li	a2,1
   107dc:	00e6173b          	sllw	a4,a2,a4
   107e0:	00e2e633          	or	a2,t0,a4
   107e4:	30c52823          	sw	a2,784(a0)
   107e8:	20d83823          	sd	a3,528(a6)
   107ec:	00200693          	li	a3,2
   107f0:	fad496e3          	bne	s1,a3,1079c <__register_exitproc+0x84>
   107f4:	31452683          	lw	a3,788(a0)
   107f8:	00e6e733          	or	a4,a3,a4
   107fc:	30e52a23          	sw	a4,788(a0)
   10800:	f9dff06f          	j	1079c <__register_exitproc+0x84>
   10804:	20040513          	addi	a0,s0,512
   10808:	1ea43c23          	sd	a0,504(s0)
   1080c:	f2dff06f          	j	10738 <__register_exitproc+0x20>
   10810:	fff00513          	li	a0,-1
   10814:	fa1ff06f          	j	107b4 <__register_exitproc+0x9c>

0000000000010818 <__call_exitprocs>:
   10818:	fa010113          	addi	sp,sp,-96
   1081c:	03413823          	sd	s4,48(sp)
   10820:	8081ba03          	ld	s4,-2040(gp) # 13e38 <_global_impure_ptr>
   10824:	03313c23          	sd	s3,56(sp)
   10828:	04913423          	sd	s1,72(sp)
   1082c:	05213023          	sd	s2,64(sp)
   10830:	03513423          	sd	s5,40(sp)
   10834:	01713c23          	sd	s7,24(sp)
   10838:	01813823          	sd	s8,16(sp)
   1083c:	04113c23          	sd	ra,88(sp)
   10840:	04813823          	sd	s0,80(sp)
   10844:	03613023          	sd	s6,32(sp)
   10848:	01913423          	sd	s9,8(sp)
   1084c:	01a13023          	sd	s10,0(sp)
   10850:	00050913          	mv	s2,a0
   10854:	00058b93          	mv	s7,a1
   10858:	1f8a0a93          	addi	s5,s4,504
   1085c:	00100493          	li	s1,1
   10860:	fff00c13          	li	s8,-1
   10864:	00000993          	li	s3,0
   10868:	1f8a3b03          	ld	s6,504(s4)
   1086c:	0c0b0463          	beqz	s6,10934 <__call_exitprocs+0x11c>
   10870:	000a8d13          	mv	s10,s5
   10874:	008b2403          	lw	s0,8(s6)
   10878:	fff4041b          	addiw	s0,s0,-1
   1087c:	02045263          	bgez	s0,108a0 <__call_exitprocs+0x88>
   10880:	08c0006f          	j	1090c <__call_exitprocs+0xf4>
   10884:	02040793          	addi	a5,s0,32
   10888:	00379793          	slli	a5,a5,0x3
   1088c:	00fb07b3          	add	a5,s6,a5
   10890:	1107b783          	ld	a5,272(a5)
   10894:	00fb8a63          	beq	s7,a5,108a8 <__call_exitprocs+0x90>
   10898:	fff4041b          	addiw	s0,s0,-1
   1089c:	07840863          	beq	s0,s8,1090c <__call_exitprocs+0xf4>
   108a0:	00040713          	mv	a4,s0
   108a4:	fe0b90e3          	bnez	s7,10884 <__call_exitprocs+0x6c>
   108a8:	008b2783          	lw	a5,8(s6)
   108ac:	00371713          	slli	a4,a4,0x3
   108b0:	00eb0733          	add	a4,s6,a4
   108b4:	fff7879b          	addiw	a5,a5,-1
   108b8:	01073683          	ld	a3,16(a4) # ffffffffffffe010 <_gp+0xfffffffffffe99e0>
   108bc:	0a878c63          	beq	a5,s0,10974 <__call_exitprocs+0x15c>
   108c0:	00073823          	sd	zero,16(a4)
   108c4:	fc068ae3          	beqz	a3,10898 <__call_exitprocs+0x80>
   108c8:	310b2783          	lw	a5,784(s6)
   108cc:	0084963b          	sllw	a2,s1,s0
   108d0:	008b2c83          	lw	s9,8(s6)
   108d4:	00f677b3          	and	a5,a2,a5
   108d8:	08078a63          	beqz	a5,1096c <__call_exitprocs+0x154>
   108dc:	314b2783          	lw	a5,788(s6)
   108e0:	00f67633          	and	a2,a2,a5
   108e4:	08061c63          	bnez	a2,1097c <__call_exitprocs+0x164>
   108e8:	11073583          	ld	a1,272(a4)
   108ec:	00090513          	mv	a0,s2
   108f0:	000680e7          	jalr	a3
   108f4:	008b2783          	lw	a5,8(s6)
   108f8:	f79798e3          	bne	a5,s9,10868 <__call_exitprocs+0x50>
   108fc:	000d3783          	ld	a5,0(s10)
   10900:	f76794e3          	bne	a5,s6,10868 <__call_exitprocs+0x50>
   10904:	fff4041b          	addiw	s0,s0,-1
   10908:	f9841ce3          	bne	s0,s8,108a0 <__call_exitprocs+0x88>
   1090c:	02098463          	beqz	s3,10934 <__call_exitprocs+0x11c>
   10910:	008b2783          	lw	a5,8(s6)
   10914:	06079a63          	bnez	a5,10988 <__call_exitprocs+0x170>
   10918:	000b3783          	ld	a5,0(s6)
   1091c:	08078063          	beqz	a5,1099c <__call_exitprocs+0x184>
   10920:	000b0513          	mv	a0,s6
   10924:	00fd3023          	sd	a5,0(s10)
   10928:	ed8ef0ef          	jal	0 <_ftext-0x10000>
   1092c:	000d3b03          	ld	s6,0(s10)
   10930:	f40b12e3          	bnez	s6,10874 <__call_exitprocs+0x5c>
   10934:	05813083          	ld	ra,88(sp)
   10938:	05013403          	ld	s0,80(sp)
   1093c:	04813483          	ld	s1,72(sp)
   10940:	04013903          	ld	s2,64(sp)
   10944:	03813983          	ld	s3,56(sp)
   10948:	03013a03          	ld	s4,48(sp)
   1094c:	02813a83          	ld	s5,40(sp)
   10950:	02013b03          	ld	s6,32(sp)
   10954:	01813b83          	ld	s7,24(sp)
   10958:	01013c03          	ld	s8,16(sp)
   1095c:	00813c83          	ld	s9,8(sp)
   10960:	00013d03          	ld	s10,0(sp)
   10964:	06010113          	addi	sp,sp,96
   10968:	00008067          	ret
   1096c:	000680e7          	jalr	a3
   10970:	f85ff06f          	j	108f4 <__call_exitprocs+0xdc>
   10974:	008b2423          	sw	s0,8(s6)
   10978:	f4dff06f          	j	108c4 <__call_exitprocs+0xac>
   1097c:	11073503          	ld	a0,272(a4)
   10980:	000680e7          	jalr	a3
   10984:	f71ff06f          	j	108f4 <__call_exitprocs+0xdc>
   10988:	000b3783          	ld	a5,0(s6)
   1098c:	000b0d13          	mv	s10,s6
   10990:	00078b13          	mv	s6,a5
   10994:	ee0b10e3          	bnez	s6,10874 <__call_exitprocs+0x5c>
   10998:	f9dff06f          	j	10934 <__call_exitprocs+0x11c>
   1099c:	00000793          	li	a5,0
   109a0:	fedff06f          	j	1098c <__call_exitprocs+0x174>

00000000000109a4 <_fflush_r>:
   109a4:	fd010113          	addi	sp,sp,-48
   109a8:	02813023          	sd	s0,32(sp)
   109ac:	01313423          	sd	s3,8(sp)
   109b0:	02113423          	sd	ra,40(sp)
   109b4:	00913c23          	sd	s1,24(sp)
   109b8:	01213823          	sd	s2,16(sp)
   109bc:	00050993          	mv	s3,a0
   109c0:	00058413          	mv	s0,a1
   109c4:	00050663          	beqz	a0,109d0 <_fflush_r+0x2c>
   109c8:	05052783          	lw	a5,80(a0)
   109cc:	18078463          	beqz	a5,10b54 <_fflush_r+0x1b0>
   109d0:	01041703          	lh	a4,16(s0)
   109d4:	0c070e63          	beqz	a4,10ab0 <_fflush_r+0x10c>
   109d8:	00877793          	andi	a5,a4,8
   109dc:	0e079a63          	bnez	a5,10ad0 <_fflush_r+0x12c>
   109e0:	000017b7          	lui	a5,0x1
   109e4:	8007879b          	addiw	a5,a5,-2048
   109e8:	00f767b3          	or	a5,a4,a5
   109ec:	00842683          	lw	a3,8(s0)
   109f0:	0107979b          	slliw	a5,a5,0x10
   109f4:	4107d79b          	sraiw	a5,a5,0x10
   109f8:	00f41823          	sh	a5,16(s0)
   109fc:	18d05a63          	blez	a3,10b90 <_fflush_r+0x1ec>
   10a00:	04843703          	ld	a4,72(s0)
   10a04:	0a070663          	beqz	a4,10ab0 <_fflush_r+0x10c>
   10a08:	03079793          	slli	a5,a5,0x30
   10a0c:	0307d793          	srli	a5,a5,0x30
   10a10:	03379693          	slli	a3,a5,0x33
   10a14:	0009a483          	lw	s1,0(s3)
   10a18:	0009a023          	sw	zero,0(s3)
   10a1c:	1406d463          	bgez	a3,10b64 <_fflush_r+0x1c0>
   10a20:	08c42603          	lw	a2,140(s0)
   10a24:	0047f793          	andi	a5,a5,4
   10a28:	00078e63          	beqz	a5,10a44 <_fflush_r+0xa0>
   10a2c:	00842683          	lw	a3,8(s0)
   10a30:	05843783          	ld	a5,88(s0)
   10a34:	40d60633          	sub	a2,a2,a3
   10a38:	00078663          	beqz	a5,10a44 <_fflush_r+0xa0>
   10a3c:	07042783          	lw	a5,112(s0)
   10a40:	40f60633          	sub	a2,a2,a5
   10a44:	03043583          	ld	a1,48(s0)
   10a48:	00000693          	li	a3,0
   10a4c:	00098513          	mv	a0,s3
   10a50:	000700e7          	jalr	a4
   10a54:	fff00793          	li	a5,-1
   10a58:	14f50263          	beq	a0,a5,10b9c <_fflush_r+0x1f8>
   10a5c:	01045683          	lhu	a3,16(s0)
   10a60:	fffff7b7          	lui	a5,0xfffff
   10a64:	7ff7879b          	addiw	a5,a5,2047
   10a68:	01843703          	ld	a4,24(s0)
   10a6c:	00f6f7b3          	and	a5,a3,a5
   10a70:	0107979b          	slliw	a5,a5,0x10
   10a74:	4107d79b          	sraiw	a5,a5,0x10
   10a78:	00e43023          	sd	a4,0(s0)
   10a7c:	03379713          	slli	a4,a5,0x33
   10a80:	00f41823          	sh	a5,16(s0)
   10a84:	00042423          	sw	zero,8(s0)
   10a88:	00075463          	bgez	a4,10a90 <_fflush_r+0xec>
   10a8c:	08a42623          	sw	a0,140(s0)
   10a90:	05843583          	ld	a1,88(s0)
   10a94:	0099a023          	sw	s1,0(s3)
   10a98:	00058c63          	beqz	a1,10ab0 <_fflush_r+0x10c>
   10a9c:	07440793          	addi	a5,s0,116
   10aa0:	00f58663          	beq	a1,a5,10aac <_fflush_r+0x108>
   10aa4:	00098513          	mv	a0,s3
   10aa8:	62c000ef          	jal	110d4 <_free_r>
   10aac:	04043c23          	sd	zero,88(s0)
   10ab0:	00000513          	li	a0,0
   10ab4:	02813083          	ld	ra,40(sp)
   10ab8:	02013403          	ld	s0,32(sp)
   10abc:	01813483          	ld	s1,24(sp)
   10ac0:	01013903          	ld	s2,16(sp)
   10ac4:	00813983          	ld	s3,8(sp)
   10ac8:	03010113          	addi	sp,sp,48
   10acc:	00008067          	ret
   10ad0:	01843903          	ld	s2,24(s0)
   10ad4:	fc090ee3          	beqz	s2,10ab0 <_fflush_r+0x10c>
   10ad8:	00043483          	ld	s1,0(s0)
   10adc:	00377793          	andi	a5,a4,3
   10ae0:	01243023          	sd	s2,0(s0)
   10ae4:	412484bb          	subw	s1,s1,s2
   10ae8:	00000713          	li	a4,0
   10aec:	06078863          	beqz	a5,10b5c <_fflush_r+0x1b8>
   10af0:	00e42623          	sw	a4,12(s0)
   10af4:	00904863          	bgtz	s1,10b04 <_fflush_r+0x160>
   10af8:	fb9ff06f          	j	10ab0 <_fflush_r+0x10c>
   10afc:	00f90933          	add	s2,s2,a5
   10b00:	fa9058e3          	blez	s1,10ab0 <_fflush_r+0x10c>
   10b04:	04043783          	ld	a5,64(s0)
   10b08:	03043583          	ld	a1,48(s0)
   10b0c:	00048693          	mv	a3,s1
   10b10:	00090613          	mv	a2,s2
   10b14:	00098513          	mv	a0,s3
   10b18:	000780e7          	jalr	a5
   10b1c:	00050793          	mv	a5,a0
   10b20:	40a484bb          	subw	s1,s1,a0
   10b24:	fca04ce3          	bgtz	a0,10afc <_fflush_r+0x158>
   10b28:	01045783          	lhu	a5,16(s0)
   10b2c:	02813083          	ld	ra,40(sp)
   10b30:	fff00513          	li	a0,-1
   10b34:	0407e793          	ori	a5,a5,64
   10b38:	00f41823          	sh	a5,16(s0)
   10b3c:	01813483          	ld	s1,24(sp)
   10b40:	02013403          	ld	s0,32(sp)
   10b44:	01013903          	ld	s2,16(sp)
   10b48:	00813983          	ld	s3,8(sp)
   10b4c:	03010113          	addi	sp,sp,48
   10b50:	00008067          	ret
   10b54:	428000ef          	jal	10f7c <__sinit>
   10b58:	e79ff06f          	j	109d0 <_fflush_r+0x2c>
   10b5c:	02042703          	lw	a4,32(s0)
   10b60:	f91ff06f          	j	10af0 <_fflush_r+0x14c>
   10b64:	03043583          	ld	a1,48(s0)
   10b68:	00000613          	li	a2,0
   10b6c:	00100693          	li	a3,1
   10b70:	00098513          	mv	a0,s3
   10b74:	000700e7          	jalr	a4
   10b78:	fff00793          	li	a5,-1
   10b7c:	00050613          	mv	a2,a0
   10b80:	06f50a63          	beq	a0,a5,10bf4 <_fflush_r+0x250>
   10b84:	01045783          	lhu	a5,16(s0)
   10b88:	04843703          	ld	a4,72(s0)
   10b8c:	e99ff06f          	j	10a24 <_fflush_r+0x80>
   10b90:	07042703          	lw	a4,112(s0)
   10b94:	e6e046e3          	bgtz	a4,10a00 <_fflush_r+0x5c>
   10b98:	f19ff06f          	j	10ab0 <_fflush_r+0x10c>
   10b9c:	0009a703          	lw	a4,0(s3)
   10ba0:	01d00793          	li	a5,29
   10ba4:	f8e7e2e3          	bltu	a5,a4,10b28 <_fflush_r+0x184>
   10ba8:	204007b7          	lui	a5,0x20400
   10bac:	00178793          	addi	a5,a5,1 # 20400001 <_gp+0x203eb9d1>
   10bb0:	00e7d7b3          	srl	a5,a5,a4
   10bb4:	0017f793          	andi	a5,a5,1
   10bb8:	f60788e3          	beqz	a5,10b28 <_fflush_r+0x184>
   10bbc:	01045603          	lhu	a2,16(s0)
   10bc0:	fffff7b7          	lui	a5,0xfffff
   10bc4:	7ff7879b          	addiw	a5,a5,2047
   10bc8:	01843683          	ld	a3,24(s0)
   10bcc:	00f677b3          	and	a5,a2,a5
   10bd0:	0107979b          	slliw	a5,a5,0x10
   10bd4:	4107d79b          	sraiw	a5,a5,0x10
   10bd8:	00d43023          	sd	a3,0(s0)
   10bdc:	03379693          	slli	a3,a5,0x33
   10be0:	00f41823          	sh	a5,16(s0)
   10be4:	00042423          	sw	zero,8(s0)
   10be8:	ea06d4e3          	bgez	a3,10a90 <_fflush_r+0xec>
   10bec:	ea0712e3          	bnez	a4,10a90 <_fflush_r+0xec>
   10bf0:	e9dff06f          	j	10a8c <_fflush_r+0xe8>
   10bf4:	0009a783          	lw	a5,0(s3)
   10bf8:	f80786e3          	beqz	a5,10b84 <_fflush_r+0x1e0>
   10bfc:	01d00713          	li	a4,29
   10c00:	00e78663          	beq	a5,a4,10c0c <_fflush_r+0x268>
   10c04:	01600713          	li	a4,22
   10c08:	00e79863          	bne	a5,a4,10c18 <_fflush_r+0x274>
   10c0c:	0099a023          	sw	s1,0(s3)
   10c10:	00000513          	li	a0,0
   10c14:	ea1ff06f          	j	10ab4 <_fflush_r+0x110>
   10c18:	01045783          	lhu	a5,16(s0)
   10c1c:	0407e793          	ori	a5,a5,64
   10c20:	00f41823          	sh	a5,16(s0)
   10c24:	e91ff06f          	j	10ab4 <_fflush_r+0x110>

0000000000010c28 <fflush>:
   10c28:	00050593          	mv	a1,a0
   10c2c:	00050663          	beqz	a0,10c38 <fflush+0x10>
   10c30:	8101b503          	ld	a0,-2032(gp) # 13e40 <_impure_ptr>
   10c34:	d71ff06f          	j	109a4 <_fflush_r>
   10c38:	8081b503          	ld	a0,-2040(gp) # 13e38 <_global_impure_ptr>
   10c3c:	000115b7          	lui	a1,0x11
   10c40:	9a458593          	addi	a1,a1,-1628 # 109a4 <_fflush_r>
   10c44:	0410006f          	j	11484 <_fwalk_reent>

0000000000010c48 <__fp_unlock>:
   10c48:	00000513          	li	a0,0
   10c4c:	00008067          	ret

0000000000010c50 <_cleanup_r>:
   10c50:	000125b7          	lui	a1,0x12
   10c54:	1f058593          	addi	a1,a1,496 # 121f0 <fclose>
   10c58:	7880006f          	j	113e0 <_fwalk>

0000000000010c5c <__sinit.part.1>:
   10c5c:	fb010113          	addi	sp,sp,-80
   10c60:	000117b7          	lui	a5,0x11
   10c64:	04813023          	sd	s0,64(sp)
   10c68:	c5078793          	addi	a5,a5,-944 # 10c50 <_cleanup_r>
   10c6c:	00853403          	ld	s0,8(a0)
   10c70:	04113423          	sd	ra,72(sp)
   10c74:	02913c23          	sd	s1,56(sp)
   10c78:	03213823          	sd	s2,48(sp)
   10c7c:	03313423          	sd	s3,40(sp)
   10c80:	03413023          	sd	s4,32(sp)
   10c84:	01513c23          	sd	s5,24(sp)
   10c88:	01613823          	sd	s6,16(sp)
   10c8c:	01713423          	sd	s7,8(sp)
   10c90:	04f53c23          	sd	a5,88(a0)
   10c94:	00300793          	li	a5,3
   10c98:	52f52423          	sw	a5,1320(a0)
   10c9c:	53850713          	addi	a4,a0,1336
   10ca0:	00100b93          	li	s7,1
   10ca4:	00400793          	li	a5,4
   10ca8:	52e53823          	sd	a4,1328(a0)
   10cac:	05752823          	sw	s7,80(a0)
   10cb0:	52053023          	sd	zero,1312(a0)
   10cb4:	00050913          	mv	s2,a0
   10cb8:	00f41823          	sh	a5,16(s0)
   10cbc:	00800613          	li	a2,8
   10cc0:	00000593          	li	a1,0
   10cc4:	00043023          	sd	zero,0(s0)
   10cc8:	00042423          	sw	zero,8(s0)
   10ccc:	00042623          	sw	zero,12(s0)
   10cd0:	0a042223          	sw	zero,164(s0)
   10cd4:	00041923          	sh	zero,18(s0)
   10cd8:	00043c23          	sd	zero,24(s0)
   10cdc:	02042023          	sw	zero,32(s0)
   10ce0:	02042423          	sw	zero,40(s0)
   10ce4:	09c40513          	addi	a0,s0,156
   10ce8:	1c0010ef          	jal	11ea8 <memset>
   10cec:	01093483          	ld	s1,16(s2)
   10cf0:	00012b37          	lui	s6,0x12
   10cf4:	00012ab7          	lui	s5,0x12
   10cf8:	00012a37          	lui	s4,0x12
   10cfc:	000129b7          	lui	s3,0x12
   10d00:	f8cb0b13          	addi	s6,s6,-116 # 11f8c <__sread>
   10d04:	ff8a8a93          	addi	s5,s5,-8 # 11ff8 <__swrite>
   10d08:	068a0a13          	addi	s4,s4,104 # 12068 <__sseek>
   10d0c:	0d498993          	addi	s3,s3,212 # 120d4 <__sclose>
   10d10:	00900793          	li	a5,9
   10d14:	03643c23          	sd	s6,56(s0)
   10d18:	05543023          	sd	s5,64(s0)
   10d1c:	05443423          	sd	s4,72(s0)
   10d20:	05343823          	sd	s3,80(s0)
   10d24:	02843823          	sd	s0,48(s0)
   10d28:	00800613          	li	a2,8
   10d2c:	00f49823          	sh	a5,16(s1)
   10d30:	01749923          	sh	s7,18(s1)
   10d34:	00000593          	li	a1,0
   10d38:	0004b023          	sd	zero,0(s1)
   10d3c:	0004a423          	sw	zero,8(s1)
   10d40:	0004a623          	sw	zero,12(s1)
   10d44:	0a04a223          	sw	zero,164(s1)
   10d48:	0004bc23          	sd	zero,24(s1)
   10d4c:	0204a023          	sw	zero,32(s1)
   10d50:	0204a423          	sw	zero,40(s1)
   10d54:	09c48513          	addi	a0,s1,156
   10d58:	150010ef          	jal	11ea8 <memset>
   10d5c:	01893403          	ld	s0,24(s2)
   10d60:	01200793          	li	a5,18
   10d64:	0364bc23          	sd	s6,56(s1)
   10d68:	0554b023          	sd	s5,64(s1)
   10d6c:	0544b423          	sd	s4,72(s1)
   10d70:	0534b823          	sd	s3,80(s1)
   10d74:	0294b823          	sd	s1,48(s1)
   10d78:	00f41823          	sh	a5,16(s0)
   10d7c:	00200793          	li	a5,2
   10d80:	00043023          	sd	zero,0(s0)
   10d84:	00042423          	sw	zero,8(s0)
   10d88:	00042623          	sw	zero,12(s0)
   10d8c:	0a042223          	sw	zero,164(s0)
   10d90:	00f41923          	sh	a5,18(s0)
   10d94:	00043c23          	sd	zero,24(s0)
   10d98:	02042023          	sw	zero,32(s0)
   10d9c:	02042423          	sw	zero,40(s0)
   10da0:	09c40513          	addi	a0,s0,156
   10da4:	00800613          	li	a2,8
   10da8:	00000593          	li	a1,0
   10dac:	0fc010ef          	jal	11ea8 <memset>
   10db0:	04813083          	ld	ra,72(sp)
   10db4:	03643c23          	sd	s6,56(s0)
   10db8:	05543023          	sd	s5,64(s0)
   10dbc:	05443423          	sd	s4,72(s0)
   10dc0:	05343823          	sd	s3,80(s0)
   10dc4:	02843823          	sd	s0,48(s0)
   10dc8:	03813483          	ld	s1,56(sp)
   10dcc:	04013403          	ld	s0,64(sp)
   10dd0:	03013903          	ld	s2,48(sp)
   10dd4:	02813983          	ld	s3,40(sp)
   10dd8:	02013a03          	ld	s4,32(sp)
   10ddc:	01813a83          	ld	s5,24(sp)
   10de0:	01013b03          	ld	s6,16(sp)
   10de4:	00813b83          	ld	s7,8(sp)
   10de8:	05010113          	addi	sp,sp,80
   10dec:	00008067          	ret

0000000000010df0 <__fp_lock>:
   10df0:	00000513          	li	a0,0
   10df4:	00008067          	ret

0000000000010df8 <__sfmoreglue>:
   10df8:	fe010113          	addi	sp,sp,-32
   10dfc:	01213023          	sd	s2,0(sp)
   10e00:	00058913          	mv	s2,a1
   10e04:	00913423          	sd	s1,8(sp)
   10e08:	00090793          	mv	a5,s2
   10e0c:	0a800493          	li	s1,168
   10e10:	029784b3          	mul	s1,a5,s1
   10e14:	00813823          	sd	s0,16(sp)
   10e18:	00113c23          	sd	ra,24(sp)
   10e1c:	01848593          	addi	a1,s1,24
   10e20:	0c5000ef          	jal	116e4 <_malloc_r>
   10e24:	00050413          	mv	s0,a0
   10e28:	02050063          	beqz	a0,10e48 <__sfmoreglue+0x50>
   10e2c:	01850513          	addi	a0,a0,24
   10e30:	00043023          	sd	zero,0(s0)
   10e34:	01242423          	sw	s2,8(s0)
   10e38:	00a43823          	sd	a0,16(s0)
   10e3c:	00048613          	mv	a2,s1
   10e40:	00000593          	li	a1,0
   10e44:	064010ef          	jal	11ea8 <memset>
   10e48:	01813083          	ld	ra,24(sp)
   10e4c:	00040513          	mv	a0,s0
   10e50:	00813483          	ld	s1,8(sp)
   10e54:	01013403          	ld	s0,16(sp)
   10e58:	00013903          	ld	s2,0(sp)
   10e5c:	02010113          	addi	sp,sp,32
   10e60:	00008067          	ret

0000000000010e64 <__sfp>:
   10e64:	fd010113          	addi	sp,sp,-48
   10e68:	01213823          	sd	s2,16(sp)
   10e6c:	8081b903          	ld	s2,-2040(gp) # 13e38 <_global_impure_ptr>
   10e70:	01313423          	sd	s3,8(sp)
   10e74:	02113423          	sd	ra,40(sp)
   10e78:	05092783          	lw	a5,80(s2)
   10e7c:	02813023          	sd	s0,32(sp)
   10e80:	00913c23          	sd	s1,24(sp)
   10e84:	00050993          	mv	s3,a0
   10e88:	00079663          	bnez	a5,10e94 <__sfp+0x30>
   10e8c:	00090513          	mv	a0,s2
   10e90:	dcdff0ef          	jal	10c5c <__sinit.part.1>
   10e94:	52090913          	addi	s2,s2,1312
   10e98:	fff00493          	li	s1,-1
   10e9c:	00892783          	lw	a5,8(s2)
   10ea0:	01093403          	ld	s0,16(s2)
   10ea4:	fff7879b          	addiw	a5,a5,-1
   10ea8:	0007da63          	bgez	a5,10ebc <__sfp+0x58>
   10eac:	0840006f          	j	10f30 <__sfp+0xcc>
   10eb0:	fff7879b          	addiw	a5,a5,-1
   10eb4:	0a840413          	addi	s0,s0,168
   10eb8:	06978c63          	beq	a5,s1,10f30 <__sfp+0xcc>
   10ebc:	01041703          	lh	a4,16(s0)
   10ec0:	fe0718e3          	bnez	a4,10eb0 <__sfp+0x4c>
   10ec4:	fff00793          	li	a5,-1
   10ec8:	00f41923          	sh	a5,18(s0)
   10ecc:	00100793          	li	a5,1
   10ed0:	00f41823          	sh	a5,16(s0)
   10ed4:	0a042223          	sw	zero,164(s0)
   10ed8:	00043023          	sd	zero,0(s0)
   10edc:	00042623          	sw	zero,12(s0)
   10ee0:	00042423          	sw	zero,8(s0)
   10ee4:	00043c23          	sd	zero,24(s0)
   10ee8:	02042023          	sw	zero,32(s0)
   10eec:	02042423          	sw	zero,40(s0)
   10ef0:	00800613          	li	a2,8
   10ef4:	00000593          	li	a1,0
   10ef8:	09c40513          	addi	a0,s0,156
   10efc:	7ad000ef          	jal	11ea8 <memset>
   10f00:	04043c23          	sd	zero,88(s0)
   10f04:	06042023          	sw	zero,96(s0)
   10f08:	06043c23          	sd	zero,120(s0)
   10f0c:	08042023          	sw	zero,128(s0)
   10f10:	00040513          	mv	a0,s0
   10f14:	02813083          	ld	ra,40(sp)
   10f18:	02013403          	ld	s0,32(sp)
   10f1c:	01813483          	ld	s1,24(sp)
   10f20:	01013903          	ld	s2,16(sp)
   10f24:	00813983          	ld	s3,8(sp)
   10f28:	03010113          	addi	sp,sp,48
   10f2c:	00008067          	ret
   10f30:	00093783          	ld	a5,0(s2)
   10f34:	00078663          	beqz	a5,10f40 <__sfp+0xdc>
   10f38:	00078913          	mv	s2,a5
   10f3c:	f61ff06f          	j	10e9c <__sfp+0x38>
   10f40:	00400593          	li	a1,4
   10f44:	00098513          	mv	a0,s3
   10f48:	eb1ff0ef          	jal	10df8 <__sfmoreglue>
   10f4c:	00a93023          	sd	a0,0(s2)
   10f50:	00050663          	beqz	a0,10f5c <__sfp+0xf8>
   10f54:	00050913          	mv	s2,a0
   10f58:	f45ff06f          	j	10e9c <__sfp+0x38>
   10f5c:	00c00793          	li	a5,12
   10f60:	00f9a023          	sw	a5,0(s3)
   10f64:	00000513          	li	a0,0
   10f68:	fadff06f          	j	10f14 <__sfp+0xb0>

0000000000010f6c <_cleanup>:
   10f6c:	8081b503          	ld	a0,-2040(gp) # 13e38 <_global_impure_ptr>
   10f70:	000125b7          	lui	a1,0x12
   10f74:	1f058593          	addi	a1,a1,496 # 121f0 <fclose>
   10f78:	4680006f          	j	113e0 <_fwalk>

0000000000010f7c <__sinit>:
   10f7c:	05052783          	lw	a5,80(a0)
   10f80:	00078463          	beqz	a5,10f88 <__sinit+0xc>
   10f84:	00008067          	ret
   10f88:	cd5ff06f          	j	10c5c <__sinit.part.1>

0000000000010f8c <__sfp_lock_acquire>:
   10f8c:	00008067          	ret

0000000000010f90 <__sfp_lock_release>:
   10f90:	00008067          	ret

0000000000010f94 <__sinit_lock_acquire>:
   10f94:	00008067          	ret

0000000000010f98 <__sinit_lock_release>:
   10f98:	00008067          	ret

0000000000010f9c <__fp_lock_all>:
   10f9c:	8101b503          	ld	a0,-2032(gp) # 13e40 <_impure_ptr>
   10fa0:	000115b7          	lui	a1,0x11
   10fa4:	df058593          	addi	a1,a1,-528 # 10df0 <__fp_lock>
   10fa8:	4380006f          	j	113e0 <_fwalk>

0000000000010fac <__fp_unlock_all>:
   10fac:	8101b503          	ld	a0,-2032(gp) # 13e40 <_impure_ptr>
   10fb0:	000115b7          	lui	a1,0x11
   10fb4:	c4858593          	addi	a1,a1,-952 # 10c48 <__fp_unlock>
   10fb8:	4280006f          	j	113e0 <_fwalk>

0000000000010fbc <_malloc_trim_r>:
   10fbc:	fd010113          	addi	sp,sp,-48
   10fc0:	01213823          	sd	s2,16(sp)
   10fc4:	00013937          	lui	s2,0x13
   10fc8:	62090913          	addi	s2,s2,1568 # 13620 <__malloc_av_>
   10fcc:	02813023          	sd	s0,32(sp)
   10fd0:	00913c23          	sd	s1,24(sp)
   10fd4:	00058413          	mv	s0,a1
   10fd8:	01313423          	sd	s3,8(sp)
   10fdc:	02113423          	sd	ra,40(sp)
   10fe0:	00050993          	mv	s3,a0
   10fe4:	7a1000ef          	jal	11f84 <__malloc_lock>
   10fe8:	01093703          	ld	a4,16(s2)
   10fec:	000017b7          	lui	a5,0x1
   10ff0:	fdf78593          	addi	a1,a5,-33 # fdf <_ftext-0xf021>
   10ff4:	00873483          	ld	s1,8(a4)
   10ff8:	ffc4f493          	andi	s1,s1,-4
   10ffc:	40848433          	sub	s0,s1,s0
   11000:	00b40433          	add	s0,s0,a1
   11004:	00c45413          	srli	s0,s0,0xc
   11008:	fff40413          	addi	s0,s0,-1
   1100c:	00c41413          	slli	s0,s0,0xc
   11010:	00f44c63          	blt	s0,a5,11028 <_malloc_trim_r+0x6c>
   11014:	00000513          	li	a0,0
   11018:	550010ef          	jal	12568 <sbrk>
   1101c:	01093783          	ld	a5,16(s2)
   11020:	009787b3          	add	a5,a5,s1
   11024:	02f50663          	beq	a0,a5,11050 <_malloc_trim_r+0x94>
   11028:	00098513          	mv	a0,s3
   1102c:	75d000ef          	jal	11f88 <__malloc_unlock>
   11030:	02813083          	ld	ra,40(sp)
   11034:	00000513          	li	a0,0
   11038:	02013403          	ld	s0,32(sp)
   1103c:	01813483          	ld	s1,24(sp)
   11040:	01013903          	ld	s2,16(sp)
   11044:	00813983          	ld	s3,8(sp)
   11048:	03010113          	addi	sp,sp,48
   1104c:	00008067          	ret
   11050:	40800533          	neg	a0,s0
   11054:	514010ef          	jal	12568 <sbrk>
   11058:	fff00793          	li	a5,-1
   1105c:	04f50463          	beq	a0,a5,110a4 <_malloc_trim_r+0xe8>
   11060:	8801a783          	lw	a5,-1920(gp) # 13eb0 <__malloc_current_mallinfo>
   11064:	01093683          	ld	a3,16(s2)
   11068:	408484b3          	sub	s1,s1,s0
   1106c:	0014e493          	ori	s1,s1,1
   11070:	4087843b          	subw	s0,a5,s0
   11074:	00098513          	mv	a0,s3
   11078:	0096b423          	sd	s1,8(a3)
   1107c:	8881a023          	sw	s0,-1920(gp) # 13eb0 <__malloc_current_mallinfo>
   11080:	709000ef          	jal	11f88 <__malloc_unlock>
   11084:	02813083          	ld	ra,40(sp)
   11088:	00100513          	li	a0,1
   1108c:	02013403          	ld	s0,32(sp)
   11090:	01813483          	ld	s1,24(sp)
   11094:	01013903          	ld	s2,16(sp)
   11098:	00813983          	ld	s3,8(sp)
   1109c:	03010113          	addi	sp,sp,48
   110a0:	00008067          	ret
   110a4:	00000513          	li	a0,0
   110a8:	4c0010ef          	jal	12568 <sbrk>
   110ac:	01093703          	ld	a4,16(s2)
   110b0:	01f00693          	li	a3,31
   110b4:	40e507b3          	sub	a5,a0,a4
   110b8:	f6f6d8e3          	ble	a5,a3,11028 <_malloc_trim_r+0x6c>
   110bc:	8181b683          	ld	a3,-2024(gp) # 13e48 <__malloc_sbrk_base>
   110c0:	0017e793          	ori	a5,a5,1
   110c4:	00f73423          	sd	a5,8(a4)
   110c8:	40d50533          	sub	a0,a0,a3
   110cc:	88a1a023          	sw	a0,-1920(gp) # 13eb0 <__malloc_current_mallinfo>
   110d0:	f59ff06f          	j	11028 <_malloc_trim_r+0x6c>

00000000000110d4 <_free_r>:
   110d4:	10058263          	beqz	a1,111d8 <_free_r+0x104>
   110d8:	fe010113          	addi	sp,sp,-32
   110dc:	00813823          	sd	s0,16(sp)
   110e0:	00058413          	mv	s0,a1
   110e4:	00913423          	sd	s1,8(sp)
   110e8:	00113c23          	sd	ra,24(sp)
   110ec:	00050493          	mv	s1,a0
   110f0:	695000ef          	jal	11f84 <__malloc_lock>
   110f4:	ff843503          	ld	a0,-8(s0)
   110f8:	ff040613          	addi	a2,s0,-16
   110fc:	000135b7          	lui	a1,0x13
   11100:	ffe57793          	andi	a5,a0,-2
   11104:	00f606b3          	add	a3,a2,a5
   11108:	62058593          	addi	a1,a1,1568 # 13620 <__malloc_av_>
   1110c:	0086b703          	ld	a4,8(a3)
   11110:	0105b803          	ld	a6,16(a1)
   11114:	00157513          	andi	a0,a0,1
   11118:	ffc77713          	andi	a4,a4,-4
   1111c:	17068463          	beq	a3,a6,11284 <_free_r+0x1b0>
   11120:	00e6b423          	sd	a4,8(a3)
   11124:	02051663          	bnez	a0,11150 <_free_r+0x7c>
   11128:	ff043503          	ld	a0,-16(s0)
   1112c:	40a60633          	sub	a2,a2,a0
   11130:	01063803          	ld	a6,16(a2) # 2010 <_ftext-0xdff0>
   11134:	00a787b3          	add	a5,a5,a0
   11138:	00013537          	lui	a0,0x13
   1113c:	63050513          	addi	a0,a0,1584 # 13630 <__malloc_av_+0x10>
   11140:	18a80663          	beq	a6,a0,112cc <_free_r+0x1f8>
   11144:	01863503          	ld	a0,24(a2)
   11148:	00a83c23          	sd	a0,24(a6)
   1114c:	01053823          	sd	a6,16(a0)
   11150:	00e68533          	add	a0,a3,a4
   11154:	00853503          	ld	a0,8(a0)
   11158:	00157513          	andi	a0,a0,1
   1115c:	0e050a63          	beqz	a0,11250 <_free_r+0x17c>
   11160:	0017e693          	ori	a3,a5,1
   11164:	00f60733          	add	a4,a2,a5
   11168:	00d63423          	sd	a3,8(a2)
   1116c:	00f73023          	sd	a5,0(a4)
   11170:	1ff00713          	li	a4,511
   11174:	06f76463          	bltu	a4,a5,111dc <_free_r+0x108>
   11178:	0037d793          	srli	a5,a5,0x3
   1117c:	0007879b          	sext.w	a5,a5
   11180:	0017871b          	addiw	a4,a5,1
   11184:	0017171b          	slliw	a4,a4,0x1
   11188:	00371713          	slli	a4,a4,0x3
   1118c:	0085b683          	ld	a3,8(a1)
   11190:	00e58733          	add	a4,a1,a4
   11194:	00073803          	ld	a6,0(a4)
   11198:	4027d79b          	sraiw	a5,a5,0x2
   1119c:	00100513          	li	a0,1
   111a0:	00f517b3          	sll	a5,a0,a5
   111a4:	00d7e7b3          	or	a5,a5,a3
   111a8:	ff070693          	addi	a3,a4,-16
   111ac:	00d63c23          	sd	a3,24(a2)
   111b0:	01063823          	sd	a6,16(a2)
   111b4:	00f5b423          	sd	a5,8(a1)
   111b8:	00c73023          	sd	a2,0(a4)
   111bc:	00c83c23          	sd	a2,24(a6)
   111c0:	00048513          	mv	a0,s1
   111c4:	01813083          	ld	ra,24(sp)
   111c8:	01013403          	ld	s0,16(sp)
   111cc:	00813483          	ld	s1,8(sp)
   111d0:	02010113          	addi	sp,sp,32
   111d4:	5b50006f          	j	11f88 <__malloc_unlock>
   111d8:	00008067          	ret
   111dc:	0097d713          	srli	a4,a5,0x9
   111e0:	00400693          	li	a3,4
   111e4:	12e6e063          	bltu	a3,a4,11304 <_free_r+0x230>
   111e8:	0067d713          	srli	a4,a5,0x6
   111ec:	0007071b          	sext.w	a4,a4
   111f0:	0397051b          	addiw	a0,a4,57
   111f4:	0387069b          	addiw	a3,a4,56
   111f8:	0015151b          	slliw	a0,a0,0x1
   111fc:	00351513          	slli	a0,a0,0x3
   11200:	00a58533          	add	a0,a1,a0
   11204:	00053703          	ld	a4,0(a0)
   11208:	ff050513          	addi	a0,a0,-16
   1120c:	10e50a63          	beq	a0,a4,11320 <_free_r+0x24c>
   11210:	00873683          	ld	a3,8(a4)
   11214:	ffc6f693          	andi	a3,a3,-4
   11218:	00d7f663          	bleu	a3,a5,11224 <_free_r+0x150>
   1121c:	01073703          	ld	a4,16(a4)
   11220:	fee518e3          	bne	a0,a4,11210 <_free_r+0x13c>
   11224:	01873503          	ld	a0,24(a4)
   11228:	00a63c23          	sd	a0,24(a2)
   1122c:	00e63823          	sd	a4,16(a2)
   11230:	01813083          	ld	ra,24(sp)
   11234:	00c53823          	sd	a2,16(a0)
   11238:	01013403          	ld	s0,16(sp)
   1123c:	00048513          	mv	a0,s1
   11240:	00813483          	ld	s1,8(sp)
   11244:	00c73c23          	sd	a2,24(a4)
   11248:	02010113          	addi	sp,sp,32
   1124c:	53d0006f          	j	11f88 <__malloc_unlock>
   11250:	0106b503          	ld	a0,16(a3)
   11254:	00e787b3          	add	a5,a5,a4
   11258:	00013737          	lui	a4,0x13
   1125c:	63070713          	addi	a4,a4,1584 # 13630 <__malloc_av_+0x10>
   11260:	0ee50063          	beq	a0,a4,11340 <_free_r+0x26c>
   11264:	0186b803          	ld	a6,24(a3)
   11268:	00f60733          	add	a4,a2,a5
   1126c:	0017e693          	ori	a3,a5,1
   11270:	01053c23          	sd	a6,24(a0)
   11274:	00a83823          	sd	a0,16(a6)
   11278:	00d63423          	sd	a3,8(a2)
   1127c:	00f73023          	sd	a5,0(a4)
   11280:	ef1ff06f          	j	11170 <_free_r+0x9c>
   11284:	00e787b3          	add	a5,a5,a4
   11288:	02051063          	bnez	a0,112a8 <_free_r+0x1d4>
   1128c:	ff043503          	ld	a0,-16(s0)
   11290:	40a60633          	sub	a2,a2,a0
   11294:	01863703          	ld	a4,24(a2)
   11298:	01063683          	ld	a3,16(a2)
   1129c:	00a787b3          	add	a5,a5,a0
   112a0:	00e6bc23          	sd	a4,24(a3)
   112a4:	00d73823          	sd	a3,16(a4)
   112a8:	8201b703          	ld	a4,-2016(gp) # 13e50 <__malloc_trim_threshold>
   112ac:	0017e693          	ori	a3,a5,1
   112b0:	00d63423          	sd	a3,8(a2)
   112b4:	00c5b823          	sd	a2,16(a1)
   112b8:	f0e7e4e3          	bltu	a5,a4,111c0 <_free_r+0xec>
   112bc:	8381b583          	ld	a1,-1992(gp) # 13e68 <__malloc_top_pad>
   112c0:	00048513          	mv	a0,s1
   112c4:	cf9ff0ef          	jal	10fbc <_malloc_trim_r>
   112c8:	ef9ff06f          	j	111c0 <_free_r+0xec>
   112cc:	00e685b3          	add	a1,a3,a4
   112d0:	0085b583          	ld	a1,8(a1)
   112d4:	0015f593          	andi	a1,a1,1
   112d8:	0e059a63          	bnez	a1,113cc <_free_r+0x2f8>
   112dc:	0106b583          	ld	a1,16(a3)
   112e0:	0186b683          	ld	a3,24(a3)
   112e4:	00f707b3          	add	a5,a4,a5
   112e8:	0017e513          	ori	a0,a5,1
   112ec:	00f60733          	add	a4,a2,a5
   112f0:	00d5bc23          	sd	a3,24(a1)
   112f4:	00b6b823          	sd	a1,16(a3)
   112f8:	00a63423          	sd	a0,8(a2)
   112fc:	00f73023          	sd	a5,0(a4)
   11300:	ec1ff06f          	j	111c0 <_free_r+0xec>
   11304:	01400693          	li	a3,20
   11308:	04e6ee63          	bltu	a3,a4,11364 <_free_r+0x290>
   1130c:	0007071b          	sext.w	a4,a4
   11310:	05c7051b          	addiw	a0,a4,92
   11314:	05b7069b          	addiw	a3,a4,91
   11318:	0015151b          	slliw	a0,a0,0x1
   1131c:	ee1ff06f          	j	111fc <_free_r+0x128>
   11320:	0085b783          	ld	a5,8(a1)
   11324:	4026d71b          	sraiw	a4,a3,0x2
   11328:	00100693          	li	a3,1
   1132c:	00e69733          	sll	a4,a3,a4
   11330:	00f76733          	or	a4,a4,a5
   11334:	00e5b423          	sd	a4,8(a1)
   11338:	00050713          	mv	a4,a0
   1133c:	eedff06f          	j	11228 <_free_r+0x154>
   11340:	0017e693          	ori	a3,a5,1
   11344:	00f60733          	add	a4,a2,a5
   11348:	02c5b423          	sd	a2,40(a1)
   1134c:	02c5b023          	sd	a2,32(a1)
   11350:	00a63c23          	sd	a0,24(a2)
   11354:	00a63823          	sd	a0,16(a2)
   11358:	00d63423          	sd	a3,8(a2)
   1135c:	00f73023          	sd	a5,0(a4)
   11360:	e61ff06f          	j	111c0 <_free_r+0xec>
   11364:	05400693          	li	a3,84
   11368:	00e6ee63          	bltu	a3,a4,11384 <_free_r+0x2b0>
   1136c:	00c7d713          	srli	a4,a5,0xc
   11370:	0007071b          	sext.w	a4,a4
   11374:	06f7051b          	addiw	a0,a4,111
   11378:	06e7069b          	addiw	a3,a4,110
   1137c:	0015151b          	slliw	a0,a0,0x1
   11380:	e7dff06f          	j	111fc <_free_r+0x128>
   11384:	15400693          	li	a3,340
   11388:	00e6ee63          	bltu	a3,a4,113a4 <_free_r+0x2d0>
   1138c:	00f7d713          	srli	a4,a5,0xf
   11390:	0007071b          	sext.w	a4,a4
   11394:	0787051b          	addiw	a0,a4,120
   11398:	0777069b          	addiw	a3,a4,119
   1139c:	0015151b          	slliw	a0,a0,0x1
   113a0:	e5dff06f          	j	111fc <_free_r+0x128>
   113a4:	55400813          	li	a6,1364
   113a8:	0fe00513          	li	a0,254
   113ac:	07e00693          	li	a3,126
   113b0:	e4e866e3          	bltu	a6,a4,111fc <_free_r+0x128>
   113b4:	0127d713          	srli	a4,a5,0x12
   113b8:	0007071b          	sext.w	a4,a4
   113bc:	07d7051b          	addiw	a0,a4,125
   113c0:	07c7069b          	addiw	a3,a4,124
   113c4:	0015151b          	slliw	a0,a0,0x1
   113c8:	e35ff06f          	j	111fc <_free_r+0x128>
   113cc:	0017e693          	ori	a3,a5,1
   113d0:	00f60733          	add	a4,a2,a5
   113d4:	00d63423          	sd	a3,8(a2)
   113d8:	00f73023          	sd	a5,0(a4)
   113dc:	de5ff06f          	j	111c0 <_free_r+0xec>

00000000000113e0 <_fwalk>:
   113e0:	fc010113          	addi	sp,sp,-64
   113e4:	01313c23          	sd	s3,24(sp)
   113e8:	52050993          	addi	s3,a0,1312
   113ec:	01413823          	sd	s4,16(sp)
   113f0:	01513423          	sd	s5,8(sp)
   113f4:	02113c23          	sd	ra,56(sp)
   113f8:	02813823          	sd	s0,48(sp)
   113fc:	02913423          	sd	s1,40(sp)
   11400:	03213023          	sd	s2,32(sp)
   11404:	00058a93          	mv	s5,a1
   11408:	00000a13          	li	s4,0
   1140c:	b81ff0ef          	jal	10f8c <__sfp_lock_acquire>
   11410:	04098463          	beqz	s3,11458 <_fwalk+0x78>
   11414:	fff00913          	li	s2,-1
   11418:	0089a483          	lw	s1,8(s3)
   1141c:	0109b403          	ld	s0,16(s3)
   11420:	fff4849b          	addiw	s1,s1,-1
   11424:	0204c663          	bltz	s1,11450 <_fwalk+0x70>
   11428:	01041783          	lh	a5,16(s0)
   1142c:	fff4849b          	addiw	s1,s1,-1
   11430:	00078c63          	beqz	a5,11448 <_fwalk+0x68>
   11434:	01241783          	lh	a5,18(s0)
   11438:	00040513          	mv	a0,s0
   1143c:	01278663          	beq	a5,s2,11448 <_fwalk+0x68>
   11440:	000a80e7          	jalr	s5
   11444:	00aa6a33          	or	s4,s4,a0
   11448:	0a840413          	addi	s0,s0,168
   1144c:	fd249ee3          	bne	s1,s2,11428 <_fwalk+0x48>
   11450:	0009b983          	ld	s3,0(s3)
   11454:	fc0992e3          	bnez	s3,11418 <_fwalk+0x38>
   11458:	b39ff0ef          	jal	10f90 <__sfp_lock_release>
   1145c:	03813083          	ld	ra,56(sp)
   11460:	000a0513          	mv	a0,s4
   11464:	03013403          	ld	s0,48(sp)
   11468:	02813483          	ld	s1,40(sp)
   1146c:	02013903          	ld	s2,32(sp)
   11470:	01813983          	ld	s3,24(sp)
   11474:	01013a03          	ld	s4,16(sp)
   11478:	00813a83          	ld	s5,8(sp)
   1147c:	04010113          	addi	sp,sp,64
   11480:	00008067          	ret

0000000000011484 <_fwalk_reent>:
   11484:	fc010113          	addi	sp,sp,-64
   11488:	01313c23          	sd	s3,24(sp)
   1148c:	52050993          	addi	s3,a0,1312
   11490:	01413823          	sd	s4,16(sp)
   11494:	01513423          	sd	s5,8(sp)
   11498:	01613023          	sd	s6,0(sp)
   1149c:	02113c23          	sd	ra,56(sp)
   114a0:	02813823          	sd	s0,48(sp)
   114a4:	02913423          	sd	s1,40(sp)
   114a8:	03213023          	sd	s2,32(sp)
   114ac:	00050a93          	mv	s5,a0
   114b0:	00058b13          	mv	s6,a1
   114b4:	00000a13          	li	s4,0
   114b8:	ad5ff0ef          	jal	10f8c <__sfp_lock_acquire>
   114bc:	04098663          	beqz	s3,11508 <_fwalk_reent+0x84>
   114c0:	fff00913          	li	s2,-1
   114c4:	0089a483          	lw	s1,8(s3)
   114c8:	0109b403          	ld	s0,16(s3)
   114cc:	fff4849b          	addiw	s1,s1,-1
   114d0:	0204c863          	bltz	s1,11500 <_fwalk_reent+0x7c>
   114d4:	01041783          	lh	a5,16(s0)
   114d8:	fff4849b          	addiw	s1,s1,-1
   114dc:	00078e63          	beqz	a5,114f8 <_fwalk_reent+0x74>
   114e0:	01241783          	lh	a5,18(s0)
   114e4:	00040593          	mv	a1,s0
   114e8:	000a8513          	mv	a0,s5
   114ec:	01278663          	beq	a5,s2,114f8 <_fwalk_reent+0x74>
   114f0:	000b00e7          	jalr	s6
   114f4:	00aa6a33          	or	s4,s4,a0
   114f8:	0a840413          	addi	s0,s0,168
   114fc:	fd249ce3          	bne	s1,s2,114d4 <_fwalk_reent+0x50>
   11500:	0009b983          	ld	s3,0(s3)
   11504:	fc0990e3          	bnez	s3,114c4 <_fwalk_reent+0x40>
   11508:	a89ff0ef          	jal	10f90 <__sfp_lock_release>
   1150c:	03813083          	ld	ra,56(sp)
   11510:	000a0513          	mv	a0,s4
   11514:	03013403          	ld	s0,48(sp)
   11518:	02813483          	ld	s1,40(sp)
   1151c:	02013903          	ld	s2,32(sp)
   11520:	01813983          	ld	s3,24(sp)
   11524:	01013a03          	ld	s4,16(sp)
   11528:	00813a83          	ld	s5,8(sp)
   1152c:	00013b03          	ld	s6,0(sp)
   11530:	04010113          	addi	sp,sp,64
   11534:	00008067          	ret

0000000000011538 <__smakebuf_r>:
   11538:	01059783          	lh	a5,16(a1)
   1153c:	f5010113          	addi	sp,sp,-176
   11540:	08913c23          	sd	s1,152(sp)
   11544:	03079493          	slli	s1,a5,0x30
   11548:	0304d493          	srli	s1,s1,0x30
   1154c:	0024f713          	andi	a4,s1,2
   11550:	0a113423          	sd	ra,168(sp)
   11554:	0a813023          	sd	s0,160(sp)
   11558:	09213823          	sd	s2,144(sp)
   1155c:	09313423          	sd	s3,136(sp)
   11560:	0e071063          	bnez	a4,11640 <__smakebuf_r+0x108>
   11564:	00050913          	mv	s2,a0
   11568:	01259503          	lh	a0,18(a1)
   1156c:	00058413          	mv	s0,a1
   11570:	04054c63          	bltz	a0,115c8 <__smakebuf_r+0x90>
   11574:	00010593          	mv	a1,sp
   11578:	525000ef          	jal	1229c <fstat>
   1157c:	04054063          	bltz	a0,115bc <__smakebuf_r+0x84>
   11580:	01012703          	lw	a4,16(sp)
   11584:	0000f7b7          	lui	a5,0xf
   11588:	ffffe9b7          	lui	s3,0xffffe
   1158c:	00f777b3          	and	a5,a4,a5
   11590:	013789bb          	addw	s3,a5,s3
   11594:	00008737          	lui	a4,0x8
   11598:	0019b993          	seqz	s3,s3
   1159c:	0ce78a63          	beq	a5,a4,11670 <__smakebuf_r+0x138>
   115a0:	01045703          	lhu	a4,16(s0)
   115a4:	000017b7          	lui	a5,0x1
   115a8:	8007879b          	addiw	a5,a5,-2048
   115ac:	00f767b3          	or	a5,a4,a5
   115b0:	00f41823          	sh	a5,16(s0)
   115b4:	40000493          	li	s1,1024
   115b8:	0340006f          	j	115ec <__smakebuf_r+0xb4>
   115bc:	01041783          	lh	a5,16(s0)
   115c0:	03079493          	slli	s1,a5,0x30
   115c4:	0304d493          	srli	s1,s1,0x30
   115c8:	03849493          	slli	s1,s1,0x38
   115cc:	00001737          	lui	a4,0x1
   115d0:	43f4d493          	srai	s1,s1,0x3f
   115d4:	8007071b          	addiw	a4,a4,-2048
   115d8:	c404f493          	andi	s1,s1,-960
   115dc:	00e7e7b3          	or	a5,a5,a4
   115e0:	40048493          	addi	s1,s1,1024
   115e4:	00f41823          	sh	a5,16(s0)
   115e8:	00000993          	li	s3,0
   115ec:	00048593          	mv	a1,s1
   115f0:	00090513          	mv	a0,s2
   115f4:	0f0000ef          	jal	116e4 <_malloc_r>
   115f8:	0c050063          	beqz	a0,116b8 <__smakebuf_r+0x180>
   115fc:	01045783          	lhu	a5,16(s0)
   11600:	00011737          	lui	a4,0x11
   11604:	c5070713          	addi	a4,a4,-944 # 10c50 <_cleanup_r>
   11608:	0807e793          	ori	a5,a5,128
   1160c:	04e93c23          	sd	a4,88(s2)
   11610:	00f41823          	sh	a5,16(s0)
   11614:	00a43023          	sd	a0,0(s0)
   11618:	00a43c23          	sd	a0,24(s0)
   1161c:	02942023          	sw	s1,32(s0)
   11620:	06099e63          	bnez	s3,1169c <__smakebuf_r+0x164>
   11624:	0a813083          	ld	ra,168(sp)
   11628:	0a013403          	ld	s0,160(sp)
   1162c:	09813483          	ld	s1,152(sp)
   11630:	09013903          	ld	s2,144(sp)
   11634:	08813983          	ld	s3,136(sp)
   11638:	0b010113          	addi	sp,sp,176
   1163c:	00008067          	ret
   11640:	0a813083          	ld	ra,168(sp)
   11644:	07758793          	addi	a5,a1,119
   11648:	00f5b023          	sd	a5,0(a1)
   1164c:	00f5bc23          	sd	a5,24(a1)
   11650:	00100793          	li	a5,1
   11654:	0a013403          	ld	s0,160(sp)
   11658:	09813483          	ld	s1,152(sp)
   1165c:	09013903          	ld	s2,144(sp)
   11660:	08813983          	ld	s3,136(sp)
   11664:	02f5a023          	sw	a5,32(a1)
   11668:	0b010113          	addi	sp,sp,176
   1166c:	00008067          	ret
   11670:	04843703          	ld	a4,72(s0)
   11674:	000127b7          	lui	a5,0x12
   11678:	06878793          	addi	a5,a5,104 # 12068 <__sseek>
   1167c:	f2f712e3          	bne	a4,a5,115a0 <__smakebuf_r+0x68>
   11680:	01045783          	lhu	a5,16(s0)
   11684:	40000713          	li	a4,1024
   11688:	08e42423          	sw	a4,136(s0)
   1168c:	00e7e7b3          	or	a5,a5,a4
   11690:	00f41823          	sh	a5,16(s0)
   11694:	40000493          	li	s1,1024
   11698:	f55ff06f          	j	115ec <__smakebuf_r+0xb4>
   1169c:	01241503          	lh	a0,18(s0)
   116a0:	589000ef          	jal	12428 <isatty>
   116a4:	f80500e3          	beqz	a0,11624 <__smakebuf_r+0xec>
   116a8:	01045783          	lhu	a5,16(s0)
   116ac:	0017e793          	ori	a5,a5,1
   116b0:	00f41823          	sh	a5,16(s0)
   116b4:	f71ff06f          	j	11624 <__smakebuf_r+0xec>
   116b8:	01041783          	lh	a5,16(s0)
   116bc:	2007f713          	andi	a4,a5,512
   116c0:	f60712e3          	bnez	a4,11624 <__smakebuf_r+0xec>
   116c4:	0027e793          	ori	a5,a5,2
   116c8:	07740713          	addi	a4,s0,119
   116cc:	00f41823          	sh	a5,16(s0)
   116d0:	00100793          	li	a5,1
   116d4:	00e43023          	sd	a4,0(s0)
   116d8:	00e43c23          	sd	a4,24(s0)
   116dc:	02f42023          	sw	a5,32(s0)
   116e0:	f45ff06f          	j	11624 <__smakebuf_r+0xec>

00000000000116e4 <_malloc_r>:
   116e4:	fa010113          	addi	sp,sp,-96
   116e8:	04913423          	sd	s1,72(sp)
   116ec:	02e00793          	li	a5,46
   116f0:	01758493          	addi	s1,a1,23
   116f4:	03313c23          	sd	s3,56(sp)
   116f8:	04113c23          	sd	ra,88(sp)
   116fc:	04813823          	sd	s0,80(sp)
   11700:	05213023          	sd	s2,64(sp)
   11704:	03413823          	sd	s4,48(sp)
   11708:	03513423          	sd	s5,40(sp)
   1170c:	03613023          	sd	s6,32(sp)
   11710:	01713c23          	sd	s7,24(sp)
   11714:	01813823          	sd	s8,16(sp)
   11718:	01913423          	sd	s9,8(sp)
   1171c:	00050993          	mv	s3,a0
   11720:	1c97fa63          	bleu	s1,a5,118f4 <_malloc_r+0x210>
   11724:	800007b7          	lui	a5,0x80000
   11728:	ff04f493          	andi	s1,s1,-16
   1172c:	fff7c793          	not	a5,a5
   11730:	2497ee63          	bltu	a5,s1,1198c <_malloc_r+0x2a8>
   11734:	24b4ec63          	bltu	s1,a1,1198c <_malloc_r+0x2a8>
   11738:	04d000ef          	jal	11f84 <__malloc_lock>
   1173c:	1f700793          	li	a5,503
   11740:	7497fa63          	bleu	s1,a5,11e94 <_malloc_r+0x7b0>
   11744:	0094d793          	srli	a5,s1,0x9
   11748:	08000693          	li	a3,128
   1174c:	04000513          	li	a0,64
   11750:	03f00593          	li	a1,63
   11754:	24079463          	bnez	a5,1199c <_malloc_r+0x2b8>
   11758:	00013937          	lui	s2,0x13
   1175c:	62090913          	addi	s2,s2,1568 # 13620 <__malloc_av_>
   11760:	00369693          	slli	a3,a3,0x3
   11764:	00d906b3          	add	a3,s2,a3
   11768:	0086b403          	ld	s0,8(a3)
   1176c:	ff068693          	addi	a3,a3,-16
   11770:	24868663          	beq	a3,s0,119bc <_malloc_r+0x2d8>
   11774:	00843783          	ld	a5,8(s0)
   11778:	01f00613          	li	a2,31
   1177c:	ffc7f793          	andi	a5,a5,-4
   11780:	40978733          	sub	a4,a5,s1
   11784:	02e64063          	blt	a2,a4,117a4 <_malloc_r+0xc0>
   11788:	22075e63          	bgez	a4,119c4 <_malloc_r+0x2e0>
   1178c:	01843403          	ld	s0,24(s0)
   11790:	22868663          	beq	a3,s0,119bc <_malloc_r+0x2d8>
   11794:	00843783          	ld	a5,8(s0)
   11798:	ffc7f793          	andi	a5,a5,-4
   1179c:	40978733          	sub	a4,a5,s1
   117a0:	fee654e3          	ble	a4,a2,11788 <_malloc_r+0xa4>
   117a4:	00058693          	mv	a3,a1
   117a8:	02093403          	ld	s0,32(s2)
   117ac:	01090813          	addi	a6,s2,16
   117b0:	4d040463          	beq	s0,a6,11c78 <_malloc_r+0x594>
   117b4:	00843783          	ld	a5,8(s0)
   117b8:	01f00613          	li	a2,31
   117bc:	ffc7f793          	andi	a5,a5,-4
   117c0:	40978733          	sub	a4,a5,s1
   117c4:	46e64c63          	blt	a2,a4,11c3c <_malloc_r+0x558>
   117c8:	03093423          	sd	a6,40(s2)
   117cc:	03093023          	sd	a6,32(s2)
   117d0:	22075263          	bgez	a4,119f4 <_malloc_r+0x310>
   117d4:	1ff00713          	li	a4,511
   117d8:	3ef76e63          	bltu	a4,a5,11bd4 <_malloc_r+0x4f0>
   117dc:	0037d793          	srli	a5,a5,0x3
   117e0:	0007879b          	sext.w	a5,a5
   117e4:	0017861b          	addiw	a2,a5,1
   117e8:	0016161b          	slliw	a2,a2,0x1
   117ec:	00361613          	slli	a2,a2,0x3
   117f0:	00893703          	ld	a4,8(s2)
   117f4:	00c90633          	add	a2,s2,a2
   117f8:	00063503          	ld	a0,0(a2)
   117fc:	4027d79b          	sraiw	a5,a5,0x2
   11800:	00100593          	li	a1,1
   11804:	00f597b3          	sll	a5,a1,a5
   11808:	00e7e7b3          	or	a5,a5,a4
   1180c:	ff060713          	addi	a4,a2,-16
   11810:	00e43c23          	sd	a4,24(s0)
   11814:	00a43823          	sd	a0,16(s0)
   11818:	00f93423          	sd	a5,8(s2)
   1181c:	00863023          	sd	s0,0(a2)
   11820:	00853c23          	sd	s0,24(a0)
   11824:	4026d61b          	sraiw	a2,a3,0x2
   11828:	00100713          	li	a4,1
   1182c:	00c71633          	sll	a2,a4,a2
   11830:	1ec7e263          	bltu	a5,a2,11a14 <_malloc_r+0x330>
   11834:	00f67733          	and	a4,a2,a5
   11838:	02071463          	bnez	a4,11860 <_malloc_r+0x17c>
   1183c:	00161613          	slli	a2,a2,0x1
   11840:	ffc6f693          	andi	a3,a3,-4
   11844:	00f67733          	and	a4,a2,a5
   11848:	0046869b          	addiw	a3,a3,4
   1184c:	00071a63          	bnez	a4,11860 <_malloc_r+0x17c>
   11850:	00161613          	slli	a2,a2,0x1
   11854:	00f67733          	and	a4,a2,a5
   11858:	0046869b          	addiw	a3,a3,4
   1185c:	fe070ae3          	beqz	a4,11850 <_malloc_r+0x16c>
   11860:	01f00513          	li	a0,31
   11864:	0016889b          	addiw	a7,a3,1
   11868:	0018989b          	slliw	a7,a7,0x1
   1186c:	00389893          	slli	a7,a7,0x3
   11870:	011908b3          	add	a7,s2,a7
   11874:	ff088893          	addi	a7,a7,-16
   11878:	00088593          	mv	a1,a7
   1187c:	00068293          	mv	t0,a3
   11880:	0185b403          	ld	s0,24(a1)
   11884:	00859a63          	bne	a1,s0,11898 <_malloc_r+0x1b4>
   11888:	3f80006f          	j	11c80 <_malloc_r+0x59c>
   1188c:	40075c63          	bgez	a4,11ca4 <_malloc_r+0x5c0>
   11890:	01843403          	ld	s0,24(s0)
   11894:	3e858663          	beq	a1,s0,11c80 <_malloc_r+0x59c>
   11898:	00843783          	ld	a5,8(s0)
   1189c:	ffc7f793          	andi	a5,a5,-4
   118a0:	40978733          	sub	a4,a5,s1
   118a4:	fee554e3          	ble	a4,a0,1188c <_malloc_r+0x1a8>
   118a8:	01843683          	ld	a3,24(s0)
   118ac:	01043603          	ld	a2,16(s0)
   118b0:	009407b3          	add	a5,s0,s1
   118b4:	00176893          	ori	a7,a4,1
   118b8:	00e785b3          	add	a1,a5,a4
   118bc:	0014e493          	ori	s1,s1,1
   118c0:	00943423          	sd	s1,8(s0)
   118c4:	00098513          	mv	a0,s3
   118c8:	00d63c23          	sd	a3,24(a2)
   118cc:	00c6b823          	sd	a2,16(a3)
   118d0:	02f93423          	sd	a5,40(s2)
   118d4:	02f93023          	sd	a5,32(s2)
   118d8:	0107bc23          	sd	a6,24(a5) # ffffffff80000018 <_gp+0xffffffff7ffeb9e8>
   118dc:	0107b823          	sd	a6,16(a5)
   118e0:	0117b423          	sd	a7,8(a5)
   118e4:	00e5b023          	sd	a4,0(a1)
   118e8:	6a0000ef          	jal	11f88 <__malloc_unlock>
   118ec:	01040513          	addi	a0,s0,16
   118f0:	0680006f          	j	11958 <_malloc_r+0x274>
   118f4:	02000493          	li	s1,32
   118f8:	08b4ea63          	bltu	s1,a1,1198c <_malloc_r+0x2a8>
   118fc:	688000ef          	jal	11f84 <__malloc_lock>
   11900:	00a00793          	li	a5,10
   11904:	00400693          	li	a3,4
   11908:	00013937          	lui	s2,0x13
   1190c:	62090913          	addi	s2,s2,1568 # 13620 <__malloc_av_>
   11910:	00379793          	slli	a5,a5,0x3
   11914:	00f907b3          	add	a5,s2,a5
   11918:	0087b403          	ld	s0,8(a5)
   1191c:	ff078713          	addi	a4,a5,-16
   11920:	36e40a63          	beq	s0,a4,11c94 <_malloc_r+0x5b0>
   11924:	00843783          	ld	a5,8(s0)
   11928:	01843683          	ld	a3,24(s0)
   1192c:	01043603          	ld	a2,16(s0)
   11930:	ffc7f793          	andi	a5,a5,-4
   11934:	00f407b3          	add	a5,s0,a5
   11938:	0087b703          	ld	a4,8(a5)
   1193c:	00098513          	mv	a0,s3
   11940:	00d63c23          	sd	a3,24(a2)
   11944:	00176713          	ori	a4,a4,1
   11948:	00c6b823          	sd	a2,16(a3)
   1194c:	00e7b423          	sd	a4,8(a5)
   11950:	638000ef          	jal	11f88 <__malloc_unlock>
   11954:	01040513          	addi	a0,s0,16
   11958:	05813083          	ld	ra,88(sp)
   1195c:	05013403          	ld	s0,80(sp)
   11960:	04813483          	ld	s1,72(sp)
   11964:	04013903          	ld	s2,64(sp)
   11968:	03813983          	ld	s3,56(sp)
   1196c:	03013a03          	ld	s4,48(sp)
   11970:	02813a83          	ld	s5,40(sp)
   11974:	02013b03          	ld	s6,32(sp)
   11978:	01813b83          	ld	s7,24(sp)
   1197c:	01013c03          	ld	s8,16(sp)
   11980:	00813c83          	ld	s9,8(sp)
   11984:	06010113          	addi	sp,sp,96
   11988:	00008067          	ret
   1198c:	00c00793          	li	a5,12
   11990:	00f9a023          	sw	a5,0(s3) # ffffffffffffe000 <_gp+0xfffffffffffe99d0>
   11994:	00000513          	li	a0,0
   11998:	fc1ff06f          	j	11958 <_malloc_r+0x274>
   1199c:	00400713          	li	a4,4
   119a0:	20f76663          	bltu	a4,a5,11bac <_malloc_r+0x4c8>
   119a4:	0064d593          	srli	a1,s1,0x6
   119a8:	0005859b          	sext.w	a1,a1
   119ac:	0395851b          	addiw	a0,a1,57
   119b0:	0015169b          	slliw	a3,a0,0x1
   119b4:	0385859b          	addiw	a1,a1,56
   119b8:	da1ff06f          	j	11758 <_malloc_r+0x74>
   119bc:	00050693          	mv	a3,a0
   119c0:	de9ff06f          	j	117a8 <_malloc_r+0xc4>
   119c4:	00f407b3          	add	a5,s0,a5
   119c8:	0087b703          	ld	a4,8(a5)
   119cc:	01843683          	ld	a3,24(s0)
   119d0:	01043603          	ld	a2,16(s0)
   119d4:	00176713          	ori	a4,a4,1
   119d8:	00098513          	mv	a0,s3
   119dc:	00d63c23          	sd	a3,24(a2)
   119e0:	00c6b823          	sd	a2,16(a3)
   119e4:	00e7b423          	sd	a4,8(a5)
   119e8:	5a0000ef          	jal	11f88 <__malloc_unlock>
   119ec:	01040513          	addi	a0,s0,16
   119f0:	f69ff06f          	j	11958 <_malloc_r+0x274>
   119f4:	00f407b3          	add	a5,s0,a5
   119f8:	0087b703          	ld	a4,8(a5)
   119fc:	00098513          	mv	a0,s3
   11a00:	00176713          	ori	a4,a4,1
   11a04:	00e7b423          	sd	a4,8(a5)
   11a08:	580000ef          	jal	11f88 <__malloc_unlock>
   11a0c:	01040513          	addi	a0,s0,16
   11a10:	f49ff06f          	j	11958 <_malloc_r+0x274>
   11a14:	01093403          	ld	s0,16(s2)
   11a18:	00843b03          	ld	s6,8(s0)
   11a1c:	ffcb7b93          	andi	s7,s6,-4
   11a20:	009be863          	bltu	s7,s1,11a30 <_malloc_r+0x34c>
   11a24:	409b87b3          	sub	a5,s7,s1
   11a28:	01f00713          	li	a4,31
   11a2c:	14f74c63          	blt	a4,a5,11b84 <_malloc_r+0x4a0>
   11a30:	8381b783          	ld	a5,-1992(gp) # 13e68 <__malloc_top_pad>
   11a34:	8181b683          	ld	a3,-2024(gp) # 13e48 <__malloc_sbrk_base>
   11a38:	fff00713          	li	a4,-1
   11a3c:	00f487b3          	add	a5,s1,a5
   11a40:	01740a33          	add	s4,s0,s7
   11a44:	02078b13          	addi	s6,a5,32
   11a48:	00e68c63          	beq	a3,a4,11a60 <_malloc_r+0x37c>
   11a4c:	000016b7          	lui	a3,0x1
   11a50:	01f68b13          	addi	s6,a3,31 # 101f <_ftext-0xefe1>
   11a54:	016786b3          	add	a3,a5,s6
   11a58:	fffff7b7          	lui	a5,0xfffff
   11a5c:	00f6fb33          	and	s6,a3,a5
   11a60:	000b0513          	mv	a0,s6
   11a64:	305000ef          	jal	12568 <sbrk>
   11a68:	fff00793          	li	a5,-1
   11a6c:	00050a93          	mv	s5,a0
   11a70:	28f50a63          	beq	a0,a5,11d04 <_malloc_r+0x620>
   11a74:	29456663          	bltu	a0,s4,11d00 <_malloc_r+0x61c>
   11a78:	88018c13          	addi	s8,gp,-1920 # 13eb0 <__malloc_current_mallinfo>
   11a7c:	000c2783          	lw	a5,0(s8)
   11a80:	00fb07bb          	addw	a5,s6,a5
   11a84:	00fc2023          	sw	a5,0(s8)
   11a88:	375a0c63          	beq	s4,s5,11e00 <_malloc_r+0x71c>
   11a8c:	8181b683          	ld	a3,-2024(gp) # 13e48 <__malloc_sbrk_base>
   11a90:	fff00713          	li	a4,-1
   11a94:	38e68a63          	beq	a3,a4,11e28 <_malloc_r+0x744>
   11a98:	414a8a33          	sub	s4,s5,s4
   11a9c:	00fa07bb          	addw	a5,s4,a5
   11aa0:	00fc2023          	sw	a5,0(s8)
   11aa4:	00faf713          	andi	a4,s5,15
   11aa8:	000017b7          	lui	a5,0x1
   11aac:	00070a63          	beqz	a4,11ac0 <_malloc_r+0x3dc>
   11ab0:	40ea8ab3          	sub	s5,s5,a4
   11ab4:	01078a13          	addi	s4,a5,16 # 1010 <_ftext-0xeff0>
   11ab8:	010a8a93          	addi	s5,s5,16
   11abc:	40ea07b3          	sub	a5,s4,a4
   11ac0:	00001a37          	lui	s4,0x1
   11ac4:	fffa0a13          	addi	s4,s4,-1 # fff <_ftext-0xf001>
   11ac8:	016a8b33          	add	s6,s5,s6
   11acc:	014b7b33          	and	s6,s6,s4
   11ad0:	41678a33          	sub	s4,a5,s6
   11ad4:	000a0513          	mv	a0,s4
   11ad8:	291000ef          	jal	12568 <sbrk>
   11adc:	fff00793          	li	a5,-1
   11ae0:	32f50e63          	beq	a0,a5,11e1c <_malloc_r+0x738>
   11ae4:	41550733          	sub	a4,a0,s5
   11ae8:	01470733          	add	a4,a4,s4
   11aec:	00176713          	ori	a4,a4,1
   11af0:	000a0a1b          	sext.w	s4,s4
   11af4:	000c2783          	lw	a5,0(s8)
   11af8:	01593823          	sd	s5,16(s2)
   11afc:	00eab423          	sd	a4,8(s5)
   11b00:	00fa07bb          	addw	a5,s4,a5
   11b04:	00fc2023          	sw	a5,0(s8)
   11b08:	03240c63          	beq	s0,s2,11b40 <_malloc_r+0x45c>
   11b0c:	01f00613          	li	a2,31
   11b10:	29767c63          	bleu	s7,a2,11da8 <_malloc_r+0x6c4>
   11b14:	fe8b8713          	addi	a4,s7,-24
   11b18:	ff077713          	andi	a4,a4,-16
   11b1c:	00e406b3          	add	a3,s0,a4
   11b20:	00900593          	li	a1,9
   11b24:	00b6b423          	sd	a1,8(a3)
   11b28:	00b6b823          	sd	a1,16(a3)
   11b2c:	00843683          	ld	a3,8(s0)
   11b30:	0016f693          	andi	a3,a3,1
   11b34:	00e6e6b3          	or	a3,a3,a4
   11b38:	00d43423          	sd	a3,8(s0)
   11b3c:	2ee66a63          	bltu	a2,a4,11e30 <_malloc_r+0x74c>
   11b40:	8301b683          	ld	a3,-2000(gp) # 13e60 <__malloc_max_sbrked_mem>
   11b44:	00f6f463          	bleu	a5,a3,11b4c <_malloc_r+0x468>
   11b48:	82f1b823          	sd	a5,-2000(gp) # 13e60 <__malloc_max_sbrked_mem>
   11b4c:	8281b683          	ld	a3,-2008(gp) # 13e58 <__malloc_max_total_mem>
   11b50:	01093403          	ld	s0,16(s2)
   11b54:	00f6f463          	bleu	a5,a3,11b5c <_malloc_r+0x478>
   11b58:	82f1b423          	sd	a5,-2008(gp) # 13e58 <__malloc_max_total_mem>
   11b5c:	00843703          	ld	a4,8(s0)
   11b60:	ffc77713          	andi	a4,a4,-4
   11b64:	409707b3          	sub	a5,a4,s1
   11b68:	00976663          	bltu	a4,s1,11b74 <_malloc_r+0x490>
   11b6c:	01f00713          	li	a4,31
   11b70:	00f74a63          	blt	a4,a5,11b84 <_malloc_r+0x4a0>
   11b74:	00098513          	mv	a0,s3
   11b78:	410000ef          	jal	11f88 <__malloc_unlock>
   11b7c:	00000513          	li	a0,0
   11b80:	dd9ff06f          	j	11958 <_malloc_r+0x274>
   11b84:	00940733          	add	a4,s0,s1
   11b88:	0017e793          	ori	a5,a5,1
   11b8c:	0014e493          	ori	s1,s1,1
   11b90:	00943423          	sd	s1,8(s0)
   11b94:	00098513          	mv	a0,s3
   11b98:	00e93823          	sd	a4,16(s2)
   11b9c:	00f73423          	sd	a5,8(a4)
   11ba0:	3e8000ef          	jal	11f88 <__malloc_unlock>
   11ba4:	01040513          	addi	a0,s0,16
   11ba8:	db1ff06f          	j	11958 <_malloc_r+0x274>
   11bac:	01400713          	li	a4,20
   11bb0:	12f77263          	bleu	a5,a4,11cd4 <_malloc_r+0x5f0>
   11bb4:	05400713          	li	a4,84
   11bb8:	1af76863          	bltu	a4,a5,11d68 <_malloc_r+0x684>
   11bbc:	00c4d593          	srli	a1,s1,0xc
   11bc0:	0005859b          	sext.w	a1,a1
   11bc4:	06f5851b          	addiw	a0,a1,111
   11bc8:	0015169b          	slliw	a3,a0,0x1
   11bcc:	06e5859b          	addiw	a1,a1,110
   11bd0:	b89ff06f          	j	11758 <_malloc_r+0x74>
   11bd4:	0097d713          	srli	a4,a5,0x9
   11bd8:	00400613          	li	a2,4
   11bdc:	10e67663          	bleu	a4,a2,11ce8 <_malloc_r+0x604>
   11be0:	01400613          	li	a2,20
   11be4:	1ee66e63          	bltu	a2,a4,11de0 <_malloc_r+0x6fc>
   11be8:	0007071b          	sext.w	a4,a4
   11bec:	05c7059b          	addiw	a1,a4,92
   11bf0:	05b7061b          	addiw	a2,a4,91
   11bf4:	0015959b          	slliw	a1,a1,0x1
   11bf8:	00359593          	slli	a1,a1,0x3
   11bfc:	00b905b3          	add	a1,s2,a1
   11c00:	0005b703          	ld	a4,0(a1)
   11c04:	ff058593          	addi	a1,a1,-16
   11c08:	18e58063          	beq	a1,a4,11d88 <_malloc_r+0x6a4>
   11c0c:	00873603          	ld	a2,8(a4)
   11c10:	ffc67613          	andi	a2,a2,-4
   11c14:	00c7f663          	bleu	a2,a5,11c20 <_malloc_r+0x53c>
   11c18:	01073703          	ld	a4,16(a4)
   11c1c:	fee598e3          	bne	a1,a4,11c0c <_malloc_r+0x528>
   11c20:	01873583          	ld	a1,24(a4)
   11c24:	00893783          	ld	a5,8(s2)
   11c28:	00b43c23          	sd	a1,24(s0)
   11c2c:	00e43823          	sd	a4,16(s0)
   11c30:	0085b823          	sd	s0,16(a1)
   11c34:	00873c23          	sd	s0,24(a4)
   11c38:	bedff06f          	j	11824 <_malloc_r+0x140>
   11c3c:	009407b3          	add	a5,s0,s1
   11c40:	00176613          	ori	a2,a4,1
   11c44:	00e786b3          	add	a3,a5,a4
   11c48:	0014e493          	ori	s1,s1,1
   11c4c:	00943423          	sd	s1,8(s0)
   11c50:	00098513          	mv	a0,s3
   11c54:	02f93423          	sd	a5,40(s2)
   11c58:	02f93023          	sd	a5,32(s2)
   11c5c:	0107bc23          	sd	a6,24(a5)
   11c60:	0107b823          	sd	a6,16(a5)
   11c64:	00c7b423          	sd	a2,8(a5)
   11c68:	00e6b023          	sd	a4,0(a3)
   11c6c:	31c000ef          	jal	11f88 <__malloc_unlock>
   11c70:	01040513          	addi	a0,s0,16
   11c74:	ce5ff06f          	j	11958 <_malloc_r+0x274>
   11c78:	00893783          	ld	a5,8(s2)
   11c7c:	ba9ff06f          	j	11824 <_malloc_r+0x140>
   11c80:	0012829b          	addiw	t0,t0,1
   11c84:	0032f793          	andi	a5,t0,3
   11c88:	01058593          	addi	a1,a1,16
   11c8c:	be079ae3          	bnez	a5,11880 <_malloc_r+0x19c>
   11c90:	0900006f          	j	11d20 <_malloc_r+0x63c>
   11c94:	0187b403          	ld	s0,24(a5)
   11c98:	0026869b          	addiw	a3,a3,2
   11c9c:	b08786e3          	beq	a5,s0,117a8 <_malloc_r+0xc4>
   11ca0:	c85ff06f          	j	11924 <_malloc_r+0x240>
   11ca4:	00f407b3          	add	a5,s0,a5
   11ca8:	0087b703          	ld	a4,8(a5)
   11cac:	01843683          	ld	a3,24(s0)
   11cb0:	01043603          	ld	a2,16(s0)
   11cb4:	00176713          	ori	a4,a4,1
   11cb8:	00e7b423          	sd	a4,8(a5)
   11cbc:	00098513          	mv	a0,s3
   11cc0:	00d63c23          	sd	a3,24(a2)
   11cc4:	00c6b823          	sd	a2,16(a3)
   11cc8:	2c0000ef          	jal	11f88 <__malloc_unlock>
   11ccc:	01040513          	addi	a0,s0,16
   11cd0:	c89ff06f          	j	11958 <_malloc_r+0x274>
   11cd4:	0007859b          	sext.w	a1,a5
   11cd8:	05c5851b          	addiw	a0,a1,92
   11cdc:	0015169b          	slliw	a3,a0,0x1
   11ce0:	05b5859b          	addiw	a1,a1,91
   11ce4:	a75ff06f          	j	11758 <_malloc_r+0x74>
   11ce8:	0067d713          	srli	a4,a5,0x6
   11cec:	0007071b          	sext.w	a4,a4
   11cf0:	0397059b          	addiw	a1,a4,57
   11cf4:	0387061b          	addiw	a2,a4,56
   11cf8:	0015959b          	slliw	a1,a1,0x1
   11cfc:	efdff06f          	j	11bf8 <_malloc_r+0x514>
   11d00:	d7240ce3          	beq	s0,s2,11a78 <_malloc_r+0x394>
   11d04:	01093403          	ld	s0,16(s2)
   11d08:	00843703          	ld	a4,8(s0)
   11d0c:	ffc77713          	andi	a4,a4,-4
   11d10:	e55ff06f          	j	11b64 <_malloc_r+0x480>
   11d14:	0108b783          	ld	a5,16(a7)
   11d18:	fff6869b          	addiw	a3,a3,-1
   11d1c:	16f89863          	bne	a7,a5,11e8c <_malloc_r+0x7a8>
   11d20:	0036f793          	andi	a5,a3,3
   11d24:	ff088893          	addi	a7,a7,-16
   11d28:	fe0796e3          	bnez	a5,11d14 <_malloc_r+0x630>
   11d2c:	00893783          	ld	a5,8(s2)
   11d30:	fff64713          	not	a4,a2
   11d34:	00f777b3          	and	a5,a4,a5
   11d38:	00f93423          	sd	a5,8(s2)
   11d3c:	00161613          	slli	a2,a2,0x1
   11d40:	ccc7eae3          	bltu	a5,a2,11a14 <_malloc_r+0x330>
   11d44:	cc0608e3          	beqz	a2,11a14 <_malloc_r+0x330>
   11d48:	00f67733          	and	a4,a2,a5
   11d4c:	00028693          	mv	a3,t0
   11d50:	b0071ae3          	bnez	a4,11864 <_malloc_r+0x180>
   11d54:	00161613          	slli	a2,a2,0x1
   11d58:	00f67733          	and	a4,a2,a5
   11d5c:	0046869b          	addiw	a3,a3,4
   11d60:	fe070ae3          	beqz	a4,11d54 <_malloc_r+0x670>
   11d64:	b01ff06f          	j	11864 <_malloc_r+0x180>
   11d68:	15400713          	li	a4,340
   11d6c:	04f76463          	bltu	a4,a5,11db4 <_malloc_r+0x6d0>
   11d70:	00f4d593          	srli	a1,s1,0xf
   11d74:	0005859b          	sext.w	a1,a1
   11d78:	0785851b          	addiw	a0,a1,120
   11d7c:	0015169b          	slliw	a3,a0,0x1
   11d80:	0775859b          	addiw	a1,a1,119
   11d84:	9d5ff06f          	j	11758 <_malloc_r+0x74>
   11d88:	00893703          	ld	a4,8(s2)
   11d8c:	00100793          	li	a5,1
   11d90:	4026561b          	sraiw	a2,a2,0x2
   11d94:	00c79633          	sll	a2,a5,a2
   11d98:	00e667b3          	or	a5,a2,a4
   11d9c:	00f93423          	sd	a5,8(s2)
   11da0:	00058713          	mv	a4,a1
   11da4:	e85ff06f          	j	11c28 <_malloc_r+0x544>
   11da8:	00100793          	li	a5,1
   11dac:	00fab423          	sd	a5,8(s5)
   11db0:	dc5ff06f          	j	11b74 <_malloc_r+0x490>
   11db4:	55400713          	li	a4,1364
   11db8:	0fe00693          	li	a3,254
   11dbc:	07f00513          	li	a0,127
   11dc0:	07e00593          	li	a1,126
   11dc4:	98f76ae3          	bltu	a4,a5,11758 <_malloc_r+0x74>
   11dc8:	0124d593          	srli	a1,s1,0x12
   11dcc:	0005859b          	sext.w	a1,a1
   11dd0:	07d5851b          	addiw	a0,a1,125
   11dd4:	0015169b          	slliw	a3,a0,0x1
   11dd8:	07c5859b          	addiw	a1,a1,124
   11ddc:	97dff06f          	j	11758 <_malloc_r+0x74>
   11de0:	05400613          	li	a2,84
   11de4:	06e66063          	bltu	a2,a4,11e44 <_malloc_r+0x760>
   11de8:	00c7d713          	srli	a4,a5,0xc
   11dec:	0007071b          	sext.w	a4,a4
   11df0:	06f7059b          	addiw	a1,a4,111
   11df4:	06e7061b          	addiw	a2,a4,110
   11df8:	0015959b          	slliw	a1,a1,0x1
   11dfc:	dfdff06f          	j	11bf8 <_malloc_r+0x514>
   11e00:	034a1713          	slli	a4,s4,0x34
   11e04:	c80714e3          	bnez	a4,11a8c <_malloc_r+0x3a8>
   11e08:	01093703          	ld	a4,16(s2)
   11e0c:	016b8b33          	add	s6,s7,s6
   11e10:	001b6b13          	ori	s6,s6,1
   11e14:	01673423          	sd	s6,8(a4)
   11e18:	d29ff06f          	j	11b40 <_malloc_r+0x45c>
   11e1c:	00100713          	li	a4,1
   11e20:	00000a13          	li	s4,0
   11e24:	cd1ff06f          	j	11af4 <_malloc_r+0x410>
   11e28:	8151bc23          	sd	s5,-2024(gp) # 13e48 <__malloc_sbrk_base>
   11e2c:	c79ff06f          	j	11aa4 <_malloc_r+0x3c0>
   11e30:	01040593          	addi	a1,s0,16
   11e34:	00098513          	mv	a0,s3
   11e38:	a9cff0ef          	jal	110d4 <_free_r>
   11e3c:	000c2783          	lw	a5,0(s8)
   11e40:	d01ff06f          	j	11b40 <_malloc_r+0x45c>
   11e44:	15400613          	li	a2,340
   11e48:	00e66e63          	bltu	a2,a4,11e64 <_malloc_r+0x780>
   11e4c:	00f7d713          	srli	a4,a5,0xf
   11e50:	0007071b          	sext.w	a4,a4
   11e54:	0787059b          	addiw	a1,a4,120
   11e58:	0777061b          	addiw	a2,a4,119
   11e5c:	0015959b          	slliw	a1,a1,0x1
   11e60:	d99ff06f          	j	11bf8 <_malloc_r+0x514>
   11e64:	55400513          	li	a0,1364
   11e68:	0fe00593          	li	a1,254
   11e6c:	07e00613          	li	a2,126
   11e70:	d8e564e3          	bltu	a0,a4,11bf8 <_malloc_r+0x514>
   11e74:	0127d713          	srli	a4,a5,0x12
   11e78:	0007071b          	sext.w	a4,a4
   11e7c:	07d7059b          	addiw	a1,a4,125
   11e80:	07c7061b          	addiw	a2,a4,124
   11e84:	0015959b          	slliw	a1,a1,0x1
   11e88:	d71ff06f          	j	11bf8 <_malloc_r+0x514>
   11e8c:	00893783          	ld	a5,8(s2)
   11e90:	eadff06f          	j	11d3c <_malloc_r+0x658>
   11e94:	0034d693          	srli	a3,s1,0x3
   11e98:	0006869b          	sext.w	a3,a3
   11e9c:	0016879b          	addiw	a5,a3,1
   11ea0:	0017979b          	slliw	a5,a5,0x1
   11ea4:	a65ff06f          	j	11908 <_malloc_r+0x224>

0000000000011ea8 <memset>:
   11ea8:	00f00813          	li	a6,15
   11eac:	00050713          	mv	a4,a0
   11eb0:	02c87a63          	bleu	a2,a6,11ee4 <memset+0x3c>
   11eb4:	00f77793          	andi	a5,a4,15
   11eb8:	0a079063          	bnez	a5,11f58 <memset+0xb0>
   11ebc:	06059e63          	bnez	a1,11f38 <memset+0x90>
   11ec0:	ff067693          	andi	a3,a2,-16
   11ec4:	00f67613          	andi	a2,a2,15
   11ec8:	00e686b3          	add	a3,a3,a4
   11ecc:	00b73023          	sd	a1,0(a4)
   11ed0:	00b73423          	sd	a1,8(a4)
   11ed4:	01070713          	addi	a4,a4,16
   11ed8:	fed76ae3          	bltu	a4,a3,11ecc <memset+0x24>
   11edc:	00061463          	bnez	a2,11ee4 <memset+0x3c>
   11ee0:	00008067          	ret
   11ee4:	40c806b3          	sub	a3,a6,a2
   11ee8:	00269693          	slli	a3,a3,0x2
   11eec:	00000297          	auipc	t0,0x0
   11ef0:	005686b3          	add	a3,a3,t0
   11ef4:	00c68067          	jr	a3,12
   11ef8:	00b70723          	sb	a1,14(a4)
   11efc:	00b706a3          	sb	a1,13(a4)
   11f00:	00b70623          	sb	a1,12(a4)
   11f04:	00b705a3          	sb	a1,11(a4)
   11f08:	00b70523          	sb	a1,10(a4)
   11f0c:	00b704a3          	sb	a1,9(a4)
   11f10:	00b70423          	sb	a1,8(a4)
   11f14:	00b703a3          	sb	a1,7(a4)
   11f18:	00b70323          	sb	a1,6(a4)
   11f1c:	00b702a3          	sb	a1,5(a4)
   11f20:	00b70223          	sb	a1,4(a4)
   11f24:	00b701a3          	sb	a1,3(a4)
   11f28:	00b70123          	sb	a1,2(a4)
   11f2c:	00b700a3          	sb	a1,1(a4)
   11f30:	00b70023          	sb	a1,0(a4)
   11f34:	00008067          	ret
   11f38:	0ff5f593          	andi	a1,a1,255
   11f3c:	00859693          	slli	a3,a1,0x8
   11f40:	00d5e5b3          	or	a1,a1,a3
   11f44:	01059693          	slli	a3,a1,0x10
   11f48:	00d5e5b3          	or	a1,a1,a3
   11f4c:	02059693          	slli	a3,a1,0x20
   11f50:	00d5e5b3          	or	a1,a1,a3
   11f54:	f6dff06f          	j	11ec0 <memset+0x18>
   11f58:	00279693          	slli	a3,a5,0x2
   11f5c:	00000297          	auipc	t0,0x0
   11f60:	005686b3          	add	a3,a3,t0
   11f64:	00008293          	mv	t0,ra
   11f68:	f98680e7          	jalr	a3,-104
   11f6c:	00028093          	mv	ra,t0
   11f70:	ff078793          	addi	a5,a5,-16
   11f74:	40f70733          	sub	a4,a4,a5
   11f78:	00f60633          	add	a2,a2,a5
   11f7c:	f6c874e3          	bleu	a2,a6,11ee4 <memset+0x3c>
   11f80:	f3dff06f          	j	11ebc <memset+0x14>

0000000000011f84 <__malloc_lock>:
   11f84:	00008067          	ret

0000000000011f88 <__malloc_unlock>:
   11f88:	00008067          	ret

0000000000011f8c <__sread>:
   11f8c:	01259503          	lh	a0,18(a1)
   11f90:	ff010113          	addi	sp,sp,-16
   11f94:	00813023          	sd	s0,0(sp)
   11f98:	00058413          	mv	s0,a1
   11f9c:	00060593          	mv	a1,a2
   11fa0:	00068613          	mv	a2,a3
   11fa4:	00113423          	sd	ra,8(sp)
   11fa8:	2c4000ef          	jal	1226c <read>
   11fac:	02054063          	bltz	a0,11fcc <__sread+0x40>
   11fb0:	08c42783          	lw	a5,140(s0)
   11fb4:	00813083          	ld	ra,8(sp)
   11fb8:	00a787bb          	addw	a5,a5,a0
   11fbc:	08f42623          	sw	a5,140(s0)
   11fc0:	00013403          	ld	s0,0(sp)
   11fc4:	01010113          	addi	sp,sp,16
   11fc8:	00008067          	ret
   11fcc:	01045703          	lhu	a4,16(s0)
   11fd0:	fffff7b7          	lui	a5,0xfffff
   11fd4:	00813083          	ld	ra,8(sp)
   11fd8:	fff7879b          	addiw	a5,a5,-1
   11fdc:	00f777b3          	and	a5,a4,a5
   11fe0:	00f41823          	sh	a5,16(s0)
   11fe4:	00013403          	ld	s0,0(sp)
   11fe8:	01010113          	addi	sp,sp,16
   11fec:	00008067          	ret

0000000000011ff0 <__seofread>:
   11ff0:	00000513          	li	a0,0
   11ff4:	00008067          	ret

0000000000011ff8 <__swrite>:
   11ff8:	01059703          	lh	a4,16(a1)
   11ffc:	fd010113          	addi	sp,sp,-48
   12000:	02813023          	sd	s0,32(sp)
   12004:	10077793          	andi	a5,a4,256
   12008:	00913c23          	sd	s1,24(sp)
   1200c:	02113423          	sd	ra,40(sp)
   12010:	00058413          	mv	s0,a1
   12014:	00060493          	mv	s1,a2
   12018:	02078063          	beqz	a5,12038 <__swrite+0x40>
   1201c:	01259503          	lh	a0,18(a1)
   12020:	00200613          	li	a2,2
   12024:	00000593          	li	a1,0
   12028:	00d13423          	sd	a3,8(sp)
   1202c:	22c000ef          	jal	12258 <lseek>
   12030:	01041703          	lh	a4,16(s0)
   12034:	00813683          	ld	a3,8(sp)
   12038:	fffff7b7          	lui	a5,0xfffff
   1203c:	fff7879b          	addiw	a5,a5,-1
   12040:	00f777b3          	and	a5,a4,a5
   12044:	01241503          	lh	a0,18(s0)
   12048:	00f41823          	sh	a5,16(s0)
   1204c:	00048593          	mv	a1,s1
   12050:	02813083          	ld	ra,40(sp)
   12054:	02013403          	ld	s0,32(sp)
   12058:	01813483          	ld	s1,24(sp)
   1205c:	00068613          	mv	a2,a3
   12060:	03010113          	addi	sp,sp,48
   12064:	2200006f          	j	12284 <write>

0000000000012068 <__sseek>:
   12068:	01259503          	lh	a0,18(a1)
   1206c:	ff010113          	addi	sp,sp,-16
   12070:	00813023          	sd	s0,0(sp)
   12074:	00058413          	mv	s0,a1
   12078:	00060593          	mv	a1,a2
   1207c:	00068613          	mv	a2,a3
   12080:	00113423          	sd	ra,8(sp)
   12084:	1d4000ef          	jal	12258 <lseek>
   12088:	fff00793          	li	a5,-1
   1208c:	01045703          	lhu	a4,16(s0)
   12090:	02f50263          	beq	a0,a5,120b4 <__sseek+0x4c>
   12094:	00813083          	ld	ra,8(sp)
   12098:	000017b7          	lui	a5,0x1
   1209c:	00f767b3          	or	a5,a4,a5
   120a0:	08a42623          	sw	a0,140(s0)
   120a4:	00f41823          	sh	a5,16(s0)
   120a8:	00013403          	ld	s0,0(sp)
   120ac:	01010113          	addi	sp,sp,16
   120b0:	00008067          	ret
   120b4:	fffff7b7          	lui	a5,0xfffff
   120b8:	00813083          	ld	ra,8(sp)
   120bc:	fff7879b          	addiw	a5,a5,-1
   120c0:	00f777b3          	and	a5,a4,a5
   120c4:	00f41823          	sh	a5,16(s0)
   120c8:	00013403          	ld	s0,0(sp)
   120cc:	01010113          	addi	sp,sp,16
   120d0:	00008067          	ret

00000000000120d4 <__sclose>:
   120d4:	01259503          	lh	a0,18(a1)
   120d8:	25c0006f          	j	12334 <close>

00000000000120dc <_fclose_r>:
   120dc:	0e058063          	beqz	a1,121bc <_fclose_r+0xe0>
   120e0:	fe010113          	addi	sp,sp,-32
   120e4:	00913423          	sd	s1,8(sp)
   120e8:	00050493          	mv	s1,a0
   120ec:	00813823          	sd	s0,16(sp)
   120f0:	00113c23          	sd	ra,24(sp)
   120f4:	01213023          	sd	s2,0(sp)
   120f8:	00058413          	mv	s0,a1
   120fc:	e91fe0ef          	jal	10f8c <__sfp_lock_acquire>
   12100:	00048663          	beqz	s1,1210c <_fclose_r+0x30>
   12104:	0504a783          	lw	a5,80(s1)
   12108:	0a078e63          	beqz	a5,121c4 <_fclose_r+0xe8>
   1210c:	01041783          	lh	a5,16(s0)
   12110:	08078663          	beqz	a5,1219c <_fclose_r+0xc0>
   12114:	00040593          	mv	a1,s0
   12118:	00048513          	mv	a0,s1
   1211c:	889fe0ef          	jal	109a4 <_fflush_r>
   12120:	05043783          	ld	a5,80(s0)
   12124:	00050913          	mv	s2,a0
   12128:	00078a63          	beqz	a5,1213c <_fclose_r+0x60>
   1212c:	03043583          	ld	a1,48(s0)
   12130:	00048513          	mv	a0,s1
   12134:	000780e7          	jalr	a5
   12138:	0a054863          	bltz	a0,121e8 <_fclose_r+0x10c>
   1213c:	01045783          	lhu	a5,16(s0)
   12140:	0807f793          	andi	a5,a5,128
   12144:	08079a63          	bnez	a5,121d8 <_fclose_r+0xfc>
   12148:	05843583          	ld	a1,88(s0)
   1214c:	00058c63          	beqz	a1,12164 <_fclose_r+0x88>
   12150:	07440793          	addi	a5,s0,116
   12154:	00f58663          	beq	a1,a5,12160 <_fclose_r+0x84>
   12158:	00048513          	mv	a0,s1
   1215c:	f79fe0ef          	jal	110d4 <_free_r>
   12160:	04043c23          	sd	zero,88(s0)
   12164:	07843583          	ld	a1,120(s0)
   12168:	00058863          	beqz	a1,12178 <_fclose_r+0x9c>
   1216c:	00048513          	mv	a0,s1
   12170:	f65fe0ef          	jal	110d4 <_free_r>
   12174:	06043c23          	sd	zero,120(s0)
   12178:	00041823          	sh	zero,16(s0)
   1217c:	e15fe0ef          	jal	10f90 <__sfp_lock_release>
   12180:	01813083          	ld	ra,24(sp)
   12184:	00090513          	mv	a0,s2
   12188:	01013403          	ld	s0,16(sp)
   1218c:	00813483          	ld	s1,8(sp)
   12190:	00013903          	ld	s2,0(sp)
   12194:	02010113          	addi	sp,sp,32
   12198:	00008067          	ret
   1219c:	df5fe0ef          	jal	10f90 <__sfp_lock_release>
   121a0:	01813083          	ld	ra,24(sp)
   121a4:	00000513          	li	a0,0
   121a8:	01013403          	ld	s0,16(sp)
   121ac:	00813483          	ld	s1,8(sp)
   121b0:	00013903          	ld	s2,0(sp)
   121b4:	02010113          	addi	sp,sp,32
   121b8:	00008067          	ret
   121bc:	00000513          	li	a0,0
   121c0:	00008067          	ret
   121c4:	00048513          	mv	a0,s1
   121c8:	db5fe0ef          	jal	10f7c <__sinit>
   121cc:	01041783          	lh	a5,16(s0)
   121d0:	f40792e3          	bnez	a5,12114 <_fclose_r+0x38>
   121d4:	fc9ff06f          	j	1219c <_fclose_r+0xc0>
   121d8:	01843583          	ld	a1,24(s0)
   121dc:	00048513          	mv	a0,s1
   121e0:	ef5fe0ef          	jal	110d4 <_free_r>
   121e4:	f65ff06f          	j	12148 <_fclose_r+0x6c>
   121e8:	fff00913          	li	s2,-1
   121ec:	f51ff06f          	j	1213c <_fclose_r+0x60>

00000000000121f0 <fclose>:
   121f0:	00050593          	mv	a1,a0
   121f4:	8101b503          	ld	a0,-2032(gp) # 13e40 <_impure_ptr>
   121f8:	ee5ff06f          	j	120dc <_fclose_r>

00000000000121fc <__syscall_error>:
   121fc:	ff010113          	addi	sp,sp,-16
   12200:	00113423          	sd	ra,8(sp)
   12204:	00813023          	sd	s0,0(sp)
   12208:	00050413          	mv	s0,a0
   1220c:	3c8000ef          	jal	125d4 <__errno>
   12210:	00813083          	ld	ra,8(sp)
   12214:	408007bb          	negw	a5,s0
   12218:	00f52023          	sw	a5,0(a0)
   1221c:	00013403          	ld	s0,0(sp)
   12220:	fff00513          	li	a0,-1
   12224:	01010113          	addi	sp,sp,16
   12228:	00008067          	ret

000000000001222c <open>:
   1222c:	00000693          	li	a3,0
   12230:	40000893          	li	a7,1024
   12234:	00000073          	ecall
   12238:	fc0542e3          	bltz	a0,121fc <__syscall_error>
   1223c:	0005051b          	sext.w	a0,a0
   12240:	00008067          	ret

0000000000012244 <openat>:
   12244:	03800893          	li	a7,56
   12248:	00000073          	ecall
   1224c:	fa0548e3          	bltz	a0,121fc <__syscall_error>
   12250:	0005051b          	sext.w	a0,a0
   12254:	00008067          	ret

0000000000012258 <lseek>:
   12258:	00000693          	li	a3,0
   1225c:	03e00893          	li	a7,62
   12260:	00000073          	ecall
   12264:	f8054ce3          	bltz	a0,121fc <__syscall_error>
   12268:	00008067          	ret

000000000001226c <read>:
   1226c:	00000693          	li	a3,0
   12270:	03f00893          	li	a7,63
   12274:	00000073          	ecall
   12278:	f80542e3          	bltz	a0,121fc <__syscall_error>
   1227c:	0005051b          	sext.w	a0,a0
   12280:	00008067          	ret

0000000000012284 <write>:
   12284:	00000693          	li	a3,0
   12288:	04000893          	li	a7,64
   1228c:	00000073          	ecall
   12290:	f60546e3          	bltz	a0,121fc <__syscall_error>
   12294:	0005051b          	sext.w	a0,a0
   12298:	00008067          	ret

000000000001229c <fstat>:
   1229c:	00000613          	li	a2,0
   122a0:	00000693          	li	a3,0
   122a4:	05000893          	li	a7,80
   122a8:	00000073          	ecall
   122ac:	f40548e3          	bltz	a0,121fc <__syscall_error>
   122b0:	0005051b          	sext.w	a0,a0
   122b4:	00008067          	ret

00000000000122b8 <stat>:
   122b8:	00000613          	li	a2,0
   122bc:	00000693          	li	a3,0
   122c0:	40e00893          	li	a7,1038
   122c4:	00000073          	ecall
   122c8:	f2054ae3          	bltz	a0,121fc <__syscall_error>
   122cc:	0005051b          	sext.w	a0,a0
   122d0:	00008067          	ret

00000000000122d4 <lstat>:
   122d4:	00000613          	li	a2,0
   122d8:	00000693          	li	a3,0
   122dc:	40f00893          	li	a7,1039
   122e0:	00000073          	ecall
   122e4:	f0054ce3          	bltz	a0,121fc <__syscall_error>
   122e8:	0005051b          	sext.w	a0,a0
   122ec:	00008067          	ret

00000000000122f0 <fstatat>:
   122f0:	04f00893          	li	a7,79
   122f4:	00000073          	ecall
   122f8:	f00542e3          	bltz	a0,121fc <__syscall_error>
   122fc:	0005051b          	sext.w	a0,a0
   12300:	00008067          	ret

0000000000012304 <access>:
   12304:	00000613          	li	a2,0
   12308:	00000693          	li	a3,0
   1230c:	40900893          	li	a7,1033
   12310:	00000073          	ecall
   12314:	ee0544e3          	bltz	a0,121fc <__syscall_error>
   12318:	0005051b          	sext.w	a0,a0
   1231c:	00008067          	ret

0000000000012320 <faccessat>:
   12320:	03000893          	li	a7,48
   12324:	00000073          	ecall
   12328:	ec054ae3          	bltz	a0,121fc <__syscall_error>
   1232c:	0005051b          	sext.w	a0,a0
   12330:	00008067          	ret

0000000000012334 <close>:
   12334:	00000593          	li	a1,0
   12338:	00000613          	li	a2,0
   1233c:	00000693          	li	a3,0
   12340:	03900893          	li	a7,57
   12344:	00000073          	ecall
   12348:	ea054ae3          	bltz	a0,121fc <__syscall_error>
   1234c:	0005051b          	sext.w	a0,a0
   12350:	00008067          	ret

0000000000012354 <link>:
   12354:	00000613          	li	a2,0
   12358:	00000693          	li	a3,0
   1235c:	40100893          	li	a7,1025
   12360:	00000073          	ecall
   12364:	e8054ce3          	bltz	a0,121fc <__syscall_error>
   12368:	0005051b          	sext.w	a0,a0
   1236c:	00008067          	ret

0000000000012370 <unlink>:
   12370:	00000593          	li	a1,0
   12374:	00000613          	li	a2,0
   12378:	00000693          	li	a3,0
   1237c:	40200893          	li	a7,1026
   12380:	00000073          	ecall
   12384:	e6054ce3          	bltz	a0,121fc <__syscall_error>
   12388:	0005051b          	sext.w	a0,a0
   1238c:	00008067          	ret

0000000000012390 <execve>:
   12390:	ff010113          	addi	sp,sp,-16
   12394:	00113423          	sd	ra,8(sp)
   12398:	23c000ef          	jal	125d4 <__errno>
   1239c:	00813083          	ld	ra,8(sp)
   123a0:	00c00793          	li	a5,12
   123a4:	00f52023          	sw	a5,0(a0)
   123a8:	01010113          	addi	sp,sp,16
   123ac:	fff00513          	li	a0,-1
   123b0:	00008067          	ret

00000000000123b4 <fork>:
   123b4:	ff010113          	addi	sp,sp,-16
   123b8:	00113423          	sd	ra,8(sp)
   123bc:	218000ef          	jal	125d4 <__errno>
   123c0:	00813083          	ld	ra,8(sp)
   123c4:	00b00793          	li	a5,11
   123c8:	00f52023          	sw	a5,0(a0)
   123cc:	01010113          	addi	sp,sp,16
   123d0:	fff00513          	li	a0,-1
   123d4:	00008067          	ret

00000000000123d8 <getpid>:
   123d8:	00100513          	li	a0,1
   123dc:	00008067          	ret

00000000000123e0 <kill>:
   123e0:	ff010113          	addi	sp,sp,-16
   123e4:	00113423          	sd	ra,8(sp)
   123e8:	1ec000ef          	jal	125d4 <__errno>
   123ec:	00813083          	ld	ra,8(sp)
   123f0:	01600793          	li	a5,22
   123f4:	00f52023          	sw	a5,0(a0)
   123f8:	01010113          	addi	sp,sp,16
   123fc:	fff00513          	li	a0,-1
   12400:	00008067          	ret

0000000000012404 <wait>:
   12404:	ff010113          	addi	sp,sp,-16
   12408:	00113423          	sd	ra,8(sp)
   1240c:	1c8000ef          	jal	125d4 <__errno>
   12410:	00813083          	ld	ra,8(sp)
   12414:	00a00793          	li	a5,10
   12418:	00f52023          	sw	a5,0(a0)
   1241c:	01010113          	addi	sp,sp,16
   12420:	fff00513          	li	a0,-1
   12424:	00008067          	ret

0000000000012428 <isatty>:
   12428:	f8010113          	addi	sp,sp,-128
   1242c:	00010593          	mv	a1,sp
   12430:	00000613          	li	a2,0
   12434:	00000693          	li	a3,0
   12438:	05000893          	li	a7,80
   1243c:	00000073          	ecall
   12440:	da054ee3          	bltz	a0,121fc <__syscall_error>
   12444:	fff00793          	li	a5,-1
   12448:	0005051b          	sext.w	a0,a0
   1244c:	00f50863          	beq	a0,a5,1245c <isatty+0x34>
   12450:	01012503          	lw	a0,16(sp)
   12454:	40d5551b          	sraiw	a0,a0,0xd
   12458:	00157513          	andi	a0,a0,1
   1245c:	08010113          	addi	sp,sp,128
   12460:	00008067          	ret

0000000000012464 <times>:
   12464:	8a818293          	addi	t0,gp,-1880 # 13ed8 <t0.2273>
   12468:	0002b703          	ld	a4,0(t0) # 11f5c <memset+0xb4>
   1246c:	ff010113          	addi	sp,sp,-16
   12470:	00050813          	mv	a6,a0
   12474:	02071063          	bnez	a4,12494 <times+0x30>
   12478:	8a818513          	addi	a0,gp,-1880 # 13ed8 <t0.2273>
   1247c:	00000593          	li	a1,0
   12480:	00000613          	li	a2,0
   12484:	00000693          	li	a3,0
   12488:	0a900893          	li	a7,169
   1248c:	00000073          	ecall
   12490:	d60546e3          	bltz	a0,121fc <__syscall_error>
   12494:	00010513          	mv	a0,sp
   12498:	00000593          	li	a1,0
   1249c:	00000613          	li	a2,0
   124a0:	00000693          	li	a3,0
   124a4:	0a900893          	li	a7,169
   124a8:	00000073          	ecall
   124ac:	d40548e3          	bltz	a0,121fc <__syscall_error>
   124b0:	0002b703          	ld	a4,0(t0)
   124b4:	00013783          	ld	a5,0(sp)
   124b8:	fff00513          	li	a0,-1
   124bc:	00083823          	sd	zero,16(a6)
   124c0:	40e786b3          	sub	a3,a5,a4
   124c4:	000f47b7          	lui	a5,0xf4
   124c8:	24078793          	addi	a5,a5,576 # f4240 <_gp+0xdfc10>
   124cc:	02f68733          	mul	a4,a3,a5
   124d0:	0082b683          	ld	a3,8(t0)
   124d4:	00813783          	ld	a5,8(sp)
   124d8:	00083c23          	sd	zero,24(a6)
   124dc:	00083423          	sd	zero,8(a6)
   124e0:	40d787b3          	sub	a5,a5,a3
   124e4:	01010113          	addi	sp,sp,16
   124e8:	00f707b3          	add	a5,a4,a5
   124ec:	00f83023          	sd	a5,0(a6)
   124f0:	00008067          	ret

00000000000124f4 <gettimeofday>:
   124f4:	00000593          	li	a1,0
   124f8:	00000613          	li	a2,0
   124fc:	00000693          	li	a3,0
   12500:	0a900893          	li	a7,169
   12504:	00000073          	ecall
   12508:	ce054ae3          	bltz	a0,121fc <__syscall_error>
   1250c:	0005051b          	sext.w	a0,a0
   12510:	00008067          	ret

0000000000012514 <ftime>:
   12514:	00051423          	sh	zero,8(a0)
   12518:	00053023          	sd	zero,0(a0)
   1251c:	00000513          	li	a0,0
   12520:	00008067          	ret

0000000000012524 <utime>:
   12524:	fff00513          	li	a0,-1
   12528:	00008067          	ret

000000000001252c <chown>:
   1252c:	fff00513          	li	a0,-1
   12530:	00008067          	ret

0000000000012534 <chmod>:
   12534:	fff00513          	li	a0,-1
   12538:	00008067          	ret

000000000001253c <chdir>:
   1253c:	fff00513          	li	a0,-1
   12540:	00008067          	ret

0000000000012544 <getcwd>:
   12544:	00000513          	li	a0,0
   12548:	00008067          	ret

000000000001254c <sysconf>:
   1254c:	00200793          	li	a5,2
   12550:	00f51863          	bne	a0,a5,12560 <sysconf+0x14>
   12554:	000f4537          	lui	a0,0xf4
   12558:	24050513          	addi	a0,a0,576 # f4240 <_gp+0xdfc10>
   1255c:	00008067          	ret
   12560:	fff00513          	li	a0,-1
   12564:	00008067          	ret

0000000000012568 <sbrk>:
   12568:	8401b703          	ld	a4,-1984(gp) # 13e70 <heap_end.2311>
   1256c:	00050793          	mv	a5,a0
   12570:	00071663          	bnez	a4,1257c <sbrk+0x14>
   12574:	8b818713          	addi	a4,gp,-1864 # 13ee8 <_end>
   12578:	84e1b023          	sd	a4,-1984(gp) # 13e70 <heap_end.2311>
   1257c:	00e78533          	add	a0,a5,a4
   12580:	00000593          	li	a1,0
   12584:	00000613          	li	a2,0
   12588:	00000693          	li	a3,0
   1258c:	0d600893          	li	a7,214
   12590:	00000073          	ecall
   12594:	c60544e3          	bltz	a0,121fc <__syscall_error>
   12598:	8401b683          	ld	a3,-1984(gp) # 13e70 <heap_end.2311>
   1259c:	fff00713          	li	a4,-1
   125a0:	00d787b3          	add	a5,a5,a3
   125a4:	00f51663          	bne	a0,a5,125b0 <sbrk+0x48>
   125a8:	84a1b023          	sd	a0,-1984(gp) # 13e70 <heap_end.2311>
   125ac:	00068713          	mv	a4,a3
   125b0:	00070513          	mv	a0,a4
   125b4:	00008067          	ret

00000000000125b8 <_exit>:
   125b8:	00000593          	li	a1,0
   125bc:	00000613          	li	a2,0
   125c0:	00000693          	li	a3,0
   125c4:	05d00893          	li	a7,93
   125c8:	00000073          	ecall
   125cc:	c20548e3          	bltz	a0,121fc <__syscall_error>
   125d0:	0000006f          	j	125d0 <_exit+0x18>

00000000000125d4 <__errno>:
   125d4:	8101b503          	ld	a0,-2032(gp) # 13e40 <_impure_ptr>
   125d8:	00008067          	ret
