*&---------------------------------------------------------------------*
*& Report z_abap_cndstatements
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_abap_cndstatements.

DATA : lv_input TYPE n LENGTH 2 VALUE 2.

"Simple IF
IF lv_input = 1.
  WRITE : 'the output is',lv_input.
ENDIF.

"ELSEIF
IF lv_input = 1.
  WRITE : 'the output is', lv_input.
ELSE.
  WRITE : 'Wrong Output'.
ENDIF.

"CASE STATEMENTS always performs faster than if.
CASE lv_input.
  WHEN : 1.
    WRITE : 'The output is ', lv_input.
  WHEN : 2.
    WRITE : 'the output is', lv_input.
  WHEN : 3.
    WRITE : 'the output is', lv_input.
  WHEN OTHERS.
    WRITE : 'Wrong output'.
ENDCASE.
