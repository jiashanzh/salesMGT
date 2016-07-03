      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.GOODS.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
        FILE-CONTROL.
               SELECT GOODS-FILE
               ASSIGN TO "D:\db\goods"
               ORGANIZATION IS INDEXED
               ACCESS MODE IS DYNAMIC
               RECORD KEY IS ID-GOODS OF REC-GOODS
               FILE STATUS IS FILE-STA-GOODS.
       DATA DIVISION.
       FILE SECTION.
        COPY SALEFILES.
       WORKING-STORAGE SECTION.
      *>  01 READ-PARAM.
      *>      02 ID-GOODS             PIC 9(6).
      *>      02 NAME-GOODS           PIC X(20).
      *>      02 PRICE-GOODS          PIC S9(4)V99.
      *>      02 LEFT-GOODS            PIC 9(5).
      *>      02 FIRM-GOODS           PIC X(20).

       COPY SALEPARAM.
       LINKAGE SECTION.
       01 LS-RETURN-GOODS PIC 9.

       PROCEDURE DIVISION USING LS-RETURN-GOODS.
       MAIN-PROCEDURE SECTION.
           DISPLAY "==============GOODS".
           OPEN I-O GOODS-FILE.

           DISPLAY "ENTER ID OF GOODS:"
           ACCEPT ID-GOODS OF REC-GOODS
           DISPLAY "ENTER NAME OF GOODS:"
           ACCEPT NAME-GOODS OF REC-GOODS
           DISPLAY "ENTER PRICE OF GOODS:"
           ACCEPT PRICE-GOODS OF REC-GOODS
           DISPLAY "ENTER FIRM OF GOODS:"
           ACCEPT FIRM-GOODS OF REC-GOODS

           IF NOT (FILE-STA-GOODS = 00) THEN
               DISPLAY "FILE NOT FIND!"
           ELSE
      *>         WRITE REC-GOODS
              READ GOODS-FILE
               KEY IS ID-GOODS OF REC-GOODS
               INVALID KEY
                   WRITE REC-GOODS
                   CONTINUE
               NOT INVALID KEY
                   DISPLAY "GOODS ALREADY EXIST."
              END-READ
           END-IF.

           DISPLAY REC-GOODS.
      *     DISPLAY FILE-STA-GOODS.
           CLOSE GOODS-FILE.
           .
       EXIT PROGRAM.
