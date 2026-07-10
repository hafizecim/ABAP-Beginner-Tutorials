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
*---------------------------------------------------------------------*
* Display Results
*---------------------------------------------------------------------*

IF gt_flights IS INITIAL.

  WRITE: / 'No flight data found.'.
  RETURN.

ENDIF.

DATA:
  lv_flight_count      TYPE i,
  lv_total_capacity    TYPE i,
  lv_total_occupied    TYPE i,
  lv_total_available   TYPE i.

lv_flight_count = lines( gt_flights ).

ULINE.
WRITE: / 'Flight Capacity Report'.
ULINE.

LOOP AT gt_flights INTO DATA(gs_flight).

  WRITE: / 'Carrier                 :', gs_flight-carrid.
  WRITE: / 'Connection              :', gs_flight-connid.
  WRITE: / 'Flight Date             :', gs_flight-fldate.
  WRITE: / 'Currency                :', gs_flight-currency.

  SKIP.

  WRITE: / 'Ticket Price            :', gs_flight-price.
  WRITE: / 'Price With Tax          :', gs_flight-price_with_tax.
  WRITE: / 'Discounted Price        :', gs_flight-discounted_price.
  WRITE: / 'Increased Price         :', gs_flight-increased_price.

  SKIP.

  WRITE: / 'Maximum Seats           :', gs_flight-seatsmax.
  WRITE: / 'Occupied Seats          :', gs_flight-seatsocc.
  WRITE: / 'Available Seats         :', gs_flight-available_seats.
  WRITE: / 'Occupancy (%)           :', gs_flight-occupancy_percent.

  SKIP.

  WRITE: / 'Extended Capacity       :', gs_flight-extended_capacity.
  WRITE: / 'Reduced Capacity        :', gs_flight-reduced_capacity.
  WRITE: / 'Double Capacity         :', gs_flight-double_capacity.
  WRITE: / 'Triple Capacity         :', gs_flight-triple_capacity.
  WRITE: / 'Half Capacity           :', gs_flight-half_capacity.
  WRITE: / 'Quarter Capacity        :', gs_flight-quarter_capacity.

  SKIP.

  WRITE: / 'Double Available        :', gs_flight-double_available.
  WRITE: / 'Triple Available        :', gs_flight-triple_available.
  WRITE: / 'Estimated Occupied      :', gs_flight-estimated_occupied.
  WRITE: / 'Estimated Free Seats    :', gs_flight-estimated_free.
  WRITE: / 'Forecast Capacity       :', gs_flight-forecast_capacity.
  WRITE: / 'Expected Occupied       :', gs_flight-expected_occupied.
  WRITE: / 'Estimated Occupancy (%) :', gs_flight-estimated_occupancy.

  ULINE.

  lv_total_capacity  = lv_total_capacity  + gs_flight-seatsmax.
  lv_total_occupied  = lv_total_occupied  + gs_flight-seatsocc.
  lv_total_available = lv_total_available + gs_flight-available_seats.

ENDLOOP.

*---------------------------------------------------------------------*
* Summary
*---------------------------------------------------------------------*

ULINE.
WRITE: / 'Summary'.
ULINE.

WRITE: / 'Number of Flights  :', lv_flight_count.
WRITE: / 'Total Capacity     :', lv_total_capacity.
WRITE: / 'Total Occupied     :', lv_total_occupied.
WRITE: / 'Total Available    :', lv_total_available.

IF lv_total_capacity > 0.

  WRITE:
  / 'Overall Occupancy % :',
    ( lv_total_occupied * 100 ) / lv_total_capacity.

ENDIF.

*---------------------------------------------------------------------*
* Best Practices
*---------------------------------------------------------------------*

SKIP.
ULINE.
WRITE: / 'Best Practices'.
ULINE.

WRITE: / '- Perform arithmetic calculations in Open SQL whenever appropriate.'.
WRITE: / '- Select only the columns required by the application.'.
WRITE: / '- Use meaningful aliases for calculated columns.'.
WRITE: / '- Use CAST for decimal precision when needed.'.
WRITE: / '- Prevent division by zero in percentage calculations.'.
WRITE: / '- Keep arithmetic expressions simple and readable.'.
WRITE: / '- Filter records in the database using WHERE conditions.'.
WRITE: / '- Avoid repeating the same calculation multiple times.'.

*---------------------------------------------------------------------*
* End of Program
*---------------------------------------------------------------------*

SKIP.
ULINE.
WRITE: / 'Program completed successfully.'.
ULINE.
