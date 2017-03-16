 @ a=r0,b=r1,c=r2,d=r3,i=r4,result=r5

.main:
mov r0,513
mov r1,5
mov r2,113
call .f  @Calling the f function
b .end   @Ending of the code where printing is done



@ the f function
.f:
mov r11,r15   @Storing address in r11
mov r4,0  @i=0
.c:
add r0,r1,r2  @a=b+c
sub r1,r0,r2   @b=a-c
@Copying the values of a,b,c in temporary registers because r0,r1,r2 will get changed
mov r8,r0
mov r9,r1
mov r10,r2
call .g      @Calling the g function
@Copying the values of a,b  
mov r0,r8
mov r1,r9
@Implementing c=c+g(a,b,c)
add r2,r10,r6
@Implementing d= return a+b+c
add r3,r0,r1
add r3,r3,r2
@i++
add r4,r4,1
cmp r4,5  
mov r15,r11 @Retrieving address from r11
beq .ex
b .c @Loop continues

.ex:
ret

@ the g function
.g:
mov r12,r15 @ Copy the address in r12
mov r3,0
call .h
mov r0,r5

mov r3,1
call .h
mov r1,r5

mov r3,2
call .h
mov r2,r5 

add r6,r0,r1
add r6,r6,r2  @The result returned from this function is r6
mov r15,r12  @Retrieving the address from r12
ret

@ the h function 
.h:
mov r5,0
cmp r3,0
beq .x
cmp r3,1
beq .y
cmp r3,2
beq .z
ret    @The value gets directly returned to g function

.x:
add r5,r0,r1
sub r5,r5,r2
ret    @The value gets directly returned to g function

.y:
sub r5,r0,r1
add r5,r5,r2
ret    @The value gets directly returned to g function

.z:
add r5,r0,r1
add r5,r5,r2
ret    @The value gets directly returned to g function

.end:
.print r3   @ Calculate the value of r3
