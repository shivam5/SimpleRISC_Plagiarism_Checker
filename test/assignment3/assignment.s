mov r0,4
mov r1,0
mov r2,0
mov r3,0x100
mov r4,0x200            @r3, r4,r5 are base addresses of a,b,c
mov r5,0x300

.loop:
mov r2,0
.loopa:                      @loop for finding a matrix
add r6,r1,r2
mul r7,r1,r0
add r7,r7,r2
mul r7,r7,4
add r7,r7,r3
st r6,[r7]
add r2,r2,1
cmp r0,r2
bgt .loopa
add r1,r1,1
cmp r0,r1
bgt .loop

mov r1,0
mov r2,0
.loopb:
mov r2,0                  @loop for finding b matrix
.loopc:
mul r1,r1,2
mul r2,r2,3
add r6,r1,r2
div r1,r1,2
div r2,r2,3
mul r7,r1,r0
add r7,r7,r2
mul r7,r7,4
add r7,r7,r4
st r6,[r7]
add r2,r2,1
cmp r0,r2
bgt .loopc
add r1,r1,1
cmp r0,r1
bgt .loopb

mov r1,0
mov r2,0
.loope:
mov r2,0
.loopf:
mov r6,0
mov r10,0
.loopg:
mul r7,r1,r0
add r7,r7,r6
mul r7,r7,4
add r7,r7,r3
ld r7,[r7]
mul r8,r6,r0
add r8,r8,r2          @loop for multiplying
mul r8,r8,4
add r8,r8,r4
ld r8,[r8]
mul r7,r7,r8
add r10,r10,r7
add r6,r6,1
cmp r0,r6
bgt .loopg
mul r9,r1,r0
add r9,r9,r2
mul r9,r9,4
add r9,r9,r5
st r10,[r9]
mov r10,0
add r2,r2,1
cmp r0,r2
bgt .loopf
add r1,r1,1
cmp r0,r1
bgt .loope

mov r1,0
mov r2,0
.loopx:
mov r2,0
.loopy:
mul r7,r1,r0
add r7,r7,r2
mul r7,r7,4
add r7,r7,r5
ld r6,[r7]               @loop for output
.print r6                   @output is given row wise
add r2,r2,1                  
cmp r0,r2
bgt .loopy
add r1,r1,1
cmp r0,r1
bgt .loopx
