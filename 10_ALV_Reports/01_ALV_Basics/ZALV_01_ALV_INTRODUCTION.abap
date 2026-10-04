REPORT ZALV_01_ALV_INTRODUCTION.

*---------------------------------------------------------------------*
* Program    : ZALV_01_ALV_INTRODUCTION
* Title      : ALV Introduction
* Purpose    : Introduces the basic concept of ALV reporting
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This report demonstrates the basic ALV reporting concept using
* the classic REUSE_ALV_GRID_DISPLAY function module.
*
* Flight data is retrieved from SFLIGHT and displayed in an
* ALV Grid.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. ALV Introduction
* 2. SFLIGHT
* 3. Internal Tables
* 4. Local Types
* 5. Modern Open SQL
* 6. REUSE_ALV_GRID_DISPLAY
* 7. Basic ALV Display
* 8. Classical ALV Architecture
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand what ALV is.
* - Understand the basic ALV reporting flow.
* - Retrieve database data into an internal table.
* - Display internal table data using ALV Grid.
* - Understand the role of REUSE_ALV_GRID_DISPLAY.
*---------------------------------------------------------------------*

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

    MESSAGE 'No flight data found.' TYPE 'I'.

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
    INTO TABLE @gt_flight
    UP TO 50 ROWS.

ENDFORM.

************************************************************************
* Display ALV
************************************************************************

FORM display_alv.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_grid_title = 'Flight Report - ALV Introduction'
    TABLES
      t_outtab     = gt_flight
    EXCEPTIONS
      program_error = 1
      OTHERS        = 2.

  IF sy-subrc <> 0.

    MESSAGE 'ALV display failed.' TYPE 'E'.

  ENDIF.

ENDFORM.
