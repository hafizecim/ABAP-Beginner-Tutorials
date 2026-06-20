REPORT ZOSQL_07_WHERE_EQUAL.

*---------------------------------------------------------------------*
* Report : ZOSQL_07_WHERE_EQUAL
* Purpose: Demonstrates equality filtering using WHERE clause
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Define Input Parameters
* 2. Define Result Structure
* 3. WHERE Equal Condition
* 4. Host Variables (@)
* 5. Internal Table Storage
* 6. Result Validation
* 7. Display Records
*---------------------------------------------------------------------*

"=========================================================
" 1. Define Input Parameters
"=========================================================
PARAMETERS:
  p_carrid TYPE sflight-carrid DEFAULT 'LH'.

"=========================================================
" 2. Define Result Structure
"=========================================================
TYPES:
  BEGIN OF ty_flight,
    carrid   TYPE sflight-carrid,
    connid   TYPE sflight-connid,
    fldate   TYPE sflight-fldate,
    price    TYPE sflight-price,
    currency TYPE sflight-currency,
  END OF ty_flight.

DATA:
  lt_flights TYPE STANDARD TABLE OF ty_flight,
  ls_flight  TYPE ty_flight.

"=========================================================
" 3. Read Filtered Records
"=========================================================
SELECT carrid,
       connid,
       fldate,
       price,
       currency
  FROM sflight
  WHERE carrid = @p_carrid
  INTO CORRESPONDING FIELDS OF TABLE @lt_flights.

"=========================================================
" 4. Validate Result
"=========================================================
IF lt_flights IS INITIAL.

  WRITE: / 'No records found for carrier:', p_carrid.
  RETURN.

ENDIF.

"=========================================================
" 5. Display Summary
"=========================================================
WRITE: / 'Carrier ID    :', p_carrid.
WRITE: / 'Total Records :', lines( lt_flights ).

ULINE.

"=========================================================
" 6. Display Records
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
