.main:
mov r0 , 10  /* a */
mov r1 , 12  /* b */
mov r2 , -1  /* c */
mov r3 , 0   /* d */

call .f
.print r3  /* answer */ 

b .exit

.f:
sub sp , sp ,16
st ra , [sp]
st r0 , 4[sp]
st r1 , 8[sp]
st r2 , 12[sp]

mov r4 , 4 /* local variable i */
b .loop

.loop: 
add r0 , r1 ,r2 /* a = b+ c */
sub r1 , r0 , r2  /* b = a - c */ 
mov r5 , r2 /* copy  of c */
call .g  
add r2 , r5 , r6 /* c = c + g(a,b,c) */
sub r4 , r4 , 1 
cmp r4 , -1 
bgt .loop
add r3 , r0 , r1
add r3 , r3 , r2 

ld ra , [sp]
ld r0 , 4[sp]
ld r1 , 8[sp]
ld r2 , 12[sp]

add sp , sp , 16
ret 

.g:
sub sp , sp ,16
st ra , [sp]
st r0 , 4[sp]
st r1 , 8[sp]
st r2 , 12[sp]

mov r7 , 0   /* variable d */
call .h
mov r0 , r8  /* r8 is the output of h */ 

mov r7 , 1
call .h
mov r1 , r8

mov r7 , 2
call .h
mov r2 , r8
 

add r6 , r0 , r1
add r6 , r6 ,r2   /* a + b + c */

ld ra , [sp]
ld r0 , 4[sp]
ld r1 , 8[sp]
ld r2 , 12[sp]
add sp , sp , 16
ret  



.h:
sub sp , sp ,16
st ra , [sp]
st r0 , 4[sp]
st r1 , 8[sp]
st r2 , 12[sp]

cmp r7 , 0 
beq .b1

cmp r7 , 1 
beq .b2


cmp r7 , 2 
beq .b3
mov r8 , 0 
.b4:
ld ra , [sp]
ld r0 , 4[sp]
ld r1 , 8[sp]
ld r2 , 12[sp]
add sp , sp , 16
ret 
 
.b1:
add r8 , r0 , r1 
sub r8 , r8 , r2 
b .b4


.b2:
add r8 , r0 , r2 
sub r8 , r8 , r1 
b .b4


.b3:
add r8 , r0 , r1 
add r8 , r8 , r2 
b .b4




















.exit:
