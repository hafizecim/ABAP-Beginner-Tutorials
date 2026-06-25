REPORT ZOSQL_23_HAVING.

*---------------------------------------------------------------------*
* Report : ZOSQL_23_HAVING
* Purpose: Demonstrates HAVING clause in Open SQL
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. GROUP BY
* 2. HAVING
* 3. COUNT
* 4. SUM
* 5. AVG
* 6. MIN
* 7. MAX
* 8. ORDER BY
*---------------------------------------------------------------------*

"=========================================================
" 1. Selection Parameters
"=========================================================
PARAMETERS:
  p_mincnt TYPE i DEFAULT 5.

"=========================================================
" 2. Type Definition
"=========================================================
TYPES:
  BEGIN OF ty_statistics,
    carrid       TYPE sflight-carrid,
    flight_count TYPE i,
    total_price  TYPE sflight-price,
    avg_price    TYPE sflight-price,
    min_price    TYPE sflight-price,
    max_price    TYPE sflight-price,
  END OF ty_statistics.

"=========================================================
" 3. Data Objects
"=========================================================
DATA:
  gt_statistics TYPE STANDARD TABLE OF ty_statistics,
  gs_statistics TYPE ty_statistics.

"=========================================================
" 4. GROUP BY + HAVING
"=========================================================
SELECT
       carrid,
       COUNT( * )   AS flight_count,
       SUM( price ) AS total_price,
       AVG( price ) AS avg_price,
       MIN( price ) AS min_price,
       MAX( price ) AS max_price
  FROM sflight
 GROUP BY carrid
 HAVING COUNT( * ) >= @p_mincnt
 ORDER BY carrid
 INTO TABLE @gt_statistics.

"=========================================================
" 5. Validation
"=========================================================
IF gt_statistics IS INITIAL.
  WRITE: / 'No carrier satisfies the HAVING condition.'.
  RETURN.
ENDIF.

"=========================================================
" 6. Report Header
"=========================================================
WRITE: / 'Carrier Statistics (HAVING COUNT >=', p_mincnt, ')'.

ULINE.

"=========================================================
" 7. Display Result
"=========================================================
LOOP AT gt_statistics INTO gs_statistics.

  WRITE:
    / 'Carrier       :', gs_statistics-carrid,
    / 'Flights       :', gs_statistics-flight_count,
    / 'Total Price   :', gs_statistics-total_price,
    / 'Average Price :', gs_statistics-avg_price,
    / 'Minimum Price :', gs_statistics-min_price,
    / 'Maximum Price :', gs_statistics-max_price.

  ULINE.

ENDLOOP.

"=========================================================
" End of Program
"=========================================================
WRITE: / 'Program completed successfully.'.
