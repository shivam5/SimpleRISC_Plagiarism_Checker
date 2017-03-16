 .main:
mov r10,0
mov r0,10
mov r1,12
mov r2,-1
call .f
.frtn:
mov r4,r3
.print r4
b .exit
 .f:  
  .loopf:
   mov r7,0
   add r0,r1,r2
   sub r1,r0,r2
   sub sp,sp,12
   st r0,[sp]
   st r1,4[sp]
   st r2,8[sp]
   st ra,12[sp]
   call .g 
   .rtng:
   ld r0,[sp]
   ld r1,4[sp]
   ld r2,8[sp]
   ld ra,12[sp]
   add sp,sp,12
   add r2,r2,r5
   add r10,r10,1
   cmp r10,5
   beq .exitlf
   b .loopf
  .exitlf:
   add r3,r1,r0
   add r3,r3,r2
b .frtn
 .g: 
   call .h
   mov r0,r6
   call .h 
   mov r1,r6
   call .h
   mov r2,r6
   add r5,r1,r0
   add r5,r5,r2
 b .rtng
.h: 
  cmp r7,0
  bgt .nxt1
  .case1:     
    add r6,r1,r0
    sub r6,r6,r2
    add r7,r7,1
  ret
  .nxt1:
  cmp r7,1
  bgt .nxt2
  .case2:
    sub r6,r0,r1
    add r6,r6,r2
    add r7,r7,1
   ret
  .nxt2:
  cmp r7,2
  bgt .nxt3 
  .case3:
   add r6,r0,r1
   add r6,r6,r2
   add r7,r7,1
  ret 
  .nxt3:
  ret
.exit: