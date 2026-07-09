REPORT ZOSQL_46_SELECT_SINGLE_VS_UP_TO_1.

*---------------------------------------------------------------------*
* Report  : ZOSQL_46_SELECT_SINGLE_VS_UP_TO_1
* Author  : ABAP Beginner Tutorials
* Purpose : Compare SELECT SINGLE and SELECT ... UP TO 1 ROWS
*
* Description
* --------------------------------------------------------------------
* This program demonstrates the functional and performance differences
* between SELECT SINGLE and SELECT ... UP TO 1 ROWS in Modern ABAP
* Open SQL.
*
* Topics Covered
* --------------------------------------------------------------------
* 1. SELECT SINGLE
* 2. SELECT ... UP TO 1 ROWS
* 3. Primary Key Access
* 4. Non-Key Field Search
* 5. ORDER BY
* 6. Result Validation
* 7. Performance Considerations
* 8. Best Practices
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
* 1. SELECT SINGLE
*---------------------------------------------------------------------*
WRITE: / '====================================================='.
WRITE: / '1. SELECT SINGLE'.
WRITE: / '====================================================='.

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
WRITE: / '====================================================='.
WRITE: / '2. SELECT ... UP TO 1 ROWS'.
WRITE: / '====================================================='.

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

ENDIF.

ULINE.

*---------------------------------------------------------------------*
* 3. Comparison
*---------------------------------------------------------------------*
WRITE: / '================ Comparison ================='.

WRITE: /
'SELECT SINGLE       -> Best for unique primary key access.'.

WRITE: /
'UP TO 1 ROWS        -> Best for first matching record.'.

WRITE: /
'ORDER BY supported  -> Only with UP TO 1 ROWS.'.

WRITE: /
'Primary Key Search  -> SELECT SINGLE'.

WRITE: /
'Non-Key Search      -> UP TO 1 ROWS'.

ULINE.

*---------------------------------------------------------------------*
* 4. Performance Notes
*---------------------------------------------------------------------*
WRITE: / 'Performance Recommendations'.

WRITE: /
'- Use SELECT SINGLE for full primary key lookups.'.

WRITE: /
'- Use ORDER BY with UP TO 1 ROWS.'.

WRITE: /
'- Avoid SELECT * whenever possible.'.

WRITE: /
'- Select only required fields.'.

WRITE: /
'- Validate SY-SUBRC after every database access.'.

ULINE.

*---------------------------------------------------------------------*
* End of Program
*---------------------------------------------------------------------*
WRITE: / 'Program completed successfully.'.
