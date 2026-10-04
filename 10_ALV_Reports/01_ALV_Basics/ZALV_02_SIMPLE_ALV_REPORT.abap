REPORT ZALV_02_SIMPLE_ALV_REPORT.

*---------------------------------------------------------------------*
* Program    : ZALV_02_SIMPLE_ALV_REPORT
* Title      : Simple ALV Report
* Purpose    : Demonstrates a basic ALV report with a selection screen
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This report retrieves flight data from SFLIGHT according to the
* selected airline and flight date.
*
* The retrieved data is displayed using the classic
* REUSE_ALV_GRID_DISPLAY function module.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Simple ALV Report
* 2. Selection-Screen Parameters
* 3. SFLIGHT
* 4. Internal Tables
* 5. Modern Open SQL
* 6. REUSE_ALV_GRID_DISPLAY
* 7. Basic ALV Grid
* 8. Selection-Based Reporting
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Create a simple ALV report with selection criteria.
* - Retrieve filtered data from a database table.
* - Display an internal table in an ALV Grid.
* - Understand the basic structure of an ALV report.
*---------------------------------------------------------------------*

************************************************************************
* Selection Screen
************************************************************************

PARAMETERS:
  p_carrid TYPE sflight-carrid,
  p_fldate TYPE sflight-fldate DEFAULT sy-datum.

************************************************************************
* Types
************************************************************************

TYPES:
  BEGIN OF ty_flight,
    carrid     TYPE sflight-carrid,
    connid     TYPE sflight-connid,
    fldate     TYPE sflight-fldate,
    price      TYPE sflight-price,
    currency   TYPE sflight-currency,
    planetype   TYPE sflight-planetype,
    seatsmax   TYPE sflight-seatsmax,
    seatsocc   TYPE sflight-seatsocc,
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

  PERFORM get_flight_data.

  IF gt_flight IS INITIAL.

    MESSAGE 'No flight data found for the selected criteria.'
      TYPE 'I'.

    RETURN.

  ENDIF.

  PERFORM display_alv.

************************************************************************
* Get Flight Data
************************************************************************

FORM get_flight_data.

  SELECT
    FROM sflight
    FIELDS
      carrid,
      connid,
      fldate,
      price,
      currency,
      planetype,
      seatsmax,
      seatsocc
    WHERE ( @p_carrid IS INITIAL OR carrid = @p_carrid )
      AND fldate = @p_fldate
    INTO TABLE @gt_flight
    ORDER BY
      carrid,
      connid.

ENDFORM.

************************************************************************
* Display ALV
************************************************************************

FORM display_alv.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_grid_title = 'Simple Flight ALV Report'
    TABLES
      t_outtab     = gt_flight
    EXCEPTIONS
      program_error = 1
      OTHERS        = 2.

  IF sy-subrc <> 0.

    MESSAGE 'ALV display failed.' TYPE 'E'.

  ENDIF.

ENDFORM.
