.global writeToFile_driver

        // file modes
             .equ    W, 0101            // creates if does not exist, for writing only

        // file permissions
             .equ    RW_RW____,0660     // chmod permissions

             .equ    AT_FDCWD, -100     // File Descriptor Current Working Directory
   .data

szFile:                 .asciz  "output.txt"          // file to be written to
iFD:                    .byte   0                     // byte initialized to 0

   .text
// x0 - &headPtr
writeToFile_driver:
   stp   x19, x20, [sp, #-16]!                          // Push x19 and x20, then move SP down 16 bytes
   stp   x21, x22, [sp, #-16]!                                  // Push x21 and x22, then move SP down 16 bytes
   stp   x23, x24, [sp, #-16]!                          // Push x23 and x24, then move SP down 16 bytes
   stp   x25, x26, [sp, #-16]!                          // Push x25 and x26, then move SP down 16 bytes
   stp   x27, x28, [sp, #-16]!                          // Push x27 and x28, then move SP down 16 bytes
   stp   x29, x30, [sp, #-16]!                          // Push x29 and x30, then move SP down 16 bytes

        mov     x19,x0                                                                  // Move &headPtr into x19

        // Load parameters for OPENAT
        // open file
   mov  x0, #AT_FDCWD                                   // local directory
   mov  x8, #56                                         // OPENAT
   ldr  x1,=szFile                                      // file name

   mov  x2, #W                                          // Flags write-only, create if doesnt exist
   mov  x3, #RW_RW____                                  // Permissions ...
   SVC  0                                               // Service call

   ldr  x1,=iFD                                 // point to iFD
   strb w0,[x1]                                 // store w0 in iFD

// Pre-requesite: headPtr points to either nullptr or a valid address
traverse:
        // Additionally, we have to preserve the LR due to BL MALLOC
   MOV  x20,x19                                                            // Move address of headPtr into x1

traverse_top:

// need to pop x1
   LDR   X20,[X20]                                                                      // Dereference address of headPtr

   CMP   X20,#0                            // Checking for empty list
   BEQ   traverse_exit                                                  // Branch if eq

        // Load parameters for WRITE (x8 - 64, x0 - int fd, x1 - const char *buf, x2 - size_t count)
   LDR   X0,[X20]                          // Double de-reference into x0
        mov     x21,x0

        bl              String_length                                                   // Get length of string in x0
        mov     x2,x0                                                                           // Move length of string into x2

        mov     x1,x21                                                                          // Store the string into x1

        ldr     x9,=iFD                                                                 // Load address of file descriptor
   ldrb w0,[x9]                                                                 // Load contents of fd into x0

   mov  x8, #64                          // mov 64 in x8

        svc     0                                // service call

   ADD   X20,X20,#8                        // Jump the x1 -> next field
   B     traverse_top


traverse_exit:
        mov     X8, #57                                                                                 // Service code 57
        ldr     x0,=iFD
        ldrb    w0,[x0]
   svc  0                                                                                               // Call Linux to terminate

   ldp   x29, x30, [sp], #16                                    // Pop x29 and x30, then move SP up 16 bytes
   ldp   x27, x28, [sp], #16                                    // Pop x27 and x28, then move SP up 16 bytes
   ldp   x25, x26, [sp], #16                                    // Pop x25 and x26, then move SP up 16 bytes
   ldp   x23, x24, [sp], #16                                    // Pop x23 and x24, then move SP up 16 bytes
   ldp   x21, x22, [sp], #16                                    // Pop x21 and x22, then move SP up 16 bytes
   ldp   x19, x20, [sp], #16                                    // Pop x19 and x20, then move SP up 16 bytes

   RET                                                          // Return to caller

   .end
