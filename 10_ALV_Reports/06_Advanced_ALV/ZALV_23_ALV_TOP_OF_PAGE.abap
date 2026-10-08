REPORT ZALV_23_ALV_TOP_OF_PAGE.

*---------------------------------------------------------------------*
* Program    : ZALV_23_ALV_TOP_OF_PAGE
* Title      : ALV Top of Page
* Purpose    : Demonstrates a Custom ALV Report Header
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This report displays flight data in a Classic ALV Grid.
* A custom header provides report information above the ALV output.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Classic ALV Grid
* 2. TOP_OF_PAGE Callback
* 3. SLIS_T_LISTHEADER
* 4. REUSE_ALV_COMMENTARY_WRITE
* 5. Dynamic Report Header
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Register a TOP_OF_PAGE callback.
* - Display report title and selection criteria.
* - Include dynamic information in the report header.
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
  gt_flight   TYPE STANDARD TABLE OF ty_flight,
  gt_fieldcat TYPE slis_t_fieldcat_alv,
  gs_fieldcat TYPE slis_fieldcat_alv,
  gt_header   TYPE slis_t_listheader,
  gs_header   TYPE slis_listheader.

DATA:
  gv_record_count TYPE i.

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

  DESCRIBE TABLE gt_flight LINES gv_record_count.

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

  "Airline
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'CARRID'.
  gs_fieldcat-seltext_m = 'Airline'.
  gs_fieldcat-col_pos   = 1.
  gs_fieldcat-outputlen = 10.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Connection Number
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'CONNID'.
  gs_fieldcat-seltext_m = 'Connection'.
  gs_fieldcat-col_pos   = 2.
  gs_fieldcat-outputlen = 12.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Flight Date
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'FLDATE'.
  gs_fieldcat-seltext_m = 'Flight Date'.
  gs_fieldcat-col_pos   = 3.
  gs_fieldcat-outputlen = 12.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Ticket Price
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'PRICE'.
  gs_fieldcat-seltext_m = 'Price'.
  gs_fieldcat-col_pos   = 4.
  gs_fieldcat-outputlen = 12.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Currency
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'CURRENCY'.
  gs_fieldcat-seltext_m = 'Currency'.
  gs_fieldcat-col_pos   = 5.
  gs_fieldcat-outputlen = 10.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Aircraft Type
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'PLANETYPE'.
  gs_fieldcat-seltext_m = 'Plane Type'.
  gs_fieldcat-col_pos   = 6.
  gs_fieldcat-outputlen = 12.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Maximum Seats
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'SEATSMAX'.
  gs_fieldcat-seltext_m = 'Maximum Seats'.
  gs_fieldcat-col_pos   = 7.
  gs_fieldcat-outputlen = 12.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Occupied Seats
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'SEATSOCC'.
  gs_fieldcat-seltext_m = 'Occupied Seats'.
  gs_fieldcat-col_pos   = 8.
  gs_fieldcat-outputlen = 12.
  APPEND gs_fieldcat TO gt_fieldcat.

ENDFORM.

************************************************************************
* Form DISPLAY_ALV
************************************************************************

FORM display_alv.

  DATA:
    lv_title TYPE lvc_title.

  lv_title = 'Flight Report'.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program      = sy-repid
      i_callback_top_of_page  = 'TOP_OF_PAGE'
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
* Form TOP_OF_PAGE
************************************************************************

FORM top_of_page.

  DATA:
    lv_carrid TYPE char30,
    lv_fldate TYPE char20,
    lv_count  TYPE char20.

  CLEAR gt_header.

  "Report Title
  CLEAR gs_header.
  gs_header-typ  = 'H'.
  gs_header-info = 'Flight Information Report'.
  APPEND gs_header TO gt_header.

  "Report Date
  CLEAR gs_header.
  gs_header-typ  = 'S'.
  gs_header-key  = 'Report Date:'.
  gs_header-info = sy-datum.
  APPEND gs_header TO gt_header.

  "Airline Selection
  IF p_carrid IS INITIAL.
    lv_carrid = 'All Airlines'.
  ELSE.
    lv_carrid = p_carrid.
  ENDIF.

  CLEAR gs_header.
  gs_header-typ  = 'S'.
  gs_header-key  = 'Airline:'.
  gs_header-info = lv_carrid.
  APPEND gs_header TO gt_header.

  "Flight Date Selection
  WRITE p_fldate TO lv_fldate.

  CLEAR gs_header.
  gs_header-typ  = 'S'.
  gs_header-key  = 'Flight Date:'.
  gs_header-info = lv_fldate.
  APPEND gs_header TO gt_header.

  "Record Count
  WRITE gv_record_count TO lv_count LEFT-JUSTIFIED.

  CLEAR gs_header.
  gs_header-typ  = 'S'.
  gs_header-key  = 'Records:'.
  gs_header-info = lv_count.
  APPEND gs_header TO gt_header.

  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
    EXPORTING
      it_list_commentary = gt_header.

ENDFORM.
