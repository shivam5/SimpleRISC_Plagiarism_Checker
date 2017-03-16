.loopfr:
	add r3,r3,r14
	add r0,r0,1
.loopf:
	cmp r0,5
	beq .exit
	add r1,r2,r3
	sub r2,r1,r3
	mov r4,r1
	mov r5,r2
	mov r6,r3

.loopg:
	mov r12,0
	call .looph
	mov r12,1
	call .looph
	mov r12,2
	call .looph
	add r14,r4,r5
	add r14,r14,r6
          b .loopfr
.looph:
	cmp r12,0
	beq .looph1
	cmp r12,1
	beq .looph2
	cmp r12,2
	beq .looph3
	ret
.looph1:
	add r4,r4,r5
	sub r4,r4,r6
	ret
.looph2:
	sub r5,r4,r5
	add r5,r5,r6
	ret
.looph3:
	add r13,r4,r5
	add r6,r13,r6
	ret

 .main:
	mov r1,25
	mov r2,-12
	mov r3,-10
	mov r0,0
	call .loopf
.exit:
	add r1,r1,r2
	add r1,r1,r3
	.print r1