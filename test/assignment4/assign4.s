// a = r0
// b = r1
// c = r2
// d = r3

 .f :	st ra ,[sp]                  // store and return func f
	sub sp,sp,8
	mov r5,5
	mov r4,0
	b .loop

.loop :                                // For loop condition
	cmp r5,r4
	bgt .calc
	add r2,r2,r0
	add r2,r2,r1                 // final a+b+c
	add sp,sp,8                       
	ld ra ,[sp]
	ret
.calc :                                // For loop implementations
	add r0,r1,r2
	sub r1,r0,r2
	call .g
	add r2,r2,r11                // c = c + g(a,b,c)
	add r4,r4,1
	b .loop

.g :      
	mov r9,0                  // r9 = a, r10 = b, r11 = c for func g
	mov r10,0
	mov r11,0
	st ra , 4[sp]               // store and return func g
	mov r6,0
	call .h                    
	add r9,r8,0                 // value of a as returned by h

	mov r6,1
	call .h
	add r10,r8,0                // value of b as returned by h

	mov r6,2
	call .h
	add r11,r8,0                // value of c as returned by h

	add r10,r10,r9
	add r11,r11,r10
	ld ra, 4[sp]
	ret

.h :                                      
	mov r8,0	
	mov r7,1
	cmp r6,r7                   // Switch - cases
	beq .l2
	bgt .l3
	b .l1

.l1 :                                 // case 0    a+b-c
	add r8,r0,r1
	sub r8,r8,r2
	ret
.l2 :                                 // case 1    a-b+c
	add r8,r9,r2
	sub r8,r8,r1
	ret
.l3 :                                 // case 2    a+b+c
	add r8,r10,r9
	add r8,r8,r2
	ret

.main :
	mov r0,10
	mov r1,12
	mov r2,-1
	call .f
	.print r2


// r2 shows the final value. 




























