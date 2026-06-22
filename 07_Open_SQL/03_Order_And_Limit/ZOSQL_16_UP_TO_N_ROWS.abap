REPORT ZOSQL_16_UP_TO_N_ROWS.

*---------------------------------------------------------------------*
* Report : ZOSQL_16_UP_TO_N_ROWS
* Purpose: Demonstrates UP TO n ROWS in Open SQL
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Input Parameters
* 2. Type Definition
* 3. UP TO n ROWS
* 4. ORDER BY Usage
* 5. Result Validation
* 6. Internal Table Processing
* 7. Performance Considerations
*---------------------------------------------------------------------*

"=========================================================
" 1. Input Parameters
"=========================================================
PARAMETERS:
  p_rows TYPE i DEFAULT 10.

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
" 4. Validate Requested Row Count
"=========================================================
IF p_rows <= 0.

  WRITE: / 'Row count must be greater than zero.'.
  RETURN.

ENDIF.

"=========================================================
" 5. Read Limited Number of Records
"=========================================================
SELECT carrid,
       connid,
       fldate,
       price,
       currency
  FROM sflight
  ORDER BY fldate DESCENDING,
           carrid ASCENDING
  INTO CORRESPONDING FIELDS OF TABLE @lt_flights
  UP TO @p_rows ROWS.

"=========================================================
" 6. Validate Result
"=========================================================
IF lt_flights IS INITIAL.

  WRITE: / 'No records found.'.
  RETURN.

ENDIF.

"=========================================================
" 7. Summary Information
"=========================================================
WRITE: / 'Requested Rows :', p_rows.
WRITE: / 'Returned Rows  :', lines( lt_flights ).

ULINE.

"=========================================================
" 8. Display Results
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
