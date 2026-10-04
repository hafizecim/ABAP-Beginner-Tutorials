REPORT ZALV_04_ALV_FIELD_CATALOG.

*---------------------------------------------------------------------*
* Program    : ZALV_04_ALV_FIELD_CATALOG
* Title      : ALV Field Catalog
* Purpose    : Demonstrates Field Catalog configuration in ALV
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This report retrieves flight data from SFLIGHT and displays it
* using REUSE_ALV_GRID_DISPLAY.
*
* A custom Field Catalog is created to control column position,
* column heading, visibility and output length.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. ALV Field Catalog
* 2. SLIS_T_FIELDCAT_ALV
* 3. SLIS_FIELDCAT_ALV
* 4. Column Position
* 5. Column Heading
* 6. Column Visibility
* 7. Output Length
* 8. REUSE_ALV_GRID_DISPLAY
* 9. Internal Tables
* 10. Modern Open SQL
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand the purpose of an ALV Field Catalog.
* - Create a custom Field Catalog.
* - Control ALV column properties.
* - Change column headings and positions.
* - Hide technical fields from the ALV output.
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

DATA:
  gt_fieldcat TYPE slis_t_fieldcat_alv,
  gs_fieldcat TYPE slis_fieldcat_alv.

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

  PERFORM build_field_catalog.
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
* Build Field Catalog
************************************************************************

FORM build_field_catalog.

  CLEAR gt_fieldcat.

  "---------------------------------------------------------------*
  " Airline
  "---------------------------------------------------------------*

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = 'CARRID'.
  gs_fieldcat-seltext_m = 'Airline'.
  gs_fieldcat-col_pos   = 1.
  gs_fieldcat-outputlen = 8.

  APPEND gs_fieldcat TO gt_fieldcat.

  "---------------------------------------------------------------*
  " Flight Number
  "---------------------------------------------------------------*

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = 'CONNID'.
  gs_fieldcat-seltext_m = 'Flight'.
  gs_fieldcat-col_pos   = 2.
  gs_fieldcat-outputlen = 8.

  APPEND gs_fieldcat TO gt_fieldcat.

  "---------------------------------------------------------------*
  " Flight Date
  "---------------------------------------------------------------*

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = 'FLDATE'.
  gs_fieldcat-seltext_m = 'Flight Date'.
  gs_fieldcat-col_pos   = 3.
  gs_fieldcat-outputlen = 12.

  APPEND gs_fieldcat TO gt_fieldcat.

  "---------------------------------------------------------------*
  " Price
  "---------------------------------------------------------------*

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = 'PRICE'.
  gs_fieldcat-seltext_m = 'Price'.
  gs_fieldcat-col_pos   = 4.
  gs_fieldcat-outputlen = 12.
  gs_fieldcat-do_sum    = 'X'.

  APPEND gs_fieldcat TO gt_fieldcat.

  "---------------------------------------------------------------*
  " Currency
  "---------------------------------------------------------------*

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = 'CURRENCY'.
  gs_fieldcat-seltext_m = 'Currency'.
  gs_fieldcat-col_pos   = 5.
  gs_fieldcat-outputlen = 8.

  APPEND gs_fieldcat TO gt_fieldcat.

  "---------------------------------------------------------------*
  " Aircraft Type
  "---------------------------------------------------------------*

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = 'PLANETYPE'.
  gs_fieldcat-seltext_m = 'Aircraft'.
  gs_fieldcat-col_pos   = 6.
  gs_fieldcat-outputlen = 15.

  APPEND gs_fieldcat TO gt_fieldcat.

  "---------------------------------------------------------------*
  " Maximum Seats
  "---------------------------------------------------------------*

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = 'SEATSMAX'.
  gs_fieldcat-seltext_m = 'Capacity'.
  gs_fieldcat-col_pos   = 7.
  gs_fieldcat-outputlen = 10.

  APPEND gs_fieldcat TO gt_fieldcat.

  "---------------------------------------------------------------*
  " Occupied Seats
  "---------------------------------------------------------------*

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = 'SEATSOCC'.
  gs_fieldcat-seltext_m = 'Occupied'.
  gs_fieldcat-col_pos   = 8.
  gs_fieldcat-outputlen = 10.

  APPEND gs_fieldcat TO gt_fieldcat.

ENDFORM.

************************************************************************
* Display ALV
************************************************************************

FORM display_alv.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_grid_title             = 'Flight Report - Field Catalog'
      i_callback_program       = sy-repid
      i_save                   = 'A'
      it_fieldcat              = gt_fieldcat
    TABLES
      t_outtab                 = gt_flight
    EXCEPTIONS
      program_error            = 1
      OTHERS                   = 2.

  IF sy-subrc <> 0.

    MESSAGE 'ALV display failed.' TYPE 'E'.

  ENDIF.

ENDFORM.
