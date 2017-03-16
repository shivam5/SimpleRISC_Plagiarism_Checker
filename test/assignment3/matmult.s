
.main:
	mov r0,3             // dimension of matrix
	mov r11,0x100	// base address of A
	mov r12,0x200	// base address of B
	mov r13,0x300	// base address of C


          
.assA1in:
	mov r1,0		// initialisation
			// outer loop for assigning A
.assA1cd:
	cmp r1,r0		// condition check
	beq .assB1in	// if satisfy goto inner loop initialisation
	b .assA2in    	// loop body
.assA1up:
	add r1,r1,1	// updatation
	b .assA1cd		// goto condition check after updatation


.assA2in:			
	mov r2,0		// inner loop for assigning A
			// initialization
.assA2cd:
	cmp r2,r0		// condition check
	beq .assA1up	// after inner loop ends go to outer loop updatation
	mul r3,r1,r0        // loop body
	add r3,r3,r2
	mul r3,r3,4 
	add r4,r1,r2
	add r3,r3,r11	
	st r4,[r3]		// store value in A[r1][r2]
	
.assA2up:
	add r2,r2,1	// updatation
	b .assA2cd		// goto condition check after updatation



.assB1in:
	mov r1,0		// outer loop for assigning B
.assB1cd:
	cmp r1,r0		// condition check
	beq .mult		// after all iterations go to .mult
	b .assB2in           // loop body
.assB1up:
	add r1,r1,1	// updatation
	b .assB1cd		// goto condition check after updatation


.assB2in:
	mov r2,0		// inner loop for assigning B
			// initialization
.assB2cd:
	cmp r2,r0		// condition check
	beq .assB1up
	mul r3,r1,r0         // loop body
	add r3,r3,r2
	mul r3,r3,4 		 
	mul r4,r1,2
	mul r5,r2,3
	add r4,r4,r5
	add r3,r3,r12		
	st r4,[r3]		// store value in B[r1][r2]
.assB2up:
	add r2,r2,1	// updatation
	b .assB2cd		// goto condition check after updatation



.mult:
       
.loop1in:
	mov r1,0		// outer loop for multiplication
			// initialisation
.loop1cd:
	cmp r1,r0		// condition check
	beq .show		// after all iterations go to show
	b .loop2in		// loop body, go to inner loop
.loop1up:
	add r1,r1,1	// updatation
	b .loop1cd		// goto condition check after updatation
		

.loop2in:
	mov r2,0		// inner loop for multiplication
			// initialisation
.loop2cd:
	cmp r2,r0		// condition check
	beq .loop1up	// after inner loop ends go to outer loop updatation
	mul r4,r1,r0	// loop body
	add r4,r4,r2
	mul r4,r4,4
	add r4,r4,r13
	mov r5,0
	st r5,[r4]		// make C[r1][r2] zero before innermost loop
	b .loop3in		// go to innermost loop initialisation
.loop2up:
	add r2,r2,1	// updatation
	b .loop2cd		// goto condition check after updatation

.loop3in:
	mov r3,0		// inner most loop for multiplication
			// initialisation
.loop3cd:
	cmp r3,r0		// condition check
	beq .loop2up	// after inner loop ends go to outer loop updatation
	b .inbody		// loop body described in .inbody
.loop3up:
	add r3,r3,1	// updatation
	b .loop3cd		// goto condition check after updatation

.inbody:
	mul r7,r1,r0	// loop body of inner most loop doing multiplication
	add r7,r7,r3
	mul r7,r7,4
	mul r8,r3,r0
	add r8,r8,r2
	mul r8,r8,4
	mul r9,r1,r0
	add r9,r9,r2
	mul r9,r9,4
	add r7,r7,r11
	ld r7,[r7]
	add r8,r8,r12
	ld r8,[r8]
          mul r10,r7,r8
	add r9,r9,r13
	ld r6,[r9]
	add r10,r10,r6
	st r10,[r9]	// store calculated value in C
	b .loop3up		// go to updatation after loop body


.show:

.show1in:
	mov r1,0		// outer loop to show result
			// initialisation
.show1cd:
	cmp r1,r0		// condition check
	beq .return	// if all shown go to return
	b .show2in 	// loop body
.show1up:
	add r1,r1,1	// updatation
	b .show1cd		// goto condition check after updatation

.show2in:
	mov r2,0		// inner loop to show result
			// initialisation
.show2cd:
	cmp r2,r0		// condition check
	beq .show1up	// after inner loop ends go to outer loop updatation
	mul r3,r1,r0         // loop body
	add r3,r3,r2
	mul r3,r3,4
	add r10,r3,r13
  	ld r4,[r10]	// load C[r1][r2] in r4
	.print r4		// print C[r1][r2]

.show2up:
	add r2,r2,1	// updatation
	b .show2cd		// goto condition check after updatation

.return:
