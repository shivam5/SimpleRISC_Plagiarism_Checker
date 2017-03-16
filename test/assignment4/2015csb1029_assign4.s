@............................LAB4.....................................
@...............f..............................
.f:
mov r5,0            @function f starts here
mov r12,5    @r5 is the counter of loop

.loop:     @loop present in function f
sub sp,sp,24
add r0,r1,r2
sub r1,r0,r2
st r0,[sp]
st,r1,4[sp]
st,r2,8[sp]
call .g               @call of function g
.ext:
ld r0,[sp]    @use of stack pointer
ld r1,4[sp]
ld r2,8[sp]
add r2,r2,r10    @ r10=call from function g
add r5,r5,1
cmp r12,r5       @comparison to continue the loop or not
bgt .loop
.loopout:
add r3,r0,r1    @r3 gets the final result
add r3,r3,r2
b .prnt     @takes to the printing statement

@ ..................g starts...............................
.g: 
mov r9,0      @r9 is used to store the value of constant to be called in h
call .h      @call of function h
mov r0,r6    
add r9,r9,1              @value from h comes in r6
call .h
mov r1,r6
add r9,r9,1    
call .h
mov r2,r6    @this staement is for the last stament of where funcion g is called
add r10,r0,r1
add r10,r10,r2
b .ext

@.................. h starts.............................
.h:
cmp r9,0
bgt .next1
.switch1:     @case 1 of function h
add r6,r0,r1
sub r6,r6,r2
ret
.next1:
cmp r9,1
bgt .next2
.switch2:     @case 2 of function h
sub r6,r0,r1
add r6,r6,r2
ret
.next2:
cmp r9,2
bgt .next3
switch3:      @case 3 of function h
add r6,r0,r1
add r6,r6,r2
ret
.next3:
ret

@........................main.................................. 
.main:
mov r0,10   @value of a
mov r1,12  @value of b
mov r2,-1    @value of c
call .f     @call of function h
.prnt:
.print r3   @ r3=d
.quit: