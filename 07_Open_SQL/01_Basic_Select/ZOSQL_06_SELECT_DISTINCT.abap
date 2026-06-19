REPORT ZOSQL_06_SELECT_DISTINCT.

*---------------------------------------------------------------------*
* Report : ZOSQL_06_SELECT_DISTINCT
* Purpose: Demonstrates DISTINCT usage in Open SQL
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Define Input Parameters
* 2. Problem: Duplicate Data
* 3. DISTINCT Usage
* 4. Internal Table Storage
* 5. Loop Display
* 6. When to Use DISTINCT
*---------------------------------------------------------------------*

"=========================================================
" 1. Define Input Parameters
"=========================================================
PARAMETERS:
  p_carrid TYPE sflight-carrid DEFAULT 'LH'.

"=========================================================
" 2. Define Structure
"=========================================================
TYPES:
  BEGIN OF ty_flight,
    carrid TYPE sflight-carrid,
    connid TYPE sflight-connid,
  END OF ty_flight.

DATA:
  lt_flights TYPE STANDARD TABLE OF ty_flight,
  ls_flight  TYPE ty_flight.

"=========================================================
" 3. PROBLEM: Duplicate Data (Without DISTINCT)
"=========================================================
* SELECT carrid, connid
*   FROM sflight
*   WHERE carrid = @p_carrid
*   INTO TABLE @DATA(lt_raw_data).

"=========================================================
" 4. SOLUTION: DISTINCT
"=========================================================
SELECT DISTINCT
       carrid,
       connid
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
" 6. Display Result
"=========================================================
WRITE: / 'Distinct Flight Records for Carrier:', p_carrid.
ULINE.

LOOP AT lt_flights INTO ls_flight.

  WRITE: / 'Carrier ID :', ls_flight-carrid,
         / 'Connection :', ls_flight-connid.

  ULINE.

ENDLOOP.

"=========================================================
" 7. Performance Note
"=========================================================
WRITE: / 'NOTE: DISTINCT removes duplicate database rows only.'.
