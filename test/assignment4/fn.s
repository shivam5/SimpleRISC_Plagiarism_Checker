main:
	mov r0,10		// r0 stores a
	mov r1,12		// r1 stores b
	mov r2,-1		// r2 storea c , r0,r1,r2 are arguments to be used by f
	call .f		// fn f is called and it will return final answer in r0
	b .return		// go to .return to print final answer

.f:
	sub sp,sp,4	// decrease stack pointer by 4byte to store return add  
	st ra,[sp]		// store ra in stack 
	mov r5,r0		// store r0,r1,r2 in r5,r6,r7 as they can be...
	mov r6,r1		// ... modified by further functions calls
	mov r7,r2		// can use r5,r6,r7 as main doesn't use them
	mov r4,-1		// r5 is the loop counter

.loop:
	add r4,r4,1	// updatation part of loop
	cmp r4,5		// condition check of the loop
	beq .loopend	// break the loop after 5 times
	add r5,r6,r7	// a=b+c
	sub r6,r5,r7	// b=a-c
	mov r0,r5		// update r0,r1,r2 with new values of a,b,c..
	mov r1,r6		// ..  which will be used by other functions
	mov r2,r7		// previous value of c will be send to g
	call .g		// call g which will r0,r1,r2
	add r7,r7,r0	// c = c + r0(value returned by g)
	b .loop		// continue the loop

.loopend:
	mov r0,r5		// after loop make r0 = a+b+c which will be used as..
	add r0,r0,r6	// .. return value of f by main
	add r0,r0,r7
	ld ra,[sp]		// store return address in ra stored in at address sp
	add sp,sp,4	// move sp to its original position as in calling fn
	ret		// return back to calling fn

.g:
	sub sp,sp,4	// decrease stack pointer by 4byte to store return add
	st ra,[sp]		// store ra in stack
	mov r8,0		// r8 is the 4th parameter to call h
	call .h		// h will not change r0,r1,r2 so no need to store
	mov r0,r9		// h returns value in r9 , a=h(a,b,c,0)
	mov r8,1		// make 4th parameter of h to be 1
	call .h		// a,b,c variables here are different from those of f
	mov r1,r9		// b=h(a,b,c,1)
	mov r8,2		// make 4th parameter of h to be 2
	call .h		// here we are sending updated value of a,b,c
	mov r2,r9		// c=h(a,b,c,2)
	add r0,r0,r1
	add r0,r0,r2	// a=a+b+c
	ld ra,[sp]		// store return address in ra stored in at address sp
	add sp,sp,4	// move sp to its original position as in calling fn
	ret		// return back to calling fn

.h:
	cmp r8,0		// compare 4th aargument with 0,1,2 to decide..
	beq .case0		// .. which switch case operation to perform
	cmp r8,1		// when g is called a,b,c in g were stored in r0,r1,r2
	beq .case1
	cmp r8,2
	beq .case2

.case0:
	mov r9,r0		// r9 = a+b-c which will be returned by fn h
	add r9,r9,r1
	sub r9,r9,r2
	ret

.case1:
	mov r9,r0		// r9 = a-b+c which will be returned by fn h
	sub r9,r9,r1
	add r9,r9,r2
	ret

.case2:
	mov r9,r0		// r9 = a+b+c which will be returned by fn h
	add r9,r9,r1
	add r9,r9,r2
	ret

.return:
	.print r0		// print final answer d returned by f as r0