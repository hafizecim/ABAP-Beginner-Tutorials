REPORT ZOSQL_10_WHERE_IN.

*---------------------------------------------------------------------*
* Report : ZOSQL_10_WHERE_IN
* Purpose: Demonstrates IN operator with SELECT-OPTIONS
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Selection Screen
* 2. SELECT-OPTIONS
* 3. IN Operator
* 4. Range Table Filtering
* 5. Internal Table Storage
* 6. Result Validation
* 7. Display Records
*---------------------------------------------------------------------*

"=========================================================
" 1. Selection Screen
"=========================================================
SELECT-OPTIONS:
  so_carrid FOR sflight-carrid.

"=========================================================
" 2. Result Structure
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
" 3. Validate Selection
"=========================================================
IF so_carrid IS INITIAL.

  WRITE: / 'Please enter at least one Carrier ID.'.
  RETURN.

ENDIF.

"=========================================================
" 4. Read Records Using IN
"=========================================================
SELECT carrid,
       connid,
       fldate,
       price,
       currency
  FROM sflight
  WHERE carrid IN @so_carrid
  INTO CORRESPONDING FIELDS OF TABLE @lt_flights
  ORDER BY carrid,
           connid.

"=========================================================
" 5. Validate Result
"=========================================================
IF lt_flights IS INITIAL.

  WRITE: / 'No records found.'.
  RETURN.

ENDIF.

"=========================================================
" 6. Display Summary
"=========================================================
WRITE: / 'Records Found :',
         lines( lt_flights ).

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
