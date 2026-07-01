REPORT ZOSQL_36_INLINE_DECLARATION.

*---------------------------------------------------------------------*
* Report : ZOSQL_36_INLINE_DECLARATION
* Purpose: Demonstrates Inline Declarations in Modern Open SQL
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. Inline Declaration (@DATA)
* 2. SELECT SINGLE with inline result
* 3. COUNT(*) inline
* 4. Aggregate functions inline
* 5. Internal table inline creation
* 6. Best practices
*
*---------------------------------------------------------------------*

TABLES: sflight.

*---------------------------------------------------------------------*
* 1. Selection Parameters
*---------------------------------------------------------------------*
PARAMETERS:
  p_carrid TYPE sflight-carrid DEFAULT 'LH'.

*---------------------------------------------------------------------*
* 2. SELECT SINGLE with Inline Structure
*---------------------------------------------------------------------*
SELECT SINGLE
       carrid,
       connid,
       fldate,
       planetype,
       seatsmax,
       seatsocc

  FROM sflight

  INTO @DATA(ls_flight)

 WHERE carrid = @p_carrid.

IF sy-subrc = 0.

  WRITE: / 'Flight Details'.
  ULINE.

  WRITE: / 'Carrier    :', ls_flight-carrid.
  WRITE: / 'Connection :', ls_flight-connid.
  WRITE: / 'Date       :', ls_flight-fldate.
  WRITE: / 'Plane Type :', ls_flight-planetype.
  WRITE: / 'Seats Max  :', ls_flight-seatsmax.
  WRITE: / 'Seats Occ  :', ls_flight-seatsocc.

ELSE.

  WRITE: / 'No flight found.'.

ENDIF.

ULINE.

*---------------------------------------------------------------------*
* 3. COUNT(*) Inline Declaration
*---------------------------------------------------------------------*
SELECT COUNT( * )
  FROM sflight
  INTO @DATA(lv_count)
 WHERE carrid = @p_carrid.

WRITE: / 'Total flights for carrier', p_carrid, ':', lv_count.

ULINE.

*---------------------------------------------------------------------*
* 4. Aggregate Example (SUM)
*---------------------------------------------------------------------*
SELECT SUM( seatsocc )
  FROM sflight
  INTO @DATA(lv_total_seats)
 WHERE carrid = @p_carrid.

WRITE: / 'Total occupied seats:', lv_total_seats.

ULINE.

*---------------------------------------------------------------------*
* 5. Inline Internal Table Declaration
*---------------------------------------------------------------------*
SELECT carrid,
       connid,
       fldate
  FROM sflight
  INTO TABLE @DATA(lt_flights)
 WHERE carrid = @p_carrid.

LOOP AT lt_flights INTO DATA(ls_row).

  WRITE: / ls_row-carrid,
           ls_row-connid,
           ls_row-fldate.

ENDLOOP.

ULINE.

*---------------------------------------------------------------------*
* 6. Best Practice Example (Explicit vs Inline)
*---------------------------------------------------------------------*

" Recommended (clean modern ABAP)
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
