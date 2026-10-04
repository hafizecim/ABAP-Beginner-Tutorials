REPORT ZALV_08_ALV_SORTING.

*---------------------------------------------------------------------*
* Program    : ZALV_08_ALV_SORTING
* Title      : ALV Sorting
* Purpose    : Demonstrates sorting in a classic ALV Grid
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This report demonstrates how to define one or more sorting rules
* for an ALV Grid using the ALV Sort Information structure.
*
* Sorting is configured independently from the database SELECT
* statement and is applied by the ALV display.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. SLIS_T_SORTINFO_ALV
* 2. SLIS_SORTINFO_ALV
* 3. Primary Sorting
* 4. Secondary Sorting
* 5. Ascending Sorting
* 6. Subtotal Configuration
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand ALV sorting configuration.
* - Define multiple sorting levels.
* - Control ascending and descending order.
* - Understand the relationship between sorting and subtotals.
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

  gt_sort TYPE slis_t_sortinfo_alv,
  gs_sort TYPE slis_sortinfo_alv,

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
  PERFORM build_sorting.
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
  gs_fieldcat-do_sum    = 'X'.
  gs_fieldcat-just      = 'R'.
  gs_fieldcat-outputlen = 14.
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
* Form BUILD_SORTING
************************************************************************

FORM build_sorting.

  "---------------------------------------------------------------*
  " Primary Sort: Airline
  "---------------------------------------------------------------*

  CLEAR gs_sort.

  gs_sort-fieldname = 'CARRID'.
  gs_sort-spos     = 1.
  gs_sort-up       = 'X'.

  APPEND gs_sort TO gt_sort.

  "---------------------------------------------------------------*
  " Secondary Sort: Flight Date
  "---------------------------------------------------------------*

  CLEAR gs_sort.

  gs_sort-fieldname = 'FLDATE'.
  gs_sort-spos     = 2.
  gs_sort-up       = 'X'.

  APPEND gs_sort TO gt_sort.

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

  lv_title = 'Flight Report - ALV Sorting'.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
      i_grid_title       = lv_title
      is_layout          = gs_layout
      i_save             = 'A'
      it_fieldcat        = gt_fieldcat
      it_sort             = gt_sort
    TABLES
      t_outtab           = gt_flight
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.

  IF sy-subrc <> 0.
    MESSAGE 'ALV display error occurred.' TYPE 'E'.
  ENDIF.

ENDFORM.
