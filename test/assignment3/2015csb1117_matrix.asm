mov r0,4       @ order of matrix 
mov r1,0x100 	@base address of first matrix
mov r2,0x200 	@	       second	
mov r3,0x300 	@ 	       third	
mov r4,-1	   	@ index for rows
mov r5,0     	@ index for columns		

@ making matrices
@ outer loop
.loopi:	add r4,r4,1  		@ incrementing row
	mov r5,0	     		@ j=0 after row changes
	cmp r4,r0				
	beq .start			@ dat is matrix are ready
	b .loopj		
	
@inner loop
.loopj:	cmp r5,r0			
	beq .loopi			
			@add r11,r4,1	
	mov r11,r4			
	mul r8,r11,2		@ 2*i
				@add r12,r5,1  	
	mov r12,r5		
	mul r9,r12,3		@ 3*j
	add r8,r8,r9		@ 2i+3j
	add r6,r11,r12		@ i+j
	mul r7,r0,r4		@ N
	add r7,r7,r5		@Ni+j
	mul r7,r7,4		
	add r7,r7,r1		@address for each number of first matrix
	st r6,[r7]
				@+.print r6		
	sub r7,r7,r1		
	add r7,r7,r2		@ address fir second matrix	
	st r8,[r7]
				@.print r7
	add r5,r5,1			
	b .loopj
	
.start:	mov r4,-1			
	mov r10,0				

@ matrix multipilication

.iloop:	add r4,r4,1
	mov r5,-1 		
	cmp r4,r0		
	beq .exit	
	b .jloop	
		
.jloop:	st r10,[r3]	@r10 contains corresponding elements of final matrix
			@mov r10,0
	add r5,r5,1	
	mov r9,0		@k index	
	cmp r5,r0
	beq .iloop
	mov r10,0		@ sum matrix
	b .kloop		
	
.kloop:	cmp r9,r0		
	beq .jloop		
	mov r2,0x200	@ base adresses 
	mov r1,0x100
	mov r3,0x300
	mul r6,r0,r4	@ Ni
	add r6,r6,r5	@Ni+j
	mul r6,r6,4	
	add r3,r3,r6	@address of final matrix
	mul r7,r0,r4	
	add r7,r7,r9	
	mul r7,r7,4
	add r1,r1,r7	@adress of first matrix
	mul r8,r0,r9
	add r8,r8,r5
	mul r8,r8,4
	add r2,r2,r8	@adresss for second matrix
	ld r6,[r1]		@ loading values
	ld r7,[r2]		
	mul r6,r6,r7	@ multiplyinf values
	add r10,r10,r6
	add r9,r9,1
	b .kloop
	
.exit:	mov r4,-1
	
@ printing product matrix
	
.finloopi:	
	add r4,r4,1
	mov r5,0
	cmp r4,r0
	beq .end
	b .finloopj

.finloopj:	mov r3,0x300
	cmp r5,r0
	beq .finloopi
	mul r6,r0,r4
	add r6,r6,r5	
	mul r6,r6,4
	add r3,r3,r6 	@address 
	ld r7,[r3]
	.print r7
	add r5,r5,1
	b .finloopj

.end:	 