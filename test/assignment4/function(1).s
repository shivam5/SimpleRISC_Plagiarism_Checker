mov r1 -1
mov r2 2
mov r3 2
call .f                                       @f function is called
b .e 

                                          
.f:               
sub sp sp 8                                   @stores local variable i and ra
st ra 0[sp]
st r5 4[sp]
mov r5 0                                       @ i is  stored in r5
b .loop
.loop:
add r1 r2 r3
sub r2 r1 r3

call .g                                        @ g is called
add r3 r3 r6
add r5 r5 1
mov r10 5
cmp r10 r5                    
bgt .loop                                      @checking i<5 
b .return        
.return:
add r4 r1 r2
add r4 r4 r3
ld ra 0[sp]
ld r5 4[sp]
add sp sp 8  
ret                       
.g:
sub sp sp 20       
st r1 0[sp]                                   @ a,b,c values are stored
st r2 4[sp]
st r3 8[sp]
st ra 12[sp]
st r7 16[sp]
mov r7 0                                       @d=0
call .h
mov r1 r8
mov r7 1                                       @d=1
call .h
mov r2 r8
mov r7 2                                       @d=2    
call .h
mov r3 r8
add r6 r1 r2
add r6 r6 r3
ld r1 0[sp]
ld r2 4[sp]
ld r3 8[sp]
ld ra 12[sp]
ld r7 16[sp]
add sp sp 20
ret

.h:
cmp r7 0                                     @switch 0
beq .loop1
b .loop2
.loop1:         
add r8 r1 r2
sub r8 r8 r3
ret
.loop2:
cmp r7 1                                      @switch 1
beq .loop4
b .loop5
.loop4:
add r8 r1 r3
sub r8 r8 r2
ret
.loop5:
cmp r7 2                                      @switch 2
beq .loop6
b .loop8
.loop6:
add r8 r1 r2
add r8 r8 r3
ret
.loop8:
mov r8 0                                      @default
ret
.e:
.print r4                                   
.exit:
