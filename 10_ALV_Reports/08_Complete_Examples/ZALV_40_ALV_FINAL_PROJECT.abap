REPORT ZALV_40_ALV_FINAL_PROJECT.

*---------------------------------------------------------------------*
* Program    : ZALV_40_ALV_FINAL_PROJECT
* Title      : Purchase Order Analysis - Classic ALV
* Purpose    : Demonstrate a complete business-oriented ALV report
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* Displays purchase order header and item information using EKKO
* and EKPO. Supports selection criteria, sorting, subtotals,
* layout variants, and hotspot-based item navigation.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Selection Screen and Validation
* 2. Modern Open SQL and Table Joins
* 3. Field Catalog and Layout Configuration
* 4. Sorting and Subtotals
* 5. Hotspot and User Command
* 6. ALV Display Variants
* 7. Modularization Using FORMs
*---------------------------------------------------------------------*

TYPE-POOLS: slis.

************************************************************************
* Types
************************************************************************
TYPES:
  BEGIN OF ty_purchase_order,
    ebeln TYPE ekko-ebeln,
    bukrs TYPE ekko-bukrs,
    bsart TYPE ekko-bsart,
    bedat TYPE ekko-bedat,
    lifnr TYPE ekko-lifnr,
    ekorg TYPE ekko-ekorg,
    ekgrp TYPE ekko-ekgrp,
    ebelp TYPE ekpo-ebelp,
    matnr TYPE ekpo-matnr,
    txz01 TYPE ekpo-txz01,
    menge TYPE ekpo-menge,
    meins TYPE ekpo-meins,
    netpr TYPE ekpo-netpr,
    peinh TYPE ekpo-peinh,
    netwr TYPE ekpo-netwr,
    waers TYPE ekko-waers,
  END OF ty_purchase_order.

************************************************************************
* Data
************************************************************************
DATA:
  gt_orders   TYPE STANDARD TABLE OF ty_purchase_order,
  gs_order    TYPE ty_purchase_order,
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
    s_ebeln FOR gs_order-ebeln,
    s_bukrs FOR gs_order-bukrs,
    s_bedat FOR gs_order-bedat,
    s_lifnr FOR gs_order-lifnr,
    s_ekorg FOR gs_order-ekorg.

  PARAMETERS:
    p_max TYPE i DEFAULT 1000 OBLIGATORY.

SELECTION-SCREEN END OF BLOCK b1.

************************************************************************
* Main Processing
************************************************************************
START-OF-SELECTION.

  PERFORM validate_selection.
  PERFORM get_purchase_orders.

  IF gt_orders IS INITIAL.
    MESSAGE 'No purchase order items found for the selection.'
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
* Form GET_PURCHASE_ORDERS
************************************************************************
FORM get_purchase_orders.

  SELECT
    h~ebeln,
    h~bukrs,
    h~bsart,
    h~bedat,
    h~lifnr,
    h~ekorg,
    h~ekgrp,
    i~ebelp,
    i~matnr,
    i~txz01,
    i~menge,
    i~meins,
    i~netpr,
    i~peinh,
    i~netwr,
    h~waers
    FROM ekko AS h
    INNER JOIN ekpo AS i
      ON i~ebeln = h~ebeln
    WHERE h~ebeln IN @s_ebeln
      AND h~bukrs IN @s_bukrs
      AND h~bedat IN @s_bedat
      AND h~lifnr IN @s_lifnr
      AND h~ekorg IN @s_ekorg
      AND i~loekz = @space
    ORDER BY h~ebeln, i~ebelp
    INTO TABLE @gt_orders
    UP TO @p_max ROWS.

ENDFORM.

************************************************************************
* Form BUILD_FIELD_CATALOG
************************************************************************
FORM build_field_catalog.

  CLEAR gt_fieldcat.

  PERFORM add_field USING:
    'EBELN' 'Purchase Order'     12 space,
    'BUKRS' 'Company Code'        8 space,
    'BSART' 'Document Type'      10 space,
    'BEDAT' 'Document Date'      12 space,
    'LIFNR' 'Vendor'             12 space,
    'EKORG' 'Purchasing Org.'    12 space,
    'EKGRP' 'Purchasing Group'   12 space,
    'EBELP' 'Item'                6 space,
    'MATNR' 'Material'           18 space,
    'TXZ01' 'Short Text'         25 space,
    'MENGE' 'Quantity'           15 space,
    'MEINS' 'Unit'                6 space,
    'NETPR' 'Net Price'          15 space,
    'PEINH' 'Price Unit'         10 space,
    'NETWR' 'Net Value'          15 space,
    'WAERS' 'Currency'            8 space.

  LOOP AT gt_fieldcat INTO gs_fieldcat.
    IF gs_fieldcat-fieldname = 'EBELN'.
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
  gs_sort-fieldname = 'EBELN'.
  gs_sort-up        = 'X'.
  gs_sort-subtot    = 'X'.
  APPEND gs_sort TO gt_sort.

  CLEAR gs_sort.
  gs_sort-spos      = 2.
  gs_sort-fieldname = 'EBELP'.
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
  gs_layout-totals_text       = 'Subtotal'.

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
      i_grid_title            = 'Purchase Order Analysis'
      is_layout               = gs_layout
      it_fieldcat             = gt_fieldcat
      it_sort                 = gt_sort
      is_variant              = gs_variant
      i_save                  = 'A'
    TABLES
      t_outtab                = gt_orders
    EXCEPTIONS
      program_error           = 1
      OTHERS                  = 2.

  IF sy-subrc <> 0.
    MESSAGE 'Error displaying purchase order ALV.'
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
    lv_ebeln TYPE ekko-ebeln,
    lv_count TYPE i.

  CASE p_ucomm.

    WHEN '&IC1'.

      IF ps_selfield-fieldname = 'EBELN'.

        READ TABLE gt_orders INTO gs_order
          INDEX ps_selfield-tabindex.

        IF sy-subrc = 0.

          lv_ebeln = gs_order-ebeln.

          LOOP AT gt_orders INTO gs_order
            WHERE ebeln = lv_ebeln.
            lv_count = lv_count + 1.
          ENDLOOP.

          MESSAGE |Purchase order { lv_ebeln } contains { lv_count } item(s) in the current result.|
            TYPE 'S'.

        ENDIF.

      ENDIF.

  ENDCASE.

ENDFORM.
