REPORT ZOSQL_44_FOR_ALL_ENTRIES_BASIC.

*---------------------------------------------------------------------*
* Report  : ZOSQL_44_FOR_ALL_ENTRIES_BASIC
* Purpose : Demonstrates the basic usage of FOR ALL ENTRIES
*
* Description
*---------------------------------------------------------------------*
* This program demonstrates how to retrieve related database records
* using FOR ALL ENTRIES in Modern ABAP Open SQL.
*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Driver Internal Table
* 2. FOR ALL ENTRIES
* 3. Empty Table Check
* 4. Remove Duplicate Keys
* 5. Modern Open SQL
* 6. Inline Declarations
* 7. Result Validation
* 8. Performance Best Practices
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* 1. Read Driver Table
*---------------------------------------------------------------------*
SELECT
       carrid,
       carrname

  FROM scarr

  INTO TABLE @DATA(lt_carriers)

  UP TO 5 ROWS.

IF sy-subrc <> 0.

  WRITE: / 'No airline records found.'.
  RETURN.

ENDIF.

*---------------------------------------------------------------------*
* 2. Driver Table Validation
*---------------------------------------------------------------------*
IF lt_carriers IS INITIAL.

  WRITE: / 'Driver internal table is empty.'.
  RETURN.

ENDIF.

WRITE: / 'Driver Records :', lines( lt_carriers ).

ULINE.

*---------------------------------------------------------------------*
* 3. Remove Duplicate Keys
*---------------------------------------------------------------------*
SORT lt_carriers BY carrid.

DELETE ADJACENT DUPLICATES
       FROM lt_carriers
       COMPARING carrid.

*---------------------------------------------------------------------*
* 4. Read Related Flight Connections
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

  WRITE: / 'No flight connection records found.'.
  RETURN.

ENDIF.

*---------------------------------------------------------------------*
* 6. Display Driver Data
*---------------------------------------------------------------------*
WRITE: / '========== Airlines =========='.

LOOP AT lt_carriers INTO DATA(ls_carrier).

  WRITE: /
         ls_carrier-carrid,
         ls_carrier-carrname.

ENDLOOP.

ULINE.

*---------------------------------------------------------------------*
* 7. Display Related Records
*---------------------------------------------------------------------*
WRITE: / '========== Flight Connections =========='.

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
* 8. Summary
*---------------------------------------------------------------------*
WRITE: / 'Driver Records     :', lines( lt_carriers ).
WRITE: / 'Connection Records :', lines( lt_connections ).

ULINE.

WRITE: / 'Program completed successfully.'.
