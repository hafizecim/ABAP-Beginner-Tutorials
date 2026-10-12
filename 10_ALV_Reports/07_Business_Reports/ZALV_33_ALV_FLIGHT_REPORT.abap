REPORT ZALV_33_ALV_FLIGHT_REPORT.

*---------------------------------------------------------------------*
* Program    : ZALV_33_ALV_FLIGHT_REPORT
* Title      : Flight Information ALV Report
* Purpose    : Display airline, route, and flight information
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* Retrieves flight information from SCARR, SPFLI, and SFLIGHT.
* Displays airline details, route information, flight dates, prices,
* currencies, and seat availability in a classic ALV Grid.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Joining Multiple Database Tables
* 2. Selection Options
* 3. Manual Field Catalog
* 4. ALV Layout Configuration
* 5. Classic ALV Grid Display
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* Learn how to combine airline, route, and flight data and display
* the resulting records using classic ALV.
*---------------------------------------------------------------------*

************************************************************************
* Types
************************************************************************
TYPES:
  BEGIN OF ty_flight,
    carrid    TYPE sflight-carrid,
    carrname  TYPE scarr-carrname,
    connid    TYPE sflight-connid,
    countryfr TYPE spfli-countryfr,
    cityfrom  TYPE spfli-cityfrom,
    countryto TYPE spfli-countryto,
    cityto    TYPE spfli-cityto,
    fldate    TYPE sflight-fldate,
    price     TYPE sflight-price,
    currency  TYPE sflight-currency,
    seatsmax  TYPE sflight-seatsmax,
    seatsocc  TYPE sflight-seatsocc,
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

  PERFORM build_field_catalog.
  PERFORM build_layout.
  PERFORM display_alv.

************************************************************************
* Form GET_FLIGHT_DATA
************************************************************************
FORM get_flight_data.

  SELECT
    f~carrid,
    c~carrname,
    f~connid,
    r~countryfr,
    r~cityfrom,
    r~countryto,
    r~cityto,
    f~fldate,
    f~price,
    f~currency,
    f~seatsmax,
    f~seatsocc
    FROM sflight AS f
    INNER JOIN scarr AS c
      ON c~carrid = f~carrid
    INNER JOIN spfli AS r
      ON r~carrid = f~carrid
     AND r~connid = f~connid
    WHERE f~carrid IN @s_carrid
      AND f~connid IN @s_connid
      AND f~fldate IN @s_fldate
    ORDER BY f~carrid, f~connid, f~fldate
    INTO TABLE @gt_flight.

ENDFORM.

************************************************************************
* Form BUILD_FIELD_CATALOG
************************************************************************
FORM build_field_catalog.

  CLEAR gt_fieldcat.

  PERFORM add_fieldcat USING 'CARRID'    'Airline ID'       10 'X'.
  PERFORM add_fieldcat USING 'CARRNAME'  'Airline'          25 space.
  PERFORM add_fieldcat USING 'CONNID'    'Flight Number'    12 space.
  PERFORM add_fieldcat USING 'COUNTRYFR' 'From Country'     12 space.
  PERFORM add_fieldcat USING 'CITYFROM'  'Departure City'   20 space.
  PERFORM add_fieldcat USING 'COUNTRYTO' 'To Country'       12 space.
  PERFORM add_fieldcat USING 'CITYTO'    'Arrival City'     20 space.
  PERFORM add_fieldcat USING 'FLDATE'    'Flight Date'      12 space.
  PERFORM add_fieldcat USING 'PRICE'     'Price'            15 space.
  PERFORM add_fieldcat USING 'CURRENCY'  'Currency'          8 space.
  PERFORM add_fieldcat USING 'SEATSMAX'  'Total Seats'      12 space.
  PERFORM add_fieldcat USING 'SEATSOCC'  'Occupied Seats'   14 space.

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
      i_grid_title       = 'Flight Information Report'
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
