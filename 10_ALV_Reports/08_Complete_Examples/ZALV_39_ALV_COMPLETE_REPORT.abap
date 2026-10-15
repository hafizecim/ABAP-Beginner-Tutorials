REPORT ZALV_39_ALV_COMPLETE_REPORT.

*---------------------------------------------------------------------*
* Program    : ZALV_39_ALV_COMPLETE_REPORT
* Title      : Complete Classic ALV Report
* Purpose    : Demonstrate an end-to-end classic ALV report
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* Retrieves flight data based on selection criteria and displays it
* using classic ALV Grid. Includes sorting, totals, hotspot handling,
* layout configuration, and ALV variant support.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Selection Screen
* 2. Modern Open SQL
* 3. Manual Field Catalog
* 4. Sorting and Totals
* 5. ALV Layout
* 6. Hotspot and User Command
* 7. Display Variants
*---------------------------------------------------------------------*

TYPE-POOLS: slis.

************************************************************************
* Types
************************************************************************
TYPES:
  BEGIN OF ty_flight,
    carrid   TYPE sflight-carrid,
    connid   TYPE sflight-connid,
    fldate   TYPE sflight-fldate,
    price    TYPE sflight-price,
    currency TYPE sflight-currency,
    planetype TYPE sflight-planetype,
    seatsmax TYPE sflight-seatsmax,
    seatsocc TYPE sflight-seatsocc,
  END OF ty_flight.

************************************************************************
* Data
************************************************************************
DATA:
  gt_flights  TYPE STANDARD TABLE OF ty_flight,
  gs_flight   TYPE ty_flight,
  gt_fieldcat TYPE slis_t_fieldcat_alv,
  gs_fieldcat TYPE slis_fieldcat_alv,
  gt_sort     TYPE slis_t_sortinfo_alv,
  gs_sort     TYPE slis_sortinfo_alv,
  gs_layout   TYPE slis_layout_alv,
  gs_variant  TYPE disvariant.

************************************************************************
* Selection Screen
************************************************************************
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.

  SELECT-OPTIONS:
    s_carrid FOR gs_flight-carrid,
    s_connid FOR gs_flight-connid,
    s_fldate FOR gs_flight-fldate.

  PARAMETERS:
    p_max TYPE i DEFAULT 500 OBLIGATORY.

SELECTION-SCREEN END OF BLOCK b1.

************************************************************************
* Main Processing
************************************************************************
START-OF-SELECTION.

  PERFORM validate_selection.
  PERFORM get_flight_data.

  IF gt_flights IS INITIAL.
    MESSAGE 'No flight data found for the selection.'
      TYPE 'S' DISPLAY LIKE 'E'.
    RETURN.
  ENDIF.

  PERFORM build_field_catalog.
  PERFORM build_sort.
  PERFORM build_layout.
  PERFORM display_alv.

************************************************************************
* Form VALIDATE_SELECTION
************************************************************************
FORM validate_selection.

  IF p_max <= 0.
    MESSAGE 'Maximum number of rows must be greater than zero.'
      TYPE 'E'.
  ENDIF.

ENDFORM.

************************************************************************
* Form GET_FLIGHT_DATA
************************************************************************
FORM get_flight_data.

  SELECT carrid,
         connid,
         fldate,
         price,
         currency,
         planetype,
         seatsmax,
         seatsocc
    FROM sflight
    WHERE carrid IN @s_carrid
      AND connid IN @s_connid
      AND fldate IN @s_fldate
    ORDER BY carrid, connid, fldate
    INTO TABLE @gt_flights
    UP TO @p_max ROWS.

ENDFORM.

************************************************************************
* Form BUILD_FIELD_CATALOG
************************************************************************
FORM build_field_catalog.

  CLEAR gt_fieldcat.

  PERFORM add_field USING:
    'CARRID'    'Airline'          8  space,
    'CONNID'    'Connection'      10  space,
    'FLDATE'    'Flight Date'     12  space,
    'PRICE'     'Price'           15  space,
    'CURRENCY'  'Currency'         8  space,
    'PLANETYPE' 'Aircraft Type'   15  space,
    'SEATSMAX'  'Maximum Seats'   12  'X',
    'SEATSOCC'  'Occupied Seats'  12  'X'.

  LOOP AT gt_fieldcat INTO gs_fieldcat.
    IF gs_fieldcat-fieldname = 'CARRID'.
      gs_fieldcat-hotspot = 'X'.
      MODIFY gt_fieldcat FROM gs_fieldcat INDEX sy-tabix.
    ENDIF.
  ENDLOOP.

ENDFORM.

************************************************************************
* Form ADD_FIELD
************************************************************************
FORM add_field USING
  p_fieldname TYPE slis_fieldname
  p_text      TYPE char40
  p_outputlen TYPE i
  p_do_sum    TYPE char1.

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = p_fieldname.
  gs_fieldcat-seltext_s = p_text.
  gs_fieldcat-seltext_m = p_text.
  gs_fieldcat-seltext_l = p_text.
  gs_fieldcat-outputlen = p_outputlen.
  gs_fieldcat-do_sum    = p_do_sum.

  APPEND gs_fieldcat TO gt_fieldcat.

ENDFORM.

************************************************************************
* Form BUILD_SORT
************************************************************************
FORM build_sort.

  CLEAR gt_sort.

  CLEAR gs_sort.
  gs_sort-spos      = 1.
  gs_sort-fieldname = 'CARRID'.
  gs_sort-up        = 'X'.
  APPEND gs_sort TO gt_sort.

  CLEAR gs_sort.
  gs_sort-spos      = 2.
  gs_sort-fieldname = 'CONNID'.
  gs_sort-up        = 'X'.
  APPEND gs_sort TO gt_sort.

  CLEAR gs_sort.
  gs_sort-spos      = 3.
  gs_sort-fieldname = 'FLDATE'.
  gs_sort-up        = 'X'.
  APPEND gs_sort TO gt_sort.

ENDFORM.

************************************************************************
* Form BUILD_LAYOUT
************************************************************************
FORM build_layout.

  CLEAR gs_layout.

  gs_layout-zebra             = 'X'.
  gs_layout-colwidth_optimize = 'X'.
  gs_layout-totals_text       = 'Totals'.

ENDFORM.

************************************************************************
* Form DISPLAY_ALV
************************************************************************
FORM display_alv.

  CLEAR gs_variant.
  gs_variant-report = sy-repid.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program      = sy-repid
      i_callback_user_command = 'USER_COMMAND'
      i_grid_title            = 'Flight Overview'
      is_layout               = gs_layout
      it_fieldcat             = gt_fieldcat
      it_sort                 = gt_sort
      is_variant              = gs_variant
      i_save                  = 'A'
    TABLES
      t_outtab                = gt_flights
    EXCEPTIONS
      program_error           = 1
      OTHERS                  = 2.

  IF sy-subrc <> 0.
    MESSAGE 'Error displaying the ALV report.'
      TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.

ENDFORM.

************************************************************************
* Form USER_COMMAND
************************************************************************
FORM user_command USING
  p_ucomm     LIKE sy-ucomm
  ps_selfield TYPE slis_selfield.

  DATA:
    lv_carrid TYPE sflight-carrid,
    lv_count  TYPE i.

  CASE p_ucomm.

    WHEN '&IC1'.

      IF ps_selfield-fieldname = 'CARRID'.

        READ TABLE gt_flights INTO gs_flight
          INDEX ps_selfield-tabindex.

        IF sy-subrc = 0.

          lv_carrid = gs_flight-carrid.

          LOOP AT gt_flights INTO gs_flight
            WHERE carrid = lv_carrid.
            lv_count = lv_count + 1.
          ENDLOOP.

          MESSAGE |Airline { lv_carrid }: { lv_count } flight(s) in the current list.|
            TYPE 'S'.

        ENDIF.

      ENDIF.

  ENDCASE.

ENDFORM.
