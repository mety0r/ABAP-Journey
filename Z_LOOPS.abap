*&---------------------------------------------------------------------*
*& Report z_loops
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_loops.

 DO LOOP -First Syntax

DO 10 TIMES.
  WRITE: / 'Hello'.
ENDDO.

DO LOOP SECOND SYNTAX
DATA: lv_input TYPE n LENGTH 2 VALUE 10.
DO .
  IF lv_input = 15.
    EXIT.
  ENDIF.
  WRITE : / 'The output is ', lv_input.
  lv_input = lv_input + 1.
ENDDO.

 while loop

WHILE lv_input LT 15.
  WRITE : / 'the output is', lv_input.
  lv_input = lv_input + 1.
ENDWHILE.
