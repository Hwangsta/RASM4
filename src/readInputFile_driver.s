.global readInputFile_driver

                                        .equ BUFFER, 512                        // Buffer size

// file modes
                                        .equ  R,    00          // Read only
               .equ  W,    01          // Write only
               .equ  RW,   02          // Read write
               .equ  T_RW, 01002       // Truncate read write
               .equ  C_W,  0101        // Create file if does not exist

// file permissions
               .equ  RW_______,0600    // chmod permissions

               .equ  AT_FDCWD, -100     // File Descriptor Current Working Directory

   .data

szFile:         .skip           BUFFER                            // file to be read from
fileBuf:        .skip    BUFFER                                           // space in text file
bFD:            .byte    0                                                // byte initialized to zero
szEOF:          .asciz   "Reached the End of File\n"   // if reach max space in text file
szERROR:        .asciz   "FILE READ ERROR\n"                   // error message
szPrompt:       .asciz  "\nEnter file name: "                           // prompt for user to enter file

   .text
readInputFile_driver:
   stp   x19, x20, [sp, #-16]!   // Push x19 and x20, then move SP down 16 bytes
   stp   x21, x22, [sp, #-16]!   // Push x21 and x22, then move SP down 16 bytes
   stp   x23, x24, [sp, #-16]!   // Push x23 and x24, then move SP down 16 bytes
   stp   x25, x26, [sp, #-16]!   // Push x25 and x26, then move SP down 16 bytes
   stp   x27, x28, [sp, #-16]!   // Push x27 and x28, then move SP down 16 bytes
   stp   x29, x30, [sp, #-16]!   // Push x29 and x30, then move SP down 16 bytes

        mov     x19,x0                                          // x0 is holding headPtr mov to x19 for later use
        mov     x20,x1                                          // x1 is holding tailPtr mov to x20 for later use
        mov     x21,x2                                          //      x2 is holding the address of dbNumNodes and moving it into x21
        mov     x22,x3                                          // x3 is holding the address of dbStrBytes and moving it into x22

        // get file name from user
        ldr     x0,=szPrompt
        bl              putstring

        ldr     x0,=szFile                                              // load address that holds file name
        mov     x1, BUFFER                                              // load buffer size
        bl              getstring                                               // get string from user

open_file:
   // open file
   mov     x0, #AT_FDCWD           // local directory
   mov     x8, #56                         // OPENAT
   ldr     x1,=szFile                      // file name

   mov     x2, #R                          // Flags read-only, create if doesnt exist
   mov     x3, #RW_______          // MODE RW-------
   SVC     0                                               // Service call

   ldr     x4,=bFD                         // point to bFD
   strb    w0,[x4]                         // store w0 in bFD

// check if file read correctly
        cmp     x0,#-1                                                          // compare to -1
        bgt     successful_read                                 // skip error message

   ldr     x0,=szERROR                                          // load address
   bl      putstring                                                    // call putstring

        b                 exit                                                          // exit code
successful_read:


driver:
   ldr     x1,=fileBuf                     // load address

   bl      getline                         // call function
   cmp     x0, #0                          // did we reach end of file?
   beq     close_file                      // close file if reached end

/****** FOR TEST PURPOSES (delete later)************/

   ldr     x0,=fileBuf                     // print the line that was just read

   mov     x4,x22                                                  //      strBytes's address is passed as a parameter in x4
   mov     x3,x21                                                  //      numNodes's address is passed as a parameter in x3
   mov     x2,x0                                                   // store the current line string's address to x2
   mov     x1,x20                                          //      re-load the tailPtr back into x1
   mov     x0,x19                                          //      re-load the headPtr back into x0
   bl      addNode                                         // pass parameters for adding a node and branch


   ldr     x0,=bFD                         //
   ldrb    w0,[x0]                         // x0 = bFD

   b       driver                          // while we keep getting data

close_file:
   ldr     x0,=bFD                         // x0 needs to have the file handle in it
   ldrb    w0,[x0]                         // x0 = bFD

   mov     x8,#57                          // close file
   svc     0                                               // service call

exit:
        // Exit the driver

   ldp   x29, x30, [sp], #16     // Pop x29 and x30, then move SP up 16 bytes
   ldp   x27, x28, [sp], #16     // Pop x27 and x28, then move SP up 16 bytes
   ldp   x25, x26, [sp], #16     // Pop x25 and x26, then move SP up 16 bytes
   ldp   x23, x24, [sp], #16     // Pop x23 and x24, then move SP up 16 bytes
   ldp   x21, x22, [sp], #16     // Pop x21 and x22, then move SP up 16 bytes
   ldp   x19, x20, [sp], #16     // Pop x19 and x20, then move SP up 16 bytes

   RET                           // Return to caller

getchar:
        str     x30,[SP,#-16]!        // push LR

   mov     x2,#1                 // attempt to read in one byte

   mov     x8,#63                // READ
   svc     0                     // does the lr change

   ldr     x30,[SP],#16          // popped in reverse order (LIFO)

   ret

getline:
   str     x30,[SP,#-16]!        // push LR

top:
   bl      getchar               // branch and link

   cmp     w0,#0x0               // nothing read from file
        blt       ERROR                                         // if less than handle error
   beq     EOF                   // got EOF if equal to 0x0

   ldrb    w2,[x1]               // x0 = bFD
   cmp     w2,#0xa               // is this character LF?

   beq     EOLINE                // branch to EOLINE

   // good
   // move file buffer pointer by 1
   add     x1,x1,#1              // concerned that x1 gets wrecked

        ldr     x0,=bFD          // reload pointer
        ldrb    w0,[x0]          //      load one byte
        b       top              // branch to top

EOLINE:
        add     x1,x1,#1         // we are going to make fileBuf into a c-string
        mov     w2,#0            // by store null at the end of fileBuf (i.e. "Cat in the hat.\0")
        strb    w2,[x1]

        b       skip

// Handling case if we are at End of File
EOF:
        // Assuming x1 points to the current position in fileBuf
         sub            x1,x1,#1
    ldrb    w2, [x1]               // Check the current buffer position
    cbz     w2, skip               // If zero, skip processing (buffer empty)
    // Process the remaining data in buffer as a line

         // add a new line at end of file
         add     x1, x1, #1             // Move buffer pointer forward for null termination
    mov     w2, #0xa               // Prepare a zero byte
    strb    w2, [x1]               // Null-terminate the string

    add     x1, x1, #1             // Move buffer pointer forward for null termination
    mov     w2, #0                 // Prepare a zero byte
    strb    w2, [x1]               // Null-terminate the string
    mov     x0, x19                // Restore original x0 if needed
    b       skip                   // Proceed to return

// Error if file cannot be oppened
ERROR:
        mov     x19,x0
        ldr     x0,=szERROR
        bl      putstring
        mov     x0,x19
        b       skip

skip:
        ldr     x30,[SP],#16

        ret


   .end
