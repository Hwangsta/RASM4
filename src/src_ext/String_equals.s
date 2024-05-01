   .global String_equals

   .data

   .text
String_equals:
   stp   x19, x20, [sp, #-16]!   // Push x19 and x20, then move SP down 16 bytes
   stp   x21, x22, [sp, #-16]!   // Push x21 and x22, then move SP down 16 bytes
   stp   x23, x24, [sp, #-16]!   // Push x23 and x24, then move SP down 16 bytes
   stp   x25, x26, [sp, #-16]!   // Push x25 and x26, then move SP down 16 bytes
   stp   x27, x28, [sp, #-16]!   // Push x27 and x28, then move SP down 16 bytes
   stp   x29, x30, [sp, #-16]!   // Push x29 and x30, then move SP down 16 bytes

   // Regsiter x5 used to track comparison result
   mov   x5, #1                  // Initalize result to true

compare_char:
   ldrb  w2, [x0], #1            // Load LSB from x0 into w2; increment x0
   ldrb  w3, [x1], #1            // Load LSB from x1 into w3; increment x1

   cmp   w2, w3                  // If w2 != w3,
   bne   not_equal               // Then jump to not_equal

   cmp   w2, #0                  // If w2 (and implicitly w3) == null
   beq   end_compare_char        // Then jump to end of loop
   b     compare_char            // Else jump to top of loop

not_equal:
   mov   x5, #0                  // Move 0 (false) to x5 result

end_compare_char:

   mov   x0, x5                  // Move the result into x0


   ldp   x29, x30, [sp], #16     // Pop x29 and x30, then move SP up 16 bytes
   ldp   x27, x28, [sp], #16     // Pop x27 and x28, then move SP up 16 bytes  
   ldp   x25, x26, [sp], #16     // Pop x25 and x26, then move SP up 16 bytes
   ldp   x23, x24, [sp], #16     // Pop x23 and x24, then move SP up 16 bytes
   ldp   x21, x22, [sp], #16     // Pop x21 and x22, then move SP up 16 bytes
   ldp   x19, x20, [sp], #16     // Pop x19 and x20, then move SP up 16 bytes

   RET                           // Return to caller; 1 or 0 (T or F) in x0

   .end
