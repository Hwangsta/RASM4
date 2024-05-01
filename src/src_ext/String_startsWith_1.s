 .global String_startsWith_1

   .data

   .text
String_startsWith_1:
   stp   x19, x20, [sp, #-16]!   // Push x19 and x20, then move SP down 16 bytes
   stp   x21, x22, [sp, #-16]!   // Push x21 and x22, then move SP down 16 bytes
   stp   x23, x24, [sp, #-16]!   // Push x23 and x24, then move SP down 16 bytes
   stp   x25, x26, [sp, #-16]!   // Push x25 and x26, then move SP down 16 bytes
   stp   x27, x28, [sp, #-16]!   // Push x27 and x28, then move SP down 16 bytes
   stp   x29, x30, [sp, #-16]!   // Push x29 and x30, then move SP down 16 bytes

   mov   x21, x0                 // Move address of string in arg1 to x21
   mov   x22, x1                 // Move startIndex in arg2 to x22
   mov   x23, x2                 // Move address of substr in arg3 to x23

   mov   x0, x23                 // Move address of substr in arg3 to x0
   bl    String_length           // Get length of substr
   
   add   x2, x22, x0             // endIndex = startIndex + len(substr)

   mov   x0, x21                 // Move address of string in arg1 to x0
   mov   x1, x22                 // Move startIndex in arg2 to x1
   bl    String_substring_1      // Get string[startIndex : endIndex]
   mov   x24, x0                 // Store address of the substr result into x24

   mov   x1, x23                 // Move address of substr in arg3 to x1
   bl    String_equals           // Evaluate substr from arg3 == substr result
   mov   x25, x0                 // Move the result to x25 to be returned later

   mov   x0, x24                 // Move address of heap allocated substr into x0
   bl    free                    // Deallocate the heap chunk

   mov   x0, x25                 // Move return value into x0

   ldp   x29, x30, [sp], #16     // Pop x29 and x30, then move SP up 16 bytes
   ldp   x27, x28, [sp], #16     // Pop x27 and x28, then move SP up 16 bytes  
   ldp   x25, x26, [sp], #16     // Pop x25 and x26, then move SP up 16 bytes
   ldp   x23, x24, [sp], #16     // Pop x23 and x24, then move SP up 16 bytes
   ldp   x21, x22, [sp], #16     // Pop x21 and x22, then move SP up 16 bytes
   ldp   x19, x20, [sp], #16     // Pop x19 and x20, then move SP up 16 bytes

   RET                           // Return to caller

   .end
