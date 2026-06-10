ZZ_11_IF_ELSEIF_ELSE_STATEMENT.

*---------------------------------------------------------------------*
* Report : ZZ_11_IF_ELSEIF_ELSE_STATEMENT
* Purpose: Demonstrates conditional statements in ABAP
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. IF Statement
* 2. IF ELSE Statement
* 3. IF ELSEIF ELSE Statement
* 4. IS INITIAL Check
* 5. BETWEEN Condition
* 6. IN Condition
* 7. IS NUMERIC Check
* 8. IS ASSIGNED Check
* 9. IS BOUND Check
* 10. Internal Table IS INITIAL Check
*---------------------------------------------------------------------*

DATA:
  lv_number_1 TYPE i VALUE 10,
  lv_number_2 TYPE i VALUE 20.

"=========================================================
" 1. IF Statement
"=========================================================

IF lv_number_1 <> lv_number_2.

  WRITE: / 'Numbers are different'.

ENDIF.

ULINE.

"=========================================================
" 2. IF ELSE Statement
"=========================================================

IF lv_number_1 = lv_number_2.

  WRITE: / 'Numbers are equal'.

ELSE.

  WRITE: / 'Numbers are not equal'.

ENDIF.

ULINE.

"=========================================================
" 3. IF ELSEIF ELSE Statement
"=========================================================

IF lv_number_1 > lv_number_2.

  WRITE: / 'Number 1 is greater'.

ELSEIF lv_number_1 < lv_number_2.

  WRITE: / 'Number 1 is smaller'.

ELSE.

  WRITE: / 'Numbers are equal'.

ENDIF.

ULINE.

"=========================================================
" 4. IS INITIAL Check
"=========================================================

DATA(lv_value) = 0.

IF lv_value IS INITIAL.

  WRITE: / 'Value is initial'.

ENDIF.

ULINE.

"=========================================================
" 5. BETWEEN Condition
"=========================================================

DATA(lv_score) = 150.

IF lv_score BETWEEN 100 AND 200.

  WRITE: / 'Score is within range'.

ENDIF.

ULINE.

"=========================================================
" 6. IN Condition
"=========================================================

DATA(lv_option) = 20.

IF lv_option IN ( 10, 20, 30 ).

  WRITE: / 'Value found in list'.

ENDIF.

ULINE.

"=========================================================
" 7. IS NUMERIC Check
"=========================================================

DATA(lv_numeric_text) TYPE string VALUE '12345'.

IF lv_numeric_text IS NUMERIC.

  WRITE: / 'Text contains only numeric characters'.

ENDIF.

ULINE.

"=========================================================
" 8. IS ASSIGNED Check
"=========================================================

DATA lr_data TYPE REF TO data.

FIELD-SYMBOLS <fs_data> TYPE any.

CREATE DATA lr_data TYPE i.

ASSIGN lr_data->* TO <fs_data>.

IF <fs_data> IS ASSIGNED.

  WRITE: / 'Field-symbol is assigned'.

ENDIF.

ULINE.

"=========================================================
" 9. IS BOUND Check
"=========================================================

CLASS lcl_demo DEFINITION.
  PUBLIC SECTION.
    METHODS constructor.
ENDCLASS.

CLASS lcl_demo IMPLEMENTATION.
  METHOD constructor.
  ENDMETHOD.
ENDCLASS.

DATA(lo_demo) = NEW lcl_demo( ).

IF lo_demo IS BOUND.

  WRITE: / 'Object reference is bound'.

ENDIF.

ULINE.

"=========================================================
" 10. Internal Table IS INITIAL Check
"=========================================================

DATA lt_numbers TYPE STANDARD TABLE OF i WITH EMPTY KEY.

IF lt_numbers IS INITIAL.

  WRITE: / 'Internal table is empty'.

ENDIF.

ULINE.

WRITE: / 'Program completed successfully'.
