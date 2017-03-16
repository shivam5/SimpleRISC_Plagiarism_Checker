 .main:
    mov r0,3
    mov r1,0
    cmp r1,r0
    bgt .exit
    beq .exit
    mov r1,0x100
    mov r2,0x200
    mov r3,0x300
    mov r4,0
    mov r5,0
    b .nested_assign_loop    
    
    .assign_loop:
        mov r5,0        
        add r4,r4,1        
        cmp r4,r0
        bgt .multiply
	beq .multiply
        b .nested_assign_loop        
    
    .nested_assign_loop:       
        cmp r5,r0
        beq .assign_loop
        bgt .assign_loop
        mul r6,r0,r4
        add r6,r6,r5
        mul r6,r6,4
        add r7,r1,r6
        add r8,r2,r6    
        add r9,r4,r5
        mul r10,r4,2
        mul r11,r5,3
        add r11,r10,r11
        st r9,0[r7]
        st r11,0[r8]
        add r5,r5,1
        b .nested_assign_loop
    
    .multiply:
	mov r4,0
	mov r5,0
	mov r6,0
	mov r7,0
	b .nested_nested_C
	
	.loop_C:
		mov r5,0
		mov r6,0
		add r4,r4,1
		cmp r4,r0
		bgt .p_array_C
		beq .p_array_C
		b .nested_nested_C
	
	.nested_C:
		mul r8,r0,r4
		add r8,r8,r5
		mul r8,r8,4
		add r9,r3,r8
		st r7,0[r9]
		mov r6,0
		mov r7,0
		add r5,r5,1
		cmp r5,r0
		beq .loop_C
		bgt .loop_C
		b .nested_nested_C
	
	.nested_nested_C:
		cmp r6,r0
		beq .nested_C
		bgt .nested_C
		mul r8,r0,r4
		add r8,r8,r6
		mul r8,r8,4
		add r9,r1,r8
		ld r10,0[r9]
		mul r8,r0,r6
		add r8,r8,r5
		mul r8,r8,4
		add r9,r2,r8
		ld r11,0[r9]
		mul r11,r10,r11
		add r7,r7,r11
		add r6,r6,1
		b .nested_nested_C		
			
    .p_array_C:
        mov r4,0
        mov r5,0
        b .p_nested_C
    
        .p_loop_C:
            mov r5,0            
            add r4,r4,1        
            cmp r4,r0
            bgt .exit
            beq .exit
            b .p_nested_C        
    
        .p_nested_C:
            cmp r5,r0
            beq .p_loop_C
            bgt .p_loop_C
            mul r6,r0,r4
            add r6,r6,r5
            mul r6,r6,4
            add r7,r3,r6
            ld r9,0[r7]
            .print r9
            add r5,r5,1
            b .p_nested_C
    
    .exit: