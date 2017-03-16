.main:
    mov r0,3                 //size of matrix in r0   
    mov r1,0x100             //base address of matrix A
    mov r2,0x200             //base address of matrix B
    mov r3,0x300             //base address of matrix C
.start:
    mov r4,0           //i index
    mov r5,0          //j index
    sub r8,r0,1
  //storing the matrix A

.outer_loop:                //Outer Loop                
           cmp r0,r4
           beq .nextloop
    .inner_loop:            //Inner Loop
            mul r6,r4,r0
            add r6,r6,r5
            mul r6,r6,4
            add r6,r6,r1
            add r7,r4,r5
            st r7,[r6]
            cmp r8,r5
            bgt .increase
            beq .equal
.increase:
         add r5,r5,1
         b .inner_loop
.equal:
      add r4,r4,1
      mov r5,0 
      b .outer_loop

//storing the matrix B

.nextloop:          
    mov r4,0
    mov r5,0
.loop1:                 //Outer Loop
    cmp r0,r4
    beq .next
    .loop2:             //Inner Loop
        mul r6,r4,r0
        add r6,r6,r5
        mul r6,r6,4
        mul r7,r4,2             //Calculating 2i
        mul r9,r5,3             //Calculating 3j
        add r10,r7,r9           //Adding 2i and 3j
        add r6,r6,r2     
        st r10,[r6]             //Storing 2i+3j
        cmp r8,r5
        bgt .inc
        beq .equ
.inc:
     add r5,r5,1
     b .loop2   
.equ:
     add r4,r4,1
     mov r5,0
     b .loop1
.next:                 //storing the matrix C  
    mov r4,0
    mov r5,0
    mov r6,0
.floop1:                        //Outer loop
        cmp r0,r4
        beq .return
        .floop2:                //Inner Loop
          cmp r0,r5
          mov r11,0             //Register to store the sum
          beq .return2
          .floop3:              //Innermost Loop
            mul r7,r4,r0
            add r7,r7,r6
            mul r7,r7,4
            add r7,r7,r1    
            ld  r9,[r7]     //Loading element from matrix A
            mul r7,r6,r0
            add r7,r7,r5
            mul r7,r7,4
            add r7,r7,r2                
            ld r10,[r7]     //Loading element from matrix B
            mul r12,r9,r10  //Multiplying the respective elements of matrices A and B
            add r11,r11,r12 // Adding the products of respective elements    
            cmp r8,r6
            bgt .plus
            beq .equals
.plus:
    add r6,r6,1
    b .floop3
.equals:
    mul r7,r4,r0
    add r7,r7,r5
    mul r7,r7,4
    add r7,r7,r3
    st r11,[r7]         //Storig the elements of matrix C
    add r5,r5,1
    mov r6,0
    b .floop2
.return2:
    add r4,r4,1
    mov r5,0 
    b .floop1   
.return:                // Printing the matrix C 
    mov r4,0
    mov r5,0
.finalloop1:
    cmp r0,r4
    beq .bahar
.finalloop2:
    mul r7,r4,r0
    add r7,r7,r5
    mul r7,r7,4
    add r7,r7,r3
    ld r10,[r7]
    .print r10 
    cmp r8,r5
    bgt .plusplus
    beq .barabar
.plusplus:
    add r5,r5,1
    b .finalloop2
.barabar:
    add r4,r4,1
    mov r5,0
    b .finalloop1
.bahar:
