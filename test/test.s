	.file	"test.c"
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	lui s4, 100
	lui s3, 10
	auipc s5, 110
	jal test1
	addi s4, s4, 100
	test1:
	addi s4, s4, 200
	addi x1,x1,20
	ret
	addi s4, x0,10
	addi s4, x0,20
	addi s5, x0,20
	beq s4, s5, test2
	addi s3,x0, 11
	test2:
	addi s3,x0, 12
	addi s3,x0,19
	addi s3,x0,21
	addi s3,x0,22
	addi s4,x0, 0xef
	lui s5,0x40302
	ori s5,s5,0xf0
	sb s5,0(s4)
	addi s4,x0, 0xf0
	sh s5,0(s4)
	addi s4,x0,0xf4
	sw s5,0(s4)
	lb s5,0(s4)
	lh s5,0(s4)
	lw s5,0(s4)
	lbu s5,0(s4)
	lhu s5,0(s4)
	addi s4,x0,1
	addi s5,x0,1
	addi s4,s4,2
	slti s5,s4,1
	addi s4,x0,-4
	addi s5,x0,1
	sltiu s5,s4,1
	addi s5,x0,0
	addi s4,x0,10
	xori s5,s4,15
	ori s5,s5,15
	andi s5,s5,4
	slli s5,s5,2
	srli s5,s5,1
	addi s5,x0,-8
	srai s5,s5,2
	addi s5,x0,2
	addi s4,x0,3
	add s5,s5,s4
	sub s5,s5,s4
	sll s5,s5,s4
	srl s5,s5,s4
	addi s5,x0, -16
	sra s5,s5,s4
	addi s5,x0,10
	addi s4,x0, 5
	or s5,s5,s4
	addi s5,x0,10
	and s5,s5,s4
	

	add	sp,sp,-16
	sw	s0,12(sp)
	add	s0,sp,16
	li	a5,0
	mv	a0,a5
	lw	s0,12(sp)
	add	sp,sp,16
	jr	ra
	.size	main, .-main
	.ident	"GCC: (GNU) 5.3.0"
