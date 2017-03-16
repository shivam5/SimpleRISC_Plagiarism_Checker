 .func3:			@ comparing with values  of d
	cmp r7,0		@ dat is switch case
	beq .case1
	cmp r7,1
	beq .case2
	cmp r7,2
	beq .case3
	ret
		
	
.case1:	  		
	add r3,r3,r4	@ a+b-c
	sub r3,r3,r5
	ret

.case2:		  
	sub r4,r3,r4	@ a-b+c
	add r4,r4,r5
	ret
.case3:	
	add r5,r5,r4	@ a+b+c
	add r5,r5,r3
	ret

.func2:	add sp,sp,20	@ size of func1 is 16
	st ra,[sp]	
	mov r7,0		@ value of d	
	mov r3,r0		@ a,b,c accessed from func 1
	mov r4,r1		
	mov r5,r2	
	call .func3	@ func3 changes value of a		
	mov r7,1		@ d incremented
	call .func3	@ func3 changes value of b
	mov r7,2		
	call .func3	@ func3 changes value of c
	add r3,r3,r4	@ a+b+c
	add r3,r3,r5	
	ld ra,[sp]
	sub sp,sp,20	
	st r3,16[sp]	@ ans of func2 stored in 16[sp]
	ret

.func1:		
	st ra,[sp]		@ ra of func1
	mov r6,0			
	st r0,4[sp]	@ values of a,b,c stored in memory	
	st r1,8[sp]			
	st r2,12[sp]	
	b .loop

.loop:	cmp r6,5		@ i
	beq .return
	ld r0,4[sp]	@ values of a,b,c accessed
	ld r1,8[sp]	
	ld r2,12[sp]	
	add r0,r1,r2	@ a=b+c
	sub r1,r0,r2	@ b=a-c
	st r0,4[sp]	@ new values of a,b,c stored in memory
	st r1,8[sp]
	st r2,12[sp]
	call .func2	
	ld r7,16[sp]	@ func2 returns value in 16[sp]
	add r2,r2,r7	@ c=c+func2
	st r2,12[sp]  	
	add r6,r6,1	
	b .loop

.return:	mov r8,r0		@ called after end of loop
	add r8,r8,r1	
	add r8,r8,r2	@ a+b+c
	ld ra,[sp]
	ret

.main:	
	mov r0,10  	@ a of main 	
	mov r1,12   	@ b 		
	mov r2,-1   	@ c
	call .func1
	.print r8	