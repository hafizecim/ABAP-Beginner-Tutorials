REPORT ZZ_13_CASE_STATEMENT.

*---------------------------------------------------------------------*
* Report : ZZ_13_CASE_STATEMENT
* Purpose: Demonstrates CASE and Nested CASE statements in ABAP
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Simple CASE Statement
* 2. Multiple WHEN Conditions
* 3. Nested CASE Statement
* 4. WHEN OTHERS
*---------------------------------------------------------------------*

"=========================================================
" Variable Declarations
"=========================================================
DATA:
  lv_first_name TYPE string VALUE 'Joe',
  lv_last_name  TYPE string VALUE 'Smith'.

WRITE: / 'First Name:', lv_first_name,
       / 'Last Name :', lv_last_name.

ULINE.

"=========================================================
" 1. Simple CASE Statement
"=========================================================
CASE lv_first_name.

  WHEN 'Joe'.

    WRITE: / 'First name is Joe'.

  WHEN 'John'.

    WRITE: / 'First name is John'.

  WHEN OTHERS.

    WRITE: / 'Unknown first name'.

ENDCASE.

ULINE.

"=========================================================
" 2. Multiple WHEN Conditions
"=========================================================
CASE lv_first_name.

  WHEN 'Joe' OR 'John'.

    WRITE: / 'User belongs to Group A'.

  WHEN 'Mary' OR 'Jane'.

    WRITE: / 'User belongs to Group B'.

  WHEN OTHERS.

    WRITE: / 'User belongs to Unknown Group'.

ENDCASE.

ULINE.

"=========================================================
" 3. Nested CASE Statement
"=========================================================
CASE lv_first_name.

  WHEN 'Joe'.

    CASE lv_last_name.

      WHEN 'Smith'.

        WRITE: / 'You are Joe Smith'.

      WHEN 'Brown'.

        WRITE: / 'You are Joe Brown'.

      WHEN OTHERS.

        WRITE: / 'You are Joe, but surname is different'.

    ENDCASE.

  WHEN OTHERS.

    WRITE: / 'You are not Joe'.

ENDCASE.

ULINE.

"=========================================================
" 4. WHEN OTHERS Example
"=========================================================
CASE lv_last_name.

  WHEN 'Smith'.

    WRITE: / 'Known surname'.

  WHEN 'Brown'.

    WRITE: / 'Known surname'.

  WHEN OTHERS.

    WRITE: / 'Unknown surname'.

ENDCASE.

ULINE.

WRITE: / 'Program completed successfully'.
