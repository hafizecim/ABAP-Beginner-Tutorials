REPORT ZOSQL_12_WHERE_AND_OR.

*---------------------------------------------------------------------*
* Report : ZOSQL_12_WHERE_AND_OR
* Purpose: Demonstrates AND / OR logic in Open SQL WHERE clause
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Input Parameters
* 2. AND Condition
* 3. OR Condition
* 4. Combined Logic
* 5. Parentheses Usage
* 6. Internal Table Result
* 7. Display Output
*---------------------------------------------------------------------*

"=========================================================
" 1. Input Parameters
"=========================================================
PARAMETERS:
  p_carrid TYPE sflight-carrid DEFAULT 'LH',
  p_price  TYPE sflight-price DEFAULT 1000.

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
" 4. AND + OR Logic Example
"=========================================================
SELECT carrid,
       connid,
       fldate,
       price,
       currency
  FROM sflight
  WHERE ( carrid = @p_carrid AND price > @p_price )
     OR price = @p_price
  INTO CORRESPONDING FIELDS OF TABLE @lt_flights
  ORDER BY carrid, price.

"=========================================================
" 5. Validate Result
"=========================================================
IF lt_flights IS INITIAL.

  WRITE: / 'No records found for given conditions.'.
  RETURN.

ENDIF.

"=========================================================
" 6. Summary Output
"=========================================================
WRITE: / 'Carrier ID Filter :', p_carrid.
WRITE: / 'Price Filter      :', p_price.
WRITE: / 'Total Records     :', lines( lt_flights ).

ULINE.

"=========================================================
" 7. Display Records
"=========================================================
LOOP AT lt_flights INTO ls_flight.

  WRITE: / 'Carrier  :', ls_flight-carrid,
         / 'Conn ID  :', ls_flight-connid,
         / 'Date     :', ls_flight-fldate,
         / 'Price    :', ls_flight-price,
         / 'Currency :', ls_flight-currency.

  ULINE.

ENDLOOP.

"=========================================================
" End of Program
"=========================================================
WRITE: / 'Program completed successfully'.
