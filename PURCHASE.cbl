      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PURCHASE.
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
       01 LS-RETURN-PURCHASE PIC 9.
       PROCEDURE DIVISION USING LS-RETURN-PURCHASE.
       MAIN-PROCEDURE SECTION.
           DISPLAY "==============PURCHASE"
           OPEN I-O PURCHASE-FILE

      *>      DISPLAY "ENTER ID OF PURCHASE-BILL:"
      *>      ACCEPT ID-PURCHASE OF REC-PURCHASE
           PERFORM INITIALIZE-PURCHASE
           ADD 1 TO SIZE-PURCHASE-WS
           MOVE SIZE-PURCHASE-WS TO ID-PURCHASE OF REC-PURCHASE
           DISPLAY "ENTER ID OF GOODS:"
      *>      CLOSE PURCHASE-FILE
      *>      STOP RUN.
      *>      PERFORM CHECK-GOODS-ID


           OPEN I-O GOODS-FILE.

      *>      查看id是否正确
           CHECK-PURCHASE-GOODS.
           ACCEPT ID-GOODS OF REC-PURCHASE
           MOVE ID-GOODS OF REC-PURCHASE
                TO ID-GOODS OF REC-GOODS
           READ GOODS-FILE
               KEY IS ID-GOODS OF REC-GOODS
               INVALID KEY
                   DISPLAY "INVALID ID OF GOODS! PLEASE RE-ENTER:"
                   GO TO CHECK-PURCHASE-GOODS
           END-READ

           DISPLAY "ENTER THE NUMBER OF GOODS:"
           ACCEPT NUM-PURCHASE OF REC-PURCHASE

           READ GOODS-FILE
               KEY IS ID-GOODS OF REC-GOODS
               NOT INVALID KEY
                  ADD NUM-PURCHASE OF REC-PURCHASE
                      TO LEFT-GOODS OF REC-GOODS
                  REWRITE REC-GOODS
           END-READ
           CLOSE GOODS-FILE.


           DISPLAY "ENTER THE DATE OF PURCHASES:"
           ACCEPT DATE-PURCHASE OF REC-PURCHASE

      *>      IF NOT (FILE-STA-PURCHASE = 00) THEN
      *>          DISPLAY "PURCHASE FILE NOT FIND!"
      *>      ELSE
           WRITE REC-PURCHASE
      *>          READ PURCHASE-FILE
      *>           KEY IS ID-PURCHASE OF REC-PURCHASE
      *>           INVALID KEY
      *>               WRITE REC-PURCHASE
      *>               CONTINUE
      *>           NOT INVALID KEY
      *>               DISPLAY "GOODS NOT FOUND."
      *>          END-READ
      *>      END-IF.

      *>      DISPLAY REC-PURCHASE
      *>      DISPLAY FILE-STA-PURCHASE.
           CLOSE PURCHASE-FILE.
           EXIT PROGRAM.
           GOBACK.
           .
      *>  CHECK-GOODS-I SECTION.
      *>  DISPLAY "ENTER ID OF GOODS:"
      *>  OPEN INPUT GOODS-FILE.

      *>  CHECK-GOODS-ID SECTION.
      *>      ACCEPT ID-GOODS OF REC-PURCHASE
      *>      OPEN INPUT GOODS-FILE.
      *>      READ GOODS-FILE
      *>          KEY IS ID-GOODS OF REC-PURCHASE
      *>          INVALID KEY
      *>              DISPLAY "INVALID ID OF GOODS! PLEASE RE-ENTER:"
      *>              GO TO CHECK-GOODS-ID
      *>              CONTINUE
      *>      END-READ
      *>      CLOSE GOODS-FILE.
      *>      CHECK-GOODS-EXT.
      *>          EXIT.
       INITIALIZE-PURCHASE SECTION.
           INITIALIZE SIZE-PURCHASE-WS.
           INIT-READ-FILE.
           READ PURCHASE-FILE NEXT RECORD
               NOT AT END ADD 1 TO SIZE-PURCHASE-WS
                          GO TO INIT-READ-FILE
           END-READ
           DISPLAY "============================================"
           .
           INITIALIZE-PURCHASE-EXT.
               EXIT.
       END PROGRAM PURCHASE.
