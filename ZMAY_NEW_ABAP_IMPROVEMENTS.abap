*&---------------------------------------------------------------------*
*& Report zmay_new_abap_improvements
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmay_new_abap_improvements.
* old code
"explicit declaration of variables
data : lt_mara TYPE table of mara,
          ls_mara type mara.

SELECT * from mara into table lt_mara.

loop at lt_mara into ls_mara.
write : / ls_mara-matnr, ls_mara-matkl.
endloop.

*new code

data : mara type table of mara,
      ls_mara TYPE mara.

select matnr, matkl from mara into table @mara.

loop at mara into ls_mara.
write : / ls_mara-matnr, ls_mara-matkl.
ENDLOOP.

"Inline data declaration

SELECT matnr, matkl from mara into table @DATA(lt_mara).

loop at lt_mara into data(ls_mara).
write : / ls_mara-matnr, ls_mara-matkl.
endloop.

" Value expression - creates data on fly
types : BEGIN OF ty_team,
            captain TYPE c length 15,
            team    TYPE c length 10,
            score   type i,
            end of ty_team.

data: lt_team type table of ty_team,
      ls_team type ty_team.

ls_team-team = 'CSK'.
ls_team-captain = 'Dhoni'.
ls_team-score = 50.
APPEND ls_team to lt_team.
ls_team-team = 'RCB'.
ls_team-captain = 'Virat'.
ls_team-score = 90.
APPEND ls_team to lt_team.

*loop at lt_team into ls_team.
write : / ls_team-team, ls_team-captain, ls_team-score.
endloop.

"Value Expression with # - indicate to check the data type in declaration
types : BEGIN OF ty_team,
            captain TYPE c length 15,
            team    TYPE c length 10,
            score   type i,
            end of ty_team.

data: lt_team type table of ty_team,
      ls_team type ty_team.

lt_team = value #( ( team = 'CSK' captain = 'Dhoni' score = 50 )
                   ( team = 'RCB' captain = 'Virat' score = 90 )
                 ).


loop at lt_team into ls_team.
write : / ls_team-team, ls_team-captain, ls_team-score.
endloop.

"best method for value expression
types : BEGIN OF ty_team,
            captain TYPE c length 15,
            team    TYPE c length 10,
            score   type i,
            end of ty_team,
            tt_team type table of ty_team with Default key.


data(lt_team) = value tt_team( ( team = 'CSK' captain = 'Dhoni' score = 50 )
                   ( team = 'RCB' captain = 'Virat' score = 90 )
                 ).

loop at lt_team into data(ls_team).
write : / ls_team-team, ls_team-captain, ls_team-score.
endloop.
