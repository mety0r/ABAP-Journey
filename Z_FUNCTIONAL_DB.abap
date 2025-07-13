*&---------------------------------------------------------------------*
*& Report z_functional_db
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_functional_db.

DATA: itab TYPE TABLE OF sflight,
      wa   TYPE sflight.

SELECT * FROM sflight INTO TABLE itab
         WHERE carrid = 'LH' AND connid = '0400' ORDER BY PRIMARY KEY .

READ TABLE itab INTO wa WITH KEY
carrid = 'LH' connid = '0400' fldate = '20130101' BINARY SEARCH.

SELECT * FROM sflight INTO TABLE itab WHERE carrid = 'LH' AND
connid = '0400' .

SORT ITAB BY CARRID CONNID FLDATE.
DELETE ADJACENT DUPLICATES FROM itab COMPARING carrid.

LOOP AT itab INTO wa.
  AT NEW carrid.
    WRITE: / wa-carrid, wa-connid.
  ENDAT.
ENDLOOP.
