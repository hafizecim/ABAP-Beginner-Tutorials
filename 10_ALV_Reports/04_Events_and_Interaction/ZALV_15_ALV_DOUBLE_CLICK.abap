REPORT ZALV_15_ALV_DOUBLE_CLICK.

*---------------------------------------------------------------------*
* Program    : ZALV_15_ALV_DOUBLE_CLICK
* Title      : ALV Double-Click Interaction
* Purpose    : Demonstrates Double-Click handling in Classic ALV
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This report demonstrates how to handle a double-click event in
* Classic ALV Grid using the USER_COMMAND callback.
*
* When the user double-clicks a flight row, the selected flight
* details are displayed.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Classic ALV Grid
* 2. Field Catalog
* 3. USER_COMMAND
* 4. Double-Click Event
* 5. &IC1 Function Code
* 6. SLIS_SELFIELD
* 7. Selected Row Handling
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand the ALV double-click event.
* - Handle the &IC1 function code.
* - Identify the selected row using TABINDEX.
* - Identify the selected field using FIELDNAME.
*---------------------------------------------------------------------*

************************************************************************
* Type Definitions
************************************************************************

TYPES:
  BEGIN OF ty_flight,
    carrid    TYPE sflight-carrid,
    connid    TYPE sflight-connid,
    fldate    TYPE sflight-fldate,
    price     TYPE sflight-price,
    currency  TYPE sflight-currency,
    planetype TYPE sflight-planetype,
    seatsmax  TYPE sflight-seatsmax,
    seatsocc  TYPE sflight-seatsocc,
  END OF ty_flight.

************************************************************************
* Data Declarations
************************************************************************

DATA:
  gt_flight TYPE STANDARD TABLE OF ty_flight,
  gs_flight TYPE ty_flight.

DATA:
  gt_fieldcat TYPE slis_t_fieldcat_alv,
  gs_fieldcat TYPE slis_fieldcat_alv.

************************************************************************
* Selection Screen
************************************************************************

PARAMETERS:
  p_carrid TYPE sflight-carrid,
  p_fldate TYPE sflight-fldate DEFAULT sy-datum.

************************************************************************
* Start of Selection
************************************************************************

START-OF-SELECTION.

  PERFORM get_flight_data.

  IF gt_flight IS INITIAL.
    MESSAGE 'No flight data found for the selection.' TYPE 'I'.
    RETURN.
  ENDIF.

  PERFORM build_field_catalog.
  PERFORM display_alv.

************************************************************************
* Form GET_FLIGHT_DATA
************************************************************************

FORM get_flight_data.

  SELECT FROM sflight
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
    INTO TABLE @gt_flight.

ENDFORM.

************************************************************************
* Form BUILD_FIELD_CATALOG
************************************************************************

FORM build_field_catalog.

  CLEAR gt_fieldcat.

  "Airline Carrier
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'CARRID'.
  gs_fieldcat-seltext_l = 'Airline Carrier'.
  gs_fieldcat-seltext_m = 'Carrier'.
  gs_fieldcat-seltext_s = 'Carrier'.
  gs_fieldcat-col_pos   = 1.
  gs_fieldcat-outputlen = 12.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Connection Number
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'CONNID'.
  gs_fieldcat-seltext_l = 'Connection Number'.
  gs_fieldcat-seltext_m = 'Connection'.
  gs_fieldcat-seltext_s = 'Conn.'.
  gs_fieldcat-col_pos   = 2.
  gs_fieldcat-outputlen = 12.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Flight Date
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'FLDATE'.
  gs_fieldcat-seltext_l = 'Flight Date'.
  gs_fieldcat-seltext_m = 'Flight Date'.
  gs_fieldcat-seltext_s = 'Date'.
  gs_fieldcat-col_pos   = 3.
  gs_fieldcat-outputlen = 12.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Price
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'PRICE'.
  gs_fieldcat-seltext_l = 'Ticket Price'.
  gs_fieldcat-seltext_m = 'Price'.
  gs_fieldcat-seltext_s = 'Price'.
  gs_fieldcat-col_pos   = 4.
  gs_fieldcat-outputlen = 12.
  gs_fieldcat-do_sum    = 'X'.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Currency
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'CURRENCY'.
  gs_fieldcat-seltext_l = 'Currency'.
  gs_fieldcat-seltext_m = 'Currency'.
  gs_fieldcat-seltext_s = 'Curr.'.
  gs_fieldcat-col_pos   = 5.
  gs_fieldcat-outputlen = 10.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Plane Type
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'PLANETYPE'.
  gs_fieldcat-seltext_l = 'Plane Type'.
  gs_fieldcat-seltext_m = 'Plane Type'.
  gs_fieldcat-seltext_s = 'Plane'.
  gs_fieldcat-col_pos   = 6.
  gs_fieldcat-outputlen = 12.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Maximum Seats
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'SEATSMAX'.
  gs_fieldcat-seltext_l = 'Maximum Seats'.
  gs_fieldcat-seltext_m = 'Max Seats'.
  gs_fieldcat-seltext_s = 'Max'.
  gs_fieldcat-col_pos   = 7.
  gs_fieldcat-outputlen = 12.
  gs_fieldcat-do_sum    = 'X'.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Occupied Seats
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'SEATSOCC'.
  gs_fieldcat-seltext_l = 'Occupied Seats'.
  gs_fieldcat-seltext_m = 'Occupied'.
  gs_fieldcat-seltext_s = 'Occ.'.
  gs_fieldcat-col_pos   = 8.
  gs_fieldcat-outputlen = 12.
  gs_fieldcat-do_sum    = 'X'.
  APPEND gs_fieldcat TO gt_fieldcat.

ENDFORM.

************************************************************************
* Form DISPLAY_ALV
************************************************************************

FORM display_alv.

  DATA:
    lv_title TYPE lvc_title.

  lv_title = 'Flight Report - Double-Click'.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program      = sy-repid
      i_callback_user_command = 'USER_COMMAND'
      i_grid_title            = lv_title
      i_save                  = 'A'
      it_fieldcat             = gt_fieldcat
    TABLES
      t_outtab                = gt_flight
    EXCEPTIONS
      program_error           = 1
      OTHERS                  = 2.

  IF sy-subrc <> 0.
    MESSAGE 'ALV could not be displayed.' TYPE 'E'.
  ENDIF.

ENDFORM.

************************************************************************
* Form USER_COMMAND
************************************************************************

FORM user_command USING pv_ucomm    TYPE sy-ucomm
                        ps_selfield TYPE slis_selfield.

  CASE pv_ucomm.

    WHEN '&IC1'.

      PERFORM handle_double_click
        USING ps_selfield-tabindex
              ps_selfield-fieldname.

    WHEN 'BACK'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

    WHEN 'CANCEL'.

      LEAVE TO SCREEN 0.

  ENDCASE.

ENDFORM.

************************************************************************
* Form HANDLE_DOUBLE_CLICK
************************************************************************

FORM handle_double_click
  USING
    pv_tabindex TYPE sy-tabix
    pv_fieldname TYPE slis_fieldname.

  READ TABLE gt_flight
    INTO gs_flight
    INDEX pv_tabindex.

  IF sy-subrc <> 0.
    MESSAGE 'Selected flight could not be found.' TYPE 'I'.
    RETURN.
  ENDIF.

  MESSAGE |Flight: { gs_flight-carrid } / { gs_flight-connid } / |
        && |Date: { gs_flight-fldate } / |
        && |Field: { pv_fieldname }|
    TYPE 'I'.

ENDFORM.
