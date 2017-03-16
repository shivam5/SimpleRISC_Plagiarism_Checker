.f:
cmp r5,5               //for loop
beq .returnf           //return for function f

.loop:                
add r1,r2,r3         //a=b-c
sub r2,r1,r3         //b=a-c
sub sp,sp,4          // call g to calcuate c
st ra,0[sp]
call .g
ld ra,0[sp]
add sp,sp,4
add r3,r3,r0
add r5,r5,1
b .f


.g:
mov r4,0              //to calculate a r0 i.e. should be zero
sub sp,sp,4           
st ra,0[sp]
call .h              //call h and calculate a+b-c
ld ra,0[sp]
add sp,sp,4
mov r9,r0           //stores a=a+b-c
mov r4,1
sub sp,sp,4
st ra,0[sp]
call .h
ld ra,0[sp]
add sp,sp,4
mov r10,r0      //stores a=a-b+c where a is the modified above
mov r4,2
sub sp,sp,4
st ra,0[sp]
call .h
ld ra,0[sp]
add sp,sp,4
mov r11,r0     //stores a=a+b+c where a and c is the modified above
b .returng

.h:                      // switch cases
cmp r4,0
beq .return0             //calculate  a+b-c
cmp r4,1
beq .return1            // calculate a-b+c
cmp r4,2
beq .return2           // calculate a+b+c

.return0:
add r0,r1,r2
sub r0,r0,r3
ret

.return1:
sub r0,r9,r2
add r0,r0,r3
ret
.return2:
add r0,r9,r10
add r0,r0,r3
ret

.returng:           //a+b+c
add r0,r9,r10      
add r0,r0,r11
ret

.returnf:
add r0,r1,r2
add r0,r0,r3        //a+b+c
ret


.main:
mov r1,10          //a
mov r2,12          //b
mov r3,-1          //c
mov r5,0            //i
call .f            //call f 
mov r4,r0          //r0 is the output that is d 
.print r4          //print 
