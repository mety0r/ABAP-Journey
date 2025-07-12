*&---------------------------------------------------------------------*
*& Report zhana_consume_hana
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zhana_consume_hana.


select bp_id, company_name,
    ceil( sum( open_days ) ) as open_days,
    sum( gross_amount ) as gross_amount,
    conv_gross_amount_currency as currency_code
     from ZVP_JUN_OIA
    group by bp_id, company_name, conv_gross_amount_currency
    into table @data(itab)
    .

cl_demo_output=>display_data(
  value   = itab
*  name    =
*  exclude =
*  include =
).
