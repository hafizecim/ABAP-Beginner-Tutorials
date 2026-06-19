REPORT ZOSQL_01_SELECT_SINGLE.

*---------------------------------------------------------------------*
* Report : ZOSQL_01_SELECT_SINGLE
* Purpose: Demonstrates SELECT SINGLE statement in Open SQL
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Define Input Parameters
* 2. SELECT SINGLE Statement
* 3. Host Variables (@)
* 4. Inline Data Declaration
* 5. SY-SUBRC Validation
* 6. Display Result
*---------------------------------------------------------------------*

"=========================================================
" 1. Define Input Parameters
"=========================================================
PARAMETERS:
  p_carrid TYPE sflight-carrid DEFAULT 'LH'.

"=========================================================
" 2. SELECT SINGLE Statement
"=========================================================
SELECT SINGLE
       carrid,
       connid,
       fldate,
       price,
       currency
  FROM sflight
  WHERE carrid = @p_carrid
  INTO @DATA(ls_flight).

"=========================================================
" 3. Validate Result
"=========================================================
IF sy-subrc = 0.

  WRITE: / 'Flight Record Found'.

  ULINE.

  "=======================================================
  " 4. Display Result
  "=======================================================
  WRITE: / 'Carrier ID :', ls_flight-carrid,
         / 'Connection :', ls_flight-connid,
         / 'Flight Date:', ls_flight-fldate,
         / 'Price      :', ls_flight-price,
         / 'Currency   :', ls_flight-currency.

ELSE.

  WRITE: / 'No flight record found.'.

ENDIF.

ULINE.

"=========================================================
" End of Program
"=========================================================
WRITE: / 'Program completed successfully'.
