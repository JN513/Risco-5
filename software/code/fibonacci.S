.global _start

_start:
	call main;

fibonacci:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	sw	s1,20(sp)
	addi	s0,sp,32
	sw	a0,-20(s0)
	lw	a4,-20(s0)
	li	a5,1
	beq	a4,a5,.L2
	lw	a4,-20(s0)
	li	a5,2
	bne	a4,a5,.L3
.L2:
	li	a5,1
	j	.L4
.L3:
	lw	a5,-20(s0)
	addi	a5,a5,-1
	mv	a0,a5
	call	fibonacci
	mv	s1,a0
	lw	a5,-20(s0)
	addi	a5,a5,2
	mv	a0,a5
	call	fibonacci
	mv	a5,a0
	add	a5,s1,a5
.L4:
	mv	a0,a5
	lw	ra,28(sp)
	lw	s0,24(sp)
	lw	s1,20(sp)
	addi	sp,sp,32
	jr	ra
main:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	li	a5,4096
	sw	a5,-20(s0)
	li	a0,5
	call	fibonacci
	sw	a0,-24(s0)
	lw	a5,-20(s0)
	lw	a4,-24(s0)
	sw	a4,0(a5)
	li	a5,0
	mv	a0,a5
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
