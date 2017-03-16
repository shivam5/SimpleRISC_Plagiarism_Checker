 .main:
mov r0,10
mov r1,12
mov r2,-1
b .f                       /* calling f function */



.f:                             /* f(a,b,c) */
    mov r5,0
   .loop:                       /*  loop  */

      cmp r5,5                  /* loop exiting criteria */
      beq .exit1
      add r0,r1,r2
      sub r1,r0,r2
      mov r10,r0
     mov  r11,r1
     mov r12,r2
      b .g                    /* calling g function */
    .ka:                     
      add r2,r2,r13
      add r5,r5,1             /* Incrementing the loop variable */
      b .loop
  .exit1:                     
        add r15,r0,r1
        add r15,r15,r2
       b .exit               /*  going to the end of the program */

  .g:                        /* g(a,b,c)*/
     mov r8,0 
     mov r6,0
      b .h
     .ka1:                   
      mov r10,r14
     mov r6,1
      add r8,r8,1
      b .h
     .ka2:
      mov r11,r14
     mov r6,2
    add r8,r8,1
      b .h
     .ka3:
      mov r12,r14
    add r13,r10,r11
     add r13,r13,r12
     b .ka
 .h:
    cmp r6,0
    beq  .h1
      cmp r6,1
    beq  .h2
     cmp r6,2
    beq  .h3 
    b .leftout
 .h1:

   add r14,r10,r11
   sub r14,r14,r12
    cmp r8,0
    beq .ka1
   cmp r8,1
    beq .ka2
   cmp r8,2
    beq .ka3
.h2:

   sub r14,r10,r11
   add r14,r14,r12
    cmp r8,0
    beq .ka1
   cmp r8,1
    beq .ka2
   cmp r8,2
    beq .ka3
.h3:
    

   add r14,r10,r11
   add r14,r14,r12
    cmp r8,0
    beq .ka1
   cmp r8,1
    beq .ka2
   cmp r8,2
    beq .ka3 
     

.exit:
print r15














 

 