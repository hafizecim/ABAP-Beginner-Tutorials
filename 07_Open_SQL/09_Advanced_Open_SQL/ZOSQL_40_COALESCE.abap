REPORT ZOSQL_40_COALESCE.

*---------------------------------------------------------------------*
* Report  : ZOSQL_40_COALESCE
* Purpose : Demonstrates the COALESCE Function in Modern ABAP Open SQL
*---------------------------------------------------------------------*
*
* Description
*---------------------------------------------------------------------*
* This program demonstrates how to replace NULL database values with
* default values using the COALESCE function during data retrieval.
*
* Topics Covered
*---------------------------------------------------------------------*
* 1. COALESCE Function
* 2. NULL Value Handling
* 3. Default Value Assignment
* 4. Column Alias (AS)
* 5. Modern Open SQL
* 6. Inline Declaration
* 7. Result Validation
* 8. Best Practices
*---------------------------------------------------------------------*

TABLES: sflight.

*---------------------------------------------------------------------*
* Selection Screen
*---------------------------------------------------------------------*
PARAMETERS:
  p_carrid TYPE sflight-carrid DEFAULT 'LH'.

*---------------------------------------------------------------------*
* Read Flight Data Using COALESCE
*---------------------------------------------------------------------*
SELECT
       carrid,
       connid,
       fldate,

       COALESCE(
         planetype,
         'UNKNOWN'
       ) AS plane_type,

       seatsmax,
       seatsocc

  FROM sflight

  INTO TABLE @DATA(lt_flights)

 WHERE carrid = @p_carrid

 ORDER BY connid.

*---------------------------------------------------------------------*
* Validate Result
*---------------------------------------------------------------------*
IF sy-subrc <> 0
   OR lt_flights IS INITIAL.

  WRITE: / 'No flight records found.'.
  RETURN.

ENDIF.

*---------------------------------------------------------------------*
* Display Flight Information
*---------------------------------------------------------------------*
WRITE: / '================ Flight Information ================'.
ULINE.

LOOP AT lt_flights INTO DATA(ls_flight).

  WRITE: / 'Carrier        :', ls_flight-carrid.
  WRITE: / 'Connection     :', ls_flight-connid.
  WRITE: / 'Flight Date    :', ls_flight-fldate.
  WRITE: / 'Aircraft Type  :', ls_flight-plane_type.
  WRITE: / 'Maximum Seats  :', ls_flight-seatsmax.
  WRITE: / 'Occupied Seats :', ls_flight-seatsocc.

  ULINE.

ENDLOOP.

*---------------------------------------------------------------------*
* Summary
*---------------------------------------------------------------------*
WRITE: / 'Total Flights :', lines( lt_flights ).

ULINE.

WRITE: / 'NULL values are replaced using the COALESCE function.'.

*---------------------------------------------------------------------*
* End of Program
*---------------------------------------------------------------------*
WRITE: / 'Program completed successfully.'.
