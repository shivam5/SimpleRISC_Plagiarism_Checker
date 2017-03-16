 .function_h:
cmp r0,0
beq .return_1
cmp r0,1
beq .return_2
cmp r0,2
beq .return_3
b .return
.function_g:
call .function_h
mov r1,r4
call .function_h
mov r2,r4
call .function_h
mov r3,r4
add r5,r1,r2
add r5,r5,r3
b .retg

.function_f:

.loop:
add r1,r2,r3
sub r2,r1,r3
st r1,[r9]
st r2,4[r9]
st r3,8[r9]
mov r0,0
call .function_g
.retg:
ld r1,[r9]
ld r2,4[r9]
ld r3,8[r9]
add r3,r3,r5
add r6,r6,1
cmp r6,5
beq .return_f
b .loop
.return_f:
add r7,r1,r2
add r7,r7,r3
b .retf

.return_1:
add r4,r1,r2
sub r4,r4,r3
add r0,r0,1
ret
.return_2:
sub r4,r1,r2
add r4,r4,r3
add r0,r0,1
ret
.return_3:
add r4,r1,r2
add r4,r4,r3
add r0,r0,1
ret
.return:
mov r4,0
.main:
mov r6,0
mov r1,10
mov r2,12
mov r3,-1
call .function_f
.retf:
mov r0,r7
.print r0










 