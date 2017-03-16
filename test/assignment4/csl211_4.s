.main://Main function
	mov r0,10//Storing value of a
	mov r1,12//Storing value of b
	mov r2,-1//Storing value of c
	call .f
	b .end
.f://Function f
	sub sp,sp,4//Allocating space for storing return address for function call f
	st ra,[sp]//Storing the return address
	mov r4,0  //Storing index
	mov r5,4  //Storing the max value of index i
	.loop:
	sub sp,sp,4//Allocating space for storing the value of c
	st r2,[sp]//Storing the value of c
	add r0,r1,r2
	sub r1,r0,r2
	call .g
	ld r2,[sp]//Loading the value of c
	add sp,sp,4//Clearing space after loading the value of c
	add r2,r2,r7
	cmp r5 r4
	beq .out
	bgt .in
	.out:
		ld ra,[sp]
		add sp,sp,4
		add r3,r0,r1
		add r3,r3,r2//Storing the retrun value of function f
		ret
	.in:
	add r4,r4,1
	b .loop

.g:
	//.print r0
	sub sp,sp,16//Allocating space
	st ra,[sp]//Storing return address for function call g
	st r0,4[sp]//Storing the value of a
	st r1,8[sp]//Storing the value of b
	st r2,12[sp]//Storing the value of c
	call .h
	add r7,r0,r1
	add r7,r7,r2
	ld ra,[sp]
	ld r0,4[sp]
	ld r1,8[sp]
	ld r2,12[sp]
	add sp,sp,16//Clearing the space after loading values
	ret




.h:
	sub sp,sp,4//Allocating space for storing return address
	st ra,[sp]//Storing the return address for the function call h
	add r7,r0,r1
	sub r7,r7,r2
	mov r0,r7//Storing the return value of function h stored in r7 in r0 for case 0
	sub r7,r0,r1
	add r7,r7,r2
	mov r1,r7//Storing the return value of function h stored in r7 in r1 for case 1
	add r7,r0,r1
	add r7,r7,r2
	mov r2,r7//Storing the return value of function h stored in r7 in r2 for case 2	
	ld ra,[sp]//Loading the return address for the function call h
	add sp,sp,4//Clearing space after loading return address
	ret 


.end:
	.print r3 //Printing the value of d

