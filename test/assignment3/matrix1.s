
mov r13,3
mov r0,0
mov r3,0x100
mov r4,0x200
mov r5,0x300

// Storing the values in matrix A and B

.loop1 :                         // for (i=0;i<n;i++)
	mov r1,1
	add r0,r0,1        
	cmp r13,r0
	beq .loop2
	bgt .loop2
	b .C

.loop2 :                         // for (j=0;j<n;<j++)
	add r6,r0,r1           // A(i,j) = i+j;
	sub r6,r6,2            // index change 1 to 0
	st r6,0[r3]
	mul r7,r0,2            // B(i,j) = 2*i +3*j;
	mul r8,r1,3
	add r8,r8,r7
	sub r8,r8,5            // index change 1 to 0
	st r8,0[r4]
	mov r9,0         // C(i,j) =0 as later we used C = C+something;
	st r9,0[r5]	
	add r3,r3,4            // Increment all addresses by 4;
	add r4,r4,4
	add r5,r5,4
	add r1,r1,1
	cmp r13,r1
	beq .loop2
	bgt .loop2
	b .loop1


// Forming C using A and B

.C :
	mov r0,0
	mov r3,0x100
	mov r4,0x200
	mov r5,0x300
	

.loopi : 
	mov r3,0x100
	mov r1,0
	add r0,r0,1
	sub r12,r0,1
	mul r10,r13,4             // A[i][k] changing according to n
	mul r12,r12,r10           // 12*i address 0 12 24
	add r3,r3,r12              // Changing address accordingly 
	cmp r13,r0
	beq .loopj
	bgt .loopj
	b .exit

.loopj :
	
	mov r4,0x200
 	mov r2,1
	add r1,r1,1
	sub r11,r1,1              // r11 stores the value of j-1;
	mul r11,r11,4             // 4*j address 0 4 8
	add r4,r4,r11             // as j will always shift by 4 (column)
	cmp r13,r1
	beq .loopk
	bgt .loopk
	b .loopi
	
	
.loopk :
	ld r7,0[r3]
	ld r8,0[r4]
	ld r9,0[r5]
	mul r10,r7,r8              // storing value in C(i,j);
	add r10,r10,r9
	st r10,0[r5]
	add r3,r3,4
	mul r10,r13,4              // B[j][k] changing according to n
	add r4,r4,r10
	add r2,r2,1
	cmp r13,r2
	beq .loopk
	bgt .loopk
	ld r10,0[r5]                // print condition
	.print r10
	add r5,r5,4
	mul r10,r13,4
	sub r3,r3,r10                // A[i][k] changing according to n
	b .loopj
	

.exit :