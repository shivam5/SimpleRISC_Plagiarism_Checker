  .loop2:
	mov r5,0
	add r4,r4,1
	
.loop1:
	cmp r4,r0
	beq .return
	cmp r5,r0
	beq .loop2    @compare j to N if it is equal increase i
	mul r6,r4,r0
	add r6,r6,r5
	mul r6,r6,4     @creating index for [i][j]
	add r7,r4,r5    @A[i][j]=i+j
	mul r8,r4,2
	mul r9,r5,3
	add r8,r8,r9    @B[i][j]=2i+3j
	add r9,r6,r1
	st r7,0[r9]
	add r10,r6,r2
	st r8,0[r10]          @storng the value in memory
	add r5,r5,1        @j=j+1
	b .loop1    @compare i to N if it is equal return to main else repeat

.loop4:
	mov r5,0
	add r4,r4,1

.loop3:
	cmp r4,r0
	beq .exit
	cmp r5,r0
	beq .loop4  @if j==N call loop4 for increasin i
	mov r6,0   @index for multiplying
	mov r11,0   @sum
	@b .loop5   @call loop5 for calculating C[i][j]

.loop5:
	cmp r6,r0
	beq .loop6
	mul r7,r4,r0
	add r7,r7,r6
	mul r7,r7,4    @calculating index for A[i][r6]
	add r10,r7,r1
	ld r8,[r10]  @load it from memory in r8
	mul r7,r6,r0
	add r7,r7,r5
	mul r7,r7,4    @calculating index for B[r6][j]
	add r10,r7,r2
	ld r9,0[r10]    @load it from memory in r9
	mul r8,r8,r9
	add r11,r11,r8   @sum
	add r6,r6,1   @increasing index for multiply
	b .loop5
.loop6:
	mul r7,r0,r4
	add r7,r7,r5
	mul r7,r7,4   @calculating index of C[i][j]
	add r8,r7,r3
	st r11,[r8]   @storing it to memory
	.print r11
	add r5,r5,1    @increasing j
	b .loop3   @comparing i to N if it is equal return to main

.return:
	ret


.main:
	mov r0,2   @size of the matrix
	mov r1,0x100        @base address of A
	mov r2,0x200       @base address of B
	mov r3,0x300      @base address of C
	mov r4,0          @index for i
	mov r5,0          @index for j
	call .loop1      @call loop for initializing A and B
	mov r4,0        @index for i
	mov r5,0        @index for j
	call .loop3     @call loop 3 for initializing C

.exit: