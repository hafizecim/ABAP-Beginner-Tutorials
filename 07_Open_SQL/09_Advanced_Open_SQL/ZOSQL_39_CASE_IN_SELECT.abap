REPORT ZOSQL_39_CASE_IN_SELECT.

*---------------------------------------------------------------------*
* Report  : ZOSQL_39_CASE_IN_SELECT
* Purpose : Demonstrates CASE Expression in Modern ABAP Open SQL
*---------------------------------------------------------------------*
*
* Description
*---------------------------------------------------------------------*
* This program demonstrates how to use CASE expressions inside
* Open SQL SELECT statements to derive business information directly
* from the database.
*
* Topics Covered
*---------------------------------------------------------------------*
* 1. CASE Expression
* 2. Multiple WHEN Conditions
* 3. ELSE Condition
* 4. Calculated Columns
* 5. Column Alias (AS)
* 6. Business Logic in SQL
* 7. Modern Open SQL
* 8. Inline Declaration
* 9. ORDER BY
* 10. Best Practices
*---------------------------------------------------------------------*

TABLES: sflight.

*---------------------------------------------------------------------*
* Selection Screen
*---------------------------------------------------------------------*
PARAMETERS:
  p_carrid TYPE sflight-carrid DEFAULT 'LH'.

*---------------------------------------------------------------------*
* Read Flight Data Using CASE Expression
*---------------------------------------------------------------------*
SELECT
       carrid,
       connid,
       fldate,
       seatsmax,
       seatsocc,

       CASE

         WHEN seatsocc = 0
           THEN 'EMPTY'

         WHEN seatsocc < ( seatsmax / 2 )
           THEN 'AVAILABLE'

         WHEN seatsocc < seatsmax
           THEN 'ALMOST FULL'

         ELSE
           'FULL'

       END AS flight_status

  FROM sflight

  INTO TABLE @DATA(lt_flights)

 WHERE carrid = @p_carrid

 ORDER BY connid.

*---------------------------------------------------------------------*
* Validate Result
*---------------------------------------------------------------------*
IF sy-subrc <> 0
   OR lt_flights IS INITIAL.

  WRITE: / 'No flight records found.'.
  RETURN.

ENDIF.

*---------------------------------------------------------------------*
* Display Report
*---------------------------------------------------------------------*
WRITE: / '================ Flight Status Report ================'.
ULINE.

LOOP AT lt_flights INTO DATA(ls_flight).

  WRITE: / 'Carrier        :', ls_flight-carrid.
  WRITE: / 'Connection     :', ls_flight-connid.
  WRITE: / 'Flight Date    :', ls_flight-fldate.
  WRITE: / 'Maximum Seats  :', ls_flight-seatsmax.
  WRITE: / 'Occupied Seats :', ls_flight-seatsocc.
  WRITE: / 'Flight Status  :', ls_flight-flight_status.

  ULINE.

ENDLOOP.

*---------------------------------------------------------------------*
* Summary
*---------------------------------------------------------------------*
WRITE: / 'Total Flights :', lines( lt_flights ).

ULINE.

WRITE: / 'CASE expression evaluated directly in the database.'.

*---------------------------------------------------------------------*
* End of Program
*---------------------------------------------------------------------*
WRITE: / 'Program completed successfully.'.
