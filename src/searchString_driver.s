.global searchString_driver

        .equ    BUFFER, 512
   .data

szPrompt:               .asciz  "\nEnter a string to search: "          // Prompt for substring

szOut1:                 .asciz  "Search \""                                                                     // First part of output
szOut2:                 .asciz  "\" ("                                                                          // second part of output
szOut3:                 .asciz  " hits in 1 file of 1 searched)\n"      // 3rd part of output
szOut4:                 .asciz  "\tLine "                                                                       // 4th part of output

szBuffer:               .skip           BUFFER                                                                          // Buffer for substring

szOutBuf:               .skip           BUFFER                                                                          // Buffer for output

chColon:                        .byte           0x3a                                                                                    // ':'

   .text
searchString_driver:
   stp   x19, x20, [sp, #-16]!   // Push x19 and x20, then move SP down 16 bytes
   stp   x21, x22, [sp, #-16]!   // Push x21 and x22, then move SP down 16 bytes
   stp   x23, x24, [sp, #-16]!   // Push x23 and x24, then move SP down 16 bytes
   stp   x25, x26, [sp, #-16]!   // Push x25 and x26, then move SP down 16 bytes
   stp   x27, x28, [sp, #-16]!   // Push x27 and x28, then move SP down 16 bytes
   stp   x29, x30, [sp, #-16]!   // Push x29 and x30, then move SP down 16 bytes

        // Parameters: x0 - &headPtr
        mov     x19,x0                                          // Move address of headPtr into x19
        mov     x22,x0                                          // Move address of headPtr into x22

        // Hits = X20
        mov     x20,#0                                          // Initiate hits counter to 0

        // Lines = X21
        mov     x21,#0                                          // Initiate lines counter to 0

        ldr     x0,=szPrompt                            // Load &szPrompt into x0
        bl              putstring                                       // Print

        ldr     x0,=szBuffer                            // Load &szBuffer into x0
        mov     x1,#BUFFER                                      // Move size of szBuffer into x1
        bl              getstring





count_hits:

   LDR   X19,[X19]

   CMP   X19,#0                   // Checking for empty list
   BEQ   count_hits_exit

        // Need to pass x0 (main string) & x1 (substring) into String_indexOf_3

   LDR   X0,[X19]                  // Double de-reference

        LDR     X1,=szBuffer
        BL              String_indexOf_3                        // Function will return -1 if substring is not found
                                                                                        // otherwise, will return an index #

        CMP     X0,#-1
        BEQ     not_found                                       // If return value is -1, substring is not found

        ADD     X20,X20,#1                                      // Increment # of hits each time substring is found in a node

        not_found:

   ADD   X19,X19,#8              // Jump the x1 -> next field
   B     count_hits

count_hits_exit:

        ldr     x0,=szOut1                                      // Load &szOut1 into x0
        bl              putstring                                       // Print

        ldr     x0,=szBuffer                            // Load &szBuffer into x0
        bl              putstring                                       // Print

        ldr     x0,=szOut2                                      // Load &szOut1 into x0
        bl              putstring                                       // Print

        mov     x0,x20                                          // Move hits count into x0
        ldr     x1,=szOutBuf                            // Load &szOutBuf into x1
        bl              int64asc                                                // Convert hits count to string

        ldr     x0,=szOutBuf                            // Load &szOutBuf into x0
        bl              putstring                                       // Print # of hits

        ldr     x0,=szOut3                                      // Load &szOut3 into x0
        bl              putstring                                       // Print

        mov     x19,x22                                         // Move address of headPtr back into x19

traverse_lines:

   LDR   X19,[X19]

   CMP   X19,#0                   // Checking for empty list
   BEQ   traverse_lines_exit

        // Need to pass x0 (main string) & x1 (substring) into String_indexOf_3

   LDR   X0,[X19]                  // Double de-reference

        LDR     X1,=szBuffer
        BL              String_indexOf_3                        // Function will return -1 if substring is not found
                                                                                        // otherwise, will return an index #

        ADD     X21,X21,#1                                      // Increment # of hits each time substring is found in a node

        CMP     X0,#-1
        BEQ     not_found_line                                  // If return value is -1, substring is not found

        LDR     X0,=szOut4                                              // Load &szOut4 into x0
        BL              putstring                                               // Print

        MOV     x0,x21                                          // Move line count into x0
        LDR     x1,=szOutBuf                            // Load &szOutBuf into x1
        BL              int64asc                                                // Convert line count to string

        LDR     x0,=szOutBuf                            // Load &szOutBuf into x0
        BL              putstring                                       // Print # of hits

        LDR     X0,=chColon                                     // Load &chColon into x0
        BL              putch                                                   // Print ':'

   LDR   X0,[X19]                  // Double de-reference
        BL              putstring


        MOV     X0,X21                                                  // Move x21 into x0

        not_found_line:

   ADD   X19,X19,#8              // Jump the x1 -> next field
   B     traverse_lines

traverse_lines_exit:



   ldp   x29, x30, [sp], #16     // Pop x29 and x30, then move SP up 16 bytes
   ldp   x27, x28, [sp], #16     // Pop x27 and x28, then move SP up 16 bytes
   ldp   x25, x26, [sp], #16     // Pop x25 and x26, then move SP up 16 bytes
   ldp   x23, x24, [sp], #16     // Pop x23 and x24, then move SP up 16 bytes
   ldp   x21, x22, [sp], #16     // Pop x21 and x22, then move SP up 16 bytes
   ldp   x19, x20, [sp], #16     // Pop x19 and x20, then move SP up 16 bytes

   RET                           // Return to caller

   .end
