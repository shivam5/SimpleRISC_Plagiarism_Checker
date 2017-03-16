 

mov r4,10
mov r5,12
mov r6,-1
mov r7,0
mov r10,0
mov r11,5
b .f
b .loopstart
.f:
cmp r10,r11
bgt .exit
beq .exit


.loopstart:
add r4,r5,r6
sub r5,r4,r6
sub sp,sp,100
st ra,[sp]
add sp,sp,4
st r4,[sp]
add sp,sp,4
st r5,[sp]
add sp,sp,4
st r6,[sp]
add sp,sp,4
call .g
sub sp,sp,4
ld r6,[sp]
sub sp,sp,4
ld r5,[sp]
sub sp,sp,4
ld r4,[sp]
sub sp,sp,4
ld ra,[sp]
add r6,r6,r8
b .loopend
.loopend:
add r10,r10,1	
b .f

.g:
st ra,[sp]
add sp,sp,4
call .h1	
call .h2
call .h3
add r8,r4,r5
add r8,r8,r6
sub sp,sp,4
ld ra,[sp]
ret


.h1:
add r12,r4,r5
sub r12,r12,r6
mov r4,r12
mov r12,0
ret

.h2:
add r12,r4,r6
sub r12,r12,r5
mov r5,r12
mov r12,0
ret

.h3:
add r12,r4,r5
add r12,r12,r6
mov r6,r12
mov r12,0
ret

.exit:
add r7,r4,r5
add r7,r7,r6
.print r7