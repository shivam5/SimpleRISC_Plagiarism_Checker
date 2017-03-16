.main:
mov r0,3   // size of matrix
mov r1,0x100   // base address of A matrix 
mov r2,0x200   // base address of B matrix
mov r3,0x300   // base address of C matrix

.start:
mov r4,-1         //temporary for i index
mov r5,-1        //temporary for j index
 
 
.increment:    // outer loop for reading the value of A and B matrix
add r4,r4,1
cmp r4,r0
beq .multiply       // Call the statement to multiply A and B
mov r5,-1

.fillArray:      // inner loop for reading the value to C matrix
add r5,r5,1
cmp r5,r0
beq .increment    // call for outer loop

mul r6,r4,r0
add r6,r6,r5
mul r6,r6,4

add r8,r6,r1       //   A[i][j]    address
add r7,r4,r5      //     i+j
st r7,[r8]        //store i+j in A[i][j]

add r8,r6,r2           //B[i][j]   address
mul r7,r4,2
mul r9,r5,3
add r7,r7,r9          //2i+3j
st r7,[r8]       // store 2i+3j in B[i][j]

b .fillArray


.multiply:
mov r4,-1

.loop1:           // outer loop for multiplication
add r4,r4,1
cmp r4,r0
beq .display    // breaking condition of outer loop
mov r5,-1

.loop2:        // inner loop for multiplication
add r5,r5,1

cmp r5,r0
beq .loop1    // call for outer loop

mul r7,r4,r0    //i*n
add r8,r7,r5    // i*n +j
mul r8,r8,4    // (i*n+j)*4

add r8,r8,r3  //C[i][j]  address

mov r6,-1      //temp variable k=-1
mov r13,0

.loop3:    // running the loop upto commom size of matrix
add r6 ,r6,1
cmp r6,r0
beq .loop2     // breaking condition for common loop

mul r9,r4,r0
add r9,r9,r6
mul r9,r9,4     //[i][k]  address
add r9,r9,r1  

ld r10,[r9]      //  retrieving A[i][k] address value

mul r11,r6,r0
add r11,r11,r5
mul r11,r11,4
add r11,r11,r2

ld r12,[r11]      //b[k][j]

mul r10,r10,r12   //a[i][k]*b[k][j]

add r13,r13,r10
st r13,[r8]     // storing the value i.e C[i][j] in memory

b .loop3


.display:      // for display of matrix C
mov r5,-1
mov r4,-1

.loopOuter:     // making outer loop and iterating in ROW MAJOR wise

add r4,r4,1
cmp r4,r0
beq .EXIT    // breaking Condition
mov r5,-1

.loopInner:     // making inner loop and iterating 
add r5,r5,1
cmp r5,r0
beq .loopOuter

mul r6,r4,r0  //i*n
add r6,r6,r5    //i*n+j
mul r6,r6,4     

add r8,r6,r3    //c[i][j]
ld r7,[r8]      // retrieving value of C[i][j] and storing in register
.print r7     // printing the value of C[i][j]
b .loopInner

.EXIT: