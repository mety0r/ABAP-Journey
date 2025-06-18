*&---------------------------------------------------------------------*
*& Report z_firs_program
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_firs_program.

"classical declaration of data
DATA lv_input1 TYPE n LENGTH 2 VALUE 10.
DATA lv_input2  TYPE n LENGTH 2 VALUE 20.
"Type i is used for arithmetic value store in the above value is used to
"store characters so if length 2 it can store 2 characters.

DATA lv_output TYPE i.

"Modern Declaration of data
DATA(lv_input3) = 30.

"Classic declaration of variable and then value
DATA lv_input4 TYPE n.



lv_input4 = 4.

lv_output = lv_input1 + lv_input2.

WRITE : / 'Result of adding:',lv_output.

WRITE: / 'this is my first program'.


"Chain Operators of data ( combining into one )
DATA : lv_input1 TYPE n LENGTH 2 VALUE 10,
       lv_input2 TYPE n LENGTH 2 VALUE 20.
