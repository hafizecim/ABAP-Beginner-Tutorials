REPORT ZALV_19_ALV_CELL_COLOR.

*---------------------------------------------------------------------*
* Program    : ZALV_19_ALV_CELL_COLOR
* Title      : ALV Cell Color
* Purpose    : Demonstrates Cell-Level Coloring in Classic ALV
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This report demonstrates how to apply colors to individual ALV
* cells by using a cell color table.
*
* The PRICE and SEATSOCC fields are colored according to their values.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Classic ALV Grid
* 2. Cell-Level Coloring
* 3. LVC_T_SCOL
* 4. LVC_S_SCOL
* 5. Color Components
* 6. Dynamic Cell Formatting
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand cell-level ALV coloring.
* - Use LVC_T_SCOL for individual cell colors.
* - Apply colors dynamically according to business conditions.
*---------------------------------------------------------------------*

************************************************************************
* Type Definitions
************************************************************************

TYPES:
  BEGIN OF ty_flight,
    carrid     TYPE sflight-carrid,
    connid     TYPE sflight-connid,
    fldate     TYPE sflight-fldate,
    price      TYPE sflight-price,
    currency   TYPE sflight-currency,
    planetype  TYPE sflight-planetype,
    seatsmax   TYPE sflight-seatsmax,
    seatsocc   TYPE sflight-seatsocc,
    cell_color TYPE lvc_t_scol,
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
  gs_cell_color TYPE lvc_s_scol.

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

  PERFORM apply_cell_colors.
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
* Form APPLY_CELL_COLORS
************************************************************************

FORM apply_cell_colors.

  LOOP AT gt_flight ASSIGNING FIELD-SYMBOL(<ls_flight>).

    CLEAR <ls_flight>-cell_color.

    "---------------------------------------------------------------*
    " Price Cell
    "---------------------------------------------------------------*
    IF <ls_flight>-price >= 1000.

      CLEAR gs_cell_color.
      gs_cell_color-fname      = 'PRICE'.
      gs_cell_color-color-col  = 6.
      gs_cell_color-color-int  = 1.
      gs_cell_color-color-inv  = 0.
      APPEND gs_cell_color TO <ls_flight>-cell_color.

    ELSEIF <ls_flight>-price >= 500.

      CLEAR gs_cell_color.
      gs_cell_color-fname      = 'PRICE'.
      gs_cell_color-color-col  = 3.
      gs_cell_color-color-int  = 1.
      gs_cell_color-color-inv  = 0.
      APPEND gs_cell_color TO <ls_flight>-cell_color.

    ENDIF.

    "---------------------------------------------------------------*
    " Occupied Seats Cell
    "---------------------------------------------------------------*
    IF <ls_flight>-seatsocc >= <ls_flight>-seatsmax.

      CLEAR gs_cell_color.
      gs_cell_color-fname      = 'SEATSOCC'.
      gs_cell_color-color-col  = 6.
      gs_cell_color-color-int  = 1.
      gs_cell_color-color-inv  = 0.
      APPEND gs_cell_color TO <ls_flight>-cell_color.

    ELSEIF <ls_flight>-seatsocc >=
           ( <ls_flight>-seatsmax * 80 / 100 ).

      CLEAR gs_cell_color.
      gs_cell_color-fname      = 'SEATSOCC'.
      gs_cell_color-color-col  = 3.
      gs_cell_color-color-int  = 1.
      gs_cell_color-color-inv  = 0.
      APPEND gs_cell_color TO <ls_flight>-cell_color.

    ENDIF.

  ENDLOOP.

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
  gs_fieldcat.do_sum    = 'X'.
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
  gs_fieldcat.outputlen = 12.
  gs_fieldcat.do_sum    = 'X'.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Technical Color Field
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'CELL_COLOR'.
  gs_fieldcat-tech      = 'X'.
  APPEND gs_fieldcat TO gt_fieldcat.

ENDFORM.

************************************************************************
* Form DISPLAY_ALV
************************************************************************

FORM display_alv.

  DATA:
    lv_title TYPE lvc_title.

  lv_title = 'Flight Report - Cell Color'.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
      i_grid_title       = lv_title
      i_save             = 'A'
      it_fieldcat        = gt_fieldcat
      i_structure_name   = ''
    TABLES
      t_outtab           = gt_flight
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.

  IF sy-subrc <> 0.
    MESSAGE 'ALV could not be displayed.' TYPE 'E'.
  ENDIF.

ENDFORM.
