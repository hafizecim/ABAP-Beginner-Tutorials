REPORT ZOSQL_21_MAX.

*---------------------------------------------------------------------*
* Report : ZOSQL_21_MAX
* Purpose: Demonstrates MAX aggregation in Open SQL
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. MAX Basic Usage
* 2. MAX with WHERE Condition
* 3. GROUP BY + MAX
* 4. Business Scenarios
* 5. Performance Considerations
*---------------------------------------------------------------------*

"=========================================================
" 1. Input Parameter
"=========================================================
PARAMETERS:
  p_carrid TYPE sflight-carrid DEFAULT 'LH'.

"=========================================================
" 2. Type Definition
"=========================================================
TYPES:
  BEGIN OF ty_max_price,
    carrid    TYPE sflight-carrid,
    max_price TYPE sflight-price,
  END OF ty_max_price.

"=========================================================
" 3. Data Declarations
"=========================================================
DATA:
  lv_max_price TYPE sflight-price,
  lt_max_price TYPE STANDARD TABLE OF ty_max_price,
  ls_max_price TYPE ty_max_price.

"=========================================================
" 4. MAX - Highest Flight Price
"=========================================================
SELECT MAX( price )
  FROM sflight
  INTO @lv_max_price
  WHERE carrid = @p_carrid.

WRITE: / 'Carrier       :', p_carrid.
WRITE: / 'Highest Price :', lv_max_price.

ULINE.

"=========================================================
" 5. MAX with Additional Condition
"=========================================================
SELECT MAX( price )
  FROM sflight
  INTO @lv_max_price
  WHERE carrid = @p_carrid
    AND seatsmax > 200.

WRITE: / 'Highest Price (Seats > 200):', lv_max_price.

ULINE.

"=========================================================
" 6. GROUP BY + MAX
"=========================================================
SELECT
       carrid,
       MAX( price ) AS max_price
  FROM sflight
 GROUP BY carrid
 INTO TABLE @lt_max_price.

WRITE: / 'Maximum Price by Carrier'.

ULINE.

LOOP AT lt_max_price INTO ls_max_price.

  WRITE: / 'Carrier :', ls_max_price-carrid,
         'Maximum :', ls_max_price-max_price.

ENDLOOP.

ULINE.

"=========================================================
" 7. Empty Result Check
"=========================================================
IF lv_max_price IS INITIAL.

  WRITE: / 'No matching records found.'.

ENDIF.

"=========================================================
" End of Program
"=========================================================
WRITE: / 'Program completed successfully.'.
