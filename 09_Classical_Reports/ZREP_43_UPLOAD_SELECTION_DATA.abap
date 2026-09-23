REPORT ZREP_43_UPLOAD_SELECTION_DATA.

*---------------------------------------------------------------------*
* Program    : ZREP_43_UPLOAD_SELECTION_DATA
* Title      : Upload Selection Data from Local File
* Purpose    : Demonstrates uploading selection data from a file
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This report reads flight selection data from a local text file
* and uses the uploaded values to retrieve flight records from
* the SFLIGHT table.
*
* The example demonstrates frontend file upload, internal tables,
* file parsing, Open SQL and classical list output.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Classical Reports
* 2. Selection-Screen Parameters
* 3. Local File Upload
* 4. GUI_UPLOAD
* 5. Internal Tables
* 6. String Processing
* 7. SFLIGHT
* 8. Modern Open SQL
* 9. FORMs
* 10. Classical List Output
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Upload data from a local file.
* - Process uploaded text data.
* - Store selection values in an internal table.
* - Use uploaded values in a database selection.
* - Display the resulting data as a classical report.
*---------------------------------------------------------------------*

************************************************************************
* Selection Screen
************************************************************************

PARAMETERS:
  p_file TYPE string
    LOWER CASE
    DEFAULT 'C:\TEMP\flight_selection.txt'
    OBLIGATORY.

************************************************************************
* Types
************************************************************************

TYPES:
  BEGIN OF ty_selection,
    carrid TYPE sflight-carrid,
  END OF ty_selection.

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
  END OF ty_flight.

************************************************************************
* Data
************************************************************************

DATA:
  gt_file_data TYPE STANDARD TABLE OF string,
  gt_selection TYPE STANDARD TABLE OF ty_selection,
  gt_flight    TYPE STANDARD TABLE OF ty_flight,

  gs_selection TYPE ty_selection,
  gs_flight    TYPE ty_flight.

************************************************************************
* START-OF-SELECTION
************************************************************************

START-OF-SELECTION.

  PERFORM upload_file.

  IF gt_file_data IS INITIAL.
    RETURN.
  ENDIF.

  PERFORM prepare_selection_data.

  IF gt_selection IS INITIAL.
    MESSAGE 'No valid airline codes found in the uploaded file.'
      TYPE 'I'.
    RETURN.
  ENDIF.

  PERFORM get_flight_data.
  PERFORM display_report.

************************************************************************
* Upload File
************************************************************************

FORM upload_file.

  CALL FUNCTION 'GUI_UPLOAD'
    EXPORTING
      filename                = p_file
      filetype                = 'ASC'
      has_field_separator     = space
    TABLES
      data_tab                = gt_file_data
    EXCEPTIONS
      file_open_error         = 1
      file_read_error         = 2
      no_batch                = 3
      gui_refuse_filetransfer = 4
      invalid_type            = 5
      no_authority            = 6
      unknown_error           = 7
      bad_data_format         = 8
      header_not_allowed      = 9
      separator_not_allowed   = 10
      header_too_long         = 11
      unknown_dp_error        = 12
      access_denied           = 13
      dp_out_of_memory        = 14
      disk_full               = 15
      dp_timeout              = 16
      OTHERS                  = 17.

  IF sy-subrc <> 0.

    MESSAGE 'File upload failed.' TYPE 'E'.

  ENDIF.

ENDFORM.

*---------------------------------------------------------------------*
* Prepare Selection Data
*---------------------------------------------------------------------*

FORM prepare_selection_data.

  DATA:
    lv_line   TYPE string,
    lv_carrid TYPE sflight-carrid.

  LOOP AT gt_file_data INTO lv_line.

    CONDENSE lv_line.

    IF lv_line IS INITIAL.
      CONTINUE.
    ENDIF.

    "Ignore header line if present
    IF lv_line = 'CARRID'.
      CONTINUE.
    ENDIF.

    lv_carrid = lv_line.

    APPEND VALUE #(
      carrid = lv_carrid
    ) TO gt_selection.

  ENDLOOP.

  SORT gt_selection BY carrid.
  DELETE ADJACENT DUPLICATES FROM gt_selection
    COMPARING carrid.

ENDFORM.

*---------------------------------------------------------------------*
* Get Flight Data
*---------------------------------------------------------------------*

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
    FOR ALL ENTRIES IN @gt_selection
    WHERE carrid = @gt_selection-carrid
    INTO TABLE @gt_flight
    ORDER BY
      carrid,
      connid.

  IF gt_flight IS INITIAL.

    MESSAGE 'No flight data found for uploaded selection data.'
      TYPE 'I'.

  ENDIF.

ENDFORM.

*---------------------------------------------------------------------*
* Display Report
*---------------------------------------------------------------------*

FORM display_report.

  DATA:
    lv_count     TYPE i,
    lv_available TYPE i.

  lv_count = lines( gt_flight ).

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE:
    / 'FLIGHT REPORT - UPLOADED SELECTION DATA',
    / 'Uploaded File:', p_file,
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

  ULINE.

  LOOP AT gt_flight INTO gs_flight.

    lv_available =
      gs_flight-seatsmax - gs_flight-seatsocc.

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

  ENDLOOP.

  SKIP 1.

  ULINE.

  FORMAT COLOR COL_TOTAL INTENSIFIED ON.

  WRITE:
    / 'Total Flight Records:', lv_count.

  FORMAT RESET.

ENDFORM.
