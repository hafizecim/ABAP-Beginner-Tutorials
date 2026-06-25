REPORT ZOSQL_22_GROUP_BY.

*---------------------------------------------------------------------*
* Report : ZOSQL_22_GROUP_BY
* Purpose: Demonstrates GROUP BY in Open SQL
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. GROUP BY
* 2. COUNT
* 3. SUM
* 4. AVG
* 5. MIN
* 6. MAX
* 7. ORDER BY
* 8. Aggregate Functions
*---------------------------------------------------------------------*

"=========================================================
" 1. Type Definition
"=========================================================
TYPES:
  BEGIN OF ty_statistics,

    carrid      TYPE sflight-carrid,
    flight_count TYPE i,
    total_price TYPE sflight-price,
    avg_price   TYPE sflight-price,
    min_price   TYPE sflight-price,
    max_price   TYPE sflight-price,

  END OF ty_statistics.

"=========================================================
" 2. Data Objects
"=========================================================
DATA:

  gt_statistics TYPE STANDARD TABLE OF ty_statistics,
  gs_statistics TYPE ty_statistics.

"=========================================================
" 3. GROUP BY + Aggregate Functions
"=========================================================
SELECT

       carrid,

       COUNT( * )      AS flight_count,
       SUM( price )    AS total_price,
       AVG( price )    AS avg_price,
       MIN( price )    AS min_price,
       MAX( price )    AS max_price

  FROM sflight

 GROUP BY carrid

 ORDER BY carrid

 INTO TABLE @gt_statistics.

"=========================================================
" 4. Validation
"=========================================================
IF gt_statistics IS INITIAL.

  WRITE: / 'No data found.'.
  RETURN.

ENDIF.

"=========================================================
" 5. Report Header
"=========================================================
WRITE: / 'Flight Statistics by Carrier'.

ULINE.

"=========================================================
" 6. Display Result
"=========================================================
LOOP AT gt_statistics INTO gs_statistics.

  WRITE:

    / 'Carrier        :', gs_statistics-carrid,
    / 'Flight Count   :', gs_statistics-flight_count,
    / 'Total Price    :', gs_statistics-total_price,
    / 'Average Price  :', gs_statistics-avg_price,
    / 'Minimum Price  :', gs_statistics-min_price,
    / 'Maximum Price  :', gs_statistics-max_price.

  ULINE.

ENDLOOP.

"=========================================================
" End of Program
"=========================================================
WRITE: / 'Program completed successfully.'.
