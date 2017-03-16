.main:
mov r0,3
mov r1,0x100
mov r2,0x200
mov r3,0x300

/* Assigning the values of first array */


mov r4,0
.loop1:
mov r5,0
	.loop2:
	mov r11,r1
	mov r6,0
	add r6,r6,r4
	add r6,r6,r5
	mul r7,r4,r0
	add r7,r7,r5
	mul r7,r7,4
	add r11,r11,r7
	st r6, [r11]
	add r7,r7,4
	add r5,r5,1
	cmp r0,r5
	bgt .loop2
add r4,r4,1 
cmp r0,r4
bgt .loop1

/*Assigning values of the second array  */

mov r4,0
.loop3:
mov r5,0
	.loop4:
	mov r11,r2
	mov r6,0
	mul r8,r4,2
	add r6,r6,r8
	mul r8,r5,3
	add r6,r6,r8
	mul r7,r4,r0
	add r7,r7,r5
	mul r7,r7,4
	add r11,r11,r7
	st r6, [r11]
	add r7,r7,4
	add r5,r5,1
	cmp r0,r5
	bgt .loop4
add r4,r4,1 
cmp r0,r4
bgt .loop3

/* Multiplication of the two arrays*/
mov r4,0
.loop5:
mov r5,0
.loop6:
mov r6,0
mul r9,r4,r0
add r9,r9,r5
mul r9,r9,4
mov r11,r3
add r11,r11,r9
st r6, [r11]
.loop7:
mul r8,r4,r0
add r8,r8,r6
mul r8,r8,4
mov r11,r1
add r11,r11,r8
ld r8, [r11]
mul r9,r6,r0
add r9,r9,r5
mul r9,r9,4
mov r11,r2
add r11,r11,r9
ld r9, [r11]
mul r8,r8,r9
mul r9,r4,r0
add r9,r9,r5
mul r9,r9,4
mov r11,r3
add r11,r11,r9
ld r10, [r11]
add r8,r8,r10
mov r11,r3
add r11,r11,r9
st r8, [r11]
add r6,r6,1
cmp r0,r6
bgt .loop7
add r5,r5,1
cmp r0,r5
bgt .loop6
add r4,r4,1
cmp r0,r4
bgt .loop5

/* Printing the output */

mov r7,0
mov r4,0
.loop8:
mov r5,0
.loop9:
mul r7,r4,r0
add r7,r7,r5
mul r7,r7,4
mov r11,r3
add r11,r11,r7
ld r7, [r11]
.print r7
add r5,r5,1
cmp r0,r5
bgt .loop9
add r4,r4,1
cmp r0,r4
bgt .loop8 