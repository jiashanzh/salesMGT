      ******************************************************************
      * Author:jiashan
      * Date:
      * Purpose: MAIN FUNCTION IN SALEMGT SYSTEM
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SALEMAIN.
       DATA DIVISION.
       FILE SECTION.
       WORKING-STORAGE SECTION.
       01 USER-MAIN-CHOICE PIC XX.
       COPY SALEPARAM.
       PROCEDURE DIVISION.
       MAIN-PROCEDURE SECTION.
           DISPLAY '**************************************************'
           DISPLAY '*                                                *'
           DISPLAY '*          GOODS SALES MANAGEMENT SYSTEM         *'
           DISPLAY '*                                                *'
           DISPLAY '**************************************************'

           PERFORM ACCEPT-OPTION UNTIL USER-MAIN-CHOICE="EX".

           MAIN-PROCDDURE-DONE.
           DISPLAY '**************************************************'
           DISPLAY '*                                                *'
           DISPLAY '*             THANKS FOR YOUR USEAGE             *'
           DISPLAY '*                                                *'
           DISPLAY '**************************************************'
           STOP RUN.

       ACCEPT-OPTION SECTION.
           DISPLAY 'EG>ENTER-NEW-GOODS   PG>PURCHASE-GOODS   '
                   'SG>SALE-GOODS   PT>PRINT EX>EXIT.'.
           DISPLAY 'ENTER YOUR CHOICE:'.
           ACCEPT USER-MAIN-CHOICE.
           EVALUATE USER-MAIN-CHOICE
               WHEN 'EG'
                   CALL 'GOODS'
               WHEN 'PG'
                   CALL 'PURCHASE'
               WHEN 'SG'
                   CALL 'SALES'
               WHEN 'PT'
                   CALL 'PRINTMAIN'
               WHEN 'EX'
                   CONTINUE
               WHEN OTHER
                   DISPLAY "INVALID CHOICE! PLEASE REENTER YOUR CHOICE!"
           END-EVALUATE.

           ACCEPT-OPTION-DONE.
               EXIT.
       END PROGRAM SALEMAIN.
