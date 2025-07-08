*&---------------------------------------------------------------------*
*& Report ymay_oia
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ymay_oia.

""Data Declarations
  types: BEGIN OF ty_open_days,
            bp_id type snwd_bpa-bp_id,
            company_name type snwd_bpa-company_name,
            days_due type int4,
            inv_count type int4,
         END OF TY_OPEN_DAYS,
         BEGIN OF ty_open_amount,
            bp_id type snwd_bpa-bp_id,
            company_name type snwd_bpa-company_name,
            gross_amount type snwd_so_inv_head-gross_amount,
            currency_code type snwd_so_inv_head-currency_code,
         END OF ty_open_amount,
         BEGIN OF ty_oia,
            bp_id type snwd_bpa-bp_id,
            company_name type snwd_bpa-company_name,
            open_days type int4,
            gross_amount type snwd_so_inv_head-gross_amount,
            currency_code type snwd_so_inv_head-currency_code,
            tagging type flag,
         END OF ty_oia.

""Ctrl+Space to do code completion in eclipse
data : lt_open_days   type TABLE of ty_open_days,
       ls_open_days   type          ty_open_days,
       lt_open_amount TYPE TABLE of ty_open_amount,
       ls_open_amount TYPE          ty_open_amount,
       lt_oia         type TABLE of ty_oia,
       ls_oia         type          ty_oia,
       lv_total       type          i.

"""We will start a timer to know the runtime it takes to execute the requiremnt
data(lo_timer) = cl_abap_runtime=>create_hr_timer(  ).
data(t1) = lo_timer->get_runtime(  ).

""Step 1: read customizing table for current user id

select single * from zdp_cust into @data(ls_cust)
            where usrid = @sy-uname.

""Step 2: Calculate the total avg. days since when invoices are due
select * from snwd_so_inv_head as head
              inner join snwd_bpa as bpa
              on head~buyer_guid = bpa~node_key
              where head~payment_status = ''
              into @data(ls_dats).

    "convert timestamp to date
    CONVERT TIME STAMP ls_dats-head-changed_at TIME ZONE sy-zonlo
                       INTO DATE data(lv_date).

    "Since how long its not paid
    ls_open_days-days_due = sy-datum - lv_date.
    ls_open_days-inv_count = 1.
    ls_open_days-bp_id = ls_dats-bpa-bp_id.
    ls_open_days-company_name = ls_dats-bpa-company_name.
    COLLECT ls_open_days into lt_open_days.

ENDSELECT.

""Step 3: Calculate the total amount due in common currency
select * from snwd_so_inv_head as head
              inner join snwd_so_inv_item as itm
                on head~node_key = itm~parent_key
              inner join snwd_bpa as bpa
                on head~buyer_guid = bpa~node_key
              where head~payment_status = ''
                into @data(ls_amount).

    ls_open_amount-bp_id = ls_amount-bpa-bp_id.
    ls_open_amount-company_name = ls_amount-bpa-company_name.

    call FUNCTION 'CONVERT_TO_LOCAL_CURRENCY'
      EXPORTING
*        client            = SY-MANDT
        date              = sy-datum
        foreign_amount    = ls_amount-itm-gross_amount
        foreign_currency  = ls_amount-itm-currency_code
        local_currency    = ls_cust-currency_code
      IMPORTING
        local_amount      = ls_open_amount-gross_amount
      .

    ls_open_amount-currency_code = ls_cust-currency_code.
    COLLECT ls_open_amount into lt_open_amount.

ENDSELECT.

loop at lt_open_days INTO ls_open_days.
    ls_open_amount = lt_open_amount[ bp_id = ls_open_days-bp_id ].
    MOVE-CORRESPONDING ls_open_days to ls_oia.
    "calculate average
    ls_oia-open_days = ls_open_days-days_due / ls_open_days-inv_count.
    ls_oia-gross_amount = ls_open_amount-gross_amount.
    ls_oia-currency_code = ls_open_amount-currency_code.

    if ( ls_oia-gross_amount > ls_cust-max_gross_amount and
         ls_oia-open_days > ls_cust-max_open_days ).
         ls_oia-tagging = abap_true.
    else.
        ls_oia-tagging = abap_false.
    ENDIF.

    append ls_oia to lt_oia.

ENDLOOP.

data(t2) = lo_timer->get_runtime(  ).
lv_total = ( t2 - t1 ) / 1000.

cl_demo_output=>display_data(
  value   = lt_oia
  name    = |Total Time taken { lv_total } ms|
*  exclude =
*  include =
).
