.main:
	mov r0,10				/* a = r0 */
	mov r1,12				/* b = r1 */
	mov r2,-1				/* c = r2 */
	call .f				/* calling f */
	mov r3,r13
	b .last
.f:
	sub sp,sp,16			/* sub. stack pointer */
	st r0,0[sp]
	st r1,4[sp]
	st r2,8[sp]
	st ra,12[sp]
	mov r5,0 				/* i=0 */
	.loop:				/* loop runs if i<5 */ 
		cmp r5,5
		beq .return
		bgt .return
		add r0,r1,r2		/* a=b+c */
		sub r1,r0,r2		/* b= a-c */
		call .g			/* calling g */
		add r2,r2,r12		/*storing return of g in r12*/
		add r5,r5,1
		b .loop
	.return:
		add r13,r0,r1
		add r13,r13,r2		/* storing return of f in r13 */
		ld r0,0[sp]		/* loading all the values */
		ld r1,4[sp]
		ld r2,8[sp]
		ld ra,12[sp]
		add sp,sp,16
		ret				/* return statement for f */
.g:
	sub sp,sp,16
	st r0,0[sp]
	st r1,4[sp]
	st r2,8[sp]
	st ra,12[sp]
	mov r4,0				/*r4 is new variable, r4=0*/
	call .h
	mov r0,r11
	mov r4,1				/* r4 = 1 */
	call .h
	mov r1,r11
	mov r4,2				/* r4 = 2 */
	call .h
	mov r2,r11				/* storing return of h in r11*/
	add r12,r0,r1
	add r12,r12,r2
	ld r0,0[sp]			/* loading all the values */
	ld r1,4[sp]
	ld r2,8[sp]
	ld ra,12[sp]
	add sp,sp,16
	ret					/* return statement for g */
.h:
	sub sp,sp,20			/* sub. stack pointer */
	st r0,0[sp]
	st r1,4[sp]
	st r2,8[sp]
	st r4,12[sp]
	st ra,16[sp]
	cmp r4,0				/* comapring d */
	beq .reta				/* implementing switch cases */
	cmp r4,1
	beq .retb
	cmp r4,2
	beq .retc
	mov r11,0
	b .final
.reta:					/* switch case 1st */
	add r11,r0,r1
	sub r11,r11,r2
	b .final
.retb:					/* switch case 2nd */
	add r11,r0,r2
	sub r11,r11,r1
	b .final
.retc:					/* switch case 3rd */
	add r11,r0,r1
	add r11,r11,r2
	b .final
.final:
	ld r0,0[sp]			/* loading all the values*/
	ld r1,4[sp]
	ld r2,8[sp]
	ld r4,12[sp]
	ld ra,16[sp]
	add sp,sp,20
	ret					/* return statement for h */
.last:
	.print r3				/* printing d */
	b .exit
.exit:					/* the end */
	



