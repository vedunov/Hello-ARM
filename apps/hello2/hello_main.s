/* Copyright 2010 Alex Vedunov (vedunov@bk.ru) */

/* HelloARM application code.
 * UART echo program.
 */

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



DBGU_CTL=0xFFFFF200
DBGU_MR=0xFFFFF204
DBGU_SR=0xFFFFF214
DBGU_RHR=0xFFFFF218
DBGU_THR=0xFFFFF21C
DBGU_CTL_VAL=0x00000050 /* Enable receiver and transmitter */
DBGU_MR_VAL=0x00000800 /* Normal mode, no parity */
RXRDY=1
TXRDY=2

.globl start_main
start_main:
	ldr	r4, =DBGU_SR
	ldr	r5, =DBGU_THR
	ldr	r6, =DBGU_RHR
	
/* Do not need this block, just left it here. */
	ldr	r0, =DBGU_MR
	ldr	r1, =DBGU_MR_VAL
	str	r1, [r0]
	ldr	r0, =DBGU_CTL
	ldr	r1, =DBGU_CTL_VAL
	str	r1, [r0]
/*                                            */

rdwait: ldr	r0, [r4]
	ands	r0, r0, #RXRDY
	beq	rdwait
	ldrb	r1, [r6]
wrwait:	ldr	r0, [r4]
	ands	r0, r0, #TXRDY
	beq	wrwait
	strb	r1, [r5]
	b	rdwait
