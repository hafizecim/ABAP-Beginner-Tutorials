REPORT ZOSQL_02_SELECT_UP_TO_1_ROWS.

*---------------------------------------------------------------------*
* Report : ZOSQL_02_SELECT_UP_TO_1_ROWS
* Purpose: Demonstrates SELECT ... UP TO 1 ROWS in Open SQL
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Define Input Parameters
* 2. SELECT with UP TO 1 ROWS
* 3. ORDER BY Clause
* 4. Host Variables (@)
* 5. Inline Data Declaration
* 6. SY-SUBRC Validation
* 7. Display Result
*---------------------------------------------------------------------*

"=========================================================
" 1. Define Input Parameters
"=========================================================
PARAMETERS:
  p_carrid TYPE sflight-carrid DEFAULT 'LH'.

"=========================================================
" 2. Define Result Structure
"=========================================================
DATA:
  ls_flight TYPE sflight.

"=========================================================
" 3. Select First Matching Record
"=========================================================
SELECT carrid,
       connid,
       fldate,
       price,
       currency
  FROM sflight
  WHERE carrid = @p_carrid
  ORDER BY fldate DESCENDING
  INTO CORRESPONDING FIELDS OF @ls_flight
  UP TO 1 ROWS.

ENDSELECT.

"=========================================================
" 4. Validate Result
"=========================================================
IF sy-subrc = 0.

  WRITE: / 'Flight Record Found'.

  ULINE.

  "=======================================================
  " 5. Display Result
  "=======================================================
  WRITE: / 'Carrier ID :', ls_flight-carrid,
         / 'Connection :', ls_flight-connid,
         / 'Flight Date:', ls_flight-fldate,
         / 'Price      :', ls_flight-price,
         / 'Currency   :', ls_flight-currency.

ELSE.

  WRITE: / 'No matching flight record found.'.

ENDIF.

ULINE.

"=========================================================
" End of Program
"=========================================================
WRITE: / 'Program completed successfully'.
