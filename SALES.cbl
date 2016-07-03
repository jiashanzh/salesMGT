      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SALES.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
        FILE-CONTROL.
               SELECT PURCHASE-FILE
               ASSIGN TO "D:\db\purchase"
               ORGANIZATION IS INDEXED
               ACCESS MODE IS DYNAMIC
               RECORD KEY IS ID-PURCHASE OF REC-PURCHASE
               FILE STATUS IS FILE-STA-PURCHASE.
      *>  ========================================
               SELECT GOODS-FILE
               ASSIGN TO "D:\db\goods"
               ORGANIZATION IS INDEXED
               ACCESS MODE IS DYNAMIC
               RECORD KEY IS ID-GOODS OF REC-GOODS
               FILE STATUS IS FILE-STA-GOODS.
      *>  ========================================
               SELECT SALE-FILE
               ASSIGN TO "D:\db\sales"
               ORGANIZATION IS INDEXED
               ACCESS MODE IS DYNAMIC
               RECORD KEY IS ID-SALE OF REC-SALE
               FILE STATUS IS FILE-STA-SALE.
       DATA DIVISION.
       FILE SECTION.
         COPY SALEFILES.
       WORKING-STORAGE SECTION.
         COPY SALEPARAM.
       LINKAGE SECTION.
       01 LS-RETURN-SALES PIC 9.

       PROCEDURE DIVISION USING LS-RETURN-SALES.
       MAIN-PROCEDURE SECTION.
           DISPLAY "==============SALES"
           OPEN I-O SALE-FILE

      *>      DISPLAY "ENTER ID OF SALE-BILL:"
      *>      ACCEPT ID-SALE OF REC-SALE
           PERFORM INITIALIZE-SALE
           ADD 1 TO SIZE-SALE-WS
           MOVE SIZE-SALE-WS TO ID-SALE OF REC-SALE
           DISPLAY "ENTER ID OF GOODS:"

           OPEN I-O GOODS-FILE.

      *>      查看id是否正确
           CHECK-SALE-GOODS.
           ACCEPT ID-GOODS OF REC-SALE
           MOVE ID-GOODS OF REC-SALE
                TO ID-GOODS OF REC-GOODS
           READ GOODS-FILE
               KEY IS ID-GOODS OF REC-GOODS
               INVALID KEY
                   DISPLAY "INVALID ID OF GOODS! PLEASE RE-ENTER:"
                   GO TO CHECK-SALE-GOODS
           END-READ

           DISPLAY "ENTER THE NUMBER OF GOODS:"
           ACCEPT NUM-SALE OF REC-SALE

           READ GOODS-FILE
               KEY IS ID-GOODS OF REC-GOODS
               NOT INVALID KEY
                  SUBTRACT  NUM-SALE OF REC-SALE
                      FROM LEFT-GOODS OF REC-GOODS
                  REWRITE REC-GOODS
           END-READ
           CLOSE GOODS-FILE.


           DISPLAY "ENTER THE DATE OF SALES:"
           ACCEPT DATE-SALE OF REC-SALE

           WRITE REC-SALE
           CLOSE SALE-FILE.
           EXIT PROGRAM.
           GOBACK.
           .

       INITIALIZE-SALE SECTION.
           INITIALIZE SIZE-SALE-WS.
           INIT-READ-FILE.
           READ SALE-FILE NEXT RECORD
               NOT AT END ADD 1 TO SIZE-SALE-WS
                          GO TO INIT-READ-FILE
           END-READ
           DISPLAY "============================================"
           .
           INITIALIZE-SALE-EXT.
               EXIT.
       END PROGRAM SALES.
