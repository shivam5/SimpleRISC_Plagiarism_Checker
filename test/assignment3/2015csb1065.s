 .main:
mov r0,3    @size of square matrices
cmp r0,0
beq .exit
mov r1,0x100   @first matrix's base address
mov r2,0x200   @second matrix's base address
mov r3,0x300   @third matrix's base address
mov r4,0
mov r5,0
mov r7,r1
mov r10,0
mul r13,r0,r0
mul r13,r13,4
b .loop1

.loop1:       @initialisation of A matrix
cmp r4,r0     @first loop
beq .ini1
cmp r5,r0
beq .loop11
add r6,r4,r5
st r6,[r7]
add r5,r5,1
add r7,r7,4
b .loop1

.loop11:     @nested loop 
add r4,r4,1
mov r5,0
b .loop1

.ini1:       @initialise non-useful registors to zero to reuse them
mov r4,0
mov r5,0
mov r7,r2
b .loop2     @call for initialisation of B matrix
             @initialisation of B matrix starts here
.loop2:      @first loop
cmp r4,r0    
beq .ini2
cmp r5,r0
beq .loop22
mul r9,r4,3
mul r10,r5,2
add r6,r9,r10
st r6,[r7]
add r7,r7,4
add r5,r5,1
b .loop2

.loop22:     @nested loop
add r4,r4,1
mov r5,0
b .loop2

.ini2:       @reinitialise non-useful registors to zero to reuse them
mov r7,r1
mov r9,r2
mov r10,0
mov r8,0
mov r12,r1
mov r11,r3
b .mul_loop1
              @multiplication of A and B matrix starts here giving matrix C
.mul_loop1:    @first loop
cmp r10,r0     
beq .mul_loop2
sub r6,r7,r1
cmp r13,r6
beq .ini3
ld r4,[r7]
ld r5,[r9]
mul r6,r4,r5   @multiplication of corresponding elements of A's row and B's column
add r8,r8,r6   @addition of all the multiplied numbers to generate a single element of C
add r7,r7,4
add r9,r9,4
add r10,r10,1
b .mul_loop1

.mul_loop2:    @nested loop
st r8,[r11]    @storing the elements of C to memory for printing at later stage
add r11,r11,4
mov r8,0
mov r10,0

sub r6,r9,r2
cmp r6,r13
beq .mul_loop3

mov r7,r12
b .mul_loop1

.mul_loop3:  @second nested loop
mov r9,r2
mov r12,r7
b .mul_loop1

.ini3:
mov r5,0
mov r4,0
mul r13,r0,r0
b .cloop

.cloop:    @loop to print the matrix C
cmp r5,r13 @terminating condition of loop
beq .exit
ld r6,[r3]
add r3,r3,4
add r5,r5,1
.print r6  @printing the elements of C
b .cloop

.exit: