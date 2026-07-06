REPORT ZOSQL_45_FOR_ALL_ENTRIES_PERFORMANCE.

*---------------------------------------------------------------------*
* Report : ZOSQL_45_FOR_ALL_ENTRIES_PERFORMANCE
* Purpose: Best Practices for FOR ALL ENTRIES Performance
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. Driver Table Optimization
* 2. IS INITIAL Check
* 3. Remove Duplicate Keys
* 4. Select Required Fields Only
* 5. Avoid SELECT *
* 6. FOR ALL ENTRIES Performance
* 7. Best Practices
*
*---------------------------------------------------------------------*

TABLES:
  scarr,
  spfli.

*---------------------------------------------------------------------*
* 1. Read Driver Table
*---------------------------------------------------------------------*
SELECT carrid
  FROM scarr
  INTO TABLE @DATA(lt_carriers)
  UP TO 10 ROWS.

*---------------------------------------------------------------------*
* 2. Check Driver Table
*---------------------------------------------------------------------*
IF lt_carriers IS INITIAL.

  WRITE: / 'Driver table is empty.'.
  RETURN.

ENDIF.

*---------------------------------------------------------------------*
* 3. Remove Duplicate Keys
*---------------------------------------------------------------------*
SORT lt_carriers BY carrid.

DELETE ADJACENT DUPLICATES
  FROM lt_carriers
  COMPARING carrid.

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

 WHERE carrid = @lt_carriers-carrid.

*---------------------------------------------------------------------*
* 5. Result Validation
*---------------------------------------------------------------------*
IF lt_connections IS INITIAL.

  WRITE: / 'No connection data found.'.
  RETURN.

ENDIF.

*---------------------------------------------------------------------*
* 6. Display Result
*---------------------------------------------------------------------*
WRITE: / 'Connection List'.
ULINE.

LOOP AT lt_connections INTO DATA(ls_connection).

  WRITE: /
         ls_connection-carrid,
         ls_connection-connid,
         ls_connection-cityfrom,
         ls_connection-cityto.

ENDLOOP.

ULINE.

WRITE: / 'Total Records :', lines( lt_connections ).

*---------------------------------------------------------------------*
* End of Program
*---------------------------------------------------------------------*
WRITE: / 'Program completed successfully.'.
