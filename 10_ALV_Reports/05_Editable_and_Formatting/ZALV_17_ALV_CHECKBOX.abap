REPORT ZALV_17_ALV_CHECKBOX.

*---------------------------------------------------------------------*
* Program    : ZALV_17_ALV_CHECKBOX
* Title      : ALV Checkbox Handling
* Purpose    : Demonstrates Checkbox Display and Selection in ALV
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This report demonstrates how to display an interactive checkbox
* column in a Classic ALV Grid.
*
* Users can select flight records by checking the checkbox.
* The selected records can then be processed using a custom
* toolbar button.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Classic ALV Grid
* 2. Checkbox Field
* 3. Editable ALV Column
* 4. Field Catalog
* 5. USER_COMMAND
* 6. CHECK_CHANGED_DATA
* 7. Selected Row Processing
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand checkbox configuration in ALV.
* - Make a checkbox column editable.
* - Synchronize user changes with the internal table.
* - Process selected records.
*---------------------------------------------------------------------*

************************************************************************
* Type Definitions
************************************************************************

TYPES:
  BEGIN OF ty_flight,
    selected  TYPE char1,
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
  gc_process TYPE sy-ucomm VALUE 'PROCESS',
  gc_select  TYPE sy-ucomm VALUE 'SELECT'.

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
    INTO CORRESPONDING FIELDS OF TABLE @gt_flight.

ENDFORM.

************************************************************************
* Form BUILD_FIELD_CATALOG
************************************************************************

FORM build_field_catalog.

  CLEAR gt_fieldcat.

  "Selection Checkbox
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'SELECTED'.
  gs_fieldcat-seltext_l = 'Select'.
  gs_fieldcat-seltext_m = 'Select'.
  gs_fieldcat-seltext_s = 'Sel.'.
  gs_fieldcat-col_pos   = 1.
  gs_fieldcat-outputlen = 6.
  gs_fieldcat-checkbox  = 'X'.
  gs_fieldcat-edit      = 'X'.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Airline Carrier
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'CARRID'.
  gs_fieldcat-seltext_l = 'Airline Carrier'.
  gs_fieldcat-seltext_m = 'Carrier'.
  gs_fieldcat-seltext_s = 'Carrier'.
  gs_fieldcat-col_pos   = 2.
  gs_fieldcat-outputlen = 12.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Connection Number
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'CONNID'.
  gs_fieldcat-seltext_l = 'Connection Number'.
  gs_fieldcat-seltext_m = 'Connection'.
  gs_fieldcat-seltext_s = 'Conn.'.
  gs_fieldcat-col_pos   = 3.
  gs_fieldcat-outputlen = 12.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Flight Date
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'FLDATE'.
  gs_fieldcat-seltext_l = 'Flight Date'.
  gs_fieldcat-seltext_m = 'Flight Date'.
  gs_fieldcat-seltext_s = 'Date'.
  gs_fieldcat-col_pos   = 4.
  gs_fieldcat-outputlen = 12.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Price
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'PRICE'.
  gs_fieldcat-seltext_l = 'Ticket Price'.
  gs_fieldcat-seltext_m = 'Price'.
  gs_fieldcat-seltext_s = 'Price'.
  gs_fieldcat-col_pos   = 5.
  gs_fieldcat-outputlen = 12.
  gs_fieldcat-do_sum    = 'X'.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Currency
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'CURRENCY'.
  gs_fieldcat-seltext_l = 'Currency'.
  gs_fieldcat-seltext_m = 'Currency'.
  gs_fieldcat-seltext_s = 'Curr.'.
  gs_fieldcat-col_pos   = 6.
  gs_fieldcat-outputlen = 10.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Plane Type
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'PLANETYPE'.
  gs_fieldcat-seltext_l = 'Plane Type'.
  gs_fieldcat-seltext_m = 'Plane Type'.
  gs_fieldcat-seltext_s = 'Plane'.
  gs_fieldcat-col_pos   = 7.
  gs_fieldcat-outputlen = 12.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Maximum Seats
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'SEATSMAX'.
  gs_fieldcat-seltext_l = 'Maximum Seats'.
  gs_fieldcat-seltext_m = 'Max Seats'.
  gs_fieldcat-seltext_s = 'Max'.
  gs_fieldcat-col_pos   = 8.
  gs_fieldcat-outputlen = 12.
  gs_fieldcat-do_sum    = 'X'.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Occupied Seats
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'SEATSOCC'.
  gs_fieldcat-seltext_l = 'Occupied Seats'.
  gs_fieldcat-seltext_m = 'Occupied'.
  gs_fieldcat-seltext_s = 'Occ.'.
  gs_fieldcat-col_pos   = 9.
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

  lv_title = 'Flight Report - Checkbox Selection'.

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

  SET PF-STATUS 'ZALV_17'.

ENDFORM.

************************************************************************
* Form USER_COMMAND
************************************************************************

FORM user_command USING pv_ucomm    TYPE sy-ucomm
                        ps_selfield TYPE slis_selfield.

  CASE pv_ucomm.

    WHEN gc_select.

      PERFORM select_all_rows.

      ps_selfield-refresh = 'X'.

    WHEN gc_process.

      PERFORM synchronize_alv_data.
      PERFORM process_selected_rows.

    WHEN 'BACK'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

    WHEN 'CANCEL'.

      LEAVE TO SCREEN 0.

  ENDCASE.

ENDFORM.

************************************************************************
* Form SELECT_ALL_ROWS
************************************************************************

FORM select_all_rows.

  LOOP AT gt_flight ASSIGNING FIELD-SYMBOL(<ls_flight>).

    <ls_flight>-selected = 'X'.

  ENDLOOP.

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
* Form PROCESS_SELECTED_ROWS
************************************************************************

FORM process_selected_rows.

  DATA:
    lv_count TYPE i.

  CLEAR lv_count.

  LOOP AT gt_flight INTO gs_flight
    WHERE selected = 'X'.

    lv_count = lv_count + 1.

  ENDLOOP.

  IF lv_count = 0.

    MESSAGE 'No flight has been selected.' TYPE 'I'.
    RETURN.

  ENDIF.

  MESSAGE |{ lv_count } flight(s) selected for processing.| TYPE 'S'.

ENDFORM.
