   .global String_equalsIgnoreCase

   .data

   .text
String_equalsIgnoreCase:
   stp   x19, x20, [sp, #-16]!   // Push x19 and x20, then move SP down 16 bytes
   stp   x21, x22, [sp, #-16]!   // Push x21 and x22, then move SP down 16 bytes
   stp   x23, x24, [sp, #-16]!   // Push x23 and x24, then move SP down 16 bytes
   stp   x25, x26, [sp, #-16]!   // Push x25 and x26, then move SP down 16 bytes
   stp   x27, x28, [sp, #-16]!   // Push x27 and x28, then move SP down 16 bytes
   stp   x29, x30, [sp, #-16]!   // Push x29 and x30, then move SP down 16 bytes

   mov   x22, x1                 // Move string address in argument_2 to x22

   bl    String_toLowerCase      // Convert argument_1 to lowercase; new str returned
   mov   x21, x0                 // Move address containing lowercase copy to x21

   mov   x0, x22                 // Move string stored in argument_2 to x0
   bl    String_toLowerCase      // Convert argument_2 to lowercase; new str returned
   mov   x22, x0                 // Move address containing lowercase copy to x22

   mov   x0, x21                 // Move address of lowercase copy of arg_1 to x0
   mov   x1, x22                 // Move address of lowercase copy of arg_2 to x1
   bl    String_equals           // Compare lower case versions of arg_1 and arg_2

   mov   x25, x0                 // Move equals result to x25

   mov   x0, x21                 // Move address of lowercase copy of arg_1 to x0
   bl    free                    // Deallocate the heap chunk
   mov   x0, x22                 // Move address of lowercase copy of arg_2 to x0
   bl    free                    // Deallocate the heap chunk

   mov   x0, x25                 // Move equals result to x0, to be returned

   ldp   x29, x30, [sp], #16     // Pop x29 and x30, then move SP up 16 bytes
   ldp   x27, x28, [sp], #16     // Pop x27 and x28, then move SP up 16 bytes  
   ldp   x25, x26, [sp], #16     // Pop x25 and x26, then move SP up 16 bytes
   ldp   x23, x24, [sp], #16     // Pop x23 and x24, then move SP up 16 bytes
   ldp   x21, x22, [sp], #16     // Pop x21 and x22, then move SP up 16 bytes
   ldp   x19, x20, [sp], #16     // Pop x19 and x20, then move SP up 16 bytes

   RET                           // Return to caller; 1 or 0 (T or F) in x0

   .end
