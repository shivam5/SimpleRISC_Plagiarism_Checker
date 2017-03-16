@---------function h---------
.h:
	cmp r3,0
	beq .return1	@ if r3==0
	cmp r3,1
	beq .return2	@ if r3==1
	cmp r3,2
	beq .return3	@ if r3==2
	mov r3,0		@ alse return 0
	ret
     .return1:		@ returning a+b-c
	add r3,r0,r1
	sub r3,r3,r2
	ret
     .return2:		@ returning a-b+c
	sub r3,r0,r1
	add r3,r3,r2
	ret
     .return3:		@ returning a+b+c
	add r3,r0,r1
	add r3,r3,r2
	ret

@---------function g---------
.g:
     @ storing the values of variables and ra in the stack
	st r0,[sp]
	st r1,4[sp]
	st r2,8[sp]
	st ra,12[sp]
	add sp,sp,16
     @ calling h
	mov r3,0		@ fourth perameter for h
	call .h		@ overwrite r3 by return value
     @ loading the values of variables and ra from the stack
	sub sp,sp,16
	ld r0,[sp]
	ld r1,4[sp]
	ld r2,8[sp]
	ld ra,12[sp]
	mov r0,r3		@ a= the value returned by h(that is stored in r3)
     @ storing the values of variables and ra in the stack
	st r0,[sp]
	st r1,4[sp]
	st r2,8[sp]
	st ra,12[sp]
	add sp,sp,16
     @ calling h
	mov r3,1		@ fourth perameter for h
	call .h		@ overwrite r3 by return value
     @ loading the values of variables and ra from the stack
	sub sp,sp,16
	ld r0,[sp]
	ld r1,4[sp]
	ld r2,8[sp]
	ld ra,12[sp]
	mov r1,r3		@ b= the value returned by h(that is stored in r3)
     @ storing the values of variables and ra in the stack
	st r0,[sp]
	st r1,4[sp]
	st r2,8[sp]
	st ra,12[sp]
	add sp,sp,16
     @ calling h
	mov r3,2		@ fourth perameter for h
	call .h		@ overwrite r3 by return value
     @ loading the values of variables and ra from the stack
	sub sp,sp,16
	ld r0,[sp]
	ld r1,4[sp]
	ld r2,8[sp]
	ld ra,12[sp]
	mov r2,r3		@ b= the value returned by h(that is stored in r3)
	add r3,r0,r1	@ r3 = a+b+c
	add r3,r3,r2
	ret

@---------function f---------
.f:
	mov r4,0		@ i, the iterator
     @ loop start
     .loop:
	cmp r4,5		@ loop condition
	beq .return	@ if i==5 or i>5, go to return lebal
	bgt .return
	add r0,r1,r2	@ a=b+c
	sub r1,r0,r2	@ b=a-c
     @ storing the value of variables and ra to the stack.
	st r0,[sp]
	st r1,4[sp]
	st r2,8[sp]
	st r4,12[sp]
	st ra,16[sp]
	add sp,sp,20
     @ calling g
	call .g
     @ loading the value of variables and ra from the stack.
	sub sp,sp,20
	ld r0,[sp]
	ld r1,4[sp]
	ld r2,8[sp]
	ld r4,12[sp]
	ld ra,16[sp]
	add r2,r2,r3	@ c = c + returned value returned by g(stored at r3)
	add r4,r4,1	@ i++
	b .loop
     .return:		@ exit of loop
	add r3,r0,r1	@ r3 = a+b+c
	add r3,r3,r2
	ret

@---------function main---------
.main:
	mov r0,10		@ a
	mov r1,12		@ b
	mov r2,-1		@ c
     @ storing the value of a,b,c to stack.
	st r0,[sp]
	st r1,4[sp]
	st r2,8[sp]
	st ra,12[sp]
	add sp,sp,16	@ To keep safe the memory of main from overwriting
     @ calling f
	call .f
	sub sp,sp,16	@ reseting sp
     @ loading the values.
	ld r0,[sp]
	ld r1,4[sp]
	ld r2,8[sp]
	ld ra,12[sp]
     @ print d
	.print r3