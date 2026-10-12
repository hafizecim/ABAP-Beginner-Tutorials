REPORT ZALV_31_ALV_CUSTOMER_REPORT.

*---------------------------------------------------------------------*
* Program    : ZALV_31_ALV_CUSTOMER_REPORT
* Title      : Customer Master ALV Report
* Purpose    : Display customer master data using classic ALV
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* Retrieves customer master data from KNA1 and displays the selected
* records in a classic ALV Grid.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Customer Master Data
* 2. Selection Options
* 3. Manual Field Catalog
* 4. ALV Layout Configuration
* 5. Classic ALV Grid Display
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* Learn how to retrieve customer master records, apply selection
* criteria, and display the results using classic ALV.
*---------------------------------------------------------------------*

************************************************************************
* Types
************************************************************************
TYPES:
  BEGIN OF ty_customer,
    kunnr TYPE kna1-kunnr,
    name1 TYPE kna1-name1,
    name2 TYPE kna1-name2,
    land1 TYPE kna1-land1,
    regio TYPE kna1-regio,
    ort01 TYPE kna1-ort01,
    pstlz TYPE kna1-pstlz,
    ktokd TYPE kna1-ktokd,
    erdat TYPE kna1-erdat,
    ernam TYPE kna1-ernam,
    sperr TYPE kna1-sperr,
    aufsd TYPE kna1-aufsd,
  END OF ty_customer.

************************************************************************
* Data
************************************************************************
DATA:
  gt_customer TYPE STANDARD TABLE OF ty_customer,
  gs_customer TYPE ty_customer,
  gt_fieldcat TYPE slis_t_fieldcat_alv,
  gs_fieldcat TYPE slis_fieldcat_alv,
  gs_layout   TYPE slis_layout_alv.

************************************************************************
* Selection Screen
************************************************************************
SELECT-OPTIONS:
  s_kunnr FOR gs_customer-kunnr,
  s_land1 FOR gs_customer-land1,
  s_ort01 FOR gs_customer-ort01,
  s_ktokd FOR gs_customer-ktokd.

************************************************************************
* Main Processing
************************************************************************
START-OF-SELECTION.

  PERFORM get_customer_data.

  IF gt_customer IS INITIAL.
    MESSAGE 'No customer data found for the selection.'
      TYPE 'S' DISPLAY LIKE 'E'.
    RETURN.
  ENDIF.

  PERFORM build_field_catalog.
  PERFORM build_layout.
  PERFORM display_alv.

************************************************************************
* Form GET_CUSTOMER_DATA
************************************************************************
FORM get_customer_data.

  SELECT
    kunnr,
    name1,
    name2,
    land1,
    regio,
    ort01,
    pstlz,
    ktokd,
    erdat,
    ernam,
    sperr,
    aufsd
    FROM kna1
    WHERE kunnr IN @s_kunnr
      AND land1 IN @s_land1
      AND ort01 IN @s_ort01
      AND ktokd IN @s_ktokd
    ORDER BY kunnr
    INTO TABLE @gt_customer.

ENDFORM.

************************************************************************
* Form BUILD_FIELD_CATALOG
************************************************************************
FORM build_field_catalog.

  CLEAR gt_fieldcat.

  PERFORM add_fieldcat USING 'KUNNR' 'Customer'          12 'X'.
  PERFORM add_fieldcat USING 'NAME1' 'Name'              25 space.
  PERFORM add_fieldcat USING 'NAME2' 'Additional Name'   20 space.
  PERFORM add_fieldcat USING 'LAND1' 'Country'            8 space.
  PERFORM add_fieldcat USING 'REGIO' 'Region'            10 space.
  PERFORM add_fieldcat USING 'ORT01' 'City'              20 space.
  PERFORM add_fieldcat USING 'PSTLZ' 'Postal Code'       10 space.
  PERFORM add_fieldcat USING 'KTOKD' 'Account Group'     12 space.
  PERFORM add_fieldcat USING 'ERDAT' 'Created On'        10 space.
  PERFORM add_fieldcat USING 'ERNAM' 'Created By'        12 space.
  PERFORM add_fieldcat USING 'SPERR' 'Posting Block'      8 space.
  PERFORM add_fieldcat USING 'AUFSD' 'Order Block'        8 space.

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
      i_grid_title       = 'Customer Master Report'
      is_layout          = gs_layout
      it_fieldcat        = gt_fieldcat
      i_save             = 'A'
    TABLES
      t_outtab           = gt_customer
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.

  IF sy-subrc <> 0.
    MESSAGE 'Error displaying the customer ALV.'
      TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.

ENDFORM.
