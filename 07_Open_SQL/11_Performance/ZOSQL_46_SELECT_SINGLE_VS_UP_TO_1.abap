REPORT ZOSQL_46_SELECT_SINGLE_VS_UP_TO_1.

*---------------------------------------------------------------------*
* Report : ZOSQL_46_SELECT_SINGLE_VS_UP_TO_1
* Purpose: Compare SELECT SINGLE and SELECT ... UP TO 1 ROWS
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. SELECT SINGLE
* 2. SELECT ... UP TO 1 ROWS
* 3. Primary Key Access
* 4. Non-Key Search
* 5. ORDER BY
* 6. Performance Considerations
* 7. Best Practices
*
*---------------------------------------------------------------------*

TABLES:
  scarr,
  spfli.

*---------------------------------------------------------------------*
* 1. Selection Parameters
*---------------------------------------------------------------------*
PARAMETERS:
  p_carrid TYPE scarr-carrid DEFAULT 'LH'.

*---------------------------------------------------------------------*
* 2. SELECT SINGLE (Primary Key Access)
*---------------------------------------------------------------------*
SELECT SINGLE
       carrid,
       carrname,
       currcode

  FROM scarr

  INTO @DATA(ls_carrier)

 WHERE carrid = @p_carrid.

IF sy-subrc = 0.

  WRITE: / '=== SELECT SINGLE ==='.
  WRITE: / 'Carrier ID   :', ls_carrier-carrid.
  WRITE: / 'Carrier Name :', ls_carrier-carrname.
  WRITE: / 'Currency     :', ls_carrier-currcode.

ELSE.

  WRITE: / 'Carrier not found.'.

ENDIF.

ULINE.

*---------------------------------------------------------------------*
* 3. SELECT ... UP TO 1 ROWS
*---------------------------------------------------------------------*
SELECT
       carrid,
       connid,
       cityfrom,
       cityto

  FROM spfli

 WHERE carrid = @p_carrid

 ORDER BY connid

 UP TO 1 ROWS

 INTO @DATA(ls_connection).

ENDSELECT.

IF sy-subrc = 0.

  WRITE: / '=== UP TO 1 ROWS ==='.
  WRITE: / 'Carrier    :', ls_connection-carrid.
  WRITE: / 'Connection :', ls_connection-connid.
  WRITE: / 'From       :', ls_connection-cityfrom.
  WRITE: / 'To         :', ls_connection-cityto.

ELSE.

  WRITE: / 'No connection found.'.

ENDIF.

ULINE.

*---------------------------------------------------------------------*
* End of Program
*---------------------------------------------------------------------*
WRITE: / 'Program completed successfully.'.
