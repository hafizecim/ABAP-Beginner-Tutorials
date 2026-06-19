REPORT ZOSQL_05_SELECT_FIELDS_ONLY.

*---------------------------------------------------------------------*
* Report : ZOSQL_05_SELECT_FIELDS_ONLY
* Purpose: Demonstrates field-based SELECT usage (performance oriented)
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Define Input Parameters
* 2. Bad Practice: SELECT *
* 3. Good Practice: Field-Based SELECT
* 4. Internal Table Usage
* 5. Performance Awareness
* 6. LOOP AT Display
*---------------------------------------------------------------------*

"=========================================================
" 1. Define Input Parameters
"=========================================================
PARAMETERS:
  p_carrid TYPE sflight-carrid DEFAULT 'LH'.

"=========================================================
" 2. Define Structure (Only Required Fields)
"=========================================================
TYPES:
  BEGIN OF ty_flight,
    carrid   TYPE sflight-carrid,
    connid   TYPE sflight-connid,
    fldate   TYPE sflight-fldate,
    price    TYPE sflight-price,
  END OF ty_flight.

DATA:
  lt_flights TYPE STANDARD TABLE OF ty_flight,
  ls_flight  TYPE ty_flight.

"=========================================================
" 3. BAD PRACTICE (COMMENTED)
"=========================================================
* SELECT *
*   FROM sflight
*   INTO TABLE @DATA(lt_all_fields)
*   WHERE carrid = @p_carrid.

"=========================================================
" 4. GOOD PRACTICE (Field-Based SELECT)
"=========================================================
SELECT carrid,
       connid,
       fldate,
       price
  FROM sflight
  WHERE carrid = @p_carrid
  INTO CORRESPONDING FIELDS OF TABLE @lt_flights.

"=========================================================
" 5. Validate Result
"=========================================================
IF lt_flights IS INITIAL.
  WRITE: / 'No data found for carrier:', p_carrid.
  RETURN.
ENDIF.

"=========================================================
" 6. Display Results
"=========================================================
WRITE: / 'Flights for Carrier:', p_carrid.
ULINE.

LOOP AT lt_flights INTO ls_flight.

  WRITE: / 'Carrier ID :', ls_flight-carrid,
         / 'Connection :', ls_flight-connid,
         / 'Flight Date:', ls_flight-fldate,
         / 'Price      :', ls_flight-price.

  ULINE.

ENDLOOP.

"=========================================================
" 7. Performance Note Output
"=========================================================
WRITE: / 'NOTE: Only required fields were selected from database.'.
