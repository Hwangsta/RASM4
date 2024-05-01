   .global String_toLowerCase

   .data

   .text
String_toLowerCase:
   stp   x19, x20, [sp, #-16]!   // Push x19 and x20, then move SP down 16 bytes
   stp   x21, x22, [sp, #-16]!   // Push x21 and x22, then move SP down 16 bytes
   stp   x23, x24, [sp, #-16]!   // Push x23 and x24, then move SP down 16 bytes
   stp   x25, x26, [sp, #-16]!   // Push x25 and x26, then move SP down 16 bytes
   stp   x27, x28, [sp, #-16]!   // Push x27 and x28, then move SP down 16 bytes
   stp   x29, x30, [sp, #-16]!   // Push x29 and x30, then move SP down 16 bytes

        bl    String_copy             // copy string that is passed in x0 as a parameter

   mov   x1, #0                  // x1 is the index of string
loop:
      ldrb  w2, [x0, x1]         // add index and load charcter into w2

      cmp   w2, #0               // compare character loaded to null
      beq   exit_loop            // if character is null, exit loop

      cmp   w2, #'Z'             // compare character loaded to 'Z'
      bgt   cont                 // character is not upper case so goto cont

      cmp   w2, #'A'             // compare character loaded to 'A'
      blt   cont                 // character is not upper case so goto cont

// character is upper case
      add   w2, w2, #0x20        // add hex 20 from current ascii value
                                 // to get the lower case version
      strb  w2, [x0, x1]         // store the lower case char in the dynamicly
                                 // string

cont:
      add x1,x1,#1               // increment the string's index

      b loop                     // loop again if no null encountered

exit_loop:

   ldp   x29, x30, [sp], #16     // Pop x29 and x30, then move SP up 16 bytes
   ldp   x27, x28, [sp], #16     // Pop x27 and x28, then move SP up 16 bytes  
   ldp   x25, x26, [sp], #16     // Pop x25 and x26, then move SP up 16 bytes
   ldp   x23, x24, [sp], #16     // Pop x23 and x24, then move SP up 16 bytes
   ldp   x21, x22, [sp], #16     // Pop x21 and x22, then move SP up 16 bytes
   ldp   x19, x20, [sp], #16     // Pop x19 and x20, then move SP up 16 bytes

   RET                           // Return to caller

   .end
