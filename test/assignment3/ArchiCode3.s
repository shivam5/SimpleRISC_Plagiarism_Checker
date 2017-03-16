  .main:                                    //main goes here
         mov r0,3                   
         mov r2,0x100                       //defining initial memory adresses
         mov r3,0x200
         mov r4,0x300
         mov r5,0                           //i
         mov r10,0
         
   .loop1: cmp r5,r0                        //input of matrix 1
           beq .mem
           mov r6,0
           .loop2: cmp r6,r0                //loop1 taking i+j as input
                   beq .t
                   add r8,r5,r6
                   add r9,r2,r10
                   st r8,[r9]
                   add r6,r6,1
                   add r10,r10,4 
                   b .loop2
           .t:
              add r5,r5,1
        b .loop1

       .mem: mov r5,0
        mov r10,0

.loop3: cmp r5,r0                                 //input matrix 2
           beq .goodloop
           mov r6,0
           .loop4: cmp r6,r0
                   beq .q
                   mul r11,r5,2
                   mul r12,r6,3
                   add r13,r11,r12
                   add r9,r3,r10
                   st r13,[r9]
                   add r6,r6,1
                   add r10,r10,4 
                   b .loop4
           .q:
              add r5,r5,1
        b .loop3

.goodloop:                                  //the loop for matrix multiplication
     
         mov r5,0                               //i
         mov r6,0                               //mem
    .l1: 
         cmp r5,r0
         beq .out			
         mov r7,0                               //j
         .l2: 
              cmp r7,r0
              beq .n
              mov r8,0                          //k
              mov r14,0                         //temp sum
            .l3: cmp r8,r0
                 beq .m
                   mul r9,r0,r5
                   add r9,r9,r8
                   mul r9,r9,4
                   add r9,r9,r2                 //a ready
                   //.print r9
                   ld r10,[r9]                  //a ready
                  //.print r10
                   mul r11,r8,r0
                   add r11,r11,r7
                   mul r11,r11,4
                   add r11,r11,r3                //b ready
                   //.print r11
                   ld r12,[r11]                  //b ready
                   //.print r12
                   mul r13,r10,r12
                   add r14,r14,r13               //r14 final useful value to be stored
                   //.print r14
                   add r8,r8,1
             b .l3
                   //.print r14
               .m: mul r9,r5,r0
                   add r9,r9,r7
                   mul r9,r9,4
                   add r9,r9,r4
                    //.print r5
                    //.print r7
                   //.print r9
                   st r14,[r9]
                   add r7,r7,1
                   add r6,r6,4
                   b .l2
             .n:  
                     add r5,r5,1
                    // add r1,r1,1
                  
             b .l1

.out:
      mov r5,0                                 //i
      mul r6,r0,r0
//.print r6                                
      mul r7,r6,4                            
     //.print r7
      .final:                                  //printing the final matrix
              cmp r5,r7
              beq .exit
              add r8,r5,r4

              ld r9,[r8]
              .print r9
              add r5,r5,4
              b .final
    .exit:                                    //END OF PROGRAM

     

    