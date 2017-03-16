.main:
mov r0,3
mov r1,0x100
mov r2,0x200
mov r13,0x300

mov r5,0
.loop: cmp r5,r0
beq .step1
bgt .step1

mov r6,0
.loop1: cmp r6,r0
beq .loopend
bgt .loopend
mul r3,r5,r0
add r3,r3,r6
mul r3,r3,4
mov r9,r3
add r3,r1,r3
add r4,r5,r6
mul r7,r5,2
mul r8,r6,3
add r7,r7,r8
add r9,r9,r2
st r7,0[r9]
st r4,0[r3]
add r6,r6,1
b .loop1


.loopend: add r5,r5,1

b .loop

.step1:

mov r4,0
.loop2: cmp r4,r0
bgt .step2
beq .step2

mov r5,0
.loop3: cmp r5,r0
bgt .loop2end
beq .loop2end
mov r7,0
mov r6,0

.loop4: cmp r6,r0
bgt .loop3end
beq .loop3end
mul r8,r4,r0
add r8,r8,r6
lsl r8,r8,2
add r8,r8,r1

mul r9,r6,r0
add r9,r9,r5
lsl r9,r9,2
add r9,r9,r2
ld r10,0[r8]
ld r11,0[r9]
mul r10,r10,r11

add r7,r7,r10

add r6,r6,1

b .loop4

.loop3end:
mul r8,r4,r0
add r8,r8,r5
lsl r8,r8,2
add r8,r8,r13
st r7,0[r8]
add r5,r5,1
b .loop3

.loop2end: add r4,r4,1
b .loop2


.step2: mov r4,0

.loop5: cmp r4,r0

bgt .step4
beq .step4
mov r5,0
.loop6:  cmp r5,r0

bgt .loop5end
beq .loop5end

mul r6,r4,r0
add r6,r6,r5

lsl r6,r6,2
add r6,r6,r13

ld r10,0[r6]
.print r10

add r5,r5,1
b .loop6

.loop5end: add r4,r4,1
b .loop5

.step4: