MOV R0, 3 //Value of n
MOV R1, 0	//Outer loop counter i
MOV R2, 0 //Inner loop counter j
MOV R3, 0x100  //Address of A[0][0]
MOV R4, 0 //Value to be stored
MOV R5, 0 //For address calculation
MOV R6, 0x200  //Address of B[0][0]
MOV R7, 0x300  //Address of C[0][0]
MOV R8, 0  //Inner inner loop counter

.outer_loop_condition:
CMP R1, R0
BGT .out_of_outer_loop
BEQ .out_of_outer_loop

MOV R2, 0
.inner_loop_condition:
CMP R2, R0
BGT .out_of_inner_loop
BEQ .out_of_inner_loop
ADD R4, R1, R2  //Computing value i+j

MUL R5, R1, R0
ADD R5, R5, R2
MUL R5, R5, 4
ADD R5, R5, R3  //Computing address in R5 for A[i][j]

ST R4, 0[R5]  //Storing value in A[i][j]

MUL R4, R1, 2
MUL R5, R2, 3   //Here, R5 is used as a temporary variable to store 3*j
ADD R4, R4, R5

MUL R5, R1, R0
ADD R5, R5, R2
MUL R5, R5, 4
ADD R5, R5, R6  //Computing address in R5 for B[i][j]

ST R4, 0[R5]  //Storing value in B[i][j]

ADD R2, R2, 1
B .inner_loop_condition

.out_of_inner_loop:
ADD R1, R1, 1
B .outer_loop_condition

.out_of_outer_loop:


MOV R1, 0  //Value i for outer loop

.outer_loop_product_condition:
CMP R1, R0
BGT .out_of_outer_loop_product
BEQ .out_of_outer_loop_product

MOV R2, 0  //Value j for inner loop
.inner_loop_product_condition:
CMP R2, R0
BGT .out_of_inner_loop_product
BEQ .out_of_inner_loop_product


MOV R4, 0  //For computing sum for ith row and jth column
MOV R8, 0  //Value k for inner inner loop

.inner_inner_loop_product_condition:
CMP R8, R0
BGT .out_of_inner_inner_loop_product
BEQ .out_of_inner_inner_loop_product

MUL R5, R0, R1
ADD R5, R5, R8
MUL R5, R5, 4
ADD R5, R5, R3

LD R9, 0[R5]  //Loading A[i][k]

MUL R5, R0, R8
ADD R5, R5, R2
MUL R5, R5, 4
ADD R5, R5, R6

LD R10, 0[R5]  //Loading B[k][j]

MUL R9, R9, R10
ADD R4, R4, R9  //Adding to the sum.

ADD R8, R8, 1
B .inner_inner_loop_product_condition

.out_of_inner_inner_loop_product:

MUL R5, R0, R1
ADD R5, R5, R2
MUL R5, R5, 4
ADD R5, R5, R7  //Computing address of C[i][j]

ST R4, 0[R5]

ADD R2, R2, 1
B .inner_loop_product_condition

.out_of_inner_loop_product:
ADD R1, R1, 1
B .outer_loop_product_condition

.out_of_outer_loop_product:


MOV R1, 0
.outer_loop_print_condition:
CMP R1, R0
BGT .out_of_outer_loop_print
BEQ .out_of_outer_loop_print

MOV R2, 0

.inner_loop_print_condition:
CMP R2, R0
BGT .out_of_inner_loop_print
BEQ .out_of_inner_loop_print

MUL R5, R0, R1
ADD R5, R5, R2
MUL R5, R5, 4
ADD R5, R5, R7

LD R4, 0[R5]

.print R4

ADD R2, R2, 1
B .inner_loop_print_condition

.out_of_inner_loop_print:
ADD R1, R1, 1
B .outer_loop_print_condition

.out_of_outer_loop_print:

