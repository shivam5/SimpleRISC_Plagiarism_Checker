//MAIN GOES HERE// 

.main:
        mov r0,10   //a
        mov r1,12   //b
        mov r2,-1   //c
        call .f     //calling the function f
        b .exit

.f:                 // f function
   mov r3,0   //i=0
   st ra,[sp]       //storing the value of the retuen adress
  .loop1:
        cmp r3,5
        beq .l
        bgt .l
        add r0,r1,r2  //a=b+c
        sub r1,r0,r2  //b=a-c
       // mov r4,r0       //copy of the variable a
       //  mov r5,r1     //copy of the variable b
        call .g       // g is called here
        add r2,r2,r10
        add r3,r3,1
        b .loop1
   .l:  add r11,r0,r1
        add r11,r11,r2
        ld ra,[sp]     // loading the return adress to return to the main again
        ret
         

.g:
   //performing required operations
   add r7,r0,r1
   sub r7,r7,r2   //a

   sub r8,r7,r1
   add r8,r8,r2   //b

   add r9,r7,r8
   add r9,r9,r2   //c

   add r10,r7,r8
   add r10,r10,r9  //return value of the function

   ret     //take back to function f
   
.exit:
      .print r11   //PRINTING THE RESULT
   