   .global String_substring_1

   .data

   .text
String_substring_1:
   stp   x19, x20, [sp, #-16]!   // Push x19 and x20, then move SP down 16 bytes
   stp   x21, x22, [sp, #-16]!   // Push x21 and x22, then move SP down 16 bytes
   stp   x23, x24, [sp, #-16]!   // Push x23 and x24, then move SP down 16 bytes
   stp   x25, x26, [sp, #-16]!   // Push x25 and x26, then move SP down 16 bytes
   stp   x27, x28, [sp, #-16]!   // Push x27 and x28, then move SP down 16 bytes
   stp   x29, x30, [sp, #-16]!   // Push x29 and x30, then move SP down 16 bytes

   mov   x21, x0                 // Move address of string in arg1 to x21
   add   x21, x21, x1            // Increment the address by beginIndex

   sub   x24, x2, x1             // substring length = endIndex - beginIndex
   add   x24, x24, #1            // Add 1 to the result to account for '\0'

   mov   x0, x24                 // Move the (substring length + 1) into x0
   bl    malloc                  // create heap allocated chunk
   mov   x22, x0                 // Move pointer result to x22

   sub   x24, x24, #1            // Decrement the substr len so it doesn't include '\0'
   mov   x0, #0                  // Inialize loop counter to 0

copy_char:
   cmp   x24, x0                 // If counter <= substr len,
   ble   end_copy_char           // Then jump to end of loop

   ldrb  w1, [x21, x0]           // Load origStr[counter] into w1

   cmp   w1, #0                  // If origStr[counter] == '\0',
   beq   end_copy_char           // Then jump to end of loop

   strb  w1, [x22, x0]           // Store origStr[counter] into substr[counter]

   add   x0, x0, #1              // Increment counter
   b     copy_char               // Jump back to top of loop

end_copy_char:

   mov   w1, #0                  // Move '\0' into w1
   strb  w1, [x22, x0]           // Store '\0' into substr[counter]
   
   mov   x0, x22                 // Move address of substring into x0, to be returned

   ldp   x29, x30, [sp], #16     // Pop x29 and x30, then move SP up 16 bytes
   ldp   x27, x28, [sp], #16     // Pop x27 and x28, then move SP up 16 bytes  
   ldp   x25, x26, [sp], #16     // Pop x25 and x26, then move SP up 16 bytes
   ldp   x23, x24, [sp], #16     // Pop x23 and x24, then move SP up 16 bytes
   ldp   x21, x22, [sp], #16     // Pop x21 and x22, then move SP up 16 bytes
   ldp   x19, x20, [sp], #16     // Pop x19 and x20, then move SP up 16 bytes

   RET                           // Return to caller

   .end
