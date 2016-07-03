      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       FD GOODS-FILE.
       01 REC-GOODS.
           02 ID-GOODS                 PIC 9(6).
           02 NAME-GOODS               PIC X(20) VALUE "TTTTT".
           02 PRICE-GOODS              PIC S9(4)V99.
           02 LEFT-GOODS               PIC 99999.
           02 FIRM-GOODS               PIC X(20).

       FD SALE-FILE.
       01 REC-SALE.
           02 ID-SALE                  PIC 9(6).
           02 ID-GOODS                 PIC 9(6).
           02 NUM-SALE                 PIC 9(5).
           02 DATE-SALE.
               03 YYYY-DATE            PIC 9(4).
               03 MM-DATE              PIC 9(2).
               03 DD-DATE              PIC 9(2).

       FD PURCHASE-FILE.
       01 REC-PURCHASE.
           02 ID-PURCHASE              PIC 9(6).
           02 ID-GOODS                 PIC 9(6).
           02 NUM-PURCHASE             PIC 9(5).
           02 DATE-PURCHASE.
               03 YYYY-DATE            PIC 9(4).
               03 MM-DATE              PIC 9(2).
               03 DD-DATE              PIC 9(2).
