.global String_indexOf_3

   .data

   .text
String_indexOf_3:
   stp   x19, x20, [sp, #-16]!   // Push x19 and x20, then move SP down 16 bytes
   stp   x21, x22, [sp, #-16]!   // Push x21 and x22, then move SP down 16 bytes
   stp   x23, x24, [sp, #-16]!   // Push x23 and x24, then move SP down 16 bytes
   stp   x25, x26, [sp, #-16]!   // Push x25 and x26, then move SP down 16 bytes
   stp   x27, x28, [sp, #-16]!   // Push x27 and x28, then move SP down 16 bytes
   stp   x29, x30, [sp, #-16]!   // Push x29 and x30, then move SP down 16 bytes

        mov     x19, x0                                         // save main string parameter address in x19
        mov     x20, x1                                         // save target string address in x20

        mov     x0, x20                                         // put target string in x0
        bl              String_length                           // get length of target string
        mov     x21, x0                                         // store string length in x21

        mov     x22, #0                                         // store index in x22
loop:

                // make sure there is enough space to make substring
                //      (if not enough space, goto no_match)
                mov     x0, x19                                 // load main string into parameter

                add     x1, x21, x22                    // add length of target string to current index
                ldrb    w3, [x0, x22]                   // load on char

                cmp     w3, #0                                  // check if character is null
                beq     no_match                                        // if null, goto no_match


                // make substring to check portion of main string
                mov     x1, x22                                 //      index is lower bound of substring
                add     x2, x22, x21                    // add target string length to index
                                                                                        // to get upper bound
                bl              String_substring_1      // call substring to check portion of main string

                mov     x23, x0                                 // save heap address to de-allocate


                // check if portion of main string matches target string
                mov     x1, x20                                 // put target string in parameter
                bl              String_equalsIgnoreCase                   // x0 has substring and is checked with target

                mov     x24, x0                                 // save true/false in x24


                // de-allocate portion of main string to free up heap
                mov     x0, x23                                 // load heap address
                bl              free                                            // de-allocate substring


                cmp     x24,#1                                  // compare true/false from String_equal to true
                beq     string_match                    // if true, then strings match

                add     x22, x22, #1                    // increment index

                b               loop                                            // loop again

string_match:
                mov     x0, x22                                 // return index

                b               exit_sequence                   // skip no_match

no_match:
                mov     x0, #-1                                 // return index

exit_sequence:

   ldp   x29, x30, [sp], #16     // Pop x29 and x30, then move SP up 16 bytes
   ldp   x27, x28, [sp], #16     // Pop x27 and x28, then move SP up 16 bytes
   ldp   x25, x26, [sp], #16     // Pop x25 and x26, then move SP up 16 bytes
   ldp   x23, x24, [sp], #16     // Pop x23 and x24, then move SP up 16 bytes
   ldp   x21, x22, [sp], #16     // Pop x21 and x22, then move SP up 16 bytes
   ldp   x19, x20, [sp], #16     // Pop x19 and x20, then move SP up 16 bytes

   RET                           // Return to caller

   .end
