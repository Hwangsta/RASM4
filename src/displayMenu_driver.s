   .global displayMenu_driver

   .data
szMenu1:        .asciz          "\t\tRASM4 TEXT EDITOR\n"                                                                                                                                                       // RASM4 TEXT EDITOR
szMenu2:        .asciz          "\tData Structure Heap Memory Consumption: "                                                                                                                                    // Data Structure Heap Memory Consumption:
szMenu2b:               .asciz  " bytes\n"                                                                                                                                                                      //  bytes
szMenu3:        .asciz          "\tNumber of Nodes: "                                                                                                                                                           // Number of Nodes:
szMenu4:        .asciz          "<1> View all strings\n\n"                                                                                                                                                      // <1> View all strings
szMenu5:        .asciz          "<2> Add string\n"                                                                                                                                                              // <2> Add string
szMenu6:        .asciz          "\t<a> from Keyboard\n"                                                                                                                                                         // <a> from Keyboard
szMenu7:        .asciz          "\t\<b> from File. Static file named input.txt\n\n"                                                                                                                             // <b> from File. Static file named input.txt
szMenu8:                        .asciz  "<3> Delete string. Given an index #, delete the entire string and de-allocate memory (including the node).\n\n"        // <3> Delete string. Given an index #, delete the entire string
                                                                                                                                                                                                                // and de-allocate memory (including the node).
szMenu9:                        .asciz  "<4> Edit string. Given an index #, replace old string w/ new string. Allocate/De-allocate as needed.\n\n"                      // <4> Edit string. Given an index #, replace old string w/ new
                                                                                                                                                                                                                // string. Allocate/De-allocate as needed.
szMenu10:               .asciz  "<5> String search. Regardless of case, return all strings that match the substring given.\n\n"                                                 // <5> String search. Regardless of case, return all strings that
                                                                                                                                                                                                                // match the substring given.
szMenu11:               .asciz  "<6> Save File (output.txt)\n\n"                                                                                                                                                // <6> Save File (output.txt)
szMenu12:               .asciz  "<7> Quit\n\n"                                                                                                                                                                  // <7> Quit
szMenu13:               .asciz  "Enter a number (1-7): "                                                                                                                                                                  // <7> Quit

szZeroBytes:    .asciz  "00000000"                                                                                                                                                                              // 0000000

szNumNodes:             .skip           21                                                                                                                                                                      // String to hold number of nodes
szTotalBytes:   .skip           21                                                                                                                                                                              // String to hold number of total bytes

chLF:                           .byte   0x0a                                                                                                                                                                    // New line
   .text
displayMenu_driver:
   stp   x19, x20, [sp, #-16]!   // Push x19 and x20, then move SP down 16 bytes
   stp   x21, x22, [sp, #-16]!   // Push x21 and x22, then move SP down 16 bytes
   stp   x23, x24, [sp, #-16]!   // Push x23 and x24, then move SP down 16 bytes
   stp   x25, x26, [sp, #-16]!   // Push x25 and x26, then move SP down 16 bytes
   stp   x27, x28, [sp, #-16]!   // Push x27 and x28, then move SP down 16 bytes
   stp   x29, x30, [sp, #-16]!   // Push x29 and x30, then move SP down 16 bytes

        // Save dbNumNodes & dbStrBytes (rasm3_driver in x19 & x20)
        mov     x19,x0                                          // Move address of dbNumNodes to x19
        mov     x20,x1                                          // Move address of dbStrBytes to x20

        ldr     x0,=szMenu1                                     // Load szMenu1
        bl              putstring                                       // Print szMenu1

        ldr     x0,=szMenu2                                     // Load szMenu2
        bl              putstring                                       // Print szMenu2

        // load parameters for calcBytes
        mov     x0,x19                                          // Move numNodes back to x0
        mov     x1,x20                                          // Move strBytes back to x1

        bl              calcBytes                                       // Calculate bytes

        mov     x21,x0                                          // Move total # of bytes into x21

        /****************** Convert total bytes to str and output ******************/
        ldr     x1,=szTotalBytes                        // Load address of szTotalBytes into x1

        bl              int64asc                                                // Convert int to str

        cmp     x21,#0                                          // Check if total bytes is 0
        beq     total_bytes_zero                        // Branch if total bytes is 0

        ldr     x0,=szTotalBytes                        // Load address of converted int
        bl              putstring                                       // Print

print_total_bytes:
        ldr     x0,=szMenu2b                            // Load szMenu3b
        bl              putstring                                       // Print szMenu3b


//  PRINT # OF NODES
        ldr     x0,=szMenu3                                     // Load szMenu3
        bl              putstring                                       // Print szMenu3

        /****************** Convert dbNumNodes to str and output ******************/
        mov     x0,x19                                          // Load address of dbNumNodes
        ldr     x0,[x0]                                         // Load contents of dbNumNodes
        ldr     x1,=szNumNodes                          // Load address of szNumNodes into x1

        bl              int64asc                                                // Convert int to str

        ldr     x0,=szNumNodes                          // Load address of converted int
        bl              putstring                                       // Print

        ldr     x0,=chLF                                                // Load line feed
        bl              putch                                                   // Print

        ldr     x0,=szMenu4                                     // Load szMenu4
        bl              putstring                                       // Print szMenu4

        ldr     x0,=szMenu5                                     // Load szMenu5
        bl              putstring                                       // Print szMenu5

        ldr     x0,=szMenu6                                     // Load szMenu6
        bl              putstring                                       // Print szMenu6

        ldr     x0,=szMenu7                                     // Load szMenu7
        bl              putstring                                       // Print szMenu7

        ldr     x0,=szMenu8                                     // Load szMenu8
        bl              putstring                                       // Print szMenu8

        ldr     x0,=szMenu9                                     // Load szMenu9
        bl              putstring                                       // Print szMenu9

        ldr     x0,=szMenu10                            // Load szMenu10
        bl              putstring                                       // Print szMenu10

        ldr     x0,=szMenu11                            // Load szMenu11
        bl              putstring                                       // Print szMenu11

        ldr     x0,=szMenu12                            // Load szMenu12
        bl              putstring                                       // Print szMenu12

        ldr     x0,=szMenu13                            // Load szMenu13
        bl              putstring                                       // Print szMenu12


   ldp   x29, x30, [sp], #16     // Pop x29 and x30, then move SP up 16 bytes
   ldp   x27, x28, [sp], #16     // Pop x27 and x28, then move SP up 16 bytes
   ldp   x25, x26, [sp], #16     // Pop x25 and x26, then move SP up 16 bytes
   ldp   x23, x24, [sp], #16     // Pop x23 and x24, then move SP up 16 bytes
   ldp   x21, x22, [sp], #16     // Pop x21 and x22, then move SP up 16 bytes
   ldp   x19, x20, [sp], #16     // Pop x19 and x20, then move SP up 16 bytes

   RET                           // Return to caller

total_bytes_zero:
        ldr     x0,=szZeroBytes
        bl              putstring
        b               print_total_bytes

   .end
