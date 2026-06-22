REPORT ZOSQL_14_ORDER_BY_DESCENDING.

*---------------------------------------------------------------------*
* Report : ZOSQL_14_ORDER_BY_DESCENDING
* Purpose: Demonstrates ORDER BY DESCENDING in Open SQL
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Input Parameters
* 2. Type Definition
* 3. ORDER BY DESCENDING
* 4. Multiple Sort Criteria
* 5. Database-Level Sorting
* 6. Internal Table Storage
* 7. Result Validation
* 8. Display Output
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
" 4. Read and Sort Data
"=========================================================
SELECT carrid,
       connid,
       fldate,
       price,
       currency
  FROM sflight
  WHERE carrid = @p_carrid
  ORDER BY price DESCENDING,
           fldate DESCENDING
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
WRITE: / 'Carrier ID    :', p_carrid.
WRITE: / 'Record Count  :', lines( lt_flights ).
WRITE: / 'Sort Order    : Price DESC, Date DESC'.

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
