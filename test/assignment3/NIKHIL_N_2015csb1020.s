  .main:
  mov r2,0x100
  mov r1,0x200
  mov r3,0x300
  mov r7,0
  mov r8,0
  mov r0,4
.loop1:
  
   cmp r7,r0
    bgt .next
     beq .next
     mov r8,0
 .loop2:
    cmp r8,r0
    beq .addq
     bgt .addq
    mul r9,r7,r0
    add r10,r8,r9
    mul r10,r10,4
    add r10,r2,r10
    
    add r9,r7,1
    add r6,r8,1    
    add r5,r9,r6
    st  r5,[r10] 
    mul r9,r7,r0
    add r10,r8,r9
    mul r10,r10,4
    add r10,r1,r10
    
    add r9,r7,1
    add r6,r8,1 
     mul r9,r9,2
     mul r6,r6,3   
    add r5,r9,r6
    st  r5,[r10]    
   add r8,r8,1
   b .loop2
 .addq:
    add r7,r7,1
   b .loop1
.next:
  
  mov r7,0
  mov r8,0
   mov r5,0
.lloop1:
      cmp r7,r0
      beq .exit
      bgt .exit
     mov r8,0
   .lloop2:
    
     cmp r8,r0
     beq .addp
     bgt .addp
     mul r9,r7,r0
     add r10,r8,r9
     mul r10,r10,4
     add r11,r3,r10
     mov r4,0
 mov r5,0
   .lloop3:
      cmp r5,r0
     bgt .addr
     beq .addr
     mul r9,r7,r0
     add r9,r9,r5
     mul r9,r9,4
     add r9,r9,r2
     ld  r12,[r9]
     mul r9,r5,r0
     add r9,r9,r8
     
     
     
     mul r9,r9,4
     add r9,r9,r1
     ld  r13,[r9]
     mul r13,r12,r13
    add r4,r4,r13
   add r5,r5,1
   b .lloop3
  .addr:
     st r4,[r11]
    add r8,r8,1
     b .lloop2
  .addp:
     add r7,r7,1
     b .lloop1
  .exit:
     mov r9,0
     mul r8,r0,r0
     sub r8,r8,1
     mul r8,r8,4
    .lloop4:

      cmp r9,r8
     bgt .exit1
   
     add r7,r3,r9
     ld r12 ,[r7]
     print r12
      
     
     add r9,r9,4
    b .lloop4
  .exit1:
 
