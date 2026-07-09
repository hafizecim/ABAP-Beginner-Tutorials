REPORT ZOSQL_45_FOR_ALL_ENTRIES_PERFORMANCE.

*---------------------------------------------------------------------*
* Report  : ZOSQL_45_FOR_ALL_ENTRIES_PERFORMANCE
* Purpose : Demonstrates Performance Best Practices for
*           FOR ALL ENTRIES in Modern ABAP Open SQL
*---------------------------------------------------------------------*
*
* Description
*---------------------------------------------------------------------*
* This program demonstrates how to optimize FOR ALL ENTRIES queries
* by preparing an efficient driver table and selecting only the
* required database fields.
*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Driver Table Optimization
* 2. IS INITIAL Validation
* 3. Remove Duplicate Keys
* 4. Select Required Fields Only
* 5. Avoid SELECT *
* 6. FOR ALL ENTRIES
* 7. ORDER BY PRIMARY KEY
* 8. Result Validation
* 9. Performance Best Practices
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* 1. Read Driver Table
*---------------------------------------------------------------------*
SELECT
       carrid

  FROM scarr

  INTO TABLE @DATA(lt_carriers)

  UP TO 10 ROWS.

IF sy-subrc <> 0.

  WRITE: / 'No airline records found.'.
  RETURN.

ENDIF.

*---------------------------------------------------------------------*
* 2. Validate Driver Table
*---------------------------------------------------------------------*
IF lt_carriers IS INITIAL.

  WRITE: / 'Driver table is empty.'.
  RETURN.

ENDIF.

WRITE: / 'Driver Records Before Optimization :',
         lines( lt_carriers ).

ULINE.

*---------------------------------------------------------------------*
* 3. Optimize Driver Table
*---------------------------------------------------------------------*
SORT lt_carriers BY carrid.

DELETE ADJACENT DUPLICATES
       FROM lt_carriers
       COMPARING carrid.

WRITE: / 'Driver Records After Optimization  :',
         lines( lt_carriers ).

ULINE.

*---------------------------------------------------------------------*
* 4. Read Related Data
*---------------------------------------------------------------------*
SELECT
       carrid,
       connid,
       cityfrom,
       cityto

  FROM spfli

  INTO TABLE @DATA(lt_connections)

  FOR ALL ENTRIES IN @lt_carriers

 WHERE carrid = @lt_carriers-carrid

 ORDER BY PRIMARY KEY.

*---------------------------------------------------------------------*
* 5. Validate Result
*---------------------------------------------------------------------*
IF sy-subrc <> 0
   OR lt_connections IS INITIAL.

  WRITE: / 'No flight connections found.'.
  RETURN.

ENDIF.

*---------------------------------------------------------------------*
* 6. Display Result
*---------------------------------------------------------------------*
WRITE: / '========== Flight Connections =========='.
ULINE.

LOOP AT lt_connections INTO DATA(ls_connection).

  WRITE: /
         'Carrier    :', ls_connection-carrid.

  WRITE: /
         'Connection :', ls_connection-connid.

  WRITE: /
         'Departure  :', ls_connection-cityfrom.

  WRITE: /
         'Arrival    :', ls_connection-cityto.

  ULINE.

ENDLOOP.

*---------------------------------------------------------------------*
* 7. Performance Summary
*---------------------------------------------------------------------*
WRITE: / 'Driver Records     :', lines( lt_carriers ).
WRITE: / 'Returned Records   :', lines( lt_connections ).

ULINE.

WRITE: / 'Performance Recommendations'.
WRITE: / '- Check IS INITIAL before FOR ALL ENTRIES.'.
WRITE: / '- Remove duplicate keys from the driver table.'.
WRITE: / '- Select only the required fields.'.
WRITE: / '- Avoid SELECT * in production code.'.
WRITE: / '- Prefer INNER JOIN when applicable.'.

ULINE.

*---------------------------------------------------------------------*
* End of Program
*---------------------------------------------------------------------*
WRITE: / 'Program completed successfully.'.
