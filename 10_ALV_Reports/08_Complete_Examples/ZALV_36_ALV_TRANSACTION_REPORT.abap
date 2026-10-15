REPORT ZALV_36_ALV_TRANSACTION_REPORT.

*---------------------------------------------------------------------*
* Program    : ZALV_36_ALV_TRANSACTION_REPORT
* Title      : Accounting Document ALV Report
* Purpose    : Display accounting document header information
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* Retrieves accounting document header data from BKPF and displays
* the selected records in a classic ALV Grid.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Accounting Document Header Data
* 2. Selection Options
* 3. Manual Field Catalog
* 4. ALV Layout Configuration
* 5. Classic ALV Grid Display
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* Learn how to retrieve accounting document headers, apply selection
* criteria, and display the results using classic ALV.
*---------------------------------------------------------------------*

************************************************************************
* Types
************************************************************************
TYPES:
  BEGIN OF ty_document,
    bukrs TYPE bkpf-bukrs,
    belnr TYPE bkpf-belnr,
    gjahr TYPE bkpf-gjahr,
    blart TYPE bkpf-blart,
    budat TYPE bkpf-budat,
    bldat TYPE bkpf-bldat,
    cpudt TYPE bkpf-cpudt,
    usnam TYPE bkpf-usnam,
    waers TYPE bkpf-waers,
    xblnr TYPE bkpf-xblnr,
    bktxt TYPE bkpf-bktxt,
  END OF ty_document.

************************************************************************
* Data
************************************************************************
DATA:
  gt_document TYPE STANDARD TABLE OF ty_document,
  gs_document TYPE ty_document,
  gt_fieldcat TYPE slis_t_fieldcat_alv,
  gs_fieldcat TYPE slis_fieldcat_alv,
  gs_layout   TYPE slis_layout_alv,
  gt_sort     TYPE slis_t_sortinfo_alv,
  gs_sort     TYPE slis_sortinfo_alv.

************************************************************************
* Selection Screen
************************************************************************
SELECT-OPTIONS:
  s_bukrs FOR gs_document-bukrs,
  s_belnr FOR gs_document-belnr,
  s_gjahr FOR gs_document-gjahr,
  s_blart FOR gs_document-blart,
  s_budat FOR gs_document-budat.

************************************************************************
* Main Processing
************************************************************************
START-OF-SELECTION.

  PERFORM get_document_data.

  IF gt_document IS INITIAL.
    MESSAGE 'No accounting documents found for the selection.'
      TYPE 'S' DISPLAY LIKE 'E'.
    RETURN.
  ENDIF.

  PERFORM build_field_catalog.
  PERFORM build_sort.
  PERFORM build_layout.
  PERFORM display_alv.

************************************************************************
* Form GET_DOCUMENT_DATA
************************************************************************
FORM get_document_data.

  SELECT
    bukrs,
    belnr,
    gjahr,
    blart,
    budat,
    bldat,
    cpudt,
    usnam,
    waers,
    xblnr,
    bktxt
    FROM bkpf
    WHERE bukrs IN @s_bukrs
      AND belnr IN @s_belnr
      AND gjahr IN @s_gjahr
      AND blart IN @s_blart
      AND budat IN @s_budat
    ORDER BY bukrs, gjahr, belnr
    INTO TABLE @gt_document.

ENDFORM.

************************************************************************
* Form BUILD_FIELD_CATALOG
************************************************************************
FORM build_field_catalog.

  CLEAR gt_fieldcat.

  PERFORM add_fieldcat USING 'BUKRS' 'Company Code'       10 'X'.
  PERFORM add_fieldcat USING 'BELNR' 'Document Number'    15 'X'.
  PERFORM add_fieldcat USING 'GJAHR' 'Fiscal Year'         8 'X'.
  PERFORM add_fieldcat USING 'BLART' 'Document Type'      10 space.
  PERFORM add_fieldcat USING 'BUDAT' 'Posting Date'       12 space.
  PERFORM add_fieldcat USING 'BLDAT' 'Document Date'      12 space.
  PERFORM add_fieldcat USING 'CPUDT' 'Entry Date'         12 space.
  PERFORM add_fieldcat USING 'USNAM' 'Created By'         12 space.
  PERFORM add_fieldcat USING 'WAERS' 'Currency'            8 space.
  PERFORM add_fieldcat USING 'XBLNR' 'Reference'          20 space.
  PERFORM add_fieldcat USING 'BKTXT' 'Document Header Text' 30 space.

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
* Form BUILD_SORT
************************************************************************
FORM build_sort.

  CLEAR gt_sort.

  CLEAR gs_sort.
  gs_sort-fieldname = 'BUKRS'.
  gs_sort-up        = 'X'.
  APPEND gs_sort TO gt_sort.

  CLEAR gs_sort.
  gs_sort-fieldname = 'GJAHR'.
  gs_sort-up        = 'X'.
  APPEND gs_sort TO gt_sort.

  CLEAR gs_sort.
  gs_sort-fieldname = 'BELNR'.
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

ENDFORM.

************************************************************************
* Form DISPLAY_ALV
************************************************************************
FORM display_alv.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
      i_grid_title       = 'Accounting Document Report'
      is_layout          = gs_layout
      it_fieldcat        = gt_fieldcat
      it_sort            = gt_sort
      i_save             = 'A'
    TABLES
      t_outtab           = gt_document
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.

  IF sy-subrc <> 0.
    MESSAGE 'Error displaying the accounting document ALV.'
      TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.

ENDFORM.
