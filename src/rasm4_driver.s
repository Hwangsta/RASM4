/*
 * Programmers          : Mason Muoio & Alex Hwang
 * RASM                 : 3
 * Purpose              : Display menu for editing
 *                        a text file.
 * Author               : Dr. Barnett
 * Date late modified   : 2nd May 2024
*/

   .global main
               .equ  BUFFER,  512

   .data

szBuffer:      .skip    BUFFER

headPtr_main:       .quad    0                              // tail of the linked list
tailPtr_main:       .quad    0                              // head of the linked list

dbNumNodes:             .quad           0              // number of nodes, used to pass as parameter
dbStrBytes:             .quad           0              // number of bytes of all the strings, used to pass as parameter

chLF:           .byte    0x0a


   .text
main:


ldr     x0,=headPtr_main
ldr     x1,=tailPtr_main
ldr     x2,=dbNumNodes
ldr     x3,=dbStrBytes
bl      readInputFile_driver

ldr     x0,=dbNumNodes
ldr     x1,=dbStrBytes
bl      displayMenu_driver


ldr     x0,=headPtr_main
bl      viewLinkedList_driver


mov     x2, #3
ldr     x0,=headPtr_main
ldr     x1,=tailPtr_main
ldr     x3,=dbNumNodes
ldr     x4,=dbStrBytes
bl      deleteNode_driver

mov     x2, #6
ldr     x0,=headPtr_main
ldr     x1,=tailPtr_main
ldr     x3,=dbNumNodes
ldr     x4,=dbStrBytes
bl      deleteNode_driver


ldr     x0,=dbNumNodes
ldr     x1,=dbStrBytes
bl      displayMenu_driver

ldr     x0,=headPtr_main
bl      viewLinkedList_driver


///////////////// FOR HEAP MEMORY CONSUMPTION - MAKE SURE EVERYTIME WE MALLOC, WE ADD THE BYTES UP ***********************//////////////////

/******************************************************************************/


/****** Free up heap allocations **********************************************/
 /*  mov   x0, x21                       // Move address of modified input1Str into x0
   bl    free                          // free that heap block

   mov   x0, x22                       // Move address of modified input2Str into x0
   bl    free                          // free that heap block

   mov   x0, x23                       // Move address of modified input3Str into x0
   bl    free                          // free that heap block

   ldr   x0, [sp], #16                 // Pop the address of intermediate dynamic str into x0
   bl    free                          // free that heap block
   ldr   x0, [sp], #16                 // Pop the address of intermediate dynamic str into x0
   bl    free                          // free that heap block
   ldr   x0, [sp], #16                 // Pop the address of intermediate dynamic str into x0
   bl    free                          // free that heap block
   ldr   x0, [sp], #16                 // Pop the address of intermediate dynamic str into x0
   bl    free                          // free that heap block */
/******************************************************************************/


/****** Terminate program ******/
   ldr   x0, =chLF                     // Load &chLF into x0
   bl    putch                         // Print a new line char

   mov   x0, #0                        // Use 0 return code
   mov   x8, #93                       // Service code 93 terminates
   svc   0                             // Call Linux to terminate


/****** Helper function for ***************************************************/


/******************************************************************************/


   .end
