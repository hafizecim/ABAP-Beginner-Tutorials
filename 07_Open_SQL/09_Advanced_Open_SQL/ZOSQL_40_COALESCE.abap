REPORT ZOSQL_40_COALESCE.

*---------------------------------------------------------------------*
* Report : ZOSQL_40_COALESCE
* Purpose: Demonstrates COALESCE function in ABAP Open SQL
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. COALESCE Function
* 2. NULL Value Handling
* 3. Default Values
* 4. Column Alias
* 5. Modern Open SQL
* 6. Best Practices
*
*---------------------------------------------------------------------*

TABLES: sflight.

*---------------------------------------------------------------------*
* 1. Selection Parameter
*---------------------------------------------------------------------*
PARAMETERS:
  p_carrid TYPE sflight-carrid DEFAULT 'LH'.

*---------------------------------------------------------------------*
* 2. Read Flight Information Using COALESCE
*---------------------------------------------------------------------*
SELECT
       carrid,
       connid,
       fldate,

       COALESCE( planetype,
                 'UNKNOWN' ) AS plane_type,

       seatsmax,
       seatsocc

  FROM sflight

  INTO TABLE @DATA(lt_flights)

 WHERE carrid = @p_carrid

 ORDER BY connid.

*---------------------------------------------------------------------*
* 3. Display Result
*---------------------------------------------------------------------*
IF lt_flights IS INITIAL.

  WRITE: / 'No flight data found.'.
  RETURN.

ENDIF.

WRITE: / 'Flight Information'.
ULINE.

LOOP AT lt_flights INTO DATA(ls_flight).

  WRITE: /
      'Carrier    :', ls_flight-carrid.

  WRITE: /
      'Connection :', ls_flight-connid.

  WRITE: /
      'Date       :', ls_flight-fldate.

  WRITE: /
      'Plane Type :', ls_flight-plane_type.

  WRITE: /
      'Capacity   :', ls_flight-seatsmax.

  WRITE: /
      'Occupied   :', ls_flight-seatsocc.

  ULINE.

ENDLOOP.

*---------------------------------------------------------------------*
* End of Program
*---------------------------------------------------------------------*
WRITE: / 'Program completed successfully.'.
