   .global editString_driver

.equ  BUFFER,  512                                                              // Size of string buffer

   .data

szBuffer:   .skip    BUFFER                                             // Buffer to hold string input
szPrompt:       .asciz  "Enter a string: "              // String prompt for user to input string

chLF:                   .byte           0x0a                                                    // Line feed

   .text
editString_driver:
   stp   x19, x20, [sp, #-16]!   // Push x19 and x20, then move SP down 16 bytes
   stp   x21, x22, [sp, #-16]!   // Push x21 and x22, then move SP down 16 bytes
   stp   x23, x24, [sp, #-16]!   // Push x23 and x24, then move SP down 16 bytes
   stp   x25, x26, [sp, #-16]!   // Push x25 and x26, then move SP down 16 bytes
   stp   x27, x28, [sp, #-16]!   // Push x27 and x28, then move SP down 16 bytes
   stp   x29, x30, [sp, #-16]!   // Push x29 and x30, then move SP down 16 bytes

        // x0 = headPtr, x1 = index, x2 = strBytes
        mov     x19,x0                                          // Store &headPtr into x19
        mov     x20,x1                  // Store index into x20
        mov     x21,x2                  // Store &strBytes into x21

        ldr     x0,=chLF                // Load &chLF into x0
        bl              putch                   // Print line feed

        // Requesting user to enter string
        ldr     x0,=szPrompt                            // Load &szPrompt into x0
        bl      putstring                                       // Print prompt

        ldr     x0,=szBuffer                            // Load &szBuffer into x0
        mov     x1,BUFFER                                       // Load 512 into x1
        bl      getstring                                       // Get string from user

        ldr     x0,=szBuffer                            // load address of buffer

        bl              add_newLine                                     // branch and link to add_newLine


        traverse:
        // Additionally, we have to preserve the LR due to BL MALLOC
        mov     x22, #1                                         // initialize the counter to 1

traverse_loop:
        ldr     x19,[x19]

        cmp     x19,#0                                  // checking for empty list
        beq     traverse_exit

        add     x19,x19,#8                              // jump the x1 -> next field

        cmp     x22, x20
        beq     index_found                                    // jump to index_found if counter matches the previous index number

        add     x22,x22,#1                                      // increment counter
        b       traverse_loop


index_found:
   sub     x19,x19,#8


   // subtract current string's bytes and update strBytes
        ldr     x0,[x19]
   bl              String_length

   add     x0, x0, #1                                                              // add null

   ldr     x1, [x21]
   sub     x0, x1, x0
   str     x0,[x21]

        // add new string's number of bytes
        ldr     x0,=szBuffer                            // load address of buffer
   bl              String_length

        add     x0, x0, #1                                                              // add null

   ldr     x1, [x21]
   add     x0, x1, x0
   str     x0,[x21]

        // delete old string's address from the link list
        ldr     x0,[x19]
        bl              free

        // add the new string to the node
        ldr     x0,=szBuffer
        bl              String_copy

        str     x0,[x19]



traverse_exit:

   ldp   x29, x30, [sp], #16     // Pop x29 and x30, then move SP up 16 bytes
   ldp   x27, x28, [sp], #16     // Pop x27 and x28, then move SP up 16 bytes
   ldp   x25, x26, [sp], #16     // Pop x25 and x26, then move SP up 16 bytes
   ldp   x23, x24, [sp], #16     // Pop x23 and x24, then move SP up 16 bytes
   ldp   x21, x22, [sp], #16     // Pop x21 and x22, then move SP up 16 bytes
   ldp   x19, x20, [sp], #16     // Pop x19 and x20, then move SP up 16 bytes

   RET                           // Return to caller

add_newLine:

        str     x30,[sp,#-16]!

// TRAVERSE STRING TO ADD LINE FEED BEFORE NULL
// REPLACE NULL WITH LF THEN ADD NULL TO ADDRESS+1

        // Initialize counter
        mov     x23,#0

        mov     x24,x0                                          // Store address of string in x24

traverse_string:
        ldrb    w1,[x0,x23]                                     // Load contents of string

        cmp     w1,#0                                                   // Compare the indexed byte to null
        beq     end_of_string                           // branch to end_of_string if null

        add     x23,x23,#1                                      // Add 1 to counter

        b               traverse_string                 // Loop back
end_of_string:
        add     x2,x0,x23                                       // Address of null into x2
        mov     w3,#0x0a                                                // Move line feed into x3

        strb    w3,[x2]                                         // Store line feed into address that has null

        add     x2,x2,#1                                                // Add 1 to the address of line feed (replaced null)

        mov     w3,#0                                                   // Move null into x3
        strb    w3,[x2]                                         // Store null into address after line feed

        ldr     x30, [sp], #16

        ret

   .end
