Report ZOSQL_04_SELECT_INTO_TABLE.

*---------------------------------------------------------------------*
* Report : ZOSQL_04_SELECT_INTO_TABLE
* Purpose: Demonstrates SELECT INTO TABLE in Open SQL
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Define Input Parameters
* 2. Define Custom Structure
* 3. Define Internal Table
* 4. SELECT INTO TABLE
* 5. Host Variables (@)
* 6. ORDER BY Clause
* 7. Validate Result
* 8. LOOP Through Records
* 9. Count Records
*---------------------------------------------------------------------*

"=========================================================
" 1. Define Input Parameters
"=========================================================
PARAMETERS:
  p_carrid TYPE sflight-carrid DEFAULT 'LH'.

"=========================================================
" 2. Define Custom Structure
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
" 3. Define Internal Table
"=========================================================
DATA:
  lt_flights TYPE STANDARD TABLE OF ty_flight,
  ls_flight  TYPE ty_flight.

"=========================================================
" 4. Read Database Records
"=========================================================
SELECT carrid,
       connid,
       fldate,
       price,
       currency
  FROM sflight
  WHERE carrid = @p_carrid
  INTO CORRESPONDING FIELDS OF TABLE @lt_flights
  ORDER BY fldate ASCENDING.

"=========================================================
" 5. Validate Result
"=========================================================
IF sy-subrc <> 0.

  WRITE: / 'No flight records found.'.
  RETURN.

ENDIF.

WRITE: / 'Flight Records Found:'.

ULINE.

"=========================================================
" 6. Display Record Count
"=========================================================
WRITE: / 'Total Records:',
       lines( lt_flights ).

ULINE.

"=========================================================
" 7. Process Internal Table
"=========================================================
LOOP AT lt_flights INTO ls_flight.

  WRITE: / 'Row Number :', sy-tabix,
         / 'Carrier ID :', ls_flight-carrid,
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
