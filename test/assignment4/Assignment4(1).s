.f:
    // Storing Return Address
    sub sp,sp,4
    st ra,0[sp]

    mov r4,0 // i=0
    .loop:
	add r0,r1,r2 // a = b+c
	sub r1,r0,r2 // b = a-c
	call .g // Store Result of g in r5
	// Loading the Values of a,b,c
	ld r0,0[sp]
	ld r1,4[sp]
	ld r2,8[sp]
	add sp,sp,12

	add r2,r2,r5 // c = c+g(a,b,c)
	add r4,r4,1 // i++
	cmp r4,5 // Check if i<5
	// If i>=5 then return 
	// Else go back to loop
	beq .ret 
	bgt .ret
	b .loop

.ret:
    // Get the first Return Address
    ld ra,0[sp]
    add sp,sp,4
    
    add r3,r0,r1 // d = a+b+c
    add r3,r3,r2

    ret

.g:
    // Storing All useful Values in Stack
    sub sp,sp,16
    st ra,0[sp]
    st r0,4[sp]
    st r1,8[sp]
    st r2,12[sp]

    mov r6,0
    call .h // Store Result for h(a,b,c,0) in r7
    mov r0,r7 // a = h(a,b,c,0)
    mov r6,1
    call .h // Store Result for h(a,b,c,0) in r7
    mov r1,r7 // b = h(a,b,c,1)
    mov r6,2
    call .h // Store Result for h(a,b,c,0) in r7
    mov r2,r7 // c = h(a,b,c,2)
    
    // Returning a+b+c
    add r5,r0,r1
    add r5,r5,r2
    ld ra,0[sp]
    add sp,sp,4
    ret

.h:

    cmp r6,0  // case 0:
    beq .ret_0 // Return a+b-c
    cmp r6,1 // case 1:
    beq .ret_1 // Return a-b+c
    cmp r6,2 // case 2:
    beq .ret_2 // Return a+b+c
    
.ret_0:
    add r7,r0,r1
    sub r7,r7,r2
    ret

.ret_1:
    sub r7,r0,r1
    add r7,r7,r2
    ret

.ret_2:
    add r7,r0,r1
    add r7,r7,r2
    ret

.main:
    // assigning a=10, b=12, c=-1
    mov r0,10
    mov r1,12
    mov r2,-1
    
    call .f // calling function f
    .print r3 // displaying output