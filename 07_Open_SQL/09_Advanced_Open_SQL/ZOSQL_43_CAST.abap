REPORT ZOSQL_43_CAST.

*---------------------------------------------------------------------*
* Report : ZOSQL_43_CAST
* Purpose: Demonstrates CAST Expressions in Modern ABAP Open SQL
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. CAST Expression
* 2. Data Type Conversion
* 3. Character Conversion
* 4. Numeric Conversion
* 5. Column Aliases (AS)
* 6. Inline Internal Table
* 7. Modern Open SQL
* 8. Best Practices
*
*---------------------------------------------------------------------*

TABLES: sflight.

*---------------------------------------------------------------------*
* 1. Selection Parameter
*---------------------------------------------------------------------*
PARAMETERS:
  p_carrid TYPE sflight-carrid DEFAULT 'LH'.

*---------------------------------------------------------------------*
* 2. Read Data Using CAST
*---------------------------------------------------------------------*
SELECT
       carrid,

       connid,

       fldate,

       CAST( seatsmax AS INT4 )      AS maximum_seats,

       CAST( seatsocc AS INT4 )      AS occupied_seats,

       CAST( planetype AS CHAR(20) ) AS aircraft_type

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

WRITE: / 'Flight Information'.
ULINE.

LOOP AT lt_flights INTO DATA(ls_flight).

  WRITE: / 'Carrier        :', ls_flight-carrid.
  WRITE: / 'Connection     :', ls_flight-connid.
  WRITE: / 'Flight Date    :', ls_flight-fldate.
  WRITE: / 'Maximum Seats  :', ls_flight-maximum_seats.
  WRITE: / 'Occupied Seats :', ls_flight-occupied_seats.
  WRITE: / 'Aircraft Type  :', ls_flight-aircraft_type.

  ULINE.

ENDLOOP.

*---------------------------------------------------------------------*
* End of Program
*---------------------------------------------------------------------*
WRITE: / 'Program completed successfully.'.
