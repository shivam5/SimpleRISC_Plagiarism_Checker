mov r3 0           @ i
mov r4 0           @ j
mov r0 5           @ n
mov r8 0x100       @ A
mov r9 0x200       @ B
mov r10 0x300      @ C
b .loop
.loop:
mul r11 r3 2       @ 2i
mul r12 r4 3       @ 3j
add r11 r11 r12    @ 2i+3j
add r5 r3 r4       @ i+j
mul r6 r0 r3       @ ni
add r6 r6 r4       @ ni+j
mul r6 r6 4        @ 4*(ni+j)
add r1 r8 r6       @ A[i][j]
st r5 [r1]         @ A[i][j]=i+j
add r12 r9 r6      @ B[i][j]
st r11 [r12]       @ B[i][j]=2i+3j
add r2 r4 1        @ r2=j+1
cmp r0 r2          @ if n>j+1
bgt .increase_j
beq .check_i       @ check if n>i+1 or not
.increase_j:
add r4 r4 1        @ j=j+1
b .loop
.check_i:
add r2 r3 1        @ check if n>i+1        
cmp r0 r2
bgt .increase_i    
beq .multiply      @ if i==n-1 then values are assigned to bothA and 
.increase_i:
add r3 r3 1        @ i=i+1
mov r4 0           @ j again set to 0
b .loop

.multiply:
mov r3 0           @ i=0
mov r4 0           @ j=0
mov r7 0           @ k=0
b .assign_C
.assign_C:
mul r6 r0 r3       @ ni
add r6 r6 r4       @ ni+j
mul r6 r6 4        @ 4*(ni+j)
add r13 r10 r6     @ c[i][j]
mov r2 0           @ sum=0
b .sum
.sum:
mul r6 r0 r3       @ ni
add r6 r6 r7       @ ni+k
mul r6 r6 4        @ 4*(ni+k)
add r1 r8 r6       @ A[i][k]
mul r6 r0 r7       @ nk
add r6 r6 r4       @ nk+j
mul r6 r6 4        @ 4*(nk+j)
add r11 r9 r6      @ B[k][j]
ld r6 [r1]         @ r6 = A[i][k]
ld r12 [r11]      @ r12 = B[k][j]
mul r6 r6 r12      @ r6 = a(i,k)*b(k,j)
add r2 r2 r6       @ sum=sum+r6
add r6 r7 1        @ k+1
cmp r0 r6          @ n>k+1 or not
beq .store_C
bgt .increase_k
.increase_k:
add r7 r7 1        @ k=k+1
b .sum
.store_C:
st r2 [r13]        @ c[i][j]=summation   a(i,k)*b(k,j)
.print r2
add r6 r4 1        @ r6 =j+1
cmp r0 r6          @ check if n>j+1
beq .checki        @ if all column over change row
bgt .inc_j         @ if all column not over j=j+1
.inc_j:            
add r4 r4 1        @ j=j+1
mov r7 0           @ k= 0
b .assign_C        @ follow loop
.checki:
add r6 r3 1       
cmp r0 r6
beq .exi
bgt .inc_i
.inc_i:
add r3 r3 1
mov r4 0
mov r7 0
b .assign_C
.exi:
.exit:
