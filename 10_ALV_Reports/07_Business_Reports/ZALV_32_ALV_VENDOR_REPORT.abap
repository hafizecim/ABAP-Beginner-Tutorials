REPORT ZALV_32_ALV_VENDOR_REPORT.

*---------------------------------------------------------------------*
* Program    : ZALV_32_ALV_VENDOR_REPORT
* Title      : Vendor Master ALV Report
* Purpose    : Display vendor master data using classic ALV
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* Retrieves vendor master data from LFA1 and displays the selected
* records in a classic ALV Grid.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Vendor Master Data
* 2. Selection Options
* 3. Manual Field Catalog
* 4. ALV Layout Configuration
* 5. Classic ALV Grid Display
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* Learn how to retrieve vendor master records, apply selection
* criteria, and display the results using classic ALV.
*---------------------------------------------------------------------*

************************************************************************
* Types
************************************************************************
TYPES:
  BEGIN OF ty_vendor,
    lifnr TYPE lfa1-lifnr,
    name1 TYPE lfa1-name1,
    name2 TYPE lfa1-name2,
    land1 TYPE lfa1-land1,
    regio TYPE lfa1-regio,
    ort01 TYPE lfa1-ort01,
    pstlz TYPE lfa1-pstlz,
    ktokk TYPE lfa1-ktokk,
    erdat TYPE lfa1-erdat,
    ernam TYPE lfa1-ernam,
    sperr TYPE lfa1-sperr,
    sperm TYPE lfa1-sperm,
  END OF ty_vendor.

************************************************************************
* Data
************************************************************************
DATA:
  gt_vendor   TYPE STANDARD TABLE OF ty_vendor,
  gs_vendor   TYPE ty_vendor,
  gt_fieldcat TYPE slis_t_fieldcat_alv,
  gs_fieldcat TYPE slis_fieldcat_alv,
  gs_layout   TYPE slis_layout_alv.

************************************************************************
* Selection Screen
************************************************************************
SELECT-OPTIONS:
  s_lifnr FOR gs_vendor-lifnr,
  s_land1 FOR gs_vendor-land1,
  s_ort01 FOR gs_vendor-ort01,
  s_ktokk FOR gs_vendor-ktokk.

************************************************************************
* Main Processing
************************************************************************
START-OF-SELECTION.

  PERFORM get_vendor_data.

  IF gt_vendor IS INITIAL.
    MESSAGE 'No vendor data found for the selection.'
      TYPE 'S' DISPLAY LIKE 'E'.
    RETURN.
  ENDIF.

  PERFORM build_field_catalog.
  PERFORM build_layout.
  PERFORM display_alv.

************************************************************************
* Form GET_VENDOR_DATA
************************************************************************
FORM get_vendor_data.

  SELECT
    lifnr,
    name1,
    name2,
    land1,
    regio,
    ort01,
    pstlz,
    ktokk,
    erdat,
    ernam,
    sperr,
    sperm
    FROM lfa1
    WHERE lifnr IN @s_lifnr
      AND land1 IN @s_land1
      AND ort01 IN @s_ort01
      AND ktokk IN @s_ktokk
    ORDER BY lifnr
    INTO TABLE @gt_vendor.

ENDFORM.

************************************************************************
* Form BUILD_FIELD_CATALOG
************************************************************************
FORM build_field_catalog.

  CLEAR gt_fieldcat.

  PERFORM add_fieldcat USING 'LIFNR' 'Vendor'            12 'X'.
  PERFORM add_fieldcat USING 'NAME1' 'Name'              25 space.
  PERFORM add_fieldcat USING 'NAME2' 'Additional Name'   20 space.
  PERFORM add_fieldcat USING 'LAND1' 'Country'            8 space.
  PERFORM add_fieldcat USING 'REGIO' 'Region'            10 space.
  PERFORM add_fieldcat USING 'ORT01' 'City'              20 space.
  PERFORM add_fieldcat USING 'PSTLZ' 'Postal Code'       10 space.
  PERFORM add_fieldcat USING 'KTOKK' 'Account Group'     12 space.
  PERFORM add_fieldcat USING 'ERDAT' 'Created On'        10 space.
  PERFORM add_fieldcat USING 'ERNAM' 'Created By'        12 space.
  PERFORM add_fieldcat USING 'SPERR' 'Posting Block'      8 space.
  PERFORM add_fieldcat USING 'SPERM' 'Purchasing Block'   8 space.

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
      i_grid_title       = 'Vendor Master Report'
      is_layout          = gs_layout
      it_fieldcat        = gt_fieldcat
      i_save             = 'A'
    TABLES
      t_outtab           = gt_vendor
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.

  IF sy-subrc <> 0.
    MESSAGE 'Error displaying the vendor ALV.'
      TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.

ENDFORM.
