 .f:
mov r4,0
st ra,0[r10]   //store the return value in r10
.loop:        //for loop 
cmp r4,5
beq .end
add r0,r1,r2
sub r1,r0,r2

call .g     // call to get r6=g(a,b,c)
add r2,r2,r6
add r4,r4,1
b .loop

.end:
add r5,r0,r1
add r5,r5,r2
ld ra,0[r10]  //load the first return value in r10
ret

.g:

st ra,0[r3]   //store the return value in r3
mov r8,0
call .h       //call to get r7=h(a,b,c,0)
mov r6,r7

mov r8,1
call .h      //call to get r7=h(a,b,c,1)

add r6,r6,r7

mov r8,2
call .h       //call to get r7=h(a,b,c,2)
add r6,r6,r7
ld ra,0[r3]    //load the return value in r3

ret

.h:
cmp r8,0
beq .h0
cmp r8,1
beq .h1
cmp r8,2
beq .h2
b .end2

.h0:
add r7,r0,r1
sub r7,r7,r2
ret
.h1:

sub r7,r6,r1
add r7,r7,r2
ret
.h2:
add r7,r6,r2
ret
.end2:
mov r7,0
ret

.main:
mov r0,10         //r0=a
mov r1,12        //r1=b
mov r2,-1        //r2=c
mov r3,0x100     //register to store ra values
mov r10,0x200   //register to store ra values
call .f         //call to get r5=f(a,b,c)
.print r5

