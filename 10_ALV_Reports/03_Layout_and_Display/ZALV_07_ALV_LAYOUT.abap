REPORT ZALV_07_ALV_LAYOUT.

*---------------------------------------------------------------------*
* Program    : ZALV_07_ALV_LAYOUT
* Title      : ALV Layout Configuration
* Purpose    : Demonstrates ALV Layout settings
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This report demonstrates how to configure the visual appearance
* of a classic ALV Grid using the ALV Layout structure.
*
* The following layout features are demonstrated:
*   - Zebra pattern
*   - Automatic column width optimization
*   - Grid lines
*   - Totals display
*   - Layout configuration
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. SLIS_LAYOUT_ALV
* 2. Zebra Pattern
* 3. Automatic Column Width
* 4. Grid Display
* 5. Totals
* 6. ALV Visual Configuration
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand the purpose of the ALV Layout structure.
* - Learn how to configure the visual appearance of an ALV Grid.
* - Use zebra pattern for improved readability.
* - Optimize column widths automatically.
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
    UP TO 50 ROWS.

ENDFORM.

************************************************************************
* Form BUILD_FIELD_CATALOG
************************************************************************

FORM build_field_catalog.

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = 'CARRID'.
  gs_fieldcat-seltext_m = 'Airline'.
  gs_fieldcat-col_pos   = 1.
  APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = 'CONNID'.
  gs_fieldcat-seltext_m = 'Connection'.
  gs_fieldcat-col_pos   = 2.
  APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = 'FLDATE'.
  gs_fieldcat-seltext_m = 'Flight Date'.
  gs_fieldcat-col_pos   = 3.
  APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = 'PRICE'.
  gs_fieldcat-seltext_m = 'Price'.
  gs_fieldcat-col_pos   = 4.
  gs_fieldcat-do_sum    = 'X'.
  gs_fieldcat-just      = 'R'.
  APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = 'CURRENCY'.
  gs_fieldcat-seltext_m = 'Currency'.
  gs_fieldcat-col_pos   = 5.
  APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = 'PLANETYPE'.
  gs_fieldcat-seltext_m = 'Plane Type'.
  gs_fieldcat-col_pos   = 6.
  APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = 'SEATSMAX'.
  gs_fieldcat-seltext_m = 'Max Seats'.
  gs_fieldcat-col_pos   = 7.
  APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = 'SEATSOCC'.
  gs_fieldcat-seltext_m = 'Occupied'.
  gs_fieldcat-col_pos   = 8.
  APPEND gs_fieldcat TO gt_fieldcat.

ENDFORM.

************************************************************************
* Form BUILD_LAYOUT
************************************************************************

FORM build_layout.

  CLEAR gs_layout.

  " Display alternating row colors
  gs_layout-zebra = 'X'.

  " Optimize column width automatically
  gs_layout-colwidth_optimize = 'X'.

  " Display totals at the bottom
  gs_layout-totals_text = 'Total'.

  " Enable grid display
  gs_layout-grid_title = 'Flight Information'.

ENDFORM.

************************************************************************
* Form DISPLAY_ALV
************************************************************************

FORM display_alv.

  DATA:
    lv_title TYPE lvc_title.

  lv_title = 'Flight Report - ALV Layout'.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
      i_grid_title       = lv_title
      is_layout          = gs_layout
      i_save             = 'A'
      it_fieldcat        = gt_fieldcat
    TABLES
      t_outtab           = gt_flight
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.

  IF sy-subrc <> 0.
    MESSAGE 'ALV display error occurred.' TYPE 'E'.
  ENDIF.

ENDFORM.
