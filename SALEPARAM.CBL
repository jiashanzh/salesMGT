      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       01  SALE-PARAM.
           02 FILE-STA.
               03  FILE-STA-GOODS         PIC 99.
               03  FILE-STA-SALE          PIC 99.
               03  FILE-STA-PURCHASE      PIC 99.

       01 TABLE-GOODS.
           02 GBODY OCCURS 1 TO 999 TIMES
                 DEPENDING ON COUNT-GOODS-WS OF COUNT-WS
                 ASCENDING KEY IS ID-GOODS
                 INDEXED BY INDEX-GOODS.
             03 ID-GOODS                 PIC 9(6).
             03 FILLER                   PIC X(14) VALUE SPACE.
             03 NAME-GOODS               PIC X(20).
             03 PRICE-GOODS              PIC S9(4)V99.
             03 FILLER                   PIC X(13) VALUE SPACE.
             03 LEFT-GOODS               PIC 9(5).
             03 FILLER                   PIC X(15) VALUE SPACE.
             03 FIRM-GOODS               PIC X(20).

       01 TABLE-PURCHASE.
           02 PBODY OCCURS 1 TO 999 TIMES
                 DEPENDING ON COUNT-PURCHASE-WS OF COUNT-WS
                 ASCENDING KEY IS ID-PURCHASE
                 INDEXED BY INDEX-PURCHASE.
             03 ID-PURCHASE              PIC 9(6).
             03 FILLER                   PIC X(14) VALUE SPACE.
             03 NAME-GOODS               PIC X(20).
             03 ID-GOODS                 PIC 9(6).
             03 FILLER                   PIC X(14) VALUE SPACE.
             03 NUM-PURCHASE             PIC 9(5).
             03 FILLER                   PIC X(15) VALUE SPACE.
             03 DATE-PURCHASE            PIC X(8).

       01 TABLE-SALE.
           02 SBODY OCCURS 1 TO 999 TIMES
                 DEPENDING ON COUNT-SALE-WS OF COUNT-WS
                 ASCENDING KEY IS ID-SALE
                 INDEXED BY INDEX-SALE.
             03 ID-SALE                  PIC 9(6).
             03 FILLER                   PIC X(14) VALUE SPACE.
             03 NAME-GOODS               PIC X(20).
             03 ID-GOODS                 PIC 9(6).
             03 FILLER                   PIC X(14) VALUE SPACE.
             03 NUM-SALE                 PIC 9(5).
             03 FILLER                   PIC X(15) VALUE SPACE.
             03 DATE-SALE                PIC X(8).

       01 SIZE-WS.
           03 SIZE-GOODS-WS              PIC 9(6).
           03 SIZE-SALE-WS               PIC 9(6).
           03 SIZE-PURCHASE-WS           PIC 9(6).

       01 COUNT-WS.
           03 COUNT-GOODS-WS             PIC 9(6).
           03 COUNT-SALE-WS              PIC 9(6).
           03 COUNT-PURCHASE-WS          PIC 9(6).
