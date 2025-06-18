*&---------------------------------------------------------------------*
*& Report z_abap_internaltable1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_abap_internaltable1.

" lty - local time this structure is local to the program
TYPES: BEGIN OF lty_data,
         ono TYPE zdeno_69,
         pm  TYPE zdepm_69,
       END OF lty_data.

" Declaring an Internal Table of structure type lty_data
" lt_data is a data object and lty_data is a data type in the internal table.

" Declaring work area. A work area is not a table.
" lwa_data is local work area of structure lty_data.

*DATA : lt_data TYPE TABLE OF lty_data.
*DATA: lwa_data TYPE lty_data.

" declaring Structure Type through SE11. This structure is created for global use.

*DATA: lt_data TYPE TABLE OF zstype_order1.
*DATA: lwa_data TYPE zstype_order1.


"Table type is only for declaring internal table never for work area.

TYPES: ltty_data TYPE TABLE OF lty_data.

DATA: lt_data TYPE ltty_data.
DATA: lwa_data TYPE ZTSTYPE_ORDER1. "global table type declaration.
