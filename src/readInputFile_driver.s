   .global readInputFile_driver

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

szFile:  .asciz   "input.txt"                           // file to be read from
fileBuf: .skip    512                                           // space in text file
bFD:     .byte    0                                                // byte initialized to zero
szEOF:   .asciz   "Reached the End of File\n"   // if reach max space in text file
szERROR: .asciz   "FILE READ ERROR\n"                   // error message


   .text
readInputFile_driver:
   stp   x19, x20, [sp, #-16]!   // Push x19 and x20, then move SP down 16 bytes
   stp   x21, x22, [sp, #-16]!   // Push x21 and x22, then move SP down 16 bytes
   stp   x23, x24, [sp, #-16]!   // Push x23 and x24, then move SP down 16 bytes
   stp   x25, x26, [sp, #-16]!   // Push x25 and x26, then move SP down 16 bytes
   stp   x27, x28, [sp, #-16]!   // Push x27 and x28, then move SP down 16 bytes
   stp   x29, x30, [sp, #-16]!   // Push x29 and x30, then move SP down 16 bytes

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

driver:
   ldr     x1,=fileBuf                     // load address

   bl      getline                         // call function
   cmp     x0, #0                          // did we reach end of file?
   beq     close_file                      // close file if reached end

/****** FOR TEST PURPOSES (delete later)************/
   ldr     x0,=fileBuf                     // print the line that was just read
   bl      putstring                       // call putstring

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
        mov     x19,x0
        ldr     x0,=szEOF
        bl      putstring
        mov     x0,x19
        b       skip

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
