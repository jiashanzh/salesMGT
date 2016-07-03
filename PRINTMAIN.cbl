      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PRINTMAIN.
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
       01 USER-PRINT-CHOICE            PIC X.
       01 VICE-PRINT-CHOICE.
           02 GOODS-PRINT-CHOICE       PIC X.
           02 SALE-PRINT-CHOICE        PIC X.
           02 PURCHASE-PRINT-CHOICE    PIC X.
       01 PRARM-ACCEPT.
           02 PARAM-NAME-GOODS         PIC X(20).
           02 PARAM-FIRM-GOODS         PIC X(20).
           02 PARAM-ID-GOODS           PIC 9(6).
       01 GHEAD.
           02 FILLER                   PIC X(20) VALUE "商品编号   ".
           02 FILLER                   PIC X(20) VALUE "商品名称   ".
           02 FILLER                   PIC X(20) VALUE "现在售价   ".
           02 FILLER                   PIC X(20) VALUE "剩余库存   ".
           02 FILLER                   PIC X(20) VALUE "生产厂商   ".
       01 PHEAD.
           02 FILLER                   PIC X(20) VALUE "订单编号   ".
           02 FILLER                   PIC X(20) VALUE "商品名称   ".
           02 FILLER                   PIC X(20) VALUE "商品编号   ".
           02 FILLER                   PIC X(20) VALUE "购进数目   ".
           02 FILLER                   PIC X(20) VALUE "购进日期   ".
       01 SHEAD.
           02 FILLER                   PIC X(20) VALUE "订单编号   ".
           02 FILLER                   PIC X(20) VALUE "商品名称   ".
           02 FILLER                   PIC X(20) VALUE "商品编号   ".
           02 FILLER                   PIC X(20) VALUE "售出数目   ".
           02 FILLER                   PIC X(20) VALUE "售出日期   ".
       LINKAGE SECTION.
       01 LS-RETURN-PRINT              PIC 9.
       PROCEDURE DIVISION USING LS-RETURN-PRINT.
       MAIN-PROCDDURE SECTION.
           PERFORM ACCEPT-OPTION UNTIL USER-PRINT-CHOICE="E".
           .
           MAIN-PROCDDURE-EXT.
               EXIT PROGRAM
               GOBACK
           .
       ACCEPT-OPTION SECTION.
           DISPLAY 'G>GOODS-INF    P>PURCHASE-INF   '
                   'S>SALE-INF    E>EXIT.'.
           DISPLAY 'ENTER YOUR CHOICE:'.
           ACCEPT USER-PRINT-CHOICE
           DISPLAY USER-PRINT-CHOICE.
            EVALUATE USER-PRINT-CHOICE
                WHEN "G"
                    PERFORM GOODS-INFO
                WHEN "S"
                    PERFORM SALE-INFO
                WHEN "P"
                    PERFORM PURCHASE-INFO
                WHEN "E"
                    CONTINUE
                WHEN OTHER
                    DISPLAY "INVALID PRINT CHOICE! "
            END-EVALUATE.

           ACCEPT-OPTION-DONE.
               EXIT.
      *>  =========================打印仓库信息========================
       GOODS-INFO SECTION.
           DISPLAY 'A>ALL-GOODS-INF    M>BY MANUFACTURER   '
                   'N>BY NAME     I>BY ID    E>EXIT.'
           DISPLAY 'ENTER YOUR CHOICE:'
           ACCEPT GOODS-PRINT-CHOICE
           EVALUATE GOODS-PRINT-CHOICE
               WHEN 'A'
                   PERFORM ALL-GOODS-INFO
               WHEN 'M'
                   PERFORM MANUF-GOODS-INFO
               WHEN 'N'
                   PERFORM NAME-GOODS-INFO
               WHEN 'I'
                   PERFORM ID-GOODS-INFO
               WHEN 'E'
                   CONTINUE
               WHEN OTHER
                   DISPLAY "INVALID CHOICE!"
           END-EVALUATE.
           GO TO GOODS-INFO-EXT.
           .
           GOODS-INFO-EXT.
               EXIT.
       ALL-GOODS-INFO SECTION.
           DISPLAY "ALL-GOODS-INFO"
           DISPLAY GHEAD.
           INITIALIZE COUNT-GOODS-WS.
           OPEN INPUT GOODS-FILE.
           READ-REC.
           READ GOODS-FILE NEXT RECORD
               NOT AT END
                   ADD 1 TO COUNT-GOODS-WS
                   MOVE CORR REC-GOODS TO GBODY(COUNT-GOODS-WS)
                   GO TO READ-REC
           END-READ.
           CLOSE GOODS-FILE.
           SET INDEX-GOODS TO 1
           PERFORM VARYING INDEX-GOODS FROM 1 BY 1
                   UNTIL INDEX-GOODS>COUNT-GOODS-WS
               DISPLAY GBODY(INDEX-GOODS)
           END-PERFORM.
           .
           ALL-GOODS-INFO-EXT.
               EXIT.
       NAME-GOODS-INFO SECTION.
           DISPLAY "NAME-GOODS-INFO"
           DISPLAY "INPUT THE NAME OF GOODS:"
           ACCEPT PARAM-NAME-GOODS
           DISPLAY GHEAD.
           INITIALIZE COUNT-GOODS-WS.
           OPEN INPUT GOODS-FILE.
           READ-REC.
           READ GOODS-FILE NEXT RECORD
               NOT AT END
                   IF (NAME-GOODS OF REC-GOODS = PARAM-NAME-GOODS)
                       ADD 1 TO COUNT-GOODS-WS
                       MOVE CORR REC-GOODS TO GBODY(COUNT-GOODS-WS)
                   END-IF
                   GO TO READ-REC
           END-READ.
           CLOSE GOODS-FILE.
           SET INDEX-GOODS TO 1
           PERFORM VARYING INDEX-GOODS FROM 1 BY 1
                   UNTIL INDEX-GOODS>COUNT-GOODS-WS
               DISPLAY GBODY(INDEX-GOODS)
           END-PERFORM.
           .
           NAME-GOODS-INFO-EXT.
               EXIT.
       MANUF-GOODS-INFO SECTION.
           DISPLAY "MANUF-GOODS-INFO"
           DISPLAY "INPUT THE MANUFACTURE OF GOODS:"
           ACCEPT PARAM-FIRM-GOODS
           DISPLAY GHEAD.
           INITIALIZE COUNT-GOODS-WS.
           OPEN INPUT GOODS-FILE.
           READ-REC.
           READ GOODS-FILE NEXT RECORD
               NOT AT END
                   IF (FIRM-GOODS OF REC-GOODS = PARAM-FIRM-GOODS)
                       ADD 1 TO COUNT-GOODS-WS
                       MOVE CORR REC-GOODS TO GBODY(COUNT-GOODS-WS)
                   END-IF
                   GO TO READ-REC
           END-READ.
           CLOSE GOODS-FILE.
           SET INDEX-GOODS TO 1
           PERFORM VARYING INDEX-GOODS FROM 1 BY 1
                   UNTIL INDEX-GOODS>COUNT-GOODS-WS
               DISPLAY GBODY(INDEX-GOODS)
           END-PERFORM.
           .
           MANUF-GOODS-INFO-EXT.
               EXIT.
       ID-GOODS-INFO SECTION.
           DISPLAY "ID-GOODS-INFO"
           DISPLAY "INPUT THE ID OF GOODS:"
           ACCEPT PARAM-ID-GOODS
           DISPLAY GHEAD.
           INITIALIZE COUNT-GOODS-WS.
           OPEN INPUT GOODS-FILE.
           READ-REC.
           READ GOODS-FILE NEXT RECORD
               NOT AT END
                   IF (ID-GOODS OF REC-GOODS = PARAM-ID-GOODS)
                       ADD 1 TO COUNT-GOODS-WS
                       MOVE CORR REC-GOODS TO GBODY(COUNT-GOODS-WS)
                   END-IF
                   GO TO READ-REC
           END-READ.
           CLOSE GOODS-FILE.
           SET INDEX-GOODS TO 1
           PERFORM VARYING INDEX-GOODS FROM 1 BY 1
                   UNTIL INDEX-GOODS>COUNT-GOODS-WS
               DISPLAY GBODY(INDEX-GOODS)
           END-PERFORM.
           .
           ID-GOODS-INFO-EXT.
               EXIT.

      *>  ===========================打印售出货单==============
       SALE-INFO SECTION.
           DISPLAY 'A>ALL-SALE-INF   E>EXIT.'
           DISPLAY 'ENTER YOUR CHOICE:'
           ACCEPT SALE-PRINT-CHOICE
           EVALUATE SALE-PRINT-CHOICE
               WHEN 'A'
                   PERFORM ALL-SALE-INFO
               WHEN 'E'
                   CONTINUE
               WHEN OTHER
                   DISPLAY "INVALID CHOICE!"
           END-EVALUATE.
           GO TO SALE-INFO-EXT.
           .
           SALE-INFO-EXT.
               EXIT.
       ALL-SALE-INFO SECTION.
           DISPLAY "ALL-SALE-INFO"
           DISPLAY SHEAD.
           INITIALIZE COUNT-SALE-WS.
           OPEN INPUT SALE-FILE.
           READ-REC.
           READ SALE-FILE NEXT RECORD
               NOT AT END
                   ADD 1 TO COUNT-SALE-WS
                   MOVE CORR REC-SALE TO SBODY(COUNT-SALE-WS)
                   GO TO READ-REC
           END-READ.
           CLOSE SALE-FILE.
           SET INDEX-SALE TO 1
           PERFORM VARYING INDEX-SALE FROM 1 BY 1
                   UNTIL INDEX-SALE>COUNT-SALE-WS
               DISPLAY SBODY(INDEX-SALE)
           END-PERFORM.
           .
           ALL-SALE-INFO-EXT.
               EXIT.
      *>  ===========================打印购进货单==============
       PURCHASE-INFO SECTION.
           DISPLAY 'A>ALL-PURCHASE-INF   E>EXIT.'
           DISPLAY 'ENTER YOUR CHOICE:'
           ACCEPT PURCHASE-PRINT-CHOICE
           EVALUATE PURCHASE-PRINT-CHOICE
               WHEN 'A'
                   PERFORM ALL-PURCHASE-INFO
               WHEN 'E'
                   CONTINUE
               WHEN OTHER
                   DISPLAY "INVALID CHOICE!"
           END-EVALUATE.
           GO TO PURCHASE-INFO-EXT.
           .
           PURCHASE-INFO-EXT.
               EXIT.
       ALL-PURCHASE-INFO SECTION.
           DISPLAY "ALL-PURCHASE-INFO"
           DISPLAY PHEAD.
           INITIALIZE COUNT-PURCHASE-WS.
           OPEN INPUT PURCHASE-FILE.
           READ-REC.
           READ PURCHASE-FILE NEXT RECORD
               NOT AT END
                   ADD 1 TO COUNT-PURCHASE-WS
                   MOVE CORR REC-PURCHASE TO PBODY(COUNT-PURCHASE-WS)
                   GO TO READ-REC
           END-READ.
           CLOSE PURCHASE-FILE.
           SET INDEX-PURCHASE TO 1
           PERFORM VARYING INDEX-PURCHASE FROM 1 BY 1
                   UNTIL INDEX-PURCHASE>COUNT-PURCHASE-WS
               DISPLAY PBODY(INDEX-PURCHASE)
           END-PERFORM.
           .
           ALL-PURCHASE-INFO-EXT.
               EXIT.

       END PROGRAM PRINTMAIN.
