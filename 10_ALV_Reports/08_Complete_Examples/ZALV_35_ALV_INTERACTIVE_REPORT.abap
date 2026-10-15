REPORT ZALV_35_ALV_INTERACTIVE_REPORT.

*---------------------------------------------------------------------*
* Program    : ZALV_35_ALV_INTERACTIVE_REPORT
* Title      : Interactive Flight ALV Report
* Purpose    : Display flight details through interactive ALV
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* Displays flight information in a main ALV. When the user clicks a
* flight connection, the program retrieves and displays its booking
* records in a secondary ALV.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Interactive ALV Reporting
* 2. Hotspot Field Catalog
* 3. User Command Callback
* 4. Master-Detail Data Retrieval
* 5. Multiple ALV Displays
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
  END OF ty_flight,

  BEGIN OF ty_booking,
    carrid   TYPE sbook-carrid,
    connid   TYPE sbook-connid,
    fldate   TYPE sbook-fldate,
    bookid   TYPE sbook-bookid,
    customid TYPE sbook-customid,
    custtype TYPE sbook-custtype,
    smoker   TYPE sbook-smoker,
    luggweight TYPE sbook-luggweight,
    wunit    TYPE sbook-wunit,
    forcuram TYPE sbook-forcuram,
    forcurkey TYPE sbook-forcurkey,
    cancelled TYPE sbook-cancelled,
  END OF ty_booking.

************************************************************************
* Data
************************************************************************
DATA:
  gt_flight          TYPE STANDARD TABLE OF ty_flight,
  gs_flight          TYPE ty_flight,
  gt_booking         TYPE STANDARD TABLE OF ty_booking,
  gs_booking         TYPE ty_booking,
  gt_fieldcat        TYPE slis_t_fieldcat_alv,
  gs_fieldcat        TYPE slis_fieldcat_alv,
  gs_layout          TYPE slis_layout_alv,
  gv_selected_carrid TYPE sflight-carrid,
  gv_selected_connid TYPE sflight-connid,
  gv_selected_fldate TYPE sflight-fldate.

************************************************************************
* Selection Screen
************************************************************************
SELECT-OPTIONS:
  s_carrid FOR gs_flight-carrid,
  s_connid FOR gs_flight-connid,
  s_fldate FOR gs_flight-fldate.

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

  PERFORM build_flight_field_catalog.
  PERFORM build_layout.
  PERFORM display_flight_alv.

************************************************************************
* Form GET_FLIGHT_DATA
************************************************************************
FORM get_flight_data.

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
    ORDER BY carrid, connid, fldate
    INTO TABLE @gt_flight.

ENDFORM.

************************************************************************
* Form BUILD_FLIGHT_FIELD_CATALOG
************************************************************************
FORM build_flight_field_catalog.

  CLEAR gt_fieldcat.

  PERFORM add_fieldcat USING 'CARRID'   'Airline'       10 space.
  PERFORM add_fieldcat USING 'CONNID'   'Flight Number' 12 'X'.
  PERFORM add_fieldcat USING 'FLDATE'   'Flight Date'   12 space.
  PERFORM add_fieldcat USING 'PRICE'    'Price'         15 space.
  PERFORM add_fieldcat USING 'CURRENCY' 'Currency'       8 space.
  PERFORM add_fieldcat USING 'SEATSMAX' 'Total Seats'   12 space.
  PERFORM add_fieldcat USING 'SEATSOCC' 'Occupied Seats' 14 space.

  LOOP AT gt_fieldcat INTO gs_fieldcat.
    IF gs_fieldcat-fieldname = 'CONNID'.
      gs_fieldcat-hotspot = 'X'.
      MODIFY gt_fieldcat FROM gs_fieldcat INDEX sy-tabix.
    ENDIF.
  ENDLOOP.

ENDFORM.

************************************************************************
* Form BUILD_BOOKING_FIELD_CATALOG
************************************************************************
FORM build_booking_field_catalog.

  CLEAR gt_fieldcat.

  PERFORM add_fieldcat USING 'BOOKID'     'Booking ID'    12 'X'.
  PERFORM add_fieldcat USING 'CARRID'     'Airline'       10 space.
  PERFORM add_fieldcat USING 'CONNID'     'Flight Number' 12 space.
  PERFORM add_fieldcat USING 'FLDATE'     'Flight Date'   12 space.
  PERFORM add_fieldcat USING 'CUSTOMID'   'Customer ID'   12 space.
  PERFORM add_fieldcat USING 'CUSTTYPE'   'Customer Type' 12 space.
  PERFORM add_fieldcat USING 'SMOKER'     'Smoker'         8 space.
  PERFORM add_fieldcat USING 'LUGGWEIGHT' 'Luggage Weight' 14 space.
  PERFORM add_fieldcat USING 'WUNIT'      'Weight Unit'    10 space.
  PERFORM add_fieldcat USING 'FORCURAM'   'Booking Amount' 15 space.
  PERFORM add_fieldcat USING 'FORCURKEY'  'Currency'        8 space.
  PERFORM add_fieldcat USING 'CANCELLED'  'Cancelled'      10 space.

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
* Form DISPLAY_FLIGHT_ALV
************************************************************************
FORM display_flight_alv.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program      = sy-repid
      i_callback_user_command = 'USER_COMMAND'
      i_grid_title            = '
