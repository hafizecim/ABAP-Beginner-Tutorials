REPORT ZOSQL_44_FOR_ALL_ENTRIES_BASIC.

*---------------------------------------------------------------------*
* Report : ZOSQL_44_FOR_ALL_ENTRIES_BASIC
* Purpose: Demonstrates FOR ALL ENTRIES in ABAP Open SQL
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. FOR ALL ENTRIES
* 2. Driver Internal Table
* 3. Empty Table Check
* 4. Duplicate Handling
* 5. Inline Declaration
* 6. Modern Open SQL
* 7. Best Practices
*
*---------------------------------------------------------------------*

TABLES:
  scarr,
  spfli.

*---------------------------------------------------------------------*
* 1. Read Driver Table
*---------------------------------------------------------------------*
SELECT carrid,
       carrname
  FROM scarr
  INTO TABLE @DATA(lt_carriers)
  UP TO 5 ROWS.

*---------------------------------------------------------------------*
* 2. Mandatory Empty Table Check
*---------------------------------------------------------------------*
IF lt_carriers IS INITIAL.

  WRITE: / 'No carrier records found.'.
  RETURN.

ENDIF.

*---------------------------------------------------------------------*
* 3. Remove Duplicate Keys (Best Practice)
*---------------------------------------------------------------------*
SORT lt_carriers BY carrid.
DELETE ADJACENT DUPLICATES FROM lt_carriers COMPARING carrid.

*---------------------------------------------------------------------*
* 4. Read Related Records
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
* 5. Display Results
*---------------------------------------------------------------------*
IF lt_connections IS INITIAL.

  WRITE: / 'No connection data found.'.
  RETURN.

ENDIF.

WRITE: / 'Flight Connections'.
ULINE.

LOOP AT lt_connections INTO DATA(ls_connection).

  WRITE: / 'Carrier    :', ls_connection-carrid.
  WRITE: / 'Connection :', ls_connection-connid.
  WRITE: / 'From       :', ls_connection-cityfrom.
  WRITE: / 'To         :', ls_connection-cityto.

  ULINE.

ENDLOOP.

*---------------------------------------------------------------------*
* End of Program
*---------------------------------------------------------------------*
WRITE: / 'Program completed successfully.'.
