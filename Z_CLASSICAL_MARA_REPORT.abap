*&---------------------------------------------------------------------*
*& Report Z_CLASSICAL_MARA_REPORT
*&---------------------------------------------------------------------*
REPORT z_classical_mara_report.

TABLES: mara.

" Creating selection screen
SELECT-OPTIONS: so_mtart FOR mara-mtart,
                so_matnr FOR mara-matnr.

" Define custom type with only necessary fields
TYPES: BEGIN OF ty_mara,
         matnr TYPE mara-matnr,
         mtart TYPE mara-mtart,
         meins TYPE mara-meins,
         matkl TYPE mara-matkl,
         mbrsh TYPE mara-mbrsh,
         ernam TYPE mara-ernam,
         ersda TYPE mara-ersda,
       END OF ty_mara.

DATA: it_mara  TYPE TABLE OF ty_mara,
      wa_mara  TYPE ty_mara,
      lv_count TYPE i.

" Main program flow

START-OF-SELECTION.
  PERFORM get_data.
  PERFORM show_data.


FORM get_data.
  " Select from MARA without join
  SELECT matnr,
         mtart,
         meins,
         matkl,
         mbrsh,
         ernam,
         ersda
    INTO TABLE @it_mara
    FROM mara
    WHERE mtart IN @so_mtart
  AND matnr IN @so_matnr.
ENDFORM.




FORM show_data.

  IF it_mara IS INITIAL.
    WRITE: / 'No materials found for the given selection'.
    RETURN.
  ENDIF.

  " Sort by creation date descending
  SORT it_mara BY ersda DESCENDING.

  " Print header
  WRITE: / 'Materials for Material type:',
         / '--------------------------------------',
         / 'Material No.', 15 'Material Type', 30 'Base Unit',
           45 'Mat. Group', 60 'Ind Sector', 75 'Created By', 90 'Created On'.

  " Loop and display data
  LOOP AT it_mara INTO wa_mara.
    WRITE: / wa_mara-matnr UNDER 'Material No.',
             wa_mara-mtart UNDER 'Material Type',
             wa_mara-meins UNDER 'Base Unit',
             wa_mara-matkl UNDER 'Mat. Group',
             wa_mara-mbrsh UNDER 'Ind Sector',
             wa_mara-ernam UNDER 'Created By',
             wa_mara-ersda UNDER 'Created On'.

    lv_count = lv_count + 1.
  ENDLOOP.

  " Summary
  SKIP 1.
  WRITE: / 'Total Materials Found:', lv_count.

ENDFORM.
