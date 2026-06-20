REPORT ZOSQL_11_WHERE_LIKE.

*---------------------------------------------------------------------*
* Report : ZOSQL_11_WHERE_LIKE
* Purpose: Demonstrates LIKE operator in Open SQL
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Define Input Parameter
* 2. Build Search Pattern
* 3. LIKE Condition
* 4. Wildcards (% and _)
* 5. Internal Table Storage
* 6. Result Validation
* 7. Display Records
*---------------------------------------------------------------------*

"=========================================================
" 1. Define Input Parameter
"=========================================================
PARAMETERS:
  p_carrid TYPE sflight-carrid DEFAULT 'L'.

"=========================================================
" 2. Define Types
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
" 3. Define Data Objects
"=========================================================
DATA:
  lt_flights TYPE STANDARD TABLE OF ty_flight,
  ls_flight  TYPE ty_flight,
  lv_pattern TYPE string.

"=========================================================
" 4. Build Search Pattern
"=========================================================
lv_pattern = |{ p_carrid }%|.

" Example:
" p_carrid = 'L'
"
" Generated Pattern:
" L%

"=========================================================
" 5. Read Matching Records
"=========================================================
SELECT carrid,
       connid,
       fldate,
       price,
       currency
  FROM sflight
  WHERE carrid LIKE @lv_pattern
  INTO CORRESPONDING FIELDS OF TABLE @lt_flights
  ORDER BY carrid,
           connid.

"=========================================================
" 6. Validate Result
"=========================================================
IF lt_flights IS INITIAL.

  WRITE: / 'No matching records found.'.
  RETURN.

ENDIF.

"=========================================================
" 7. Display Summary
"=========================================================
WRITE: / 'Search Pattern :', lv_pattern.
WRITE: / 'Records Found  :', lines( lt_flights ).

ULINE.

"=========================================================
" 8. Display Records
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
