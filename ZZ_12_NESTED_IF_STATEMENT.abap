REPORT ZZ_12_NESTED_IF_STATEMENT.

*---------------------------------------------------------------------*
* Report : ZZ_12_NESTED_IF_STATEMENT
* Purpose: Demonstrates nested IF statements in ABAP
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Nested IF Statement
* 2. Multiple Conditions with AND
* 3. ELSEIF Statement
* 4. Finding the Largest Number
*---------------------------------------------------------------------*

"=========================================================
" Variable Declarations
"=========================================================
DATA:
  lv_number_1 TYPE i VALUE 1,
  lv_number_2 TYPE i VALUE 2,
  lv_number_3 TYPE i VALUE 3.

WRITE: / 'Number 1:', lv_number_1,
       / 'Number 2:', lv_number_2,
       / 'Number 3:', lv_number_3.

ULINE.

"=========================================================
" 1. Check Whether All Numbers Are Equal
"=========================================================
IF lv_number_1 = lv_number_2
   AND lv_number_2 = lv_number_3.

  WRITE: / 'All numbers are equal'.

"=========================================================
" 2. Nested IF Statement
"=========================================================
ELSEIF lv_number_1 > lv_number_2.

  IF lv_number_1 > lv_number_3.

    WRITE: / |Largest number is { lv_number_1 }|.

  ELSE.

    WRITE: / |Largest number is { lv_number_3 }|.

  ENDIF.

"=========================================================
" 3. ELSEIF Statement
"=========================================================
ELSEIF lv_number_2 > lv_number_3.

  WRITE: / |Largest number is { lv_number_2 }|.

"=========================================================
" 4. ELSE Statement
"=========================================================
ELSE.

  WRITE: / |Largest number is { lv_number_3 }|.

ENDIF.

ULINE.

WRITE: / 'Program completed successfully'.
