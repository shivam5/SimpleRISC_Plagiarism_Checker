.main:
mov r0,10
mov r1,12
mov r2,-1
sub sp,sp,16
st r0,[sp]
st r1,4[sp]
st r2,8[sp]
st ra,12[sp]
call .f
ld r0,[sp]
ld r1,4[sp]
ld r2,8[sp]
ld ra,12[sp]
.print r3
add sp,sp,16
b .end

.f:
mov r4,0
.loop:
cmp r4,5
bgt .break
beq .break
add r0,r1,r2
sub r1,r0,r2

sub sp,sp,20
st r0,[sp]
st r1,4[sp]
st r2,8[sp]
st r4,12[sp]
st ra,16[sp]
call .g
ld r0,[sp]
ld r1,4[sp]
ld r2,8[sp]
ld r4,12[sp]
ld ra,16[sp]
add sp,sp,20

add r2,r2,r3
add r4,r4,1
b .loop

.break:
add r3,r0,r1
add r3,r3,r2
ret

.g:
mov r4,0
sub sp,sp,16
st r0,[sp]
st r1,4[sp]
st r2,8[sp]
st ra,12[sp]
call .h
ld r0,[sp]
ld r1,4[sp]
ld r2,8[sp]
ld ra,12[sp]
add sp,sp,16
mov r0,r3

mov r4,1
sub sp,sp,16
st r0,[sp]
st r1,4[sp]
st r2,8[sp]
st ra,12[sp]
call .h
ld r0,[sp]
ld r1,4[sp]
ld r2,8[sp]
ld ra,12[sp]
add sp,sp,16
mov r1,r3

mov r4,2
sub sp,sp,16
st r0,[sp]
st r1,4[sp]
st r2,8[sp]
st ra,12[sp]
call .h
ld r0,[sp]
ld r1,4[sp]
ld r2,8[sp]
ld ra,12[sp]
add sp,sp,16
mov r2,r3

add r3,r0,r1
add r3,r3,r2
ret

.h:
cmp r4,0
beq .case0
cmp r4,1
beq .case1
cmp r4,2
beq .case2
.continue:
ret

.case0:
add r3,r0,r1
sub r3,r3,r2
b .continue

.case1:
sub r3,r0,r1
add r3,r3,r2
b .continue

.case2:
add r3,r0,r1
add r3,r3,r2
b .continue

.end: