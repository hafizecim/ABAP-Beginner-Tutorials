REPORT ZOSQL_46_SELECT_SINGLE_VS_UP_TO_1.

*---------------------------------------------------------------------*
* Report  : ZOSQL_46_SELECT_SINGLE_VS_UP_TO_1
* Purpose : Compare SELECT SINGLE and SELECT ... UP TO 1 ROWS
*
* Description
*---------------------------------------------------------------------*
* This program demonstrates the differences between SELECT SINGLE
* and SELECT ... UP TO 1 ROWS in Modern ABAP Open SQL.
*
* Topics Covered
*---------------------------------------------------------------------*
* 1. SELECT SINGLE
* 2. SELECT ... UP TO 1 ROWS
* 3. Primary Key Access
* 4. Non-Key Search
* 5. ORDER BY
* 6. Result Validation (SY-SUBRC)
* 7. Performance Considerations
* 8. Common Mistakes
* 9. Best Practices
*---------------------------------------------------------------------*

TABLES:
  scarr,
  spfli.

*---------------------------------------------------------------------*
* Selection Screen
*---------------------------------------------------------------------*
PARAMETERS:
  p_carrid TYPE scarr-carrid DEFAULT 'LH'.

*---------------------------------------------------------------------*
* 1. SELECT SINGLE (Primary Key Access)
*---------------------------------------------------------------------*
WRITE: / '========== SELECT SINGLE =========='.

SELECT SINGLE
       carrid,
       carrname,
       currcode

  FROM scarr

  INTO @DATA(ls_carrier)

 WHERE carrid = @p_carrid.

IF sy-subrc = 0.

  WRITE: / 'Carrier ID   :', ls_carrier-carrid.
  WRITE: / 'Carrier Name :', ls_carrier-carrname.
  WRITE: / 'Currency     :', ls_carrier-currcode.

ELSE.

  WRITE: / 'Carrier not found.'.

ENDIF.

ULINE.

*---------------------------------------------------------------------*
* 2. SELECT ... UP TO 1 ROWS
*---------------------------------------------------------------------*
WRITE: / '========== SELECT UP TO 1 ROWS =========='.

SELECT
       carrid,
       connid,
       cityfrom,
       cityto

  FROM spfli

 WHERE carrid = @p_carrid

 ORDER BY connid ASCENDING

 INTO @DATA(ls_connection)

 UP TO 1 ROWS.

ENDSELECT.

IF sy-subrc = 0.

  WRITE: / 'Carrier    :', ls_connection-carrid.
  WRITE: / 'Connection :', ls_connection-connid.
  WRITE: / 'Departure  :', ls_connection-cityfrom.
  WRITE: / 'Arrival    :', ls_connection-cityto.

ELSE.

  WRITE: / 'No connection found.'.

ENDIF
