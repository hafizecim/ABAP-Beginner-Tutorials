REPORT ZOSQL_09_WHERE_BETWEEN.

*---------------------------------------------------------------------*
* Report : ZOSQL_09_WHERE_BETWEEN
* Purpose: Demonstrates BETWEEN operator in Open SQL
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Define Input Parameters
* 2. Define Result Structure
* 3. BETWEEN Condition
* 4. Date Range Filtering
* 5. Internal Table Storage
* 6. Result Validation
* 7. Display Records
*---------------------------------------------------------------------*

"=========================================================
" 1. Define Input Parameters
"=========================================================
PARAMETERS:
  p_date_from TYPE sflight-fldate DEFAULT '20240101',
  p_date_to   TYPE sflight-fldate DEFAULT '20241231'.

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
" 3. Validate Input
"=========================================================
IF p_date_from > p_date_to.

  WRITE: / 'Invalid date range.'.
  WRITE: / 'Start date cannot be greater than end date.'.
  RETURN.

ENDIF.

"=========================================================
" 4. Read Records Within Date Range
"=========================================================
SELECT carrid,
       connid,
       fldate,
       price,
       currency
  FROM sflight
  WHERE fldate BETWEEN @p_date_from AND @p_date_to
  INTO CORRESPONDING FIELDS OF TABLE @lt_flights
  ORDER BY fldate ASCENDING.

"=========================================================
" 5. Validate Result
"=========================================================
IF lt_flights IS INITIAL.

  WRITE: / 'No records found in selected date range.'.
  RETURN.

ENDIF.

"=========================================================
" 6. Display Summary
"=========================================================
WRITE: / 'Date From     :', p_date_from.
WRITE: / 'Date To       :', p_date_to.
WRITE: / 'Records Found :', lines( lt_flights ).

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
