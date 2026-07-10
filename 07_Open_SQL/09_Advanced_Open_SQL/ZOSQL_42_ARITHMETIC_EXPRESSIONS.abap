REPORT ZOSQL_42_ARITHMETIC_EXPRESSIONS.

*---------------------------------------------------------------------*
* Report : ZOSQL_42_ARITHMETIC_EXPRESSIONS
* Purpose: Demonstrates Arithmetic Expressions in Modern ABAP Open SQL
*---------------------------------------------------------------------*
*
* Topics Covered
*
* 1. Addition (+)
* 2. Subtraction (-)
* 3. Multiplication (*)
* 4. Division (/)
* 5. Parentheses
* 6. Calculated Columns
* 7. Column Aliases (AS)
* 8. CAST
* 9. Nested Expressions
*10. Best Practices
*
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Selection Screen
*---------------------------------------------------------------------*
PARAMETERS:
  p_carrid TYPE sflight-carrid DEFAULT 'LH'.

*---------------------------------------------------------------------*
* Read Flight Data
*---------------------------------------------------------------------*
SELECT
       carrid,
       connid,
       fldate,
       currency,
       price,
       seatsmax,
       seatsocc,

*---------------------------------------------------------------------*
* Addition
*---------------------------------------------------------------------*

       ( seatsmax + 20 )                       AS extended_capacity,

*---------------------------------------------------------------------*
* Subtraction
*---------------------------------------------------------------------*

       ( seatsmax - seatsocc )                 AS available_seats,

       ( seatsmax - 10 )                       AS reduced_capacity,

*---------------------------------------------------------------------*
* Multiplication
*---------------------------------------------------------------------*

       ( seatsmax * 2 )                        AS double_capacity,

       ( seatsocc * 2 )                        AS double_occupied,

*---------------------------------------------------------------------*
* Division
*---------------------------------------------------------------------*

       ( seatsmax / 2 )                        AS half_capacity,

       ( seatsocc / 2 )                        AS half_occupied,

*---------------------------------------------------------------------*
* Nested Arithmetic Expressions
*---------------------------------------------------------------------*

       ( ( seatsmax - seatsocc ) * 2 )         AS double_available,

       ( ( seatsmax + 50 ) / 2 )               AS average_capacity,

*---------------------------------------------------------------------*
* Percentage Calculation
*---------------------------------------------------------------------*

       CAST(
            ( seatsocc * 100.0 / seatsmax )
            AS DEC(5,2)
           )                                   AS occupancy_percent

  FROM sflight

 WHERE carrid = @p_carrid
   AND seatsmax > 0

 ORDER BY
       carrid,
       connid,
       fldate

 INTO TABLE @DATA(gt_flights).

*---------------------------------------------------------------------*
* Check Result
*---------------------------------------------------------------------*

IF gt_flights IS INITIAL.

  WRITE: / 'No flight data found.'.
  RETURN.

ENDIF.
*---------------------------------------------------------------------*
* Price Calculations
*---------------------------------------------------------------------*

* Ticket price including 18% tax
       CAST(
            ( price * 1.18 )
            AS DEC(15,2)
           )                                   AS price_with_tax,

* Ticket price after 10% discount
       CAST(
            ( price * 0.90 )
            AS DEC(15,2)
           )                                   AS discounted_price,

* Price increased by 25%
       CAST(
            ( price * 1.25 )
            AS DEC(15,2)
           )                                   AS increased_price,

*---------------------------------------------------------------------*
* Capacity Planning
*---------------------------------------------------------------------*

* Planned additional seats
       ( seatsmax + 50 )                       AS planned_capacity,

* Estimated occupied seats
       ( seatsocc + 15 )                       AS estimated_occupied,

* Remaining seats after reservation
       ( seatsmax - seatsocc - 10 )            AS remaining_after_booking,

*---------------------------------------------------------------------*
* Advanced Arithmetic Expressions
*---------------------------------------------------------------------*

* Triple capacity
       ( seatsmax * 3 )                        AS triple_capacity,

* Quarter capacity
       ( seatsmax / 4 )                        AS quarter_capacity,

* Triple available seats
       ( ( seatsmax - seatsocc ) * 3 )         AS triple_available,

* Estimated free seats after reservations
       ( seatsmax - ( seatsocc + 20 ) )        AS estimated_free,

*---------------------------------------------------------------------*
* Capacity Ratios
*---------------------------------------------------------------------*

* Available seat percentage
       CAST(
            ( ( seatsmax - seatsocc ) * 100.0 / seatsmax )
            AS DEC(5,2)
           )                                   AS available_percent,

* Remaining capacity after maintenance
       CAST(
            ( ( seatsmax - 25 ) * 100.0 / seatsmax )
            AS DEC(5,2)
           )                                   AS maintenance_percent,

*---------------------------------------------------------------------*
* Complex Arithmetic Expressions
*---------------------------------------------------------------------*

* Forecast capacity after expansion
       CAST(
            ( ( seatsmax + 100 ) * 1.05 )
            AS DEC(10,2)
           )                                   AS forecast_capacity,

* Expected occupied seats
       CAST(
            ( seatsocc * 1.08 )
            AS DEC(10,2)
           )                                   AS expected_occupied,

* Estimated occupancy percentage
       CAST(
            ( ( seatsocc * 1.08 ) * 100.0 / seatsmax )
            AS DEC(5,2)
           )                                   AS estimated_occupancy
