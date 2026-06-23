REPORT ZOSQL_18_SUM.

*---------------------------------------------------------------------*
* Report : ZOSQL_18_SUM
* Purpose: Demonstrates SUM aggregation in Open SQL
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. SUM basic usage
* 2. SUM with WHERE condition
* 3. GROUP BY + SUM
* 4. Financial aggregation logic
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
  lv_total_price TYPE sflight-price,
  lv_high_price   TYPE sflight-price.

"=========================================================
" 3. SUM - Total Price
"=========================================================
SELECT SUM( price )
  FROM sflight
  INTO @lv_total_price
  WHERE carrid = @p_carrid.

WRITE: / 'Total Price (All Flights):', lv_total_price.
ULINE.

"=========================================================
" 4. SUM with Condition
"=========================================================
SELECT SUM( price )
  FROM sflight
  INTO @lv_high_price
  WHERE carrid = @p_carrid
    AND price > 1000.

WRITE: / 'Total Price (Price > 1000):', lv_high_price.
ULINE.

"=========================================================
" 5. GROUP BY + SUM (Advanced)
"=========================================================
TYPES: BEGIN OF ty_sum,
         carrid TYPE sflight-carrid,
         total  TYPE sflight-price,
       END OF ty_sum.

DATA lt_sum TYPE TABLE OF ty_sum.

SELECT carrid,
       SUM( price ) AS total
  FROM sflight
  GROUP BY carrid
  INTO TABLE @lt_sum.

WRITE: / 'Total Price by Carrier:'.
ULINE.

LOOP AT lt_sum INTO DATA(ls_sum).

  WRITE: / 'Carrier:', ls_sum-carrid,
         'Total   :', ls_sum-total.

ENDLOOP.

"=========================================================
" 6. Zero Safety Check
"=========================================================
IF lv_total_price IS INITIAL.
  WRITE: / 'No data found for SUM calculation.'.
ENDIF.

"=========================================================
" End of Program
"=========================================================
WRITE: / 'Program completed successfully'.
