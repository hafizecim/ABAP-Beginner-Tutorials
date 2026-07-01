REPORT ZOSQL_35_HOST_VARIABLES.

*---------------------------------------------------------------------*
* Report : ZOSQL_35_HOST_VARIABLES
* Purpose: Demonstrates Host Variables in Modern ABAP Open SQL
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. Host Variables (@)
* 2. Modern Open SQL Syntax
* 3. Selection Parameters
* 4. SELECT SINGLE
* 5. INTO Structure
* 6. WHERE Condition
* 7. sy-subrc
* 8. Best Practices
*
*---------------------------------------------------------------------*

TABLES: sflight.

*---------------------------------------------------------------------*
* 1. Selection Parameters
*---------------------------------------------------------------------*
PARAMETERS:
  p_carrid TYPE sflight-carrid DEFAULT 'LH',
  p_connid TYPE sflight-connid DEFAULT '0400'.

*---------------------------------------------------------------------*
* 2. Data Declaration
*---------------------------------------------------------------------*
DATA:
  ls_flight TYPE sflight.

*---------------------------------------------------------------------*
* 3. Read Flight Information Using Host Variables
*---------------------------------------------------------------------*
SELECT SINGLE
       carrid,
       connid,
       fldate,
       planetype,
       seatsmax,
       seatsocc

  FROM sflight

  INTO CORRESPONDING FIELDS OF @ls_flight

 WHERE carrid = @p_carrid
   AND connid = @p_connid.

*---------------------------------------------------------------------*
* 4. Validate Result
*---------------------------------------------------------------------*
IF sy-subrc = 0.

  WRITE: / 'Flight Information'.
  ULINE.

  WRITE: / 'Carrier     :', ls_flight-carrid.
  WRITE: / 'Connection  :', ls_flight-connid.
  WRITE: / 'Flight Date :', ls_flight-fldate.
  WRITE: / 'Plane Type  :', ls_flight-planetype.
  WRITE: / 'Max Seats   :', ls_flight-seatsmax.
  WRITE: / 'Occupied    :', ls_flight-seatsocc.

ELSE.

  WRITE: / 'No matching flight found.'.

ENDIF.

ULINE.

*---------------------------------------------------------------------*
* 5. Host Variable Example
*---------------------------------------------------------------------*
DATA(lv_carrier) = 'LH'.

SELECT COUNT( * )
  FROM sflight
  INTO @DATA(lv_count)
 WHERE carrid = @lv_carrier.

WRITE: / 'Number of flights for carrier', lv_carrier, ':', lv_count.

ULINE.

*---------------------------------------------------------------------*
* End of Program
*---------------------------------------------------------------------*
WRITE: / 'Program completed successfully.'.
