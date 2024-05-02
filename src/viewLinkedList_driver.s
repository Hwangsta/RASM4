.global viewLinkedList_driver


        .equ            BUFFER, 512
   .data

szBuffer:               .skip           BUFFER                                                                  // string buffer

szOutput:       .asciz  "**************** Linked List ****************"         // Output label for linked list output

chLF:                   .byte           0x0a                                                                                                                       // line feed

szOut1:                 .asciz  "["                                                                                             // Part of output
szOut2:                 .asciz  "] "                                                                                            // Part of output

   .text
viewLinkedList_driver:
   stp   x19, x20, [sp, #-16]!   // Push x19 and x20, then move SP down 16 bytes
   stp   x21, x22, [sp, #-16]!   // Push x21 and x22, then move SP down 16 bytes
   stp   x23, x24, [sp, #-16]!   // Push x23 and x24, then move SP down 16 bytes
   stp   x25, x26, [sp, #-16]!   // Push x25 and x26, then move SP down 16 bytes
   stp   x27, x28, [sp, #-16]!   // Push x27 and x28, then move SP down 16 bytes
   stp   x29, x30, [sp, #-16]!   // Push x29 and x30, then move SP down 16 bytes

traverse:

        mov   x19,x0
                  mov           x20,#1          // counter for index #

        ldr     x0,=chLF                                                // Load &chLF into x0
        bl              putch                                                   // Print

        ldr     x0,=szOutput                            // Load &szOutput into x0
        bl              putstring                                       // Print

        ldr     x0,=chLF                                                // Load &chLF into x0
        bl              putch                                                   // Print

traverse_top:
   ldr   x19,[x19]

   cmp   x19,#0                                  // checking for empty list
   beq   traverse_exit

        ldr     x0,=szOut1
        bl              putstring

        mov     x0,x20
        ldr     x1,=szBuffer
        bl              int64asc

        ldr     x0,=szBuffer
        bl              putstring

        ldr     x0,=szOut2
        bl              putstring

   str   x19,[sp,#-16]!

   ldr   x0,[x19]                                // double de-reference
   bl    putstring

        ldr   x19,[sp],#16

        add     x20,x20,#1

   add   x19,x19,#8                              // jump the x1 -> next field
   b     traverse_top

traverse_exit:

   ldp   x29, x30, [sp], #16     // Pop x29 and x30, then move SP up 16 bytes
   ldp   x27, x28, [sp], #16     // Pop x27 and x28, then move SP up 16 bytes
   ldp   x25, x26, [sp], #16     // Pop x25 and x26, then move SP up 16 bytes
   ldp   x23, x24, [sp], #16     // Pop x23 and x24, then move SP up 16 bytes
   ldp   x21, x22, [sp], #16     // Pop x21 and x22, then move SP up 16 bytes
   ldp   x19, x20, [sp], #16     // Pop x19 and x20, then move SP up 16 bytes

   RET                           // Return to caller

   .end
