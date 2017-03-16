mov r0 3                              @ initial n value
mov r1 0x100                           @ A address 
mov r2 0x200                           @ B address
mov r3 0x300                           @ C address
mov r8 r1    
mov r9 r2
mov r4 0                               @ i 
.loop1:
mov r5 0
                               @ j 
b .loop2


.loop2:
 add r6 r4 r5                   @ i+j
mul r7 r6 2                             
add r7 r7 r5                           @2i +3j
st r6 [r8]
st r7 [r9]
add r8 r8 4                              @ increasing by 4
add r9 r9 4                              @increasing by 4
add r5 r5 1
cmp r0 r5                                  @ check j
bgt .loop2
b .foo


.foo:
add r4 r4 1          
cmp r0 r4                                  @check i
bgt .loop1
b .loop3


.loop3:
mov r4 0                                   @ i counter    
b .loop4


.loop4:
 mov r5 0                            @ j counter
b .loop5


.loop5:
 mov r6 0                             @ k counter
mov r7 0                                      @ sum
b .loop6


.loop6:
mul r8 r0 r4
add r8 r8 r6
mul r8 r8 4
add r8 r8 r1
ld r10 [r8]                                 @A[i][k]
mul r8 r0 r6
add r8 r8 r5
mul r8 r8 4
add r8 r8 r2
ld r11 [r8]                                  @B[k][j]
mul r10 r10 r11
add r7 r7 r10                                @sum=sum+A[i][k]*B[i][k]
add r6 r6 1                                  
cmp r0 r6                                    @check k<N
bgt .loop6
b .poo


.poo:
.print r7
st r7 [r3]                                      @stores in C array
add r3 r3 4
add r5 r5 1                                     
cmp r0 r5                                         @checks j<N
bgt .loop5                                        
b .loo


.loo:
add r4 r4 1
cmp r0 r4
bgt .loop4
b .exi
.exi:
.exit:
