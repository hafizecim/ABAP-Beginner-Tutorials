REPORT ZALV_03_REUSE_ALV_GRID.

*---------------------------------------------------------------------*
* Program    : ZALV_03_REUSE_ALV_GRID
* Title      : REUSE ALV Grid
* Purpose    : Demonstrates the basic REUSE_ALV_GRID_DISPLAY usage
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This report retrieves flight data from SFLIGHT and displays the
* result using the classic REUSE_ALV_GRID_DISPLAY function module.
*
* The report demonstrates basic ALV configuration through the
* function module parameters without introducing a custom field
* catalog yet.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. REUSE_ALV_GRID_DISPLAY
* 2. ALV Grid Configuration
* 3. ALV Header Information
* 4. Selection-Screen Parameters
* 5. Internal Tables
* 6. Modern Open SQL
* 7. ALV Display Parameters
* 8. Classical ALV Architecture
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand REUSE_ALV_GRID_DISPLAY in more detail.
* - Configure basic ALV display properties.
* - Use an internal table as the ALV output table.
* - Understand the relationship between report data and ALV.
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

  DATA:
    lv_title TYPE lvc_title.

  lv_title = 'Flight Report - REUSE ALV Grid'.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_grid_title             = lv_title
      i_structure_name        = 'SFLIGHT'
      i_default                = 'X'
      i_save                   = 'A'
      i_screen_start_column   = 5
      i_screen_start_line     = 3
      i_screen_end_column    = 150
      i_screen_end_line       = 30
    TABLES
      t_outtab                = gt_flight
    EXCEPTIONS
      program_error           = 1
      OTHERS                  = 2.

  IF sy-subrc <> 0.

    MESSAGE 'ALV Grid could not be displayed.' TYPE 'E'.

  ENDIF.

ENDFORM.
