REPORT ZREP_34_REPORT_WITH_OPEN_SQL.

*---------------------------------------------------------------------*
* Program    : ZREP_34_REPORT_WITH_OPEN_SQL
* Title      : Report with Open SQL
* Purpose    : Demonstrates Open SQL database access in a Classical
*              ABAP List Report.
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This report demonstrates the basic flow of a classical ABAP report
* that retrieves data from the SAP database using Open SQL.
*
* Processing Flow:
*
* Database Table
*      |
*      v
*    SELECT
*      |
*      v
* Internal Table
*      |
*      v
*     SORT
*      |
*      v
*    LOOP AT
*      |
*      v
* Classical List Output
*
* Topics Covered
* 1. Open SQL
* 2. SELECT
* 3. INTO TABLE
* 4. Internal tables
* 5. WHERE condition
* 6. ORDER BY
* 7. sy-subrc
* 8. sy-dbcnt
* 9. Classical list output
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand how a classical report retrieves database data.
* - Store SELECT results in an internal table.
* - Process database results with LOOP AT.
* - Handle empty SELECT results.
* - Display database data using WRITE.
*---------------------------------------------------------------------*

************************************************************************
* Types
************************************************************************

TYPES:
  BEGIN OF ty_flight,
    carrid   TYPE sflight-carrid,
    connid   TYPE sflight-connid,
    fldate   TYPE sflight-fldate,
    price    TYPE sflight-price,
    currency TYPE sflight-currency,
    planetype TYPE sflight-planetype,
  END OF ty_flight.

************************************************************************
* Data
************************************************************************

DATA:
  gt_flight TYPE STANDARD TABLE OF ty_flight,
  gs_flight TYPE ty_flight.

************************************************************************
* START-OF-SELECTION
************************************************************************

START-OF-SELECTION.

  PERFORM get_data.
  PERFORM display_report.

************************************************************************
* FORM get_data
************************************************************************
* Retrieves flight data from the database using Open SQL.

FORM get_data.

  SELECT
    FROM sflight
    FIELDS
      carrid,
      connid,
      fldate,
      price,
      currency,
      planetype
    INTO TABLE @gt_flight
    ORDER BY carrid,
             connid,
             fldate.

*---------------------------------------------------------------------*
* Check whether the SELECT returned any records.
*---------------------------------------------------------------------*

  IF sy-subrc <> 0.

    MESSAGE 'No flight data found.' TYPE 'I'.

    RETURN.

  ENDIF.

ENDFORM.

************************************************************************
* FORM display_report
************************************************************************
* Displays database records as a classical list.

FORM display_report.

*---------------------------------------------------------------------*
* Report Header
*---------------------------------------------------------------------*

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE: / '============================================================'.
  WRITE: / '                 FLIGHT DATABASE REPORT'.
  WRITE: / '============================================================'.

  FORMAT RESET.

  SKIP 1.

*---------------------------------------------------------------------*
* Report Information
*---------------------------------------------------------------------*

  WRITE: / 'Program       :', sy-repid.
  WRITE: / 'Database Table:', 'SFLIGHT'.
  WRITE: / 'Records Read  :', sy-dbcnt.
  WRITE: / 'Report Date   :', sy-datum.
  WRITE: / 'Report Time   :', sy-uzeit.

  SKIP 2.

*---------------------------------------------------------------------*
* Column Header
*---------------------------------------------------------------------*

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  POSITION 1.
  WRITE: 'Carrier'.

  POSITION 12.
  WRITE: 'Connection'.

  POSITION 25.
  WRITE: 'Flight Date'.

  POSITION 40.
  WRITE: 'Price'.

  POSITION 55.
  WRITE: 'Currency'.

  POSITION 65.
  WRITE: 'Plane Type'.

  FORMAT RESET.

  SKIP 1.

  ULINE.

*---------------------------------------------------------------------*
* Database Result Processing
*---------------------------------------------------------------------*

  LOOP AT gt_flight INTO gs_flight.

    POSITION 1.
    WRITE: / gs_flight-carrid.

    POSITION 12.
    WRITE: gs_flight-connid.

    POSITION 25.
    WRITE: gs_flight-fldate.

    POSITION 40.
    WRITE: gs_flight-price.

    POSITION 55.
    WRITE: gs_flight-currency.

    POSITION 65.
    WRITE: gs_flight-planetype.

  ENDLOOP.

*---------------------------------------------------------------------*
* Final Section
*---------------------------------------------------------------------*

  SKIP 1.

  ULINE.

  FORMAT COLOR COL_POSITIVE INTENSIFIED ON.

  WRITE: / 'Open SQL report completed successfully.'.

  FORMAT RESET.

ENDFORM.
