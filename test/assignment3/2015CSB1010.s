.main:
mov r0,3			@ size of matrix
mov r1,0x100		@ addr of A[0][0]
mov r2,0x200		@ addr of B[0][0]
mov r3,0x300		@ addr of C[0][0]
mov r4,0			@ row iterator
mov r5,0			@ col iterator

@ preparing the matrices A and B 
.loop1:			@ outer loop for row num
	cmp r4,r0
	bgt .operating
	beq .operating
mov r5,0
.loop2:			@ iner loop for column num  
	cmp r5,r0
	bgt .continue
	beq .continue
	mul r7,r0,r4
	add r7,r7,r5
	mul r7,r7,4

	add r6,r4,r5
	add r8,r7,r1
	st r6,[r8]		@ storing in A

	add r8,r7,r2
	mul r6,r6,2
	add r6,r6,r5
	st r6,[r8]		@ storing in B

	add r5,r5,1
	b .loop2
.continue:			@ exit loop2 but continue with loop1
	add r4,r4,1
	b .loop1

.operating:		@ exit of loop1 and generating matrix C
	mov r4,0

@ there are three loops to generate matrix C
.lp1:			@ loop for row num of C
	cmp r4,r0
	bgt .exit
	beq .exit
	mov r5,0
.lp2:			@ loop for column num of C
	cmp r5,r0
	bgt .continue1
	beq .continue1

	mul r7,r0,r4
	mul r7,r7,4
	add r7,r7,r1

	mul r8,r5,4
	add r8,r8,r2

	mov r6,0
	mov r11,0
.lp3:			@ loop to calculate A[i][1:n]*B[1:n][j]
	cmp r6,r0
	bgt .continue2
	beq .continue2

	ld r9,[r7]
	ld r10,[r8]
	mul r9,r9,r10	@ r9=A[i][k]*B[k][j]
	add r11,r11,r9	@ r11+=r9

	add r7,r7,4
	mul r10,r0,4
	add r8,r8,r10

	add r6,r6,1
	b .lp3
.continue2:		@ exit of lp3
	mul r8,r0,r4
	add r8,r8,r5
	mul r8,r8,4
	add r8,r8,r3
	st r11,[r8]	@ storing in C
	add r5,r5,1
	b .lp2
	
.continue1:		@ exit of lp2
	add r4,r4,1
	b .lp1


.exit:			@ exit of lp1 and print the matrix C
	mov r4,0
	mov r5,0
.pt1:			@ row iterator
	cmp r4,r0
	beq .return
	bgt .return
.pt2:			@ column iterator
	cmp r5,r0
	beq .endp2
	bgt .endp2
	mul r6,r4,r0
	add r6,r6,r5
	mul r6,r6,4
	add r6,r6,r3
	ld r7,[r6]
	.print r7			@ printing C[i][j]
	add r5,r5,1
	b .pt2
.endp2:			@ exit of pt2
	mov r5,0
	add r4,r4,1
	b .pt1
.return:			@ end of the code