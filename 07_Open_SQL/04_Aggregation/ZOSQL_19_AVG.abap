REPORT ZOSQL_19_AVG.

*---------------------------------------------------------------------*
* Report : ZOSQL_19_AVG
* Purpose: Demonstrates AVG aggregation in Open SQL
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. AVG basic usage
* 2. AVG with WHERE condition
* 3. GROUP BY + AVG
* 4. Business analytics usage
* 5. Performance considerations
*---------------------------------------------------------------------*

"=========================================================
" 1. Input Parameter
"=========================================================
PARAMETERS:
  p_carrid TYPE sflight-carrid DEFAULT 'LH'.

"=========================================================
" 2. Data Objects
"=========================================================
DATA:
  lv_avg_price TYPE sflight-price,
  lv_avg_high   TYPE sflight-price.

"=========================================================
" 3. AVG - Overall Average Price
"=========================================================
SELECT AVG( price )
  FROM sflight
  INTO @lv_avg_price
  WHERE carrid = @p_carrid.

WRITE: / 'Average Price (All Flights):', lv_avg_price.
ULINE.

"=========================================================
" 4. AVG with Condition
"=========================================================
SELECT AVG( price )
  FROM sflight
  INTO @lv_avg_high
  WHERE carrid = @p_carrid
    AND price > 1000.

WRITE: / 'Average Price (Price > 1000):', lv_avg_high.
ULINE.

"=========================================================
" 5. GROUP BY + AVG (Advanced)
"=========================================================
TYPES: BEGIN OF ty_avg,
         carrid TYPE sflight-carrid,
         avgval TYPE sflight-price,
       END OF ty_avg.

DATA lt_avg TYPE TABLE OF ty_avg.

SELECT carrid,
       AVG( price ) AS avgval
  FROM sflight
  GROUP BY carrid
  INTO TABLE @lt_avg.

WRITE: / 'Average Price by Carrier:'.
ULINE.

LOOP AT lt_avg INTO DATA(ls_avg).

  WRITE: / 'Carrier:', ls_avg-carrid,
         'Average :', ls_avg-avgval.

ENDLOOP.

"=========================================================
" 6. Empty Result Check
"=========================================================
IF lv_avg_price IS INITIAL.
  WRITE: / 'No data found for AVG calculation.'.
ENDIF.

"=========================================================
" End of Program
"=========================================================
WRITE: / 'Program completed successfully'.
