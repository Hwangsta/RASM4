.global displayMenu_driver

   .data
szMenu1:        .asciz          "\t\tRASM4 TEXT EDITOR\n"                                                                                                                                                       // RASM4 TEXT EDITOR
szMenu2:        .asciz          "\tData Structure Heap Memory Consumption: "                                                                                                                                    // Data Structure Heap Memory Consumption:
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

szMenu12:               .asciz  "<7> Quit\n"                                                                                                                                                                    // <7> Quit
szClear:                        .asciz  "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"                          // To clear terminal

chLF:                           .byte   0x0a                                                                                                                                                                    // New line

   .text
displayMenu_driver:
   stp   x19, x20, [sp, #-16]!   // Push x19 and x20, then move SP down 16 bytes
   stp   x21, x22, [sp, #-16]!   // Push x21 and x22, then move SP down 16 bytes
   stp   x23, x24, [sp, #-16]!   // Push x23 and x24, then move SP down 16 bytes
   stp   x25, x26, [sp, #-16]!   // Push x25 and x26, then move SP down 16 bytes
   stp   x27, x28, [sp, #-16]!   // Push x27 and x28, then move SP down 16 bytes
   stp   x29, x30, [sp, #-16]!   // Push x29 and x30, then move SP down 16 bytes

        ldr     x0,=szClear                                     // Load szClear
        bl              putstring                                       // Clear the terminal

        ldr     x0,=szMenu1                                     // Load szMenu1
        bl              putstring                                       // Print szMenu1

        ldr     x0,=szMenu2                                     // Load szMenu2
        bl              putstring                                       // Print szMenu2


        ldr     x0,=chLF                                                // Load line feed
        bl              putch                                                   // Print

        ldr     x0,=szMenu3                                     // Load szMenu3
        bl              putstring                                       // Print szMenu3

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


   ldp   x29, x30, [sp], #16     // Pop x29 and x30, then move SP up 16 bytes
   ldp   x27, x28, [sp], #16     // Pop x27 and x28, then move SP up 16 bytes
   ldp   x25, x26, [sp], #16     // Pop x25 and x26, then move SP up 16 bytes
   ldp   x23, x24, [sp], #16     // Pop x23 and x24, then move SP up 16 bytes
   ldp   x21, x22, [sp], #16     // Pop x21 and x22, then move SP up 16 bytes
   ldp   x19, x20, [sp], #16     // Pop x19 and x20, then move SP up 16 bytes

   RET                           // Return to caller

   .end
