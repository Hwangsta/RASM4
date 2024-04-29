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

// x0 = headPtr, x1 = tailPtr, x2 = index number, x3 = numNodes, x4 = strBytes
        mov     x21, x3                                         // save numNodes in x21
        mov     x22, x4                                         // save strBytes in x22
        mov     x23, x0                                         // save headPtr in x23
        mov     x24, x1                                         // save tailPtr in x24
        traverse:
        // Additionally, we have to preserve the LR due to BL MALLOC
        mov     x19,x0
        mov     x20, #1                                         // initialize the counter to 1

        cmp     x2, #1                                          // check if we are at first node
   beq  first_index                                     // jump to first index if we are at first node
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

   mov     x26,x19

   add   x19,x19,#8                              // jump the x1 -> next field
   ldr     x20,[x19]                                                                             // dereference the next pointer

        // delete one from numNodes
        ldr     x25,[x21]                                                               // de-reference numNodes address to get node #
        sub     x4, x25, #1                                                             // decrement node number
        str     x4,[x21]

        // subtract string's bytes and update strBytes
        ldr     x0,[x20]
        bl              String_length

        add     x0, x0, #1                                                              // add null

        ldr     x4, [x22]
        sub     x0, x4, x0
        str     x0,[x22]

   mov  x3,x26
        mov     x1,x24
        mov     x0,x23                                                                  // reload headPtr into x0
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

first_index:
        // delete one from numNodes
        ldr     x25,[x21]                                                               // de-reference numNodes address to get node #
        sub     x4, x25, #1                                                             // decrement node number
        str     x4,[x21]

        // subtract string's bytes and update strBytes
        ldr     x0,[x23]
        ldr     x0,[x0]
        bl              String_length

        add     x0, x0, #1                                                              // add null

        ldr     x4, [x22]
        sub     x0, x4, x0
        str     x0,[x22]

        mov     x3,#0x0                                                                         // set previ
        mov     x0,x23
        mov     x1,x24
        ldr     x2,[x0]

        bl              deleteNode

        b               traverse_exit

  .end
