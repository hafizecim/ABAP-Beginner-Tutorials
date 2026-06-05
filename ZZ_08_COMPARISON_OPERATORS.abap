REPORT zz_08_comparison_operators.

*---------------------------------------------------------------------*
* Report : ZZ_08_COMPARISON_OPERATORS
* Purpose: Demonstrates comparison and logical operators in ABAP
*---------------------------------------------------------------------*

"=========================================================
" Variable Declarations
"=========================================================
DATA:
  lv_operand_1 TYPE i VALUE 13,
  lv_operand_2 TYPE i VALUE 8.

WRITE: / |Operand 1 = { lv_operand_1 }|,
       / |Operand 2 = { lv_operand_2 }|.

ULINE.

"=========================================================
" Comparison Operators
"=========================================================

IF lv_operand_1 = lv_operand_2.

  WRITE: / 'Equal (=)',
         / 'Operand 1 is equal to Operand 2'.

ENDIF.

ULINE.

IF lv_operand_1 <> lv_operand_2.

  WRITE: / 'Not Equal (<>)',
         / 'Operand 1 is not equal to Operand 2'.

ENDIF.

ULINE.

IF lv_operand_1 < lv_operand_2.

  WRITE: / 'Less Than (<)',
         / 'Operand 1 is less than Operand 2'.

ENDIF.

ULINE.

IF lv_operand_1 > lv_operand_2.

  WRITE: / 'Greater Than (>)',
         / 'Operand 1 is greater than Operand 2'.

ENDIF.

ULINE.

IF lv_operand_1 <= lv_operand_2.

  WRITE: / 'Less Than or Equal (<=)',
         / 'Operand 1 is less than or equal to Operand 2'.

ENDIF.

ULINE.

IF lv_operand_1 >= lv_operand_2.

  WRITE: / 'Greater Than or Equal (>=)',
         / 'Operand 1 is greater than or equal to Operand 2'.

ENDIF.

ULINE.

"=========================================================
" Logical Operators
"=========================================================

IF lv_operand_1 = 13 AND lv_operand_2 = 8.

  WRITE: / 'Logical AND',
         / 'Both conditions are true'.

ENDIF.

ULINE.

IF lv_operand_1 = 13 OR lv_operand_2 = 8.

  WRITE: / 'Logical OR',
         / 'At least one condition is true'.

ENDIF.

ULINE.

IF NOT lv_operand_1 = 13.

  WRITE: / 'Logical NOT',
         / 'Operand 1 is not equal to 13'.

ENDIF.

ULINE.

IF lv_operand_1 = 13
   AND NOT lv_operand_2 = 8.

  WRITE: / 'AND with NOT',
         / 'Operand 1 equals 13 and Operand 2 does not equal 8'.

ENDIF.

ULINE.

IF lv_operand_1 = 13
   OR NOT lv_operand_2 = 8.

  WRITE: / 'OR with NOT',
         / 'Operand 1 equals 13 or Operand 2 does not equal 8'.

ENDIF.

ULINE.

"=========================================================
" Complex Conditions
"=========================================================

IF lv_operand_1 = 13
   AND lv_operand_2 = 8
   OR lv_operand_1 > 10.

  WRITE: / 'Complex Condition',
         / 'Condition using AND and OR'.

ENDIF.

ULINE.

IF lv_operand_1 = 13
   AND ( lv_operand_2 = 8
         OR lv_operand_2 < 10 ).

  WRITE: / 'Condition with Parentheses',
         / 'Operand 2 equals 8 or is less than 10'.

ENDIF.

ULINE.

IF lv_operand_1 = 13
   AND ( lv_operand_2 = 8
         OR lv_operand_2 < 10 )
   AND NOT lv_operand_1 > 20.

  WRITE: / 'Complex Condition with NOT',
         / 'All conditions are satisfied'.

ENDIF.

ULINE.

"=========================================================
" End of Program
"=========================================================

WRITE: / 'Program completed successfully'.
