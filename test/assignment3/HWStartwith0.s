 .main:
	mov r0,3		// n is stored to r0, size = n+1 
	add r10,r0,1	// matrix runs from 0 to n
	mov r1,0x100
	mov r2,0x200
	mov r3,0		//i = r3
	mov r4,0		//j=r4
	b .afiller
	
.afiller:	
	cmp r3,r0
	bgt .bcaller	//if i>n goto fill b
	mov r4,0
	call .afillerj	//goto fill a
	add r3,r3,1	//increase i
	b .afiller

.afillerj:
	cmp r4,r0
	bgt .return
	mul r5,r3,r10	//r5 = i*(n+1)
	add r5,r5,r4	// r5 = r5 + j
	mul r5,r5,4
	add r6,r3,r4	//r6 = i+j
	add r7,r5,r1	//add address of a
	st r6,0[r7]
	.print r6
	add r4,r4,1
	b .afillerj

.bcaller:
	mov r3,0
	mov r4,0
	b .bfiller
	
.bfiller:	
	cmp r3,r0		//if i>n i.e matrix filled
	bgt .multiplier	//goto multiply a and b
	mov r4,0		
	call .bfillerj	// goto fiil it
	add r3,r3,1
	b .bfiller		

.bfillerj:
	cmp r4,r0
	bgt .return
	mul r5,r3,r10 	//r5 = (n+1)*i
	add r5,r5,r4	// r5+=j
	mul r5,r5,4	//r5 = ((n+1)*i + j)*4
	mul r7,r3,2	//2i
	mul r8,r4,3	//3j
	add r6,r7,r8	//2i+3j
	add r8,r5,r2	//r8 = address to store, r5 + address b
	st r6,0[r8]	
	.print r6
	add r4,r4,1
	b .bfillerj

.multiplier:
	mov r3,0x300
	mov r4,0		//new i
	mov r5,0		//new j
	mov r6,0		//new k
	b .ichoose

.ichoose:
	cmp r4,r0		// if i>n
	bgt .exit		
	call .jcaller	//go to j loop
	add r4,r4,1
	b .ichoose

.jcaller:
	mov r5,0  // make j = 0 and goto j loop
	b .jchoose

.jchoose:
	cmp r5,r0		//cmp with n
	bgt .return
	add sp,sp,-4	//create space for return address to i choose
	st ra,0[sp]
	call .kcaller  //goto k loop upon making k 0
	ld ra,0[sp]   // load return address
	add sp,sp,4
	mul r9,r4,r10	//r9 =  i*n-1
	add r9,r9,r5	//r9 = r9+j
	mul r9,r9,4
	add r9,r9,r3  //r9=(i*(n-1)+j)*4 + addr a
	st r8,0[r9]		// store c[i][j]
	.print r8
	add r5,r5,1 // increase j
	b .jchoose

.kcaller:
	mov r6,0
	mov r8,0
	b .kchoose

.kchoose:
	cmp r6,r0
	bgt .return
	mul r7,r4,r10
	add r7,r7,r6
	mul r7,r7,4
	add r7,r7,r1 
	ld r7,0[r7] // load A[i][k]
	mul r9,r6,r10
	add r9,r9,r5
	mul r9,r9,4
	add r9,r9,r2
	ld r9,0[r9] // load B[k][j]
	mul r7,r7,r9 
	add r8,r7,r8 // add n elements that we get as product
	add r6,r6,1
	b .kchoose

.return:
	ret

.exit:
