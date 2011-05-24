/* Copyright 2011 Alex Vedunov (vedunov@bk.ru) */

/* HelloARM application code */

/*
 * This file is part of HelloARM.
 * HelloARM is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation version 3 of the License
 * HelloARM is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * You should have received a copy of the GNU General Public License
 * along with HelloARM.  If not, see <http://www.gnu.org/licenses/>.
 */



STACK_BOTTOM=0x21E00000

RTT_BASE=0xFFFFFD20
RTT_MR=RTT_BASE
RTT_AR=RTT_BASE+0x04
RTT_VR=RTT_BASE+0x08
RTT_SR=RTT_BASE+0x0C
RTT_MR_VAL=0x00041000

DBGU_SR=0xFFFFF214
DBGU_THR=0xFFFFF21C

.globl start_main
start_main:
setup_stack:
	ldr	r0, =STACK_BOTTOM
	mov	fp, r0
	mov	sp, fp
	b	setup_rtt
setup_rtt:
	ldr	r0, =RTT_MR_VAL
	ldr	r1, =RTT_MR
	str	r0, [r1]
	b	pr_hello
#r0 - symbol address
pr_char:
	str	lr, [sp], #-4
	str	fp, [sp], #-4
	mov	fp, sp
	stmda	sp!, {r1-r5}
	ldr	r4, =DBGU_SR
	ldr	r5, =DBGU_THR
pr_wrwait:
	ldr	r1, [r4]
	ands	r1, r1, #2
	beq	pr_wrwait
	strb	r0, [r5]
	ldmib	sp!, {r1-r5}
	ldr	fp, [sp, #4]!
	ldr	pc, [sp, #4]!

wait_rtt:
	str	lr, [sp], #-4
	str	fp, [sp], #-4
	mov	fp, sp
	stmda	sp!, {r0-r5}
	ldr	r0, =RTT_SR
w_set:	ldr	r1, [r0]
	ands	r1, r1, #2
	beq	w_set
#wait for RTTINC flag to be cleared in RTT_SR to prevent false positives
w_clr:	ldr	r1, [r0]
	ands	r1, r1, #2
	bne	w_clr
	ldmib	sp!, {r0-r5}
	ldr	fp, [sp, #4]!
	ldr	pc, [sp, #4]!

pr_hello:
	ldr	r2, =hello_str
do_pr:
	ldrb	r0, [r2], #1
	cmp	r0, #0
	beq	halt
	bl	pr_char
	bl	wait_rtt
	b	do_pr
halt:	b	halt

HELLO_STR_SIZE=5
hello_str:
	.asciz "Hello ARM AT91SAM9260 Starter Kit!!!"
