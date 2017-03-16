.main:
	mov r0,10    @r0 is a
	mov r1,12     @ r1 is b
	mov r2,-1	  @ r2 is c
          mov r4,0     
          call .f
	.print r4   @printing the value of d
	b .exit
.f:              @function f
st ra,[sp]       @storing the return address for the call to f function in stack pointer
mov r3,0         @r3 is 'i'
mov r6,5         @r6 is the max value of 'i'
b .loop 
.loop:           @loop in the first function
add r0,r1,r2
sub r1,r0,r2
st r0,4[sp]       @storing the a,b,c values to stack before calling the next function
st r1,8[sp]
st r2,12[sp]
call .g
ld r0,4[sp]     
ld r1,8[sp]
ld r2,12[sp]
add r2,r2,r4
add r3,r3,1
cmp r6,r3
bgt .loop
add r4,r1,r2     
add r4,r4,r0  @value to be returned to main is again stored in r4
ld ra,[sp]   @loading the return address to return to main function
ret

.g:          @function g
sub sp,sp,4  @creating new block by subtracting from sp
st ra,[sp]   @storing return address for previous call
mov r4,0
call .h
mov r0,r5
mov r4,1
call .h
mov r1,r5
mov r4,2
call .h
mov r2,r5
add r4,r0,r1
add r4,r4,r2 @r4 is the value to be returned to f function
ld ra,[sp]   @loading the return address into ra registor to return to f function
add sp,sp,4  @block deleted before returning
ret

.h:       @function h
cmp r4,1
beq .case1
cmp r4,2
beq .case2
cmp r4,0
beq .case0
mov r5,0   @r5 is the value to be returned to g function(default set to 0)
ret
.case0:
  add r5,r0,r1
  sub r5,r5,r2    @r5 is a+b-c
  b .break
.case1:
  add r5,r0,r2
  sub r5,r5,r1    @r5 is a-b+c
  b .break
.case2:
  add r5,r0,r1
  add r5,r5,r2  @here r5 is a+b+c
.break:
 ret

.exit: