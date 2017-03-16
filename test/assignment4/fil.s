.main:
mov r1,10      //    for storing a
mov r2,12     // for storing b
mov r3,-1     //for storing c
mov r4,0     // for storing d

call .f      // call function f
mov r4,r0    // copying the value returned by 'f' function
.print r4    // displaying the result

b .EXIT      // after calling the function exit main function

.f:        // definition of function f
mov r5,-1

.loop:       // making the loop in function f
add r5,r5,1
cmp r5,5       // checking the breaking condition of loop
beq .end_f     // end of function f

add r1,r2,r3   //a=b+c
sub r2,r1,r3    //b=a-c

sub sp,sp,16     // storing the value of a,b,c, in stack
mov r10,sp
st r1,[r10]     // for a
add r10,r10,4
st r2,[r10]     // for b
add r10,r10,4
st r3,[r10]    // for c
add r10,r10,4
st ra,[r10]     // storing the return address

call .g         // call for function g
mov r10,sp
ld r1,[r10]      // loading back value in register ,here for a
add r10,r10,4
ld r2,[r10]         // for b
add r10,r10,4
ld r3,[r10]        // for c
add r10,r10,4
ld ra,[r10]      // retrieving return address
add sp,sp,16

add r3,r3,r0     //c=c+g(a,b,c)

b .loop         // unconditionally running the loop

.end_f:            // breaking statement of function f
add r0,r1,r2
add r0,r0,r3       //calculating the return value for function f
ret


.g:   // dfinition for function g

mov r9,0
sub sp,sp,4
st ra,[sp]    // storing the return address
call .h
mov r1,r0     // storing return value of h function to 'a'
mov r9,1
call .h
mov r2,r0
mov r9,2
call .h
mov r3,r0

ld ra,[sp]     // simalarly loading the value from stack pointer
add sp,sp,4
add r0,r1,r2
add r0,r0,r3         // g funcctin returning a+b+c
ret

.h:         // definition for function h
mov r0,0
cmp r9,0       // checking for switch case 0
beq .case0
cmp r9,1         // checking for switch case 1
beq .case1    
cmp r9,2
beq .case2     // checking for switch case 2


.case0:
add r0,r1,r2
sub r0,r0,r3    //return value for case 0
ret

.case1:
sub r0,r1,r2
add r0,r0,r3      //return value for case 1
ret

.case2:
add r0,r1,r2
add r0,r0,r3      //return value for case 2
ret

.EXIT:

     