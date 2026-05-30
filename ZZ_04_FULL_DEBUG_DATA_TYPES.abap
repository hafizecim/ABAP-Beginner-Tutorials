*&---------------------------------------------------------------------*
*& Report ZFULL_DEBUG_DATA_TYPES
*&---------------------------------------------------------------------*
*& ABAP Data Types + Debug Example
*& Modern Syntax Version
*&---------------------------------------------------------------------*

REPORT ZFULL_DEBUG_DATA_TYPES.

"==============================
" 1️⃣ Elementary Data Types
"==============================
DATA lv_char   TYPE c LENGTH 10 VALUE 'ABAPDEBUG'.
DATA lv_string TYPE string VALUE 'Hello ABAP'.
DATA lv_int    TYPE i VALUE 10.
DATA lv_dec    TYPE p LENGTH 8 DECIMALS 2 VALUE '123.45'.
DATA lv_flt    TYPE f VALUE '3.14'.
DATA lv_bool   TYPE abap_bool VALUE abap_true.
DATA lv_date   TYPE d VALUE '20250815'.
DATA lv_time   TYPE t VALUE '113000'.

WRITE: / |Char     : { lv_char }|,
       / |String   : { lv_string }|,
       / |Integer  : { lv_int }|,
       / |Decimal  : { lv_dec }|,
       / |Float    : { lv_flt }|,
       / |Boolean  : { lv_bool }|,
       / |Date     : { lv_date }|,
       / |Time     : { lv_time }|.

"==============================
" 2️⃣ Structure Example
"==============================
TYPES: BEGIN OF ty_person,
         name   TYPE string,
         age    TYPE i,
         gender TYPE c LENGTH 1,
       END OF ty_person.

DATA ls_person TYPE ty_person.

ls_person-name   = 'Ahmet'.
ls_person-age    = 30.
ls_person-gender = 'M'.

WRITE: / |Structure => Name: { ls_person-name }|,
       / |Age       : { ls_person-age }|,
       / |Gender    : { ls_person-gender }|.

"==============================
" 3️⃣ Internal Table Example
"==============================
TYPES ty_numbers TYPE TABLE OF i WITH DEFAULT KEY.

DATA lt_numbers TYPE ty_numbers.

APPEND 10 TO lt_numbers.
APPEND 20 TO lt_numbers.
APPEND 30 TO lt_numbers.

WRITE: / '--- Internal Table Content ---'.

LOOP AT lt_numbers INTO DATA(lv_num).

  WRITE: / |Number: { lv_num }|.

ENDLOOP.

"==============================
" 4️⃣ User-Specific Breakpoint
"==============================
WRITE: / 'User-specific breakpoint check'.

IF sy-uname = 'HAFIZE'.

  BREAK-POINT.

ENDIF.

"==============================
" 5️⃣ Conditional Breakpoint
"==============================
IF lv_int + lv_dec > 120.

  WRITE: / 'Condition satisfied. Debugger will stop here'.

  BREAK-POINT.

ENDIF.

"==============================
" 6️⃣ OOP ABAP - Method Debug
"==============================
CLASS cl_calc DEFINITION.

  PUBLIC SECTION.

    METHODS sum
      IMPORTING
        iv_a TYPE i
        iv_b TYPE i
      RETURNING VALUE(rv_sum) TYPE i.

ENDCLASS.

CLASS cl_calc IMPLEMENTATION.

  METHOD sum.

    " Breakpoint for debugger practice
    BREAK-POINT.

    rv_sum = iv_a + iv_b.

  ENDMETHOD.

ENDCLASS.

DATA lo_calc TYPE REF TO cl_calc.

lo_calc = NEW cl_calc( ).

DATA lv_total TYPE i.

lv_total = lo_calc->sum(
  iv_a = 7
  iv_b = 8
).

WRITE: / |Total = { lv_total }|.

"==============================
" 7️⃣ LOOP + Debug Keys Practice
"==============================
DATA lt_employees TYPE TABLE OF ty_person.

APPEND VALUE #(
  name   = 'Ayse'
  age    = 28
  gender = 'F'
) TO lt_employees.

APPEND VALUE #(
  name   = 'Mehmet'
  age    = 35
  gender = 'M'
) TO lt_employees.

WRITE: / '--- Employee List ---'.

LOOP AT lt_employees ASSIGNING FIELD-SYMBOL(<ls_emp>).

  " During debugging:
  " F5 -> Step Into
  " F6 -> Step Over
  " F7 -> Step Out
  " F8 -> Continue

  BREAK-POINT.

  WRITE: / |Name    : { <ls_emp>-name }|,
         / |Age     : { <ls_emp>-age }|,
         / |Gender  : { <ls_emp>-gender }|,
         / '-----------------------------'.

ENDLOOP.

"==============================
" 8️⃣ XSTRING Example
"==============================
DATA lv_xstring TYPE xstring VALUE X'4D5A'.

WRITE: / |XSTRING Value: { lv_xstring }|.

"==============================
" 9️⃣ Boolean Example
"==============================
IF lv_bool = abap_true.

  WRITE: / 'Boolean TRUE executed'.

ELSE.

  WRITE: / 'Boolean FALSE executed'.

ENDIF.

"==============================
" End of Program
"==============================
WRITE: / 'Program completed. Data types and debugging examples displayed.'.

*---------------------------------------------------------------------*
* DEBUG KEYS
*---------------------------------------------------------------------*
* F5  -> Step Into
*        Enters method/function
*
* F6  -> Step Over
*        Executes line without entering method
*
* F7  -> Return / Step Out
*        Exits current method/function
*
* F8  -> Continue
*        Continues until next breakpoint
*
* F9  -> Run to Cursor
*        Runs until cursor line
*
* Shift+F2
*        Watchpoint / Variable monitoring
*
* F3
*        Exit
*---------------------------------------------------------------------*
