 .main:
mov r0,4        @contains the size of matrix
mov r1,0x100        @base address of matrix A
mov r2,0x200       @base address of matrix B
mov r3,0x300       @base address of matrix C
mov r9,0x100       @used later for printing A
mov r10,0x200       @used later for printing B 
mov r11,0x300       @used later for printing C
mul r8,r0,4


.innerloop1:      @ this is sort of for loop to generate matrix A
cmp r5,r0
beq .outerloop1          @nested loop 
add r6,r5,r4      @executing the step A[i]j[]=i+j
st r6,[r1]        @store the result in memory
add r1, r1,4    @increement of memory address
add r5,r5,1    @increement of j
b .innerloop1   

.outerloop1:     @i-loop
add r4,r4,1  @increement of i
cmp r4,r0
beq .initialize    @to initialize i again
mov r5 0
cmp r0,r4
bgt .innerloop1
.initialize:
mov r5 0   @ re-initializing such that it can be used later
mov r4 0

.innerloop2:    @this loop is to execute the statement A[i][j]=2i + 3j
cmp r5,r0      
beq .outerloop2    @nested loop
mul r11,r5,3
mul r12,r4,2    
add r6,r11,r12   @r6 contains 2i+3j for corresponding values
st r6,[r2]      @storing to memeory
add r2,r2,4
add r5,r5,1   @increement of j
b .innerloop2

.outerloop2:
add r4,r4,1  @increement of i
cmp r4 r0
beq .multipl
mov r5 0
cmp r0 r4
bgt .innerloop2

.multipl:
mov r4,0
mov r5,0
mul r11,r4,r8
add r11,r9,r11
mul r12,r5,4
add r12,r10,r12
mov r7,0

.multiply:   @this label ececutes the multiplication
ld r1,[r11]
ld r2,[r12]
mul r6,r1,r2  @multiplying the row element to column
add r13,r13,r6  @implementing the multiplicatuion opetion (its algorithm)
add r7,r7,1    @these counters are used to shift to next element
add r12,r12,r8
add r11,r11,4
cmp r7,r0
beq .change
b .multiply
 
.change:
mov r7,0
add r5,r5,1   @increement of counter of loop
st r13,[r3]
.print r13   @printing the elements of matrix C
cmp r5,r0
beq .faltu   @if r5 =r0.. then corresponding row is completed and we have to assign r5=0

.change1:    @ to repaeat the process for next row
mul r11,r4,r8
add r11,r9,r11
mul r12,r5,4
add r12,r10,r12
mov r13,0
add r3,r3,4
b .multiply

.faltu:
mov r5,0
b .again

.again:
add r4,r4,1
cmp r0,r4
bgt .change1
b .return
.return:




