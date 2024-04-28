.global calcBytes

   .data

// x0 holds address dbNumNodes
// x1 holds address of dbStrBytes

   .text
calcBytes:
   stp   x19, x20, [sp, #-16]!   // Push x19 and x20, then move SP down 16 bytes
   stp   x21, x22, [sp, #-16]!   // Push x21 and x22, then move SP down 16 bytes
   stp   x23, x24, [sp, #-16]!   // Push x23 and x24, then move SP down 16 bytes
   stp   x25, x26, [sp, #-16]!   // Push x25 and x26, then move SP down 16 bytes
   stp   x27, x28, [sp, #-16]!   // Push x27 and x28, then move SP down 16 bytes
   stp   x29, x30, [sp, #-16]!   // Push x29 and x30, then move SP down 16 bytes

        // Load number of nodes into x19
        mov     x19,x0                                          // Move address of dbNumNodes (rasm3_driver)
        ldr     x19,[x19]                                       // Dereference address of dbNumNodes

        // Calculate number of bytes for each node
        mov     x21,#16                                         // Move int 16 into x21
        mul     x0,x19,x21                                      // Calculate # of bytes for the nodes

        // Load number of bytes from all strings into x20
        mov     x20,x1                                          // Move address of dbStrBytes (rasm3_driver)
        ldr     x20,[x20]                                       // Dereference address

        add     x0,x0,x20                                       // Add number of bytes of all strings to the bytes
                                                                                        // of all the nodes in the heap

   ldp   x29, x30, [sp], #16     // Pop x29 and x30, then move SP up 16 bytes
   ldp   x27, x28, [sp], #16     // Pop x27 and x28, then move SP up 16 bytes
   ldp   x25, x26, [sp], #16     // Pop x25 and x26, then move SP up 16 bytes
   ldp   x23, x24, [sp], #16     // Pop x23 and x24, then move SP up 16 bytes
   ldp   x21, x22, [sp], #16     // Pop x21 and x22, then move SP up 16 bytes
   ldp   x19, x20, [sp], #16     // Pop x19 and x20, then move SP up 16 bytes

   RET                               // Return to caller

   .end
