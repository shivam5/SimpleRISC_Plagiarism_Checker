.main:
	mov r0,3
.start:
	mov r1,0x100
	mov r2,0x200
	mov r3,0x300
	mov r4,-1       	/*r4 is i*/
	mov r5,0		/*r5 is j*/
.loopa1:
	add r4,r4,1	
	cmp r4,r0
	beq .continue
	bgt .continue
	mov r5,0
	.loopa2:
		cmp r5,r0
		beq .loopa1
		bgt .loopa1
		mul r6,r4,r0		/* i*N */
		add r6,r6,r5		/* i*N + j */
		mul r6,r6,4		/* (i*N + j)*4 */
		add r7,r6,r1		/* Base address of A */
		add r8,r6,r2		/* Base address of B */
		add r9,r4,r5		/* (i+j) */
		st r9,0[r7]		/* laoding in A */
		mul r9,r4,2		/* r9 = 2*i */
		mul r10,r5,3		/* r10 = 3*j */
		add r9,r9,r10		/* r9 = 2i + 3j */
		st r9,0[r8]		/* loading in B */
		add r5,r5,1		/* j++ */
		b .loopa2
.continue:
	mov r4,-1
	mov r5,0
	mov r6,0				/* r6 is k */
.loopc1:
	add r4,r4,1			/* r4 is i*/
	cmp r4,r0				/*if i<n then continue*/
	beq .return
	bgt .return
	mov r5,-1
	.loopc2:
		add r5,r5,1		/*r5 if j*/
		cmp r5,r0			/*if j<n then continue*/
		beq .loopc1
		bgt .loopc1
		mul r9,r4,r0
		add r9,r9,r5
		mul r9,r9,4
		add r9,r9,r3
		mov r10,0
		st r10,0[r9]			/* C[i,j]=0 */
		mov r6,0
		.loopc3:
			cmp r6,r0
			beq .loopc2
			bgt .loopc2
			mul r7,r4,r0
			add r7,r7,r6
			mul r7,r7,4
			add r7,r7,r1
			ld r7,0[r7]		/* loading value r7 */
			mul r8,r6,r0
			add r8,r8,r5
			mul r8,r8,4
			add r8,r8,r2
			ld r8,0[r8]		/* loading value r8 */
			mul r7,r7,r8
			ld r8,0[r9]
			add r7,r7,r8
			st r7,0[r9]		/* storing value in r7*/
			add r6,r6,1
			b .loopc3
.return:
	mov r4,0					/* r4 is i of matrix C */
	mov r5,0					/* r5 is j of matrix C */
	mul r4,r4,r0
	add r4,r4,r5
	mul r4,r4,4
	add r4,r4,r3
	ld r4,0[r4]				/* loading value in r4 */
	.print r4
			
	
	 