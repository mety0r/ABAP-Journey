*&---------------------------------------------------------------------*
*& Report z_dic_ordentry
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_dic_ordentry.

DATA : ls_zordh_69 TYPE zordh_69.

"Inserting Records into the Table
"NOTE: THE CODE ENTERS DATE IN INVALID FORMAT PLEASE LOOK INTO IT.
ls_zordh_69-mandt = '100'.
ls_zordh_69-ono = '1'.
ls_zordh_69-odate = '01062025'.
ls_zordh_69-pm = 'C'.
ls_zordh_69-ta = '500'.
ls_zordh_69-curr = 'INR'.

INSERT zordh_69 FROM ls_zordh_69.
IF sy-subrc = 0.
    WRITE : / 'Data for order 1 inserted successfully'.
ELSE.
    WRITE : / 'Error inserting Data for Order 1'.
ENDIF.

ls_zordh_69-ono = '2'.
ls_zordh_69-odate = '02062025'.
ls_zordh_69-pm = 'D'.
ls_zordh_69-ta = '5000'.
ls_zordh_69-curr = 'INR'.

INSERT zordh_69 FROM ls_zordh_69.
IF sy-subrc = 0.
  WRITE: / 'Data for order 2 inserted successfully'.
ELSE.
  WRITE: / 'Error inserting 2'.
ENDIF.

ls_zordh_69-ono = '3'.
ls_zordh_69-odate = '03062025'.
ls_zordh_69-pm = 'D'.
ls_zordh_69-ta = '10000'.
ls_zordh_69-curr = 'INR'.

INSERT zordh_69 FROM ls_zordh_69.
IF sy-subrc = 0.
  WRITE : / 'Data for order 3 entered successfully'.
ELSE.
  WRITE : / 'Error in entering Order 3'.
ENDIF.

ls_zordh_69-ono = '4'.
ls_zordh_69-odate = '04062025'.
ls_zordh_69-pm = 'N'.
ls_zordh_69-ta = '20000'.
ls_zordh_69-curr = 'INR'.

INSERT zordh_69 FROM ls_zordh_69.
IF sy-subrc = 0.
  WRITE : / 'Entered Order 4 successfully'.
ELSE.
  WRITE : / 'Error in entering Order 4'.
ENDIF.

  ls_zordh_69-ono = '5'.
  ls_zordh_69-odate = '05062025'.
  ls_zordh_69-pm = 'N'.
  ls_zordh_69-ta = '30000'.
  ls_zordh_69-curr = 'INR'.

  INSERT zordh_69 FROM ls_zordh_69.
  IF sy-subrc = 0.
    WRITE : / 'Entered Order 5 successfully'.
  ELSE.
    WRITE : / 'Error in entering Order 5'.
  ENDIF.

 ls_zordh_69-ono = '6'.
  ls_zordh_69-odate = '06062025'.
  ls_zordh_69-pm = 'N'.
  ls_zordh_69-ta = '40000'.
  ls_zordh_69-curr = 'INR'.

  INSERT zordh_69 FROM ls_zordh_69.
  IF sy-subrc = 0.
    WRITE : / 'Entered Order 6 successfully'.
  ELSE.
    WRITE : / 'Error in entering Order 6'.
  ENDIF.
