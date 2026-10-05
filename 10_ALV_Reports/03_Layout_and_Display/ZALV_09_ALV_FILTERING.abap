REPORT ZALV_09_ALV_FILTERING.

*---------------------------------------------------------------------*
* Program    : ZALV_09_ALV_FILTERING
* Title      : ALV Filtering
* Purpose    : Demonstrates filtering in a classic ALV Grid
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This report demonstrates how to define initial filter criteria
* for a classic ALV Grid using the ALV Filter Information structure.
*
* The filters are passed to the ALV through IT_FILTER.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. SLIS_T_FILTER_ALV
* 2. SLIS_FILTER_ALV
* 3. Initial ALV Filters
* 4. Multiple Filter Conditions
* 5. Field Catalog
* 6. ALV Layout
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand the ALV filter structure.
* - Define initial filter criteria.
* - Apply filters to specific ALV columns.
* - Display only records matching predefined criteria.
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

  gt_fieldcat TYPE slis_t_fieldcat_alv,
  gs_fieldcat TYPE slis_fieldcat_alv,

  gt_filter TYPE slis_t_filter_alv,
  gs_filter TYPE slis_filter_alv,

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
  PERFORM build_filter.
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
  gs_fieldcat-do_sum    = 'X'.
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
  APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = 'SEATSOCC'.
  gs_fieldcat-seltext_m = 'Occupied Seats'.
  gs_fieldcat-col_pos   = 8.
  gs_fieldcat-outputlen = 14.
  APPEND gs_fieldcat TO gt_fieldcat.

ENDFORM.

************************************************************************
* Form BUILD_FILTER
************************************************************************

FORM build_filter.

  "---------------------------------------------------------------*
  " Filter by Airline
  "---------------------------------------------------------------*

  IF p_carrid IS NOT INITIAL.

    CLEAR gs_filter.

    gs_filter-fieldname = 'CARRID'.
    gs_filter-tabname   = 'GT_FLIGHT'.
    gs_filter-sign      = 'I'.
    gs_filter-option    = 'EQ'.
    gs_filter-low       = p_carrid.

    APPEND gs_filter TO gt_filter.

  ENDIF.

  "---------------------------------------------------------------*
  " Filter by Flight Date
  "---------------------------------------------------------------*

  IF p_fldate IS NOT INITIAL.

    CLEAR gs_filter.

    gs_filter-fieldname = 'FLDATE'.
    gs_filter-tabname   = 'GT_FLIGHT'.
    gs_filter-sign      = 'I'.
    gs_filter-option    = 'EQ'.
    gs_filter-low       = p_fldate.

    APPEND gs_filter TO gt_filter.

  ENDIF.

ENDFORM.

************************************************************************
* Form BUILD_LAYOUT
************************************************************************

FORM build_layout.

  CLEAR gs_layout.

  gs_layout-zebra = 'X'.
  gs_layout-colwidth_optimize = 'X'.
  gs_layout-totals_text = 'Total'.

ENDFORM.

************************************************************************
* Form DISPLAY_ALV
************************************************************************

FORM display_alv.

  DATA:
    lv_title TYPE lvc_title.

  lv_title = 'Flight Report - ALV Filtering'.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
      i_grid_title       = lv_title
      is_layout          = gs_layout
      i_save             = 'A'
      it_fieldcat        = gt_fieldcat
      it_filter          = gt_filter
    TABLES
      t_outtab           = gt_flight
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.

  IF sy-subrc <> 0.
    MESSAGE 'ALV display error occurred.' TYPE 'E'.
  ENDIF.

ENDFORM.
