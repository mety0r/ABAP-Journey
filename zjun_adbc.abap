REPORT zjun_adbc.

"Data Declaration
types: BEGIN OF ty_oia,
        bp_id type snwd_bpa-bp_id,
        company_name type snwd_bpa-company_name,
        open_days type int4,
        gross_amount type snwd_so_inv_head-gross_amount,
        currency_code type snwD_so_inv_head-currency_code,
       END OF TY_OIA,
       tt_oia type table of ty_oia.

data: lr_data type ref to data,
      itab    type tt_oia.

"get dynamic reference into the data variable itab
get REFERENCE OF itab into lr_data.

"get our hana query in a string variable
data(lv_query) = |SELECT BP_ID, COMPANY_NAME, ROUND(SUM( OPEN_DAYS ),0) AS OPEN_DAYS, | &&
                 |SUM(CONV_GROSS_AMOUNT) AS GROSS_AMOUNT, | &&
                 |CONV_GROSS_AMOUNT_CURRENCY AS CURRENCY_CODE | &&
                 |FROM "_SYS_BIC"."JUN_ANUBHAV/CV_OIA"| &&
                 |GROUP BY BP_ID, | &&
                 |COMPANY_NAME, CONV_GROSS_AMOUNT_CURRENCY |.

try.
"use the ADBC framework = collection of classes - cl_sql_connection
data(lo_connection) = cl_sql_connection=>get_connection( ).
"Create a statement object which is going to communicate our query to DB
data(lo_statement) = lo_connection->create_statement(  ).
"Set the query to statement
data(lo_query) = lo_statement->execute_query(
  EXPORTING
    statement             = lv_query
).

"What is my host variable in program where data will come and sit after execution
lo_query->set_param_table(
  itab_ref             = lr_data
).
""Fire the query
lo_query->next_package(  ).
""We can release the objects which we open
lo_query->close( ).
lo_connection->close( ).

cl_demo_output=>display_data(
  value   = itab
*  name    =
*  exclude =
*  include =
).
catch cx_sql_exception into data(lo_ex).
    WRITE :/ lo_ex->get_text(  ).
ENDTRY.
