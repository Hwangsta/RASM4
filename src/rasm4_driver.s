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

szFreezeMenu:   .asciz  "\n[Press enter to display menu.]\n\n"
szCase2Out:             .asciz  "Enter 'a' or 'b': "

szCase2AOut:    .asciz  "\n*** Added string to linked list. ***\n\n"
szCase2BOut:    .asciz  "\n*** Read from \"input.txt\" into linked list. ***\n\n"
szCase3Out:             .asciz  "\n*** Deleted string from entered index. ***\n\n"
szCase4Out:             .asciz  "\n*** Edited string from entered index. ***\n\n"
szCase6Out:             .asciz  "\n*** Saved linked list to \"output.txt\". ***\n\n"
szCase7Out:             .asciz  "\n*** Deleted linked list... *** \n *** Quitting Program ***\n\n"


headPtr_main:       .quad    0                        // tail of the linked list
tailPtr_main:       .quad    0                        // head of the linked list

dbNumNodes:             .quad           0             // number of nodes, used to pass as parameter
dbStrBytes:             .quad           0             // number of bytes of all the strings, used to pass as parameter

chLF:           .byte    0x0a

szClear:                        .asciz  "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
   .text
main:


/*********** start switch cases ****************/

input_loop:                                                                                                                     // loop until user quits

        ldr     x0, =chLF
        bl              putch

        // display menu
        ldr     x0,=dbNumNodes                                                                          // load address of dbNumNodes into parameter x0
        ldr     x1,=dbStrBytes                                                                          // load address of dbStrBytess into parameter x1
        bl      displayMenu_driver                                                                      // call driver

        bl              get_input                                                                                               // call get_input which returns one char in x0

        // check case 1
        cmp     x0,#'1'                                                                                                 // compare to ascii 1
        beq     case_1                                                                                                  // branch to case_1

        b skip_1                                                                                                                        // skip to next case

case_1:
        ldr     x0,=headPtr_main                                                                        // load address of headPtr into parameter
        bl      viewLinkedList_driver                                                           // call function

skip_1:

        // check case 2
        cmp     x0,#'2'                                                                                                 // compare to ascii 2
        beq     case_2                                                                                                  // branch to case_2

        b skip_2                                                                                                                        // skip to next case

case_2:

        ldr     x0,=szCase2Output                                                                               // load address of prompt
        bl              putstring                                                                                               // call function

        bl              get_input                                                                                               // call get_input to check for 'a' or 'b'

                // check case a
                cmp     x0,#'a'                                                                                         // compare to ascii a
                beq     case_a                                                                                          // branch to case_a

                b skip_a                                                                                                                // skip to next case

        case_a:
                ldr     x0,=headPtr_main                                                                        // load x0 parameter
                ldr     x1,=tailPtr_main                                                                        // load x1 parameter
                ldr     x2,=dbNumNodes                                                                          // load x2 parameter
                ldr     x3,=dbStrBytes                                                                          // load x3 parameter
                bl              getStringFromUser_driver                                                // call function

        skip_a:

                // check case b
                cmp     x0,#'b'                                                                                         // compare to ascii b
                beq     case_b                                                                                          // branch to case_b

                b skip_b                                                                                                                // skip to next case

        case_b:
                ldr     x0,=headPtr_main
                ldr     x1,=tailPtr_main
                ldr     x2,=dbNumNodes
                ldr     x3,=dbStrBytes
                bl      readInputFile_driver

        skip_b:

skip_2:

        // check case 3
        cmp     x0,#'3'                                                                                                 // compare to ascii 3
        beq     case_3                                                                                                  // branch to case_3

        b skip_3                                                                                                                        // skip to next case

case_3:
        mov     x2, #1
        ldr     x0,=headPtr_main
        ldr     x1,=tailPtr_main
        ldr     x3,=dbNumNodes
        ldr     x4,=dbStrBytes
        bl      deleteNode_driver

skip_3:

        // check case 4
        cmp     x0,#'4'                                                                                                 // compare to ascii 4
        beq     case_4                                                                                                  // branch to case_4

        b skip_4                                                                                                                        // skip to next case

case_4:
        mov     x1, #1
        ldr     x0,=headPtr_main
        ldr     x2,=dbStrBytes
        bl      editString_driver

skip_4:

        // check case 6
        cmp     x0,#'6'                                                                                                 // compare to ascii 6
        beq     case_6                                                                                                  // branch to case_6

        b skip_6                                                                                                                        // skip to next case

case_6:
   ldr     x0,=headPtr_main
   bl              writeToFile_driver

skip_6:

        // out the freeze menu
        ldr     x0,=szFreezeMenu                                                                                // output Freeze Menu prompt
        bl              putstring                                                                                               // print

        bl              get_input                                                                                               // freeze

        // clear the screen
        ldr     x0,=szClear
        bl              putstring

        // loop user inputs again
        b               input_loop                                                                                              // loop until quit

/*
ldr     x0,=headPtr_main
ldr     x1,=tailPtr_main
ldr     x2,=dbNumNodes
ldr     x3,=dbStrBytes
bl      readInputFile_driver

ldr     x0,=dbNumNodes
ldr     x1,=dbStrBytes
bl      displayMenu_driver

ldr     x0,=chLF
bl              putch

ldr     x0,=headPtr_main
bl      viewLinkedList_driver


mov     x2, #1
ldr     x0,=headPtr_main
ldr     x1,=tailPtr_main
ldr     x3,=dbNumNodes
ldr     x4,=dbStrBytes
bl      deleteNode_driver

mov     x2, #1
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

ldr     x0,=headPtr_main
ldr     x1,=tailPtr_main
ldr     x2,=dbNumNodes
ldr     x3,=dbStrBytes
bl              getStringFromUser_driver

ldr     x0,=headPtr_main
ldr     x1,=tailPtr_main
ldr     x2,=dbNumNodes
ldr     x3,=dbStrBytes
bl              getStringFromUser_driver

ldr     x0,=headPtr_main
bl      viewLinkedList_driver

ldr     x0,=dbNumNodes
ldr     x1,=dbStrBytes
bl      displayMenu_driver

        ldr     x0,=headPtr_main
        bl              writeToFile_driver
*/

quit:
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
get_input:
        str     x30, [sp, #16]!                                         // push link register to stack

        ldr     x0, =szBuffer                                                   // load address of buffer
        mov     x1, #BUFFER                                                             // set buffer size
        bl      getstring                                                               // get user string

        ldr     x0, =szBuffer                                                   // load address of buffer
        ldrb    w0,[x0]                                                                 // load one character into x0

        ldr     x30, [sp], #16                                                  // pop the link register from stack

        ret                                                                                             // return to caller
/******************************************************************************/


   .end
