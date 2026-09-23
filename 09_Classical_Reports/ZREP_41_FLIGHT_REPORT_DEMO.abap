REPORT ZREP_41_FLIGHT_REPORT_DEMO.

*---------------------------------------------------------------------*
* Program    : ZREP_41_FLIGHT_REPORT_DEMO
* Title      : Flight Report Demo
* Purpose    : Demonstrates a Classical Report using SFLIGHT
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This report retrieves flight information from the SFLIGHT table
* according to the selected airline and flight date.
*
* The report demonstrates selection-screen parameters, Open SQL,
* internal tables, local types and classical list output.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Classical Reports
* 2. Selection-Screen Parameters
* 3. SFLIGHT Table
* 4. Modern Open SQL
* 5. Internal Tables
* 6. Local Types
* 7. Database Selection
* 8. Classical List Output
* 9. FORMs
* 10. Basic Report Statistics
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand the structure of the SFLIGHT table.
* - Retrieve flight data using selection parameters.
* - Store database results in an internal table.
* - Display flight information using classical list output.
* - Separate data retrieval from presentation logic.
*---------------------------------------------------------------------*

************************************************************************
* Selection Screen
************************************************************************

PARAMETERS:
  p_carrid TYPE sflight-carrid OBLIGATORY,
  p_fldate TYPE sflight-fldate DEFAULT sy-datum.

************************************************************************
* Types
************************************************************************

TYPES:
  BEGIN OF ty_flight,
    carrid     TYPE sflight-carrid,
    connid     TYPE sflight-connid,
    fldate     TYPE sflight-fldate,
    price      TYPE sflight-price,
    currency   TYPE sflight-currency,
    planetype   TYPE sflight-planetype,
    seatsmax   TYPE sflight-seatsmax,
    seatsocc   TYPE sflight-seatsocc,
    paymentsum  TYPE sflight-paymentsum,
  END OF ty_flight.

************************************************************************
* Data
************************************************************************

DATA:
  gt_flight TYPE STANDARD TABLE OF ty_flight,
  gs_flight TYPE ty_flight.

************************************************************************
* START-OF-SELECTION
************************************************************************

START-OF-SELECTION.

  PERFORM get_flight_data.
  PERFORM display_report.

************************************************************************
* Forms
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
      seatsocc,
      paymentsum
    WHERE carrid = @p_carrid
      AND fldate = @p_fldate
    INTO TABLE @gt_flight
    ORDER BY
      carrid,
      connid.

  IF gt_flight IS INITIAL.

    MESSAGE 'No flight data found for the selected criteria.'
      TYPE 'I'.

    RETURN.

  ENDIF.

ENDFORM.

*---------------------------------------------------------------------*
* Display Report
*---------------------------------------------------------------------*

FORM display_report.

  DATA:
    lv_count     TYPE i,
    lv_available TYPE i,
    lv_occupancy TYPE p LENGTH 8 DECIMALS 2.

  lv_count = lines( gt_flight ).

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE:
    / 'FLIGHT REPORT DEMO',
    / 'Airline:', p_carrid,
    / 'Flight Date:', p_fldate,
    / 'Total Flights:', lv_count.

  FORMAT RESET.

  SKIP 2.

  ULINE.

  POSITION 1.
  WRITE 'Airline'.

  POSITION 10.
  WRITE 'Flight'.

  POSITION 19.
  WRITE 'Date'.

  POSITION 31.
  WRITE 'Price'.

  POSITION 45.
  WRITE 'Currency'.

  POSITION 55.
  WRITE 'Aircraft'.

  POSITION 70.
  WRITE 'Capacity'.

  POSITION 82.
  WRITE 'Occupied'.

  POSITION 95.
  WRITE 'Available'.

  POSITION 110.
  WRITE 'Occupancy %'.

  ULINE.

  LOOP AT gt_flight INTO gs_flight.

    lv_available = gs_flight-seatsmax - gs_flight-seatsocc.

    IF gs_flight-seatsmax > 0.

      lv_occupancy =
        ( gs_flight-seatsocc * 100 ) /
        gs_flight-seatsmax.

    ELSE.

      CLEAR lv_occupancy.

    ENDIF.

    WRITE:
      / gs_flight-carrid.

    POSITION 10.
    WRITE gs_flight-connid.

    POSITION 19.
    WRITE gs_flight-fldate.

    POSITION 31.
    WRITE gs_flight-price.

    POSITION 45.
    WRITE gs_flight-currency.

    POSITION 55.
    WRITE gs_flight-planetype.

    POSITION 70.
    WRITE gs_flight-seatsmax.

    POSITION 82.
    WRITE gs_flight-seatsocc.

    POSITION 95.
    WRITE lv_available.

    POSITION 110.
    WRITE lv_occupancy DECIMALS 2.

  ENDLOOP.

  SKIP 1.

  ULINE.

  FORMAT COLOR COL_TOTAL INTENSIFIED ON.

  WRITE:
    / 'Total Flight Records:', lv_count.

  FORMAT RESET.

ENDFORM.
