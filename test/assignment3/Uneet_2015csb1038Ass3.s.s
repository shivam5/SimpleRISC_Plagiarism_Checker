mov r0,3
mov r13,r0
mov r1,0x100
mov r2,0x200
mov r3,0x300
mov r5,0              //i
mov r6,0              //j



.main:
    	.loop1r1:                    //assigning the matrix a
	cmp r0,r5
	beq .exitj1


.loop2r1:
	cmp r0,r6
	beq .exiti1
	mul r7,r0,r5               
	add r7,r7,r6
	mul r7,r7,4
	add r7,r1,r7               //r1+4(N.i+j)
	add r8,r5,r6               
	st r8,[r7]
	add r6,r6,1                //j=j+1
	b .loop2r1

.exiti1:
	mov r6,0
	add r5,r5,1              //i=i+1
	b .loop1r1

.exitj1:
	mov r5,0              // set both the indexes to zero
	mov r6,0



.loop1r2:                            //assigning the matrix b
	cmp r0,r5
	beq .exitj2



.loop2r2:
	cmp r0,r6
	beq .exiti2
	mul r7,r0,r5
	add r7,r7,r6
	mul r7,r7,4
	add r7,r2,r7
	mul r10,r5,2
	mul r11,r6,3
	add r8,r10,r11
	st r8,[r7]
	add r6,r6,1
	b .loop2r2

.exiti2:
	mov r6,0
	add r5,r5,1
	b .loop1r2

.exitj2:
	mov r5,0                   //set all the indexes to zero
	mov r6,0
	mov r7,0
	mov r8,0
	mov r10,0
	mov r11,0

.loopc1:
	cmp r0,r5                // i loop
	beq .exitc1


.loopc2:
	cmp r0,r6               // j loop 
	beq .exitc2


.loopc3:
	cmp r7,r0               // k loop 
	beq .exitc3

	mul r8,r5,r0
	add r8,r8,r7
	mul r8,r8,4
	add r8,r8,r1
	ld r8,[r8]

	mul r9,r7,r0
	add r9,r9,r6
	mul r9,r9,4
	add r9,r9,r2
	ld r9,[r9]

	mul r9,r9,r8           // multipl A and B
	add r11,r11,r9         // sum=sum+mul(A,B)
	add r7,r7,1
	b .loopc3

.exitc3:
	mov r7,0
	add r6,r6,1
	mul r10,r0,r5
	add r10,r10,r6
	mul r10,r10,4
	add r10,r10,r3
	st r11,[r10]
	.print r11           //print selements of c
	mov r11,0
	b .loopc2

.exitc2:
	mov r6,0                 
	add r5,r5,1
	b .loopc1

.exitc1:



	