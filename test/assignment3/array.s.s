mov r0 , 0x100  /* address of matrix A */
mov r10 , 0x200 /* address of matrix B */
mov r4 , 4      /* size of two dimension array */
sub r5 , r4, 1  /* to subtract 1 */
mov r1 , r5     /* index of i */ 
mov r2 , r5     /* index of j */
  
.loop1:
  mov r2 , r5 
  cmp r1 , -1   /* compare i with -1 */
  bgt .loop2  
  b .change 


 .loop2:
 cmp r2,-1
 bgt .label
  sub r1 , r1 ,1
  b .loop1 

.label:
mul r6,r1,r4        /* i*n */
add r6, r6 , r2     /* i*n + j */
mul r6 , r6 , 4     /* integer is 4 bit 4(i*n + j)  */
add r7 , r0 , r6    /* A[i][j] */ 

add r8 , r1 , r2    /* i+j */
mul r11 , r1 ,2        /* 2*i */
mul r12 , r2 , 3      /* 3*j */
add r11 , r11 , r12   /* 2*i + 3*j */
add r12 , r10 , r6    /* B[i][j] */

st r8 , [r7]
st r11 , [r12]
ld r9 , [r7]
ld r9 , [r12]
sub r2 , r2 ,1
b .loop2





.change:
mov r3 , 0x300  /* address initialize of matrix C */

sub r5 , r4, 1  /* to subtract 1 */
mov r1 , r5     /* index of i */ 
mov r2 , r5     /* index of j */

.loopA:
  mov r2 , r5 
  cmp r1 , -1   /* compare i with -1 */
  bgt .loopB  
  b .exit 


 .loopB:
 cmp r2,-1
 bgt .labelA
  sub r1 , r1 ,1
  b .loopA 

.labelA:
mul r6,r1,r4        /* i*n */
add r6, r6 , r2     /* i*n + j */
mul r6 , r6 , 4     /* integer is 4 bit 4(i*n + j)  */
add r7 , r3 , r6    /* C[i][j] */ 
mov r8 , r5     /* variable k for multipilication purpose */
mov r12 , 0    /* variable to add multipliy indexes */
cmp r8 , -1
bgt .loop3


.loop3:
mov r9 , r4              /* n*i */
mul r9 , r9 ,r1          /* n*i +k */
add r9 , r9 , r8      
mul r9 , r9 , 4            /* 4(n*i + k) */

add r9 , r0 , r9     /* A[0][0] + 4(n*i + k) */

ld r9 , [r9]
.print r9
mov r11 , r4              /* n*k */
mul r11 , r11 ,r8          /* n*k +j */
add r11 , r11 , r2      
mul r11 , r11 , 4            /* 4(n*k + j) */

add r11 , r10 , r11     /* B[0][0] + 4(n*k + j) */

ld r11 , [r11]
.print r11
mul r9 , r9 ,r11       /* A[i][k]*B[k][j] */     
add r12 , r12 ,r9       /* sum = sum + A[i][k]*B[k][j]*/      

sub r8 , r8 ,1        /* k = k-1 */
cmp r8 , -1              
bgt .loop3                 

st r12 , [r7]        
.print r12
 sub r2 ,r2,1
 b .loopB


.exit:

 mov r3 , 0x300
mov r6 , 0   /*for printing */
mul r4 , r4 ,r4 
.loop:

ld r5 , [r3]
.print r5
add r3 , r3, 4
add r6 , r6 ,1
cmp r6 , r4
beq .finish
bgt .finish
b .loop


.finish:



