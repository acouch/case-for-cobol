       IDENTIFICATION DIVISION.
       PROGRAM-ID. truth.
      
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. IBM-PC.
       OBJECT-COMPUTER. IBM-PC.
      
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 var PIC 99.
      
       PROCEDURE DIVISION.
       begin.
           DISPLAY "Hello World".
           MOVE 42 TO var.
           DISPLAY var.
           EXIT PROGRAM.

      