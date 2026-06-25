REPORT ZOSQL_20_MIN.

*---------------------------------------------------------------------*
* Report : ZOSQL_20_MIN
* Purpose: Demonstrates MIN aggregation in Open SQL
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. MIN Basic Usage
* 2. MIN with WHERE Condition
* 3. GROUP BY + MIN
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
  BEGIN OF ty_min_price,
    carrid    TYPE sflight-carrid,
    min_price TYPE sflight-price,
  END OF ty_min_price.

"=========================================================
" 3. Data Declarations
"=========================================================
DATA:
  lv_min_price TYPE sflight-price,
  lt_min_price TYPE STANDARD TABLE OF ty_min_price,
  ls_min_price TYPE ty_min_price.

"=========================================================
" 4. MIN - Lowest Flight Price
"=========================================================
SELECT MIN( price )
  FROM sflight
  INTO @lv_min_price
  WHERE carrid = @p_carrid.

WRITE: / 'Carrier       :', p_carrid.
WRITE: / 'Lowest Price  :', lv_min_price.

ULINE.

"=========================================================
" 5. MIN with Additional Condition
"=========================================================
SELECT MIN( price )
  FROM sflight
  INTO @lv_min_price
  WHERE carrid = @p_carrid
    AND seatsmax > 200.

WRITE: / 'Lowest Price (Seats > 200):', lv_min_price.

ULINE.

"=========================================================
" 6. GROUP BY + MIN
"=========================================================
SELECT
       carrid,
       MIN( price ) AS min_price
  FROM sflight
 GROUP BY carrid
 INTO TABLE @lt_min_price.

WRITE: / 'Minimum Price by Carrier'.

ULINE.

LOOP AT lt_min_price INTO ls_min_price.

  WRITE: / 'Carrier :', ls_min_price-carrid,
         'Minimum :', ls_min_price-min_price.

ENDLOOP.

ULINE.

"=========================================================
" 7. Empty Result Check
"=========================================================
IF lv_min_price IS INITIAL.

  WRITE: / 'No matching records found.'.

ENDIF.

"=========================================================
" End of Program
"=========================================================
WRITE: / 'Program completed successfully.'.
