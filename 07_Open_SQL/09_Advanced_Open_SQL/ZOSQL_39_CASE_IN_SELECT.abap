REPORT ZOSQL_39_CASE_IN_SELECT.

*---------------------------------------------------------------------*
* Report : ZOSQL_39_CASE_IN_SELECT
* Purpose: Demonstrates CASE expression in ABAP Open SQL
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. CASE Expression
* 2. Calculated Columns
* 3. Column Aliases (AS)
* 4. Inline Internal Table
* 5. ORDER BY
* 6. Modern Open SQL
* 7. Best Practices
*
*---------------------------------------------------------------------*

TABLES: sflight.

*---------------------------------------------------------------------*
* 1. Selection Parameter
*---------------------------------------------------------------------*
PARAMETERS:
  p_carrid TYPE sflight-carrid DEFAULT 'LH'.

*---------------------------------------------------------------------*
* 2. SELECT with CASE Expression
*---------------------------------------------------------------------*
SELECT
       carrid,
       connid,
       seatsmax,
       seatsocc,

       CASE

         WHEN seatsocc = 0
           THEN 'Empty Flight'

         WHEN seatsocc < seatsmax / 2
           THEN 'Available'

         WHEN seatsocc < seatsmax
           THEN 'Almost Full'

         ELSE
           'Full Flight'

       END AS flight_status

  FROM sflight

  INTO TABLE @DATA(lt_flights)

 WHERE carrid = @p_carrid

 ORDER BY connid.

*---------------------------------------------------------------------*
* 3. Display Results
*---------------------------------------------------------------------*
IF lt_flights IS INITIAL.

  WRITE: / 'No flight data found.'.
  RETURN.

ENDIF.

WRITE: / 'Flight Status Report'.
ULINE.

LOOP AT lt_flights INTO DATA(ls_flight).

  WRITE: /
    'Carrier :', ls_flight-carrid,
    'Connection :', ls_flight-connid.

  WRITE: /
    'Capacity :', ls_flight-seatsmax,
    'Occupied :', ls_flight-seatsocc.

  WRITE: /
    'Status :', ls_flight-flight_status.

  ULINE.

ENDLOOP.

*---------------------------------------------------------------------*
* End of Program
*---------------------------------------------------------------------*
WRITE: / 'Program completed successfully.'.
