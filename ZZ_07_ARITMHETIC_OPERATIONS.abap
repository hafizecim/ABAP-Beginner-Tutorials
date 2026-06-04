REPORT zz_07_arithmetic_operations.

*---------------------------------------------------------------------*
* Report : ZZ_07_ARITHMETIC_OPERATIONS
* Purpose: Demonstrates arithmetic operators in ABAP
*---------------------------------------------------------------------*

"=========================================================
" Variable Declarations
"=========================================================
DATA:
  lv_operand_1 TYPE i VALUE 14,
  lv_operand_2 TYPE i VALUE 3,
  lv_result    TYPE i.

DATA lv_decimal_result TYPE p LENGTH 8 DECIMALS 2.

WRITE: / |Operand 1 = { lv_operand_1 }|,
       / |Operand 2 = { lv_operand_2 }|.

ULINE.

"=========================================================
" Addition
"=========================================================
lv_result = lv_operand_1 + lv_operand_2.

WRITE: / 'Addition',
       / |{ lv_operand_1 } + { lv_operand_2 } = { lv_result }|.

ULINE.

"=========================================================
" Subtraction
"=========================================================
lv_result = lv_operand_1 - lv_operand_2.

WRITE: / 'Subtraction',
       / |{ lv_operand_1 } - { lv_operand_2 } = { lv_result }|.

ULINE.

"=========================================================
" Multiplication
"=========================================================
lv_result = lv_operand_1 * lv_operand_2.

WRITE: / 'Multiplication',
       / |{ lv_operand_1 } * { lv_operand_2 } = { lv_result }|.

ULINE.

"=========================================================
" Division
"=========================================================
IF lv_operand_2 <> 0.

  lv_decimal_result = lv_operand_1 / lv_operand_2.

  WRITE: / 'Division',
         / |{ lv_operand_1 } / { lv_operand_2 } = { lv_decimal_result }|.

ELSE.

  WRITE: / 'Division by zero is not allowed'.

ENDIF.

ULINE.

"=========================================================
" Integer Division (DIV)
"=========================================================
IF lv_operand_2 <> 0.

  lv_result = lv_operand_1 DIV lv_operand_2.

  WRITE: / 'Integer Division (DIV)',
         / |{ lv_operand_1 } DIV { lv_operand_2 } = { lv_result }|.

ELSE.

  WRITE: / 'Division by zero is not allowed'.

ENDIF.

ULINE.

"=========================================================
" Modulus (MOD)
"=========================================================
IF lv_operand_2 <> 0.

  lv_result = lv_operand_1 MOD lv_operand_2.

  WRITE: / 'Modulus (MOD)',
         / |{ lv_operand_1 } MOD { lv_operand_2 } = { lv_result }|.

ELSE.

  WRITE: / 'Division by zero is not allowed'.

ENDIF.

ULINE.

"=========================================================
" Exponentiation
"=========================================================
DATA(lv_exponent) = 2.

lv_result = lv_operand_1 ** lv_exponent.

WRITE: / 'Exponentiation',
       / |{ lv_operand_1 } ** { lv_exponent } = { lv_result }|.

ULINE.

"=========================================================
" Unary Minus
"=========================================================
DATA(lv_negative_value) = -lv_operand_1.

WRITE: / 'Unary Minus',
       / |Negative value of { lv_operand_1 } = { lv_negative_value }|.

ULINE.

"=========================================================
" End of Program
"=========================================================
WRITE: / 'Program completed successfully'.
