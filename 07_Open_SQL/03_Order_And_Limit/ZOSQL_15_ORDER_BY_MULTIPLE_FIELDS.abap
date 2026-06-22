REPORT ZOSQL_15_ORDER_BY_MULTIPLE_FIELDS.

*---------------------------------------------------------------------*
* Report : ZOSQL_15_ORDER_BY_MULTIPLE_FIELDS
* Purpose: Demonstrates sorting by multiple fields in Open SQL
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Input Parameters
* 2. Type Definition
* 3. ORDER BY Multiple Fields
* 4. Mixed ASCENDING / DESCENDING
* 5. Internal Table Storage
* 6. Result Validation
* 7. Display Output
*---------------------------------------------------------------------*

"=========================================================
" 1. Input Parameters
"=========================================================
PARAMETERS:
  p_carrid TYPE sflight-carrid DEFAULT 'LH'.

"=========================================================
" 2. Type Definition
"=========================================================
TYPES:
  BEGIN OF ty_flight,
    carrid   TYPE sflight-carrid,
    connid   TYPE sflight-connid,
    fldate   TYPE sflight-fldate,
    price    TYPE sflight-price,
    currency TYPE sflight-currency,
  END OF ty_flight.

"=========================================================
" 3. Data Objects
"=========================================================
DATA:
  lt_flights TYPE STANDARD TABLE OF ty_flight,
  ls_flight  TYPE ty_flight.

"=========================================================
" 4. Read Data
"=========================================================
SELECT carrid,
       connid,
       fldate,
       price,
       currency
  FROM sflight
  WHERE carrid = @p_carrid
  ORDER BY carrid ASCENDING,
           fldate DESCENDING,
           price DESCENDING
  INTO CORRESPONDING FIELDS OF TABLE @lt_flights.

"=========================================================
" 5. Validate Result
"=========================================================
IF lt_flights IS INITIAL.

  WRITE: / 'No records found.'.
  RETURN.

ENDIF.

"=========================================================
" 6. Summary
"=========================================================
WRITE: / 'Carrier ID Filter :', p_carrid.
WRITE: / 'Record Count      :', lines( lt_flights ).

ULINE.

"=========================================================
" 7. Display Records
"=========================================================
LOOP AT lt_flights INTO ls_flight.

  WRITE: / 'Carrier ID :', ls_flight-carrid,
         / 'Connection :', ls_flight-connid,
         / 'Flight Date:', ls_flight-fldate,
         / 'Price      :', ls_flight-price,
         / 'Currency   :', ls_flight-currency.

  ULINE.

ENDLOOP.

"=========================================================
" End of Program
"=========================================================
WRITE: / 'Program completed successfully'.
