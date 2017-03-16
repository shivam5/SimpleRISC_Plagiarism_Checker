.main:							/*main function*/
	mov r0,10
	mov r1,12
	mov r2,-1
	call .f 					/*calling function f*/
	.print r13
	b .exit						/*exit condition*/

.f:								/*function f*/
	sub sp,sp,16				
	st ra,0[sp]
	st r0,4[sp]
	st r1,8[sp]
	st r2,12[sp]
	mov r3,5
	mov r4,0
	cmp r4,r3
	b .for1
	.for1:
		add r0,r1,r2
		sub r1,r0,r2
		call .g					/*calling function g*/
		add r2,r2,r12
		add r4,r4,1
		cmp r3,r4
		beq .sum5
		b .for1

.g:								/*function g*/
	sub sp,sp,16
	st ra,0[sp]
	st r0,4[sp]
	st r1,8[sp]
	st r2,12[sp]
	mov r8,0
	call .h						/*calling function h*/
	mov r0,r9
	mov r8,1
	call .h
	mov r1,r9
	mov r8,2
	call .h
	mov r2,r9
	.sum4:
		add r12,r0,r1
		add r12,r12,r2
		ld ra,0[sp]
		ld r0,4[sp]
		ld r1,8[sp]
		ld r2,12[sp]
		add sp,sp,16
		ret

.h:								/*function h*/
	sub sp,sp,16
	st ra,0[sp]
	st r0,4[sp]
	st r1,8[sp]
	st r2,12[sp]
	mov r5,0
	mov r6,1
	mov r7,2
	cmp r8,r5
	beq .sum1
	cmp r8,r6
	beq .sum2
	cmp r8,r7
	beq .sum3


.sum1:
	add r9,r0,r1
	sub r9,r9,r2
	ld ra,0[sp]
	ld r0,4[sp]
	ld r1,8[sp]
	ld r2,12[sp]
	add sp,sp,16
	ret

.sum2:
	sub r9,r0,r1
	add r9,r9,r2
	ld ra,0[sp]
	ld r0,4[sp]
	ld r1,8[sp]
	ld r2,12[sp]
	add sp,sp,16
	ret

.sum3:
	add r9,r0,r1
	add r9,r9,r2
	ld ra,0[sp]
	ld r0,4[sp]
	ld r1,8[sp]
	ld r2,12[sp]
	add sp,sp,16
	ret

.sum5:
	add r13,r0,r1
	add r13,r13,r2
	ld ra,0[sp]
	ld r0,4[sp]
	ld r1,8[sp]
	ld r2,12[sp]
	add sp,sp,16
	ret 

.exit:
