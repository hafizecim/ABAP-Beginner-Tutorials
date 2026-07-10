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
