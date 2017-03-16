mov r1 10
mov r2 12
mov r3 -1
b .f

.f:
mov r4 0      @ i=0
b .f1

.f1:
add r1 r2 r3     @ a= b+c
sub r2 r1 r3     @ b= a-c

call .g
ld r1 0[sp]      
ld r2 4[sp]
ld r3 8[sp]
ld ra 12[sp]
add r3 r3 r6    @ c= c+g(a,b,c)
add sp sp 16   
add r4 r4 1     @ i=i+1
cmp r4 5        @ cmp i with 5
bgt .exi      
beq .res        @ if i==5 iteration over
b .f1           @ if i<5 again go to f1

.res:
add r1 r1 r2    @ b+c
add r1 r1 r3    @ a+b+c
.print r1       @ print a+b+c
b .exi




.g:
sub sp sp 16
st ra 12[sp]
st r1 0[sp]
st r2 4[sp]
st r3 8[sp]
mov r12 0       @ r12 stores int d of function h
call .h
mov r1 r9       @ a= h(a,b,c,0)
mov r12 1       @ d=1
call .h         
mov r2 r10      @ b= h(a,b,c,1)
mov r12 2       @ d=2
call .h
mov r3 r11      @ c= h(a,b,c,2)
add r6 r1 r2    
add r6 r6 r3    @ r6 = a+b+c  r6 is returned to f
ld ra 12[sp]
ret

.h:
cmp r12 0
beq .h1
cmp r12 1
beq .h2
cmp r12 2
beq .h3

.h1:
sub r8 r2 r3        @ r8=b-c
add r9 r1 r8        @ r9=a+b-c
ret
.h2:
sub r8 r1 r2        @ r8=a-b
add r10 r3 r8       @ r10=a-b+c
ret
.h3:
add r8 r1 r2        @ r8=a+b
add r11 r3 r8       @ r11=a+b+c
ret

.exi:
.exit:

