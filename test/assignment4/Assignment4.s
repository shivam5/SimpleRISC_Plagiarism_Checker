
 .floop :	
	st ra ,[sp]                  	
	sub sp,sp,8						@ create space on the stack
	mov r10,5
	mov r4,0
	b .loop
	
.loop :                             @ Looping begins
	cmp r10,r4
	bgt .sum
	add r2,r2,r0
	add r2,r2,r1                 	@ Computing The final a+b+c
	add sp,sp,8                       
	ld ra ,[sp]						@ restore the return address
	ret

.gloop :      
	mov r13,0                 		@ r13 = a, r12 = b, r11 = c for func g
	mov r12,0
	mov r11,0
	st ra , 4[sp]                	@ push the return address register --ra 
	mov r9,0
	call .hloop                    
	add r13,r5,0                 	@ "a" value after running "H" function 
	mov r9,1
	call .hloop
	add r12,r5,0                	@ "b" value after running "H" function 
	mov r9,2
	call .hloop
	add r11,r5,0                	@ "c" value after running "H" function 
	add r12,r12,r13
	add r11,r11,r12
	ld ra, 4[sp]
	ret
	
.sum :                             
	add r0,r1,r2
	sub r1,r0,r2
	call .gloop						@ Loop condition
	add r2,r2,r11                	@ c += g(a,b,c)
	add r4,r4,1						@ i++
	b .loop
	
.hloop :                                      
	mov r5,0	
	mov r7,1
	cmp r9,r7                   	@Switch Implementation
	beq .loop2
	bgt .loop3
	b .loop1
	
.loop3 :                            @ Case 2 = a+b+c
	add r5,r12,r13
	add r5,r5,r2
	ret
	
.loop2 :                            @ Case 1 = a-b+c
	add r5,r13,r2
	sub r5,r5,r1
	ret
	
.loop1 :                            @ Case 0 = a+b-c
	add r5,r0,r1
	sub r5,r5,r2
	ret

									@r0 = a
									@r1 = b
									@r2 = c
									@r3 = d

.main :
	mov r0,10
	mov r1,12
	mov r2,-1
	call .floop
	.print r2

									@r2 Printing the Answer "d"