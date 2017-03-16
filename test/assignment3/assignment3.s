////////filling in values of matrix A ;
mov r0,5
mov r11,r0 
mov r12,r0
mul r12,r12,4
sub r0,r0,1
mov r1,0
mov r4,0x100
.loopi:
mov r2,0
 .loopj:
  mov r3,0
  add r3,r1,r2
  st r3,[r4]
  add r4,r4,4
  cmp r0,r2
  beq .exitj
  add r2,r2,1
 b .loopj
 .exitj:
 cmp r0,r1
 beq .exiti
add r1,r1,1
b .loopi
.exiti:
////////filling in values of matrix B;
mov r1,0
mov r4,0x200
.loopib:
 mov r2,0
 .loopjb:
   mov r3,0
   mul r5,r1,2
   mul r6,r2,3
   add r3,r6,r5
   st r3,[r4]
   add r4,r4,4
   cmp r0,r2
   beq .exitjb
   add r2,r2,1
   b .loopjb
 .exitjb:
  cmp r0,r1
  beq .exitib
 add r1,r1,1
b .loopib
.exitib:
//// ///////filling in values of  C=AxB  ;
mov r1,0x100
mov r10,0x300
mov r13,0
.loopic: 
mov r11,0x200
  mov r2,0 
  .loopjc:
      mov r6,0
      mov r4,r1
      mov r5,r11
      mov r3,0
     .loopin:
      ld r7,[r4]
      ld r8,[r5]
      mul r9,r7,r8
      add r6,r6,r9
      cmp r3,r0
      beq .exitin
      add r4,r4,4
      add r5,r5,r12
      add r3,r3,1
      b .loopin
     .exitin:
    st r6,[r10]
    add r10,r10,4
    cmp r0,r2
    beq .exitjc
   add r2,r2,1
   add r11,r11,4
  b .loopjc
.exitjc:
 cmp r13,r0
beq .exitic
add r13,r13,1
add r1,r1,r12
b .loopic
.exitic:
///////////for displaying C
  mov r2,0
  add r0,r0,1
  mul r0,r0,r0
  sub r0,r0,1
.prntlp:
  mov r1,0x300
  mov r3,r2
  mul r3,r3,4
  add r1,r1,r3
  ld r4,[r1]
  .print r4
  cmp r0,r2
  beq .exitp
  add r2,r2,1
  b .prntlp
.exitp:
      

    












    






