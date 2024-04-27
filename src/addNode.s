   .global addNode

        .equ                    NODE_SIZE,      16                                                                              // Size of Node of linked list
   .data

newNodePtr:             .quad       0                                                      // used for creating a new node
newSzPtr:               .quad                   0                                                                               // used for copying string

headPtr:       .quad            0                         // tail of the linked list
tailPtr:       .quad            0                         // head of the linked list


.text

addNode:

        stp   x19, x20, [sp, #-16]!   // Push x19 and x20, then move SP down 16 bytes
   stp   x21, x22, [sp, #-16]!   // Push x21 and x22, then move SP down 16 bytes
   stp   x23, x24, [sp, #-16]!   // Push x23 and x24, then move SP down 16 bytes
   stp   x25, x26, [sp, #-16]!   // Push x25 and x26, then move SP down 16 bytes
   stp   x27, x28, [sp, #-16]!   // Push x27 and x28, then move SP down 16 bytes
   stp   x29, x30, [sp, #-16]!   // Push x29 and x30, then move SP down 16 bytes


        // double de-reference because we are passing the address of the pointers from main

        mov     x19,x0                                  // Save original headpointer address
        mov     x20,x1                                  // Save original tailpointer address

        ldr     x0,[x0]                                         // double de-reference headPtr and put contents into x0
        ldr     x8,=headPtr                             // Load address of local headPtr variable into x19
        str     x0,[x8]                                         // Store actual headptr (local to rasm3_driver) into headPtr

        ldr     x1,[x1]                                         // double de-reference tailPtr and put contents into x0
        ldr     x8,=tailPtr                             // Load address of local tailPtr variable into x20
        str     x1,[x8]                                         // Store actual tailptr (local to rasm3_driver) into tailPtr

        mov     x21,x2                                                  // Move address of string to copy into x0


   // Step 1:      Create new node

   mov     x0,NODE_SIZE
   bl      malloc                   // attempt to get block 16 bytes from the heap

   ldr     x1,=newNodePtr          // save address of the newNode
   str     x0,[x1]

   // step 2:      Copy passed string (ptr) into new heap memory
        mov     x0,x21
   bl      String_copy

   ldr     x1,=newNodePtr          // reload the newNodePtr
        ldr     x1,[x1] //temp

   str     x0,[x1]                                              // Store new copied string into newNodePtr


        // Step 3: Add new node to linked list
        ldr     x0,=headPtr                                     // Load address of headPtr
        ldr     x0,[x0]                                         // Dereference

        cmp     x0,#0
        beq     add_head_node

        ldr     x1,=newNodePtr
        ldr     x1,[x1]

//      str     x0,[x1]         // temp

// for node->next
        ldr     x0,=tailPtr
        ldr     x0,[x0]
        add     x0,x0,#8

        str     x1,[x0]

        ldr     x0,=tailPtr
        str     x1,[x0]

exit_sequence:

        ldr     x0,=headPtr
        ldr     x0,[x0]
        str     x0,[x19]

        ldr     x0,=tailPtr
        ldr     x0,[x0]
        str     x0,[x20]

   ldp   x29, x30, [sp], #16     // Pop x29 and x30, then move SP up 16 bytes
   ldp   x27, x28, [sp], #16     // Pop x27 and x28, then move SP up 16 bytes  
   ldp   x25, x26, [sp], #16     // Pop x25 and x26, then move SP up 16 bytes
   ldp   x23, x24, [sp], #16     // Pop x23 and x24, then move SP up 16 bytes
   ldp   x21, x22, [sp], #16     // Pop x21 and x22, then move SP up 16 bytes
   ldp   x19, x20, [sp], #16     // Pop x19 and x20, then move SP up 16 bytes

   RET                           // Return to caller

add_head_node:
        // Step: Insert newNode Into an empty linked list
        ldr     x1,=newNodePtr
        ldr     x1,[x1]


        ldr     x0,=headPtr
        str     x1,[x0]

        ldr     x0,=tailPtr
        str     x1,[x0]

        b               exit_sequence

   .end
