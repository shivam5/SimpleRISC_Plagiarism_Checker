@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

                                              @@ CSL 211 @@
                                           @@ ASSIGNMENT-4 @@

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

.f:                   @'f' function

   st ra,[sp]         @return address is stored in stack
   mov r4,0
   .loop:
   cmp r4,5
     beq .exf
   add r1,r2,r3
   sub r2,r1,r3
   st r1,4[sp]
   st r2,8[sp]
   st r3,12[sp]
   add sp,sp,16
   call .g
   sub sp,sp,16
   ld r1,4[sp]
   ld r2,8[sp]
   ld r3,12[sp]
   add r3,r3,r0
   add r4 r4,1
   b .loop

 .exf: add r0,r1,r2
      add r0,r0,r3
      ld ra,[sp]
      ret


.g:                     @'g' functiom
            
   st ra,[sp]
   mov r5,0
    call .h
    mov r1,r0
   mov r5,1
    call .h
    mov r2,r0
   mov r5,2
    call .h
    mov r3,r0

   add r0,r1,r2
   add r0,r0,r3
   ld ra,[sp]           @return address is loaded from memory
   ret


.h:                     @'h' function 
                        @switch
   cmp r5,0
    beq .h0
   cmp r5,1
    beq .h1
   cmp r5,2
    beq .h2
   b .default

    .h0:
      add r0,r1,r2
      sub r0,r0,r3
      ret 

    .h1:
      sub r0,r1,r2
      add r0,r0,r3
      ret

    .h2:
      add r0,r1,r2
      add r0,r0,r3
      ret

    .default:
      mov r0,0
      ret
  


 .main:                  @main function

   mov r1,10
   mov r2,-12
   mov r3,-1

   st r1,[sp]            @activation block(AB)
   st r2,4[sp]
   add sp,sp,12          @sp points to next AB
   call .f
   .print r0


  