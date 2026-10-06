REPORT ZALV_13_ALV_USER_COMMAND.

*---------------------------------------------------------------------*
* Program    : ZALV_13_ALV_USER_COMMAND
* Title      : ALV User Command
* Purpose    : Demonstrates USER_COMMAND handling in classic ALV
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This report demonstrates how user commands can be handled in a
* classic ALV Grid using the USER_COMMAND callback routine.
*
* The selected ALV row can be identified through SLIS_SELFIELD.
* Custom commands can also be handled inside USER_COMMAND.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. USER_COMMAND
* 2. SLIS_SELFIELD
* 3. Selected Row
* 4. Custom Function Code
* 5. ALV Refresh
* 6. Callback Processing
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand the USER_COMMAND event.
* - Read the selected ALV row.
* - Process custom function codes.
* - Refresh the ALV after an operation.
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
    carrid    TYPE sflight-carrid,
    connid    TYPE sflight-connid,
    fldate    TYPE sflight-fldate,
    price     TYPE sflight-price,
    currency  TYPE sflight-currency,
    planetype  TYPE sflight-planetype,
    seatsmax  TYPE sflight-seatsmax,
    seatsocc  TYPE sflight-seatsocc,
  END OF ty_flight.

************************************************************************
* Data
************************************************************************

DATA:
  gt_flight TYPE STANDARD TABLE OF ty_flight,
  gs_flight TYPE ty_flight,

  gt_fieldcat TYPE slis_t_fieldcat_alv,
  gs_fieldcat TYPE slis_fieldcat_alv,

  gs_layout TYPE slis_layout_alv.

************************************************************************
* Constants
************************************************************************

CONSTANTS:
  gc_command_info TYPE sy-ucomm VALUE 'INFO',
  gc_command_refresh TYPE sy-ucomm VALUE 'REFRESH'.

************************************************************************
* Start of Selection
************************************************************************

START-OF-SELECTION.

  PERFORM get_flight_data.

  IF gt_flight IS INITIAL.
    MESSAGE 'No flight data found.' TYPE 'I'.
    RETURN.
  ENDIF.

  PERFORM build_field_catalog.
  PERFORM build_layout.
  PERFORM display_alv.

************************************************************************
* Form GET_FLIGHT_DATA
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
    UP TO 100 ROWS.

ENDFORM.

************************************************************************
* Form BUILD_FIELD_CATALOG
************************************************************************

FORM build_field_catalog.

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = 'CARRID'.
  gs_fieldcat-seltext_m = 'Airline'.
  gs_fieldcat-col_pos   = 1.
  gs_fieldcat-outputlen = 10.
  APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = 'CONNID'.
  gs_fieldcat-seltext_m = 'Connection'.
  gs_fieldcat-col_pos   = 2.
  gs_fieldcat-outputlen = 12.
  APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = 'FLDATE'.
  gs_fieldcat-seltext_m = 'Flight Date'.
  gs_fieldcat-col_pos   = 3.
  gs_fieldcat-outputlen = 12.
  APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = 'PRICE'.
  gs_fieldcat-seltext_m = 'Price'.
  gs_fieldcat-col_pos   = 4.
  gs_fieldcat-outputlen = 14.
  gs_fieldcat-just      = 'R'.
  APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = 'CURRENCY'.
  gs_fieldcat-seltext_m = 'Currency'.
  gs_fieldcat-col_pos   = 5.
  gs_fieldcat-outputlen = 10.
  APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = 'PLANETYPE'.
  gs_fieldcat-seltext_m = 'Plane Type'.
  gs_fieldcat-col_pos   = 6.
  gs_fieldcat-outputlen = 12.
  APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = 'SEATSMAX'.
  gs_fieldcat-seltext_m = 'Max Seats'.
  gs_fieldcat-col_pos   = 7.
  gs_fieldcat-outputlen = 12.
  gs_fieldcat-just      = 'R'.
  APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = 'SEATSOCC'.
  gs_fieldcat-seltext_m = 'Occupied Seats'.
  gs_fieldcat-col_pos   = 8.
  gs_fieldcat-outputlen = 14.
  gs_fieldcat-just      = 'R'.
  APPEND gs_fieldcat TO gt_fieldcat.

ENDFORM.

************************************************************************
* Form BUILD_LAYOUT
************************************************************************

FORM build_layout.

  CLEAR gs_layout.

  gs_layout-zebra             = 'X'.
  gs_layout-colwidth_optimize = 'X'.

ENDFORM.

************************************************************************
* Form DISPLAY_ALV
************************************************************************

FORM display_alv.

  DATA:
    lv_title TYPE lvc_title.

  lv_title = 'Flight Report - USER_COMMAND'.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program       = sy-repid
      i_callback_pf_status_set = 'PF_STATUS_SET'
      i_callback_user_command  = 'USER_COMMAND'
      i_grid_title             = lv_title
      is_layout                = gs_layout
      i_save                   = 'A'
      it_fieldcat              = gt_fieldcat
    TABLES
      t_outtab                 = gt_flight
    EXCEPTIONS
      program_error            = 1
      OTHERS                   = 2.

  IF sy-subrc <> 0.
    MESSAGE 'ALV display error occurred.' TYPE 'E'.
  ENDIF.

ENDFORM.

************************************************************************
* Form PF_STATUS_SET
************************************************************************

FORM pf_status_set USING pt_extab TYPE slis_t_extab.

  SET PF-STATUS 'STANDARD_FULLSCREEN'.

ENDFORM.

************************************************************************
* Form USER_COMMAND
************************************************************************

FORM user_command USING pv_ucomm    TYPE sy-ucomm
                        ps_selfield TYPE slis_selfield.

  CASE pv_ucomm.

    WHEN gc_command_info.

      PERFORM display_selected_row
        USING ps_selfield-tabindex.

    WHEN gc_command_refresh.

      PERFORM get_flight_data.

      ps_selfield-refresh = 'X'.

    WHEN 'BACK'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

    WHEN 'CANCEL'.

      LEAVE TO SCREEN 0.

  ENDCASE.

ENDFORM.

************************************************************************
* Form DISPLAY_SELECTED_ROW
************************************************************************

FORM display_selected_row USING pv_tabindex TYPE sy-tabix.

  READ TABLE gt_flight INTO gs_flight
    INDEX pv_tabindex.

  IF sy-subrc <> 0.
    MESSAGE 'Please select a valid ALV row.' TYPE 'I'.
    RETURN.
  ENDIF.

  MESSAGE |Airline: { gs_flight-carrid } / Connection: { gs_flight-connid }|
    TYPE 'I'.

ENDFORM.
