*&---------------------------------------------------------------------*
*& Report zprog_adbc
*&---------------------------------------------------------------------*
REPORT zprog_adbc.

" Define structure and table type to match SQL result
TYPES: BEGIN OF ty_oia,
         bp_id         TYPE snwd_bpa-bp_id,
         company_name  TYPE snwd_bpa-company_name,
         open_days     TYPE int4, " Added missing field
         gross_amount  TYPE snwd_so_inv_head-gross_amount,
         currency_code TYPE snwd_so_inv_head-currency_code,
       END OF ty_oia,
       tt_oia TYPE TABLE OF ty_oia.

DATA: lr_data TYPE REF TO data,
      itab    TYPE tt_oia.

" Get dynamic reference of internal table
GET REFERENCE OF itab INTO lr_data.

" SQL query from HANA calculation view
DATA(lv_query) = |SELECT BP_ID, COMPANY_NAME, ROUND(SUM( OPEN_DAYS ),0) AS OPEN_DAYS, | &
                 |SUM(CONV_GROSS_AMOUNT) AS GROSS_AMOUNT, | &
                 |CONV_GROSS_AMOUNT_CURRENCY AS CURRENCY_CODE | &
                 |FROM "_SYS_BIC"."JUN_ANUBHAV/CV_OIA" | &
                 |GROUP BY BP_ID, COMPANY_NAME, CONV_GROSS_AMOUNT_CURRENCY|.

TRY.
    " Get SQL connection object
    DATA(lo_connection) = cl_sql_connection=>get_connection( ).

    " Create SQL statement
    DATA(lo_statement) = lo_connection->create_statement( ).

    " Execute query
    DATA(lo_query) = lo_statement->execute_query(
      EXPORTING
        statement = lv_query
    ).

    " Set target internal table for results
    lo_query->set_param_table(
      itab_ref = lr_data
    ).

    " Fetch results into internal table
    lo_query->next_package( ).

    " Close result and connection
    lo_query->close( ).
    lo_connection->close( ).

    " Display result
    cl_demo_output=>display_data(
      value = itab
    ).

  CATCH cx_sql_exception INTO DATA(lx_sql).
    cl_demo_output=>display( |SQL Error: { lx_sql->get_text( ) }| ).
ENDTRY.
