REPORT ZOSQL_42_ARITHMETIC_EXPRESSIONS.

*---------------------------------------------------------------------*
* Report : ZOSQL_42_ARITHMETIC_EXPRESSIONS
* Purpose: Demonstrates Arithmetic Expressions in Modern ABAP Open SQL
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. Arithmetic Expressions
* 2. Addition (+)
* 3. Subtraction (-)
* 4. Multiplication (*)
* 5. Division (/)
* 6. Calculated Columns
* 7. Column Aliases (AS)
* 8. Inline Internal Table
* 9. Modern Open SQL
* 10. Best Practices
*
*---------------------------------------------------------------------*

TABLES: sflight.

*---------------------------------------------------------------------*
* 1. Selection Parameters
*---------------------------------------------------------------------*
PARAMETERS:
  p_carrid TYPE sflight-carrid DEFAULT 'LH'.

*---------------------------------------------------------------------*
* 2. Read Flight Data with Arithmetic Expressions
*---------------------------------------------------------------------*
SELECT
       carrid,
       connid,
       seatsmax,
       seatsocc,

       ( seatsmax - seatsocc )              AS available_seats,

       ( seatsocc * 100 / seatsmax )        AS occupancy_percent,

       ( seatsmax + 20 )                    AS extended_capacity,

       ( seatsmax * 2 )                     AS double_capacity,

       ( seatsocc / 2 )                     AS half_occupied

  FROM sflight

  INTO TABLE @DATA(lt_flights)

 WHERE carrid = @p_carrid
   AND seatsmax > 0

 ORDER BY connid.

*---------------------------------------------------------------------*
* 3. Display Results
*---------------------------------------------------------------------*
IF lt_flights IS INITIAL.

  WRITE: / 'No flight data found.'.
  RETURN.

ENDIF.

WRITE: / 'Flight Capacity Report'.
ULINE.

LOOP AT lt_flights INTO DATA(ls_flight).

  WRITE: / 'Carrier            :', ls_flight-carrid.
  WRITE: / 'Connection         :', ls_flight-connid.
  WRITE: / 'Maximum Seats      :', ls_flight-seatsmax.
  WRITE: / 'Occupied Seats     :', ls_flight-seatsocc.
  WRITE: / 'Available Seats    :', ls_flight-available_seats.
  WRITE: / 'Occupancy (%)      :', ls_flight-occupancy_percent.
  WRITE: / 'Extended Capacity  :', ls_flight-extended_capacity.
  WRITE: / 'Double Capacity    :', ls_flight-double_capacity.
  WRITE: / 'Half Occupied      :', ls_flight-half_occupied.

  ULINE.

ENDLOOP.

*---------------------------------------------------------------------*
* End of Program
*---------------------------------------------------------------------*
WRITE: / 'Program completed successfully.'.
