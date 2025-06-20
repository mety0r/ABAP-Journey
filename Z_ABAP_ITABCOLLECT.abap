*&---------------------------------------------------------------------*
*& Report Z_ABAP_ITABCOLLECT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_abap_itabcollect.

TYPES: BEGIN OF lty_data,
         cname TYPE c LENGTH 10,
         dept  TYPE c LENGTH 10,
         Amt   TYPE zdedate_69,
       END OF lty_data.

DATA: lt_data TYPE TABLE OF lty_data.
DATA: lwa_data TYPE lty_data.
DATA: lt_temp_data TYPE TABLE OF lty_data.

lwa_data-cname = 'ABC'.
lwa_data-dept = 'ADMIN'.
lwa_data-amt = '10000'.

APPEND lwa_data TO lt_data.
CLEAR: lwa_data.

lwa_data-cname = 'ABC'.
lwa_data-dept = 'HR'.
lwa_data-amt = '20000'.

APPEND lwa_data TO lt_data.
CLEAR: lwa_data.

lwa_data-cname = 'ABC'.
lwa_data-dept = 'ADMIN'.
lwa_data-amt = '50000'.

APPEND lwa_data TO lt_data.
CLEAR: lwa_data.

lwa_data-cname = 'ABC'.
lwa_data-dept = 'TRAINING'.
lwa_data-amt = '10000'.

APPEND lwa_data TO lt_data.
CLEAR: lwa_data.

lwa_data-cname = 'ABCD'.
lwa_data-dept = 'HR'.
lwa_data-amt = '20000'.

APPEND lwa_data TO lt_data.
CLEAR: lwa_data.

LOOP AT lt_data INTO lwa_data.
  COLLECT lwa_data INTO lt_temp_data.
ENDLOOP.

LOOP AT lt_temp_data INTO lwa_data.
  WRITE: / lwa_data-cname,lwa_data-dept,lwa_data-amt.
ENDLOOP.
