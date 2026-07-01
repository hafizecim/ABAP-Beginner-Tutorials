REPORT ZOSQL_38_NEW_OPEN_SQL_SYNTAX.

*---------------------------------------------------------------------*
* Report : ZOSQL_38_NEW_OPEN_SQL_SYNTAX
* Purpose: Demonstrates Modern Open SQL Syntax (7.40+)
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. @ Escape Character (Host Variables)
* 2. Inline Declarations (@DATA)
* 3. CORRESPONDING FIELDS
* 4. Aggregation Functions
* 5. Explicit Field Lists
* 6. Modern SELECT Style
* 7. Clean ABAP Principles
*
*---------------------------------------------------------------------*

TABLES: sflight.

*---------------------------------------------------------------------*
* 1. Selection Parameter
*---------------------------------------------------------------------*
PARAMETERS:
  p_carrid TYPE sflight-carrid DEFAULT 'LH'.

*---------------------------------------------------------------------*
* 2. Modern SELECT SINGLE
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
* 3. Modern SELECT INTO TABLE
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
* 4. Aggregate Function (COUNT)
*---------------------------------------------------------------------*
SELECT COUNT( * )
  FROM sflight
  INTO @DATA(lv_count)
 WHERE carrid = @p_carrid.

WRITE: / 'Total Flights:', lv_count.

ULINE.

*---------------------------------------------------------------------*
* 5. Aggregate Function (SUM)
*---------------------------------------------------------------------*
SELECT SUM( seatsocc )
  FROM sflight
  INTO @DATA(lv_total_seats)
 WHERE carrid = @p_carrid.

WRITE: / 'Total Occupied Seats:', lv_total_seats.

ULINE.

*---------------------------------------------------------------------*
* 6. CORRESPONDING FIELDS Example
*---------------------------------------------------------------------*
DATA ls_result TYPE sflight.

SELECT SINGLE
       carrid,
       connid,
       fldate

  FROM sflight

  INTO CORRESPONDING FIELDS OF @ls_result

 WHERE carrid = @p_carrid.

IF sy-subrc = 0.
  WRITE: / 'CORRESPONDING FIELDS result loaded.'.
ENDIF.

ULINE.

*---------------------------------------------------------------------*
* 7. Clean ABAP Best Practice Example
*---------------------------------------------------------------------*
DATA(lv_carrier) = p_carrid.

SELECT SINGLE carrid
  FROM sflight
  INTO @DATA(lv_check)
 WHERE carrid = @lv_carrier.

IF sy-subrc = 0.
  WRITE: / |Carrier { lv_carrier } exists in system|.
ENDIF.

*---------------------------------------------------------------------*
* End of Program
*---------------------------------------------------------------------*
WRITE: / 'Program completed successfully.'.
