REPORT ZOSQL_03_SELECT_INTO_STRUCTURE.

*---------------------------------------------------------------------*
* Report : ZOSQL_03_SELECT_INTO_STRUCTURE
* Purpose: Demonstrates SELECT INTO STRUCTURE in Open SQL
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Define Input Parameters
* 2. Define Custom Structure
* 3. SELECT INTO STRUCTURE
* 4. INTO CORRESPONDING FIELDS
* 5. Host Variables (@)
* 6. SY-SUBRC Validation
* 7. Display Result
*---------------------------------------------------------------------*

"=========================================================
" 1. Define Input Parameters
"=========================================================
PARAMETERS:
  p_carrid TYPE sflight-carrid DEFAULT 'LH',
  p_connid TYPE sflight-connid DEFAULT '0400'.

"=========================================================
" 2. Define Custom Structure
"=========================================================
TYPES:
  BEGIN OF ty_flight_info,
    carrid   TYPE sflight-carrid,
    connid   TYPE sflight-connid,
    fldate   TYPE sflight-fldate,
    price    TYPE sflight-price,
    currency TYPE sflight-currency,
  END OF ty_flight_info.

DATA:
  ls_flight_info TYPE ty_flight_info.

"=========================================================
" 3. Read Flight Record
"=========================================================
SELECT SINGLE
       carrid,
       connid,
       fldate,
       price,
       currency
  FROM sflight
  WHERE carrid = @p_carrid
    AND connid = @p_connid
  INTO CORRESPONDING FIELDS OF @ls_flight_info.

"=========================================================
" 4. Validate Result
"=========================================================
IF sy-subrc = 0.

  WRITE: / 'Flight Record Found'.

  ULINE.

  "=======================================================
  " 5. Display Structure Content
  "=======================================================
  WRITE: / 'Carrier ID :', ls_flight_info-carrid,
         / 'Connection :', ls_flight_info-connid,
         / 'Flight Date:', ls_flight_info-fldate,
         / 'Price      :', ls_flight_info-price,
         / 'Currency   :', ls_flight_info-currency.

ELSE.

  WRITE: / 'No flight record found.'.

ENDIF.

ULINE.

"=========================================================
" End of Program
"=========================================================
WRITE: / 'Program completed successfully'.
