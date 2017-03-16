    .main:
    mov r0,5
    mov r1,0x100    /*Base address of r1*/
    mov r2,0x200    /*Base address of r2*/
    mov r3,0x300    /*Base address of r3*/
    mov r4,0        /*i*/
    mov r5,0        /*j*/
    cmp r4,r0
    mov r12,0
    mov r13,r0
    mov r11,1
    b .loop
    beq .return2
.loop:              /*for loop for i*/
    cmp r4,r0
    beq .return2
    b .loop1
    .loop1:         /*for loop for j*/
        cmp r5,r0
        beq .increment
        add r6,r4,r5
        st r6,0[r1] /*Storing matrix A*/
        mul r7,r4,2
        mul r8,r5,3
        add r9,r7,r8
        st r9,0[r2] /*Storing matrix B*/
        add r1,r1,4
        add r2,r2,4
        add r5,r5,1
        cmp r5,r0
        b .loop1
        beq .increment

.increment:         /*Increment of i*/
	add r4,r4,1
	mov r5,0
	b .loop

.return2:
     mov r4,0
     mov r5,0
     mov r7,r0
     mov r8,1
     mov r1, 0x100
     mov r2, 0x200
     b .loop2

.loop2:             /*Loops for calculating matrix C*/
    cmp r4,r0
    mov r13,r0
        b .loop3
    .loop3:
        cmp r5,r0
        beq .increment1
        ld r6,0[r1]
        ld r9,0[r2]
        mul r7,r0,4
        add r2,r2,r7
        add r1,r1,4
        mul r10,r6,r9
        add r12,r12,r10
        add r5,r5,1
        sub r13,r13,1
        cmp r13,0
        add r3,r3,4
        beq .increment1
        b .loop3
        .print r13

.increment1:
    st r12,0[r3]
    .print r12
    mov r3,0x300
    add r3,r3,4
    mov r2,0x200
    mul r8,r8,4
    add r2,r2,r8
    sub r1,r1,r7
    div r8,r8,4
    add r8,r8,1
    mov r12,0
    mov r13,r0
    add r4,r4,1
    mov r5,0
    cmp r8,r0
    bgt .increment3
    b .loop2
.increment3:
    mov r8,1
    add r1,r1,r7
    mov r2,0x200
    add r11,r11,1
    cmp r11,r0
    bgt .exit
    b .loop2
//.loop4:             /*Loops for printing matrix C*/
//    cmp r4,r0
//    beq .exit
//    b .loop5
//    .loop5:
//        cmp r5,r0
//        beq .increment2
//        ld r12,0[r3]
//        add r3,r3,4
//        .print r12
//        add r5,r5,1
//        cmp r5,r0
//        b .loop5
//        beq .increment2
//
//.increment2:
//    add r4,r4,1
//    mov r5,0
//    b .loop4



.return1:
     mov r4,0
     mov r5,0
     mov r1, 0x100
     mov r2, 0x200
     mov r3, 0x300
     b .loop4

.exit: