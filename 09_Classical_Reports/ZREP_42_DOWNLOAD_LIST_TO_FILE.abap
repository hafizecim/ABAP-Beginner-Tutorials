REPORT ZREP_42_DOWNLOAD_LIST_TO_FILE.

*---------------------------------------------------------------------*
* Program    : ZREP_42_DOWNLOAD_LIST_TO_FILE
* Title      : Download Classical List to File
* Purpose    : Demonstrates downloading report data to a local file
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This report retrieves flight data from the SFLIGHT table and
* downloads the selected records to a local CSV file.
*
* The example demonstrates the relationship between classical
* report output and frontend file handling.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Classical Reports
* 2. Selection-Screen Parameters
* 3. SFLIGHT
* 4. Internal Tables
* 5. Modern Open SQL
* 6. CSV File Preparation
* 7. Frontend File Download
* 8. GUI_DOWNLOAD
* 9. FORMs
* 10. Error Handling
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Retrieve report data from a database table.
* - Prepare internal table data for file output.
* - Download report data to the user's local computer.
* - Understand the use of GUI_DOWNLOAD.
* - Separate database, preparation and download logic.
*---------------------------------------------------------------------*

************************************************************************
* Selection Screen
************************************************************************

PARAMETERS:
  p_carrid TYPE sflight-carrid OBLIGATORY,
  p_fldate TYPE sflight-fldate DEFAULT sy-datum,
  p_file   TYPE string
    LOWER CASE
    DEFAULT 'C:\TEMP\flight_report.csv'.

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

TYPES:
  BEGIN OF ty_file_line,
    line TYPE string,
  END OF ty_file_line.

************************************************************************
* Data
************************************************************************

DATA:
  gt_flight    TYPE STANDARD TABLE OF ty_flight,
  gs_flight    TYPE ty_flight,
  gt_file_data TYPE STANDARD TABLE OF ty_file_line,
  gs_file_data TYPE ty_file_line.

************************************************************************
* START-OF-SELECTION
************************************************************************

START-OF-SELECTION.

  PERFORM get_flight_data.

  IF gt_flight IS INITIAL.
    RETURN.
  ENDIF.

  PERFORM prepare_file_data.
  PERFORM download_file.

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
      seatsocc
    WHERE carrid = @p_carrid
      AND fldate = @p_fldate
    INTO TABLE @gt_flight
    ORDER BY
      carrid,
      connid.

  IF gt_flight IS INITIAL.

    MESSAGE 'No flight data found for the selected criteria.'
      TYPE 'I'.

  ENDIF.

ENDFORM.

*---------------------------------------------------------------------*
* Prepare File Data
*---------------------------------------------------------------------*

FORM prepare_file_data.

  DATA lv_line TYPE string.

  CLEAR gt_file_data.

  lv_line =
    'AIRLINE;FLIGHT;DATE;PRICE;CURRENCY;AIRCRAFT;CAPACITY;OCCUPIED'.

  APPEND VALUE #( line = lv_line ) TO gt_file_data.

  LOOP AT gt_flight INTO gs_flight.

    CLEAR lv_line.

    lv_line =
      |{ gs_flight-carrid };| &&
      |{ gs_flight-connid };| &&
      |{ gs_flight-fldate DATE = ISO };| &&
      |{ gs_flight-price };| &&
      |{ gs_flight-currency };| &&
      |{ gs_flight-planetype };| &&
      |{ gs_flight-seatsmax };| &&
      |{ gs_flight-seatsocc }|.

    APPEND VALUE #( line = lv_line ) TO gt_file_data.

  ENDLOOP.

ENDFORM.

*---------------------------------------------------------------------*
* Download File
*---------------------------------------------------------------------*

FORM download_file.

  DATA:
    lv_filename TYPE string.

  lv_filename = p_file.

  CALL FUNCTION 'GUI_DOWNLOAD'
    EXPORTING
      filename                = lv_filename
      filetype                = 'ASC'
      write_field_separator   = space
      trunc_trailing_blanks   = 'X'
    TABLES
      data_tab                = gt_file_data
    EXCEPTIONS
      file_write_error        = 1
      no_batch                = 2
      gui_refuse_filetransfer = 3
      invalid_type            = 4
      no_authority            = 5
      unknown_error           = 6
      header_not_allowed      = 7
      separator_not_allowed   = 8
      filesize_not_allowed    = 9
      OTHERS                  = 10.

  IF sy-subrc <> 0.

    MESSAGE 'File download failed.' TYPE 'E'.

  ENDIF.

  IF sy-subrc = 0.

    MESSAGE 'File downloaded successfully.' TYPE 'S'.

  ENDIF.

ENDFORM.
