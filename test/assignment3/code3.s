mov r0,8                          @Size of Matrix Input (N*N)
sub r11,r0,1                      @Decreasing the size of N by 1
mov r1, 0x100                     @A[i][j]
mov r2, 0x200                     @B[i][j]
mov r3, 0x300                     @C[i][j]

mov r4,0                          @ROW initialise
mov r5,0                          @COLUMN initialise

.cache :                          @Cache loop
mul r6,r4,r0                      @r6 = N*i
add r6,r6,r5                      @r6 = (j+(N*i))
mul r6,r6,4                       @r6 = ((N*i)+j)*4

add r7,r4,r5                      @r7 = Base Matrix A [i+j]
mul r8,r4,2                       @2i = Base Matrix B [ROW]
mul r9,r5,3                       @3j = Base Matrix B [COLUMN]
add r8,r8,r9                      @r8=  Base Matrix B [2i+3j]

@OFFSET

add r9,r1,r6                      @r9 = 0x100 + offset
add r10,r2,r6                     @r10= 0x200 + offset

st r7, 0[r9]
st r8,0[r10]

cmp r5,r11
beq .loljf
add r5,r5,1
b .cache

@If j Fails
.loljf : mov r5,0
cmp r4,r11
beq .lolif
add r4,r4,1
b .cache

@If i fails
.lolif:
mov r4,0
mov r5,0


@Matrix Multiplication & Calculating C Matrix

.sum :
mul r6,r4,r0                       @r6 = N*i
add r6,r6,r5                       @r6 = j +(N*i)
mul r6,r6,4                        @r6 = ((i*N)+j)*4

add r9,r3,r6

mov r13,0 @Initialising k 
mov r8,0 

.sumone:
mul r6,r4,r0                       @r6=i*N
add r6,r6,r13                      @r6=(i*N)+k
mul r6,r6,4                        @r6 = ((i*N)+k)*4
@Two For Loops
add r7,r1,r6                       @r7=A+offset
ld r10, 0[r7]                      @r10=A[i][k] Loop1

mul r6,r13,r0                      @r6=k*N
add r6,r6,r5                       @r6=(k*N)+j
mul r6,r6,4                        @r6 = ((i*N)+j)*4

add r7,r2,r6                       @r7= B+offset
ld r12, 0[r7]                      @r11=B[k][j] Loop2

mul r10,r10,r12                    @r10=A[i][k]*B[k][j]
add r8,r8,r10

cmp r13,r11
beq .lolkf
add r13,r13,1
B .sumone
@printing the value in register r8
.lolkf :
.print r8
st r8, 0[r9]
cmp r5,r11
beq .loljf1
add r5,r5,1
B .sum

.loljf1 : mov r5,0
cmp r4,r11
beq .lolif1
add r4,r4,1
b .sum

.lolif1: