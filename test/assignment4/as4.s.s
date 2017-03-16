 .main:
     mov r0,10 @a
     mov r1,12 @b
     mov r2,-1 @c
     mov r3,0  @i
	mov r9,0
     b .f
.f:
     cmp r3,5
     beq .exitf
     add r0,r1,r2 @a = b+c
     sub r1,r0,r2 @b =	a-c
    mov r6,r0 //saved a
    mov r7,r1//saved b
    mov r8,r2//saved c
     call .g
     add r2,r2,r9 //c = c+ returned value
     add r3,r3,1
     b .f

.exitf:
	add r13,r0,r1
	add r13,r13,r2
	.print r13
	b .exit
	

.g:
	add sp,sp,-4
	st ra,0[sp]
     call .h1
     call .h2
     call .h3    
      add r9,r6,r7
      add r9,r9,r8 //return a+b+c
	ld ra,0[sp]
	add sp,sp,4
      ret

.h1:
     add r6,r6,r7
     sub r6,r6,r8 @a = a+b-c
     ret
.h2:
      sub r7,r6,r7
      add r7,r7,r8   @b = a-b+c
      ret
.h3:
      add r8,r6,r8
      add r8,r8,r7
      ret            @c = a+b+c

.exit: