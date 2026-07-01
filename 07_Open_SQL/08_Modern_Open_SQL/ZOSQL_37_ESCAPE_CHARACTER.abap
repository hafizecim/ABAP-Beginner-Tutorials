REPORT ZOSQL_37_ESCAPE_CHARACTER.

*---------------------------------------------------------------------*
* Report : ZOSQL_37_ESCAPE_CHARACTER
* Purpose: Demonstrates Escape Character (@) in Open SQL
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. Escape Character (@)
* 2. Host Variable Separation
* 3. SQL Injection Safety
* 4. Dynamic Value Binding
* 5. Best Practices
*
*---------------------------------------------------------------------*

TABLES: sflight.

*---------------------------------------------------------------------*
* 1. Selection Parameter
*---------------------------------------------------------------------*
PARAMETERS:
  p_carrid TYPE sflight-carrid DEFAULT 'LH'.

*---------------------------------------------------------------------*
* 2. Unsafe vs Safe Usage Concept
*---------------------------------------------------------------------*

"-------------------------------------------------------------
" ❌ OLD / UNSAFE STYLE (Not allowed in modern Open SQL)
"-------------------------------------------------------------
" SELECT * FROM sflight WHERE carrid = p_carrid.

"-------------------------------------------------------------
" ✅ MODERN SAFE STYLE WITH ESCAPE CHARACTER (@)
"-------------------------------------------------------------
DATA(ls_flight) = VALUE sflight( ).

SELECT SINGLE
       carrid,
       connid,
       fldate,
       planetype,
       seatsmax,
       seatsocc

  FROM sflight

  INTO @ls_flight

 WHERE carrid = @p_carrid.

IF sy-subrc = 0.

  WRITE: / 'Flight Found'.
  ULINE.

  WRITE: / 'Carrier    :', ls_flight-carrid.
  WRITE: / 'Connection :', ls_flight-connid.
  WRITE: / 'Date       :', ls_flight-fldate.
  WRITE: / 'Plane Type :', ls_flight-planetype.
  WRITE: / 'Seats Max  :', ls_flight-seatsmax.
  WRITE: / 'Seats Occ  :', ls_flight-seatsocc.

ELSE.

  WRITE: / 'No flight found for given carrier.'.

ENDIF.

ULINE.

*---------------------------------------------------------------------*
* 3. Example with Inline Declaration
*---------------------------------------------------------------------*
SELECT COUNT( * )
  FROM sflight
  INTO @DATA(lv_count)
 WHERE carrid = @p_carrid.

WRITE: / 'Total flights:', lv_count.

ULINE.

*---------------------------------------------------------------------*
* 4. Why Escape Character (@) is Important
*---------------------------------------------------------------------*
* - Separates ABAP variables from DB fields
* - Prevents ambiguity in Open SQL parsing
* - Enables modern Open SQL syntax
* - Improves readability and safety
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* 5. Best Practice Example
*---------------------------------------------------------------------*
DATA(lv_carrier) = p_carrid.

SELECT SINGLE carrid
  FROM sflight
  INTO @DATA(lv_check)
 WHERE carrid = @lv_carrier.

IF sy-subrc = 0.
  WRITE: / 'Carrier exists:', lv_carrier.
ENDIF.

*---------------------------------------------------------------------*
* End of Program
*---------------------------------------------------------------------*
WRITE: / 'Program completed successfully.'.
