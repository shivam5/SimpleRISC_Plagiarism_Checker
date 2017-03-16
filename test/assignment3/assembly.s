   mov r0,6                       /*r0=n i. e. size of matrix*/
mov r1,0x100
mov r2,0x200
mov r3,0x300
mov r12,r1
mov r13,r2


mov r4,0                     /* i=r4 */
mov r5,0                     /* j=r5 */
.loop1:         
cmp r4,r0                  /*comparing i and n*/
beq .e                     /* if i==n then exit loop1 */
bgt .e
mov r5,0                   /* start of loop2 by initialising j=0 */
b .loop2


.loop2:                  
cmp r5,r0                   /*comparing j and n*/
beq .t                      /* if j==n then exit loop1 */
bgt .t
add r6,r4,r5                  /* A[i][j]=i+j */
st r6,[r1]                    /* store A[i][j] in base address of A */
add r1,r1,4                   /* Next Array element */
mov r6,2
mul r6,r6,r4                  /* r6= 2*i */
mul r7,r5,3                   /* r7=3*j */
add r6,r6,r7                  /* r6=2i+3j */
st r6,[r2]             
add r2,r2,4               
add r5,r5,1                   /* j++ */
b .loop2

.t:
add r4,r4,1                  /* i++ */
b .loop1                     /* goto loop1 */
 
.e:
add r12,r12,0
ld r4,[r12]
.print r4
.print r12

mov r1,r12                    /* r1= r12 */
mov r2,r13                    /* r2=r13 */
mov r4,0                      /* i=0 */
mov r5,0                      /* j=0 */
mul r6,r0,r0                  /* r6=n*n */

.loop3:                   
cmp r4,r6                     /*  compare i with n*n */
beq .exit                     /* if i==n exit */
bgt .exit
mov r12,r1                    /* r12=r1*/
div r4,r4,r0                  /* i=i/n */
mul r4,r4,4                   /* i=i*4 */
add r12,r12,r4                /* r12=r12+i */
div r4,r4,4                   /* i=i/4 */
mul r4,r4,r0                  /*i=i*n */
mov r5,0                      /* j=0 */
b .loop4


.loop4:
cmp r5,r0                  /*  compare j with n */
beq .t2                     /* if j==n exit */
bgt .t2
mul r4,r4,4                 /* i=i*4 */
mov r12,r1                  /* r12=r1*/
add r12,r12,r4               /* r12=r12+i */
div r4,r4,4                  /* i=i/4 */

mov r13,r2                    /* r13=r2*/
mov r7,0                       /* sum=0 */
mov r8,r4                        /* p=i */
mov r9,r5                       /* r9=m */

.loop5:
cmp r9,r6                      /*  compare m with n*n */
bgt .t3                       /* if m> n*n goto t3 */
beq .t3
mov r13,r2                    /* r13=r2 */
mul r9,r9,4                    /* m=m*4 */
add r13,r13,r9                 /* r13=r13+m */
 div r9,r9,4                   /* m=m/4 */

.print r12
.print r9
ld r10,[r12]               /* r10= value stored in r12 */
.print r10
ld r11,[r13]                 /* r11= value stored in r13 */
.print r13
.print r11
mul r10,r10,r11            /* r10=r10*r11 */
add r7,r7,r10              /* sum=sum+r10 */
add r12,r12,4              /* r12=r12+4 */

add r9,r9,r0                 /* i=i+n */
b .loop5

.t2:
add r4,r4,r0       /* i=i+n */
b .loop3

.t3:
st r7,[r3]         /* r7= value stored in r3 */
.print r7
add r3,r3,4       /* r3=r3+4 */
add r5,r5,1        /* j=j+1 */
b .loop4

.exit:

 mov r3 , 0x300
mov r6 , 0   /*for printing */
mul r0 , r0 ,r0 
.loop:

ld r5 , [r3]
.print r5
add r3 , r3, 4
add r6 , r6 ,1
cmp r6 , r0
beq .finish
bgt .finish
b .loop


.finish:

