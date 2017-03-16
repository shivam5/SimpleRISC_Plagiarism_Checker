.main:
mov r0,2                          @ giving the value of n
mov r1,0x100
mov r2,0x200
mov r3,0x300
mov r4,0
mov r5,0


.loop1:

.break1:
cmp r4,r0
beq .break
bgt .break
mov r5,0

.loop2:
cmp r5,r0
beq .inc0
bgt .inc0
mul r6,r0,r4
add r6,r6,r5
mul r6,r6,4
add r7,r6,r2
add r6,r6,r1
add r8,r4,r5
mul r10,r4,2
mul r9,r5,3
add r9,r9,r10
st r8,[r6]                                  @ storing elements of A and B
st r9,[r7]
ld r13,[r7]

add r5,r5,1
b .loop2


.inc0:
add r4,r4,1
b .break1


.break:
mov r4,0
mov r5,0
mov r6,0

.l1:
cmp r4,r0
beq .end
bgt .end
mov r5,0

.l2:
cmp r5,r0
beq .inc1
bgt .inc1
mov r6,0
mov r7,0

.l3:
cmp r6,r0
beq .inc2
bgt .inc2
mul r8,r4,r0
add r8,r8,r6
mul r8,r8,4
add r8,r8,r1

mul r9,r6,r0
add r9,r9,r5
mul r9,r9,4
add r9,r9,r2

ld r10,[r8]
ld r11,[r9]

mul r10,r10,r11
add r7,r7,r10

add r6,r6,1
b .l3


.inc1:
add r4,r4,1
b .l1

.inc2:

mul r12,r4,r0
add r12,r12,r5
mul r12,r12,4
add r12,r12,r3
.print r7
st r7,[r12]                                  @ storing final matrix C

add r5,r5,1
b .l2

.end: