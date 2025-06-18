*&---------------------------------------------------------------------*
*& Report z_abap_itabop
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_abap_itabop.

TYPES : BEGIN OF lty_data,
          ono TYPE zdeno_69,
          pm  TYPE zdepm_69,
        END OF lty_data.

DATA: lt_data TYPE TABLE OF lty_data.
DATA: lwa_data TYPE lty_data.
DATA: lv_lines TYPE i.

"APPEND Operation
lwa_data-ono = 1.
lwa_data-pm = 'C'.
APPEND lwa_data TO lt_data.
CLEAR: lwa_data.

"It is necessary to clear work area after any function

lwa_data-ono = 1.
lwa_data-pm = 'D'.
APPEND lwa_data TO lt_data.
CLEAR: lwa_data.

lwa_data-ono = 2.
lwa_data-pm = 'C'.
APPEND lwa_data TO lt_data.
CLEAR: lwa_data.

lwa_data-ono = 2.
lwa_data-pm = 'D'.
APPEND lwa_data TO lt_data.
CLEAR: lwa_data.

lwa_data-ono = 3.
lwa_data-pm = 'C'.
APPEND lwa_data TO lt_data.
CLEAR: lwa_data.

"Delete Operation
DELETE lt_data WHERE pm = 'D'.
DELETE lt_data INDEX 3.

"Modify Operation
LOOP AT lt_data INTO lwa_data.
  IF lwa_data-ono = 1.
    lwa_data-pm = 'N'.
    MODIFY lt_data FROM lwa_data TRANSPORTING pm.
  ENDIF.
ENDLOOP.

"Read Operation
READ TABLE lt_data INTO lwa_data WITH KEY ono = 1.
IF sy-subrc = 0.
  WRITE: / lwa_data-ono, lwa_data-pm.
ELSE.
  WRITE: / 'Unsucessful'.
ENDIF.

"Read Operation based on Index
READ TABLE lt_data INTO lwa_data INDEX 4.
IF sy-subrc = 0.
  WRITE: / lwa_data-ono, lwa_data-pm.
ELSE.
  WRITE: / 'Unsucessful'.
ENDIF.

"Clear Operation
CLEAR: lt_data.

"Refresh Operation
REFRESH: lt_data.

"Describe Operation
DESCRIBE TABLE lt_data LINES lv_lines.

WRITE:/ lv_lines.

"Sort Operation
SORT lt_data BY ono.

"Sort By Descending
SORT lt_data BY ono DESCENDING.

LOOP AT  lt_data INTO lwa_data.
  WRITE : / lwa_data-ono, lwa_data-pm.
ENDLOOP.
