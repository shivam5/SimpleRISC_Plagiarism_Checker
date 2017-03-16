 .main:

mov r0,10     //a=10;
mov r1,12     //b=12
mov r2,-1     //c=-1
mov r4,0     
sub sp,sp,16
st r0,[sp]      //r0,r1,r2 are going to change so storing them
st r1,4[sp]
st r2,8[sp]
st r15,12[sp]
call .f       //d=f(a,b,c)


.f :
mov r5,1
.foo:
add r0,r1,r2      //a=b+c;
sub r1,r0,r2      //b=a-c;
sub sp,sp,16    //creating stack and storing a,b,c
st r0,[sp]
st r1,4[sp]
st r2,8[sp]
st r15,12[sp]      //storing return address
call .g       //calling g function
ld r0,[sp]    //loading back those values from stack pointer
ld r1,4[sp]
ld r2,8[sp]
ld r15,12[sp]
add sp,sp,16        //discarding stack pointer
add r2,r2,r9        //c=c+g(a,b,c)
cmp r5,5
add r5,r5,1
beq .break
b .foo
.break:
add r4,r0,r1
add r4,r4,r2       //storing a+b+c in r4
call .outofprogram  

.g:
mov r3,0         //4th value of h function
sub sp,sp,16    //creating stack pointer
st r0,[sp]
st r1,4[sp]
st r2,8[sp]
st r15,12[sp]
call .h       //calling h function
ld r0,[sp]
ld r1,4[sp]
ld r2,8[sp]
ld r15,12[sp]
add sp,sp,16
mov r0,r13       //a=h(a,b,c) r13 is return value of h
mov r3,1
sub sp,sp,16   
st r0,[sp]
st r1,4[sp]
st r2,8[sp]
st r15,12[sp]
call .h         //again calling h with fourth value 1
ld r0,[sp]
ld r1,4[sp]
ld r2,8[sp]
ld r15,12[sp]
add sp,sp,16
mov r1,r13

mov r3,2
sub sp,sp,16
st r0,[sp]
st r1,4[sp]
st r2,8[sp]
st r15,12[sp]
call .h         //calling h with fourth value 2
ld r0,[sp]
ld r1,4[sp]
ld r2,8[sp]
ld r15,12[sp]
add sp,sp,16

mov r2,r13
add r9,r0,r1
add r9,r9,r2          //r9=a+b+c; r9 is return value
ret

.h:
cmp r3,0            //constructing switch structure with if statement
beq .i
cmp r3,1
beq .j
cmp r3,2
beq .k
b .l
.i:            //i for case 0
add r13,r0,r1
sub r13,r13,r2
ret 
.j:           //j for case 1
add r13,r0,r2
sub r13,r13,r1
ret
.k:            //k for case 2
add r13,r0,r1
add r13,r13,r2
ret
.l:
mov r13,0
ret

.outofprogram:
.print r4         //printing value