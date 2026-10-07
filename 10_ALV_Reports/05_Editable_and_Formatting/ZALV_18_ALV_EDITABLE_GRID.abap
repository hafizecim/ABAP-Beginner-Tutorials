REPORT ZALV_18_ALV_EDITABLE_GRID.

*---------------------------------------------------------------------*
* Program    : ZALV_18_ALV_EDITABLE_GRID
* Title      : Editable ALV Grid
* Purpose    : Demonstrates editable cells in Classic ALV
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This report demonstrates how to create an editable Classic ALV Grid.
*
* Users can change selected flight values directly in the ALV.
* The changed data is synchronized with the internal table by using
* CHECK_CHANGED_DATA.
*
* This example does not update the database. The SAVE action only
* demonstrates how changed records can be processed safely.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Classic ALV Grid
* 2. Editable Field Catalog
* 3. CHECK_CHANGED_DATA
* 4. USER_COMMAND
* 5. Changed Data Processing
* 6. Custom Toolbar Button
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Make selected ALV columns editable.
* - Synchronize ALV changes with an internal table.
* - Process changed records.
* - Understand the basic architecture of an editable ALV.
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

DATA:
  go_grid TYPE REF TO cl_gui_alv_grid.

************************************************************************
* Constants
************************************************************************

CONSTANTS:
  gc_save TYPE sy-ucomm VALUE 'SAVE'.

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

  "Airline Carrier - Read Only
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'CARRID'.
  gs_fieldcat-seltext_l = 'Airline Carrier'.
  gs_fieldcat-seltext_m = 'Carrier'.
  gs_fieldcat-seltext_s = 'Carrier'.
  gs_fieldcat-col_pos   = 1.
  gs_fieldcat-outputlen = 12.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Connection Number - Read Only
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'CONNID'.
  gs_fieldcat-seltext_l = 'Connection Number'.
  gs_fieldcat-seltext_m = 'Connection'.
  gs_fieldcat-seltext_s = 'Conn.'.
  gs_fieldcat-col_pos   = 2.
  gs_fieldcat-outputlen = 12.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Flight Date - Read Only
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'FLDATE'.
  gs_fieldcat-seltext_l = 'Flight Date'.
  gs_fieldcat-seltext_m = 'Flight Date'.
  gs_fieldcat-seltext_s = 'Date'.
  gs_fieldcat-col_pos   = 3.
  gs_fieldcat-outputlen = 12.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Price - Editable
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'PRICE'.
  gs_fieldcat-seltext_l = 'Ticket Price'.
  gs_fieldcat-seltext_m = 'Price'.
  gs_fieldcat-seltext_s = 'Price'.
  gs_fieldcat-col_pos   = 4.
  gs_fieldcat-outputlen = 12.
  gs_fieldcat-edit      = 'X'.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Currency - Read Only
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'CURRENCY'.
  gs_fieldcat-seltext_l = 'Currency'.
  gs_fieldcat-seltext_m = 'Currency'.
  gs_fieldcat-seltext_s = 'Curr.'.
  gs_fieldcat-col_pos   = 5.
  gs_fieldcat-outputlen = 10.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Plane Type - Editable
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'PLANETYPE'.
  gs_fieldcat-seltext_l = 'Plane Type'.
  gs_fieldcat-seltext_m = 'Plane Type'.
  gs_fieldcat-seltext_s = 'Plane'.
  gs_fieldcat-col_pos   = 6.
  gs_fieldcat-outputlen = 12.
  gs_fieldcat-edit      = 'X'.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Maximum Seats - Editable
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'SEATSMAX'.
  gs_fieldcat-seltext_l = 'Maximum Seats'.
  gs_fieldcat-seltext_m = 'Max Seats'.
  gs_fieldcat-seltext_s = 'Max'.
  gs_fieldcat-col_pos   = 7.
  gs_fieldcat-outputlen = 12.
  gs_fieldcat-edit      = 'X'.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Occupied Seats - Editable
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'SEATSOCC'.
  gs_fieldcat-seltext_l = 'Occupied Seats'.
  gs_fieldcat-seltext_m = 'Occupied'.
  gs_fieldcat-seltext_s = 'Occ.'.
  gs_fieldcat-col_pos   = 8.
  gs_fieldcat-outputlen = 12.
  gs_fieldcat-edit      = 'X'.
  APPEND gs_fieldcat TO gt_fieldcat.

ENDFORM.

************************************************************************
* Form DISPLAY_ALV
************************************************************************

FORM display_alv.

  DATA:
    lv_title TYPE lvc_title.

  lv_title = 'Flight Report - Editable ALV'.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program       = sy-repid
      i_callback_pf_status_set = 'PF_STATUS_SET'
      i_callback_user_command  = 'USER_COMMAND'
      i_grid_title             = lv_title
      i_save                   = 'A'
      it_fieldcat              = gt_fieldcat
    TABLES
      t_outtab                 = gt_flight
    EXCEPTIONS
      program_error            = 1
      OTHERS                   = 2.

  IF sy-subrc <> 0.
    MESSAGE 'ALV could not be displayed.' TYPE 'E'.
  ENDIF.

ENDFORM.

************************************************************************
* Form PF_STATUS_SET
************************************************************************

FORM pf_status_set USING pt_extab TYPE slis_t_extab.

  SET PF-STATUS 'ZALV_18'.

ENDFORM.

************************************************************************
* Form USER_COMMAND
************************************************************************

FORM user_command USING pv_ucomm    TYPE sy-ucomm
                        ps_selfield TYPE slis_selfield.

  CASE pv_ucomm.

    WHEN gc_save.

      PERFORM synchronize_alv_data.
      PERFORM save_changed_data.

    WHEN 'BACK'.

      PERFORM synchronize_alv_data.
      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      PERFORM synchronize_alv_data.
      LEAVE PROGRAM.

    WHEN 'CANCEL'.

      LEAVE TO SCREEN 0.

  ENDCASE.

ENDFORM.

************************************************************************
* Form SYNCHRONIZE_ALV_DATA
************************************************************************

FORM synchronize_alv_data.

  IF go_grid IS INITIAL.

    CALL FUNCTION 'GET_GLOBALS_FROM_SLVC_FULLSCR'
      IMPORTING
        e_grid = go_grid.

  ENDIF.

  IF go_grid IS BOUND.

    go_grid->check_changed_data( ).

  ENDIF.

ENDFORM.

************************************************************************
* Form SAVE_CHANGED_DATA
************************************************************************

FORM save_changed_data.

  DATA:
    lv_count TYPE i.

  CLEAR lv_count.

  LOOP AT gt_flight INTO gs_flight.

    lv_count = lv_count + 1.

  ENDLOOP.

  IF lv_count = 0.
    MESSAGE 'There is no data to process.' TYPE 'I'.
    RETURN.
  ENDIF.

  MESSAGE |{ lv_count } flight record(s) are ready for processing.| TYPE 'S'.

ENDFORM.
