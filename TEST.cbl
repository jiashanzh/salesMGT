      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. YOUR-PROGRAM-NAME.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
        FILE-CONTROL.
               SELECT GOODS-FILE
               ASSIGN TO "D:\db\goods"
               ORGANIZATION IS INDEXED
               ACCESS MODE IS DYNAMIC
               RECORD KEY IS ID-GOODS OF REC-GOODS.

               SELECT PURCHASE-FILE
               ASSIGN TO "D:\db\purchase"
               ORGANIZATION IS INDEXED
               ACCESS MODE IS DYNAMIC
               RECORD KEY IS ID-PURCHASE OF REC-PURCHASE.

               SELECT SALE-FILE
               ASSIGN TO "D:\db\sales"
               ORGANIZATION IS INDEXED
               ACCESS MODE IS DYNAMIC
               RECORD KEY IS ID-SALE OF REC-SALE.
       DATA DIVISION.
       FILE SECTION.
       FD GOODS-FILE.
       01 REC-GOODS.
           02 ID-GOODS                 PIC 9(6).
           02 NAME-GOODS               PIC X(20) VALUE "TTTTT".
           02 PRICE-GOODS              PIC S9(4)V99.
           02 LEFT-GOODS               PIC 9(5) VALUE 0.
           02 FIRM-GOODS               PIC X(20).
       FD PURCHASE-FILE.
       01 REC-PURCHASE.
           02 ID-PURCHASE              PIC 9(6).
           02 ID-GOODS                 PIC 9(6).
           02 NUM-PURCHASE             PIC 9(5).
           02 DATE-PURCHASE.
               03 YYYY-DATE            PIC 9(4).
               03 MM-DATE              PIC 9(2).
               03 DD-DATE              PIC 9(2).
       FD SALE-FILE.
       01 REC-SALE.
           02 ID-SALE                  PIC 9(6).
           02 ID-GOODS                 PIC 9(6).
           02 NUM-SALE                 PIC 9(5).
           02 DATE-SALE.
               03 YYYY-DATE            PIC 9(4).
               03 MM-DATE              PIC 9(2).
               03 DD-DATE              PIC 9(2).
       WORKING-STORAGE SECTION.
       01 PARAM-GOODS.
           02 ID-GOODS                 PIC 9(6).
           02 NAME-GOODS               PIC X(20) VALUE "TTTTT".
           02 PRICE-GOODS              PIC S9(4)V99.
           02 LEFT-GOODS               PIC 9(5) VALUE 0.
           02 FIRM-GOODS               PIC X(20).
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           OPEN INPUT GOODS-FILE PURCHASE-FILE SALE-FILE.
           READ-REC.
           READ GOODS-FILE NEXT RECORD
               AT END DISPLAY "OVER"
               NOT AT END DISPLAY REC-GOODS
                          GO TO READ-REC
           END-READ.
           CLOSE GOODS-FILE.

           READ-PURCHASE.
           READ PURCHASE-FILE NEXT RECORD
               AT END DISPLAY "OVER"
               NOT AT END DISPLAY REC-PURCHASE
                          GO TO READ-PURCHASE
           END-READ.
           CLOSE PURCHASE-FILE.

           READ-SALE.
           READ SALE-FILE NEXT RECORD
               AT END DISPLAY "OVER"
               NOT AT END DISPLAY REC-SALE
                          GO TO READ-SALE
           END-READ.
           CLOSE SALE-FILE.

           STOP RUN.
       END PROGRAM YOUR-PROGRAM-NAME.
