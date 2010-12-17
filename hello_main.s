DBGU_SR=0xFFFFF214
DBGU_THR=0xFFFFF21C

.globl start_main
start_main:
	ldr	r4, =DBGU_SR
	ldr	r5, =DBGU_THR
	ldr	r2, =hello_str
do_pr:	
	ldrb	r1, [r2], #1
	cmp	r1, #0
	beq	halt
wrwait:	ldr	r0, [r4]
	ands	r0, r0, #2
	beq	wrwait
	strb	r1, [r5]
	b	do_pr
halt:	b	halt

HELLO_STR_SIZE=5
hello_str:
	.asciz "Hello"
