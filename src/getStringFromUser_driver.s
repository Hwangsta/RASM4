.global getStringFromUser_driver


        .equ  BUFFER,  512                                                              // Size of string buffer

        .data

szBuffer:   .skip    BUFFER                                             // Buffer to hold string input
szPrompt:       .asciz  "Enter a string: "              // String prompt for user to input string

chLF:                   .byte           0x0a                                                    // Line feed

   .text
getStringFromUser_driver:
   stp   x19, x20, [sp, #-16]!   // Push x19 and x20, then move SP down 16 bytes
   stp   x21, x22, [sp, #-16]!   // Push x21 and x22, then move SP down 16 bytes
   stp   x23, x24, [sp, #-16]!   // Push x23 and x24, then move SP down 16 bytes
   stp   x25, x26, [sp, #-16]!   // Push x25 and x26, then move SP down 16 bytes
   stp   x27, x28, [sp, #-16]!   // Push x27 and x28, then move SP down 16 bytes
   stp   x29, x30, [sp, #-16]!   // Push x29 and x30, then move SP down 16 bytes

        // PARAMETERS
        // X0 - headPtr ,       X1 - tailPtr    ,       X2 - numNodes   ,       X3      - strBytes
        mov     x19,x0                                          // Store &headPtr into x19
        mov     x20,x1                                          // Store &tailPtr into x20
        mov     x21,x2                                          // Store &numNodes into x21
        mov     x22,x3                                          // Store &strBytes into x22

        ldr     x0,=chLF                                                // Load &chLF into x0
        bl              putch                                                   // Print line feed
        ldr     x0,=chLF                                                // Load &chLF into x0
        bl              putch                                                   // Print line feed

        // Requesting user to enter string
        ldr     x0,=szPrompt                            // Load &szPrompt into x0
        bl              putstring                                       // Print prompt

        ldr     x0,=szBuffer                            // Load &szBuffer into x0
        mov     x1,BUFFER                                       // Load 512 into x1
        bl              getstring                                       // Get string from user

        mov     x0,x19                                          // Store &headPtr back into x0
        mov     x1,x20                                          // Store &tailPtr back into x1
        ldr     x2,=szBuffer                            // store &szBuffer into x2
        mov     x3,x21                                          // Store &numNodes back into x2
        mov     x4,x22                                          // Store &strBytes back into x3

        bl              addNode                                         // Add string as a node to the linked list

   ldp   x29, x30, [sp], #16     // Pop x29 and x30, then move SP up 16 bytes
   ldp   x27, x28, [sp], #16     // Pop x27 and x28, then move SP up 16 bytes
   ldp   x25, x26, [sp], #16     // Pop x25 and x26, then move SP up 16 bytes
   ldp   x23, x24, [sp], #16     // Pop x23 and x24, then move SP up 16 bytes
   ldp   x21, x22, [sp], #16     // Pop x21 and x22, then move SP up 16 bytes
   ldp   x19, x20, [sp], #16     // Pop x19 and x20, then move SP up 16 bytes

   RET                           // Return to caller

   .end
