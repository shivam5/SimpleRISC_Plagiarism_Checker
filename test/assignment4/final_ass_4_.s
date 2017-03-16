   .main:     //beginning of main
 mov r0 10   //setting the value of a
 mov r1 12   //setting the value of b
 mov r2 -1   //setting the value of c
mov r4 0     //setting the value of counter(i)

.loopf:      //beginning of function f
  cmp r4 5   //comparing with 5
 
  beq .return  //making to leave if counter gets value 5

  add r0 r1 r2  //a=b+c

mov r5 r0       //copying value of a
  sub r1 r0 r2  //b=a-c

mov r6 r1      //copying value of b
.loopg:       //beginning of function g

   .looph1:   //computing value of a
      add r5 r0 r1  

      sub r5 r5 r2

   .looph2:    //computing value of b
      sub r6 r5 r1
      add r6 r6 r2
   .looph3:      //computing value of c
      add r7 r6 r2
      add r7 r7 r5

  add r2 r2 r7   //c=c'+a+b+c
  add r2 r2 r5
 add r2 r2 r6  

  add r4 r4 1   //increasing counter by 1

b .loopf     


.return:  
  add r0 r0 r1
  add r0 r0 r2
.print r0
