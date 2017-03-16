.h:
	//a is stored in R0, b in r1, c in r2, d in r3
	CMP r3, 0
	BEQ .return_1
	CMP r3, 1
	BEQ .return_2
	CMP r3, 2
	BEQ .return_3
	
	MOV r3, 0	//recycling r3
	ret

	.return_1:
		ADD r3, r0, r1
		SUB r3, r3, r2
		ret
	.return_2:
		SUB r3, r0, r1
		ADD r3, r3, r2
		ret
	.return_3:
		ADD r3, r0, r1
		ADD r3, r3, r2
		ret
.g:
	//a is stored in r0, b in r1 and c in r2
	SUB sp, sp, 16
	ST ra, 0[sp]
	ST r0, 4[sp]
	ST r1, 8[sp]
	ST r2, 12[sp]

	MOV r3, 0
	call .h
	MOV r0, r3
	
	MOV r3, 1
	call .h
	MOV r1, r3

	MOV r3, 2
	call .h
	MOV r2, r3

	ADD r3, r0, r1
	ADD r3, r3, r2
	
	LD ra, 0[sp]
	LD r0, 4[sp]
	LD r1, 8[sp]
	LD r2, 12[sp]

	ADD sp, sp, 16
	ret

.f:	//a is stored in r0, b in r1 and c in r2
	MOV r4,0
	SUB sp, sp, 16
	ST ra, 0[sp]
	ST r0, 4[sp]
	ST r1, 8[sp]
	ST r2, 12[sp]

	.cond: CMP r4, 5
	BGT .return_f
	BEQ .return_f

	ADD r0, r1, r2
	SUB r1, r0, r2
	
	call .g
	
	ADD r2, r2, r3
	ADD r4, r4, 1
	B .cond

	.return_f:
		ADD r3, r0, r1
		ADD r3, r3, r2

		LD ra, 0[sp]
		LD r0, 4[sp]
		LD r1, 8[sp]
		LD r2, 12[sp]

		ADD sp, sp, 16
		ret
.main:
	MOV r0, 10
	MOV r1, 12
	MOV r2, -1
	call .f
	.print r3