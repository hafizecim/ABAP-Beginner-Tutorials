REPORT ZALV_34_ALV_SELECTION_SCREEN.

*---------------------------------------------------------------------*
* Program    : ZALV_34_ALV_SELECTION_SCREEN
* Title      : ALV Report with Advanced Selection Screen
* Purpose    : Demonstrate selection-screen design and validation
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* Retrieves flight data from SFLIGHT and displays the selected records
* using classic ALV Grid. The selection screen demonstrates blocks,
* radio buttons, checkboxes, and input validation.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Selection-Screen Blocks
* 2. Parameters and Select-Options
* 3. Radio Buttons and Checkboxes
* 4. Selection-Screen Validation
* 5. Classic ALV Grid Display
*---------------------------------------------------------------------*

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
    seatsmax TYPE sflight-seatsmax,
    seatsocc TYPE sflight-seatsocc,
  END OF ty_flight.

************************************************************************
* Data
************************************************************************
DATA:
  gt_flight   TYPE STANDARD TABLE OF ty_flight,
  gs_flight   TYPE ty_flight,
  gt_fieldcat TYPE slis_t_fieldcat_alv,
  gs_fieldcat TYPE slis_fieldcat_alv,
  gs_layout   TYPE slis_layout_alv.

************************************************************************
* Selection Screen
************************************************************************
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.

  SELECT-OPTIONS:
    s_carrid FOR gs_flight-carrid,
    s_connid FOR gs_flight-connid,
    s_fldate FOR gs_flight-fldate.

SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE text-002.

  PARAMETERS:
    p_curr TYPE sflight-currency,
    p_all  AS CHECKBOX DEFAULT 'X'.

  SELECTION-SCREEN SKIP 1.

  PARAMETERS:
    p_sort1 RADIOBUTTON GROUP r1 DEFAULT 'X',
    p_sort2 RADIOBUTTON GROUP r1.

SELECTION-SCREEN END OF BLOCK b2.

************************************************************************
* Selection-Screen Texts
************************************************************************
* Maintain the following text symbols in the program's text elements:
* TEXT-001: Flight Selection
* TEXT-002: Display Options
* TEXT-003: Flight Report

************************************************************************
* Selection-Screen Validation
************************************************************************
AT SELECTION-SCREEN.

  IF s_fldate[] IS NOT INITIAL.
    LOOP AT s_fldate ASSIGNING FIELD-SYMBOL(<ls_date>).
      IF <ls_date>-low IS NOT INITIAL
         AND <ls_date>-high IS NOT INITIAL
         AND <ls_date>-low > <ls_date>-high.
        MESSAGE 'The start date must not be later than the end date.'
          TYPE 'E'.
      ENDIF.
    ENDLOOP.
  ENDIF.

************************************************************************
* Main Processing
************************************************************************
START-OF-SELECTION.

  PERFORM get_flight_data.

  IF gt_flight IS INITIAL.
    MESSAGE 'No flight data found for the selection.'
      TYPE 'S' DISPLAY LIKE 'E'.
    RETURN.
  ENDIF.

  PERFORM build_field_catalog.
  PERFORM build_layout.
  PERFORM display_alv.

************************************************************************
* Form GET_FLIGHT_DATA
************************************************************************
FORM get_flight_data.

  IF p_all = 'X'.

    SELECT
      carrid,
      connid,
      fldate,
      price,
      currency,
      seatsmax,
      seatsocc
      FROM sflight
      WHERE carrid IN @s_carrid
        AND connid IN @s_connid
        AND fldate IN @s_fldate
        AND currency = @p_curr
      ORDER BY carrid, connid, fldate
      INTO TABLE @gt_flight.

  ELSE.

    SELECT
      carrid,
      connid,
      fldate,
      price,
      currency,
      seatsmax,
      seatsocc
      FROM sflight
      WHERE carrid IN @s_carrid
        AND connid IN @s_connid
        AND fldate IN @s_fldate
        AND currency = @p_curr
        AND seatsocc < seatsmax
      ORDER BY carrid, connid, fldate
      INTO TABLE @gt_flight.

  ENDIF.

  IF p_sort2 = 'X'.
    SORT gt_flight BY fldate carrid connid.
  ENDIF.

ENDFORM.

************************************************************************
* Form BUILD_FIELD_CATALOG
************************************************************************
FORM build_field_catalog.

  CLEAR gt_fieldcat.

  PERFORM add_fieldcat USING 'CARRID'   'Airline'          10 'X'.
  PERFORM add_fieldcat USING 'CONNID'   'Flight Number'    12 space.
  PERFORM add_fieldcat USING 'FLDATE'   'Flight Date'      12 space.
  PERFORM add_fieldcat USING 'PRICE'    'Price'            15 space.
  PERFORM add_fieldcat USING 'CURRENCY' 'Currency'          8 space.
  PERFORM add_fieldcat USING 'SEATSMAX' 'Total Seats'      12 space.
  PERFORM add_fieldcat USING 'SEATSOCC' 'Occupied Seats'   14 space.

ENDFORM.

************************************************************************
* Form ADD_FIELDCAT
************************************************************************
FORM add_fieldcat
  USING
    iv_fieldname TYPE slis_fieldname
    iv_text      TYPE char30
    iv_outputlen TYPE i
    iv_key       TYPE char1.

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = iv_fieldname.
  gs_fieldcat-seltext_m = iv_text.
  gs_fieldcat-outputlen = iv_outputlen.
  gs_fieldcat-key       = iv_key.

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

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
      i_grid_title       = 'Flight Selection Report'
      is_layout          = gs_layout
      it_fieldcat        = gt_fieldcat
      i_save             = 'A'
    TABLES
      t_outtab           = gt_flight
    EXCEPTIONS
      program_error      = 1
      OTHERS              = 2.

  IF sy-subrc <> 0.
    MESSAGE 'Error displaying the flight ALV.'
      TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.

ENDFORM.
