/* Copyright 2010 Alex Vedunov (vedunov@bk.ru) */

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
