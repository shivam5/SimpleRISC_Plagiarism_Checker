 
.origin:
mov r0,2
cmp r0,0
beq .exit

mov r1,0x100
mov r2,0x200
mov r3,0x300

//Storing A and B

mov r4,-1
.loop1:
add r4,r4,1
cmp r4,r0
beq .multiply

mov r5,0
.loop2:


mul r7,r0,r4
add r7,r7,r5


add r6,r5,r4


mul r7,r7,4
add r11,r1,r7
st r6, 0[r11]
mul r6,r4,2
mul r8,r5,3
add r6,r6,r8


add r11,r7,r2
st r6,0[r11]

add r5,r5,1

cmp r5,r0
beq .loop1
b .loop2

// MULTIPLICATION OF A AND B

.multiply:
mov r4,-1
.loopi:
add r4,r4,1
cmp r4,r0
beq .display

mov r5,-1
.loopj:
add r5,r5,1
cmp r5,r0
beq .loopi

mov r10,0
mov r6,0
.loopk:
mul r7,r4,r0
add r7,r7,r6

mul r7,r7,4
add r11,r7,r1
ld r8,0[r11]

mul r7,r6,r0
add r7,r7,r5

mul r7,r7,4
add r11,r7,r2
ld r9,0[r11]

mul r8,r8,r9

add r10,r10,r8

add r6,r6,1
cmp r6,r0
beq .store
b .loopk

.store:
mul r8,r0,r4
add r8,r8,r5

mul r8,r8,4
add r11,r8,r3
st r10,0[r11]
b .loopj


.display:
mul r4,r0,r0

mov r5,0

.display1:

mul r6,r5,4
add r8,r6,r3
ld r10,0[r8]
.print r10
add r5,r5,1
cmp r5,r4
beq .exit
b .display1

.exit: