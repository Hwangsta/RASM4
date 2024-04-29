.global deleteNode_driver

   .data

   .text
deleteNode_driver:
   stp   x19, x20, [sp, #-16]!   // Push x19 and x20, then move SP down 16 bytes
   stp   x21, x22, [sp, #-16]!   // Push x21 and x22, then move SP down 16 bytes
   stp   x23, x24, [sp, #-16]!   // Push x23 and x24, then move SP down 16 bytes
   stp   x25, x26, [sp, #-16]!   // Push x25 and x26, then move SP down 16 bytes
   stp   x27, x28, [sp, #-16]!   // Push x27 and x28, then move SP down 16 bytes
   stp   x29, x30, [sp, #-16]!   // Push x29 and x30, then move SP down 16 bytes

// x0 = headPtr, x1 = tailPtr, x2 = index number

        traverse:
        // Additionally, we have to preserve the LR due to BL MALLOC
        mov     x19,x0
        mov     x20, #1                                         // initialize the counter to 1

        sub     x2, x2, #1

traverse_loop:
   ldr     x19,[x19]

   cmp     x19,#0                                  // checking for empty list
   beq     traverse_exit

   add     x19,x19,#8                              // jump the x1 -> next field

        cmp     x20, x2
        beq     previous_index_found                                    // jump to index_found if counter matches the previous index number

        add     x20,x20,#1                                      // increment counter
         b               traverse_loop

previous_index_found:
        sub     x19,x19,#8

                mov     x3,x19

   add   x19,x19,#8                              // jump the x1 -> next field
   ldr     x20,[x19]                                                                             // dereference the next pointer

        mov     x2, x20
        bl              deleteNode

traverse_exit:

   ldp   x29, x30, [sp], #16     // Pop x29 and x30, then move SP up 16 bytes
   ldp   x27, x28, [sp], #16     // Pop x27 and x28, then move SP up 16 bytes
   ldp   x25, x26, [sp], #16     // Pop x25 and x26, then move SP up 16 bytes
   ldp   x23, x24, [sp], #16     // Pop x23 and x24, then move SP up 16 bytes
   ldp   x21, x22, [sp], #16     // Pop x21 and x22, then move SP up 16 bytes
   ldp   x19, x20, [sp], #16     // Pop x19 and x20, then move SP up 16 bytes

   RET                           // Return to caller

   .end
