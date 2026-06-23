REPORT ZOSQL_17_COUNT.

*---------------------------------------------------------------------*
* Report : ZOSQL_17_COUNT
* Purpose: Demonstrates COUNT aggregation in Open SQL
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. COUNT(*) usage
* 2. COUNT(field)
* 3. COUNT DISTINCT
* 4. WHERE condition with COUNT
* 5. Grouped COUNT
* 6. Performance considerations
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
  lv_total_flights TYPE i,
  lv_unique_conn    TYPE i.

"=========================================================
" 3. COUNT(*) - Total Records
"=========================================================
SELECT COUNT( * )
  FROM sflight
  INTO @lv_total_flights
  WHERE carrid = @p_carrid.

WRITE: / 'Total Flights (ALL):', lv_total_flights.
ULINE.

"=========================================================
" 4. COUNT(DISTINCT field)
"=========================================================
SELECT COUNT( DISTINCT connid )
  FROM sflight
  INTO @lv_unique_conn
  WHERE carrid = @p_carrid.

WRITE: / 'Unique Connections:', lv_unique_conn.
ULINE.

"=========================================================
" 5. COUNT with different condition
"=========================================================
DATA lv_expensive TYPE i.

SELECT COUNT( * )
  FROM sflight
  INTO @lv_expensive
  WHERE carrid = @p_carrid
    AND price > 1000.

WRITE: / 'Flights with Price > 1000:', lv_expensive.
ULINE.

"=========================================================
" 6. Grouped COUNT (Advanced)
"=========================================================
TYPES: BEGIN OF ty_count,
         carrid TYPE sflight-carrid,
         cnt    TYPE i,
       END OF ty_count.

DATA lt_count TYPE TABLE OF ty_count.

SELECT carrid,
       COUNT( * ) AS cnt
  FROM sflight
  GROUP BY carrid
  INTO TABLE @lt_count.

WRITE: / 'Flights Count by Carrier:'.
ULINE.

LOOP AT lt_count INTO DATA(ls_count).

  WRITE: / 'Carrier:', ls_count-carrid,
         'Count  :', ls_count-cnt.

ENDLOOP.

"=========================================================
" End of Program
"=========================================================
WRITE: / 'Program completed successfully'.
