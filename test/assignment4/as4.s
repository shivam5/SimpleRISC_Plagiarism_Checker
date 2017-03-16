 .f :
	cmp r6,5
	beq .break
	bgt .break

	add r0,r1,r2 	@a=b+c
	sub r1,r0,r2	@b=a-c

	sub sp,sp,16	@stack deceremented by 12	
	st r0,0[sp]		@a,b,c stored in stack
	st r1,4[sp]
	st r2,8[sp]
	st ra, 12[sp] 
	call .g		@g is called, will use r0, r1, r2 as arguments

	ld r0,0[sp]
	ld r1,4[sp]
	ld r2,8[sp]
	ld ra,12[sp]
	add sp,sp,16	

	add r2,r2,r3	@c=c+g(a,b,c) 
	add r6,r6,1
	b .f

	.break :
		add r3,r0,r1	@return a+b
		add r3,r3,r2	@return a+b+c
		ret
	
.g:
	sub sp,sp,16	@stack deceremented by 12	
	st r0,[sp]		@a,b,c stored in stack
	st r1,4[sp]
	st r2,8[sp]
	st ra,12[sp]
	mov r4,0
	call .h		@g is called, will use r0,r1, r2, r4
  			@ as arguments	
	ld r1,4[sp]
	ld r2,8[sp]
	ld ra,12[sp]
	add sp,sp,16
	mov r0,r3		@a=h(a,b,c,0)


	sub sp,sp,16	@stack deceremented by 12	
	st r0,[sp]		@a,b,c stored in stack
	st r1,4[sp]
	st r2,8[sp]
	st ra, 12[sp]
	mov r4,1
	call .h		@g is called, will use r0,r1, r2, r4
  			@ as arguments	

	ld r0,[sp]
	ld r2,8[sp]	
	ld ra,12[sp]
	add sp,sp,16
	mov r1,r3		@b=h(a,b,c,1)
	
	sub sp,sp,16	@stack deceremented by 12	
	st r0,[sp]		@a,b,c stored in stack
	st r1,4[sp]
	st r2,8[sp]
	st ra,12[sp]
	mov r4,2

	call .h		@g is called, will use r0,r1, r2, r4
  			@ as arguments	

	ld r0,[sp]
	ld r1,4[sp]
	ld ra,12[sp]
	add sp,sp,16
	mov r2,r3		@b=h(a,b,c,2)
	add r3,r0,r1	@return a+b
	add r3,r3,r2	@return a+b+c
	ret
	
.h:
	cmp r4,0
	beq .zero	

	cmp r4,1
	beq .one

	cmp r4,2
	beq .two

	mov r3,0
	ret

	.zero :
		add r3,r0,r1
		sub r3,r3,r2
		ret

	.one :
		sub r3,r0,r1
		add r3,r3,r2
		ret

	.two :
		add r3,r0,r1
		add r3,r3,r2
		ret


.main :
	mov r0,10		@a=r0
	mov r1,12		@b=r1
	mov r2,-1		@c=r2

	mov r6,0		@r4=i
	call .f		@f function called and it will be using r0,r1,r2
	.print r3		@Print r3=d