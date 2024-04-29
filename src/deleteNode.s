   .global deleteNode

   .data

   .text
deleteNode:
   stp   x19, x20, [sp, #-16]!   // Push x19 and x20, then move SP down 16 bytes
   stp   x21, x22, [sp, #-16]!   // Push x21 and x22, then move SP down 16 bytes
   stp   x23, x24, [sp, #-16]!   // Push x23 and x24, then move SP down 16 bytes
   stp   x25, x26, [sp, #-16]!   // Push x25 and x26, then move SP down 16 bytes
   stp   x27, x28, [sp, #-16]!   // Push x27 and x28, then move SP down 16 bytes
   stp   x29, x30, [sp, #-16]!   // Push x29 and x30, then move SP down 16 bytes

        // x0 = headPtr, x1 = tailPtr, x2 = nodePtr (node to delete), x3 = previous node pointer

        // check if node we are deleting is head node
        ldr     x19, [x0]                                       // get the first node's address
        cmp     x2,x19                                          // compare the address of the first node to nodePtr
        beq     delete_head                                     // jump to delete_head if at first node

        // check if node we are deleting is tail node
        ldr     x20, [x1]                                       // get the last node's address
        cmp     x2,x20                                          // compare the address of the last node to nodePtr
        beq     delete_tail                                     // jump to delete_tail if at last node

        mov     x19, x0                                         // save the headPtr
        mov     x20, x1                                         // save the tailPtr
        mov     x21, x2                                         // save the nodePtr
        mov     x22, x3                                         // save the pevious node

        add     x23, x21, #8                            // get the address of next pointer and save in x22
        ldr     x23,[x23]                                       // get the address of next node

        ldr     x0,[x21]                                                // dereference nodePtr
        bl              free                                                    // free the string

        mov     x0, x21                                         // move the address of nodePtr into x0
        bl              free                                                    // free the Node

        add     x22, x22, #8                            // get the next pointer
        str     x23, [x22]                                      // store the next node into the next pointer

        b               exit_sequence
delete_head:
        mov     x19, x0                                         // save the headPtr
        mov     x20, x1                                         // save the tailPtr
        mov     x21, x2                                         // save the nodePtr
        mov     x22, x3                                         // save the pevious node

        add     x23, x21, #8                            // get the address of next pointer and save in x22

        cmp     x23, #0                                         // check to see if next pointer is null
        beq     next_null                                       // jump if there is a null

        ldr     x23,[x23]                                       // get the address of next node

        ldr     x0,[x21]                                                // dereference nodePtr
        bl              free                                                    // free the string

        mov     x0, x21                                         // move the address of nodePtr into x0
        bl              free                                                    // free the Node

        str     x23, [x19]                                      // store the address of next node into headPtr

        b               exit_sequence

next_null:
        ldr     x0,[x21]                                                // dereference nodePtr
        bl              free                                                    // free the string

        mov     x0, x21                                         // move the address of nodePtr into x0
        bl              free                                                    // free the Node

        mov     x27,#0x0
   str     x27,[x23]

   str     x27,[x24]

        b               exit_sequence

delete_tail:
        mov     x19, x0                                         // save the headPtr
        mov     x20, x1                                         // save the tailPtr
        mov     x21, x2                                         // save the nodePtr
        mov     x22, x3                                         // save the pevious node

        ldr     x0,[x21]                                                // dereference nodePtr
        bl              free                                                    // free the string

        mov     x0, x21                                         // move the address of nodePtr into x0
        bl              free                                                    // free the Node

        mov     x23, #0x0                                       // move null into x23

        add     x22, x22, #8                            // get the next pointer
        str     x23, [x22]                                      // store the next node into the next pointer

        sub     x22, x22, #8                            // make x22 point to the node itself
        str     x22, [x20]                                      // insert previous node into tailPtr

exit_sequence:
   ldp   x29, x30, [sp], #16     // Pop x29 and x30, then move SP up 16 bytes
   ldp   x27, x28, [sp], #16     // Pop x27 and x28, then move SP up 16 bytes  
   ldp   x25, x26, [sp], #16     // Pop x25 and x26, then move SP up 16 bytes
   ldp   x23, x24, [sp], #16     // Pop x23 and x24, then move SP up 16 bytes
   ldp   x21, x22, [sp], #16     // Pop x21 and x22, then move SP up 16 bytes
   ldp   x19, x20, [sp], #16     // Pop x19 and x20, then move SP up 16 bytes

   RET                           // Return to caller

   .end
