REPORT ZALV_05_ALV_FIELD_CATALOG_CUSTOM.

*---------------------------------------------------------------------*
* Program    : ZALV_05_ALV_FIELD_CATALOG_CUSTOM
* Title      : Custom ALV Field Catalog
* Purpose    : Demonstrates custom Field Catalog configuration
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This report retrieves purchase order item data from EKKO and EKPO
* and displays the result using a custom ALV Field Catalog.
*
* The Field Catalog controls column headings, positions, visibility,
* output lengths, alignment and aggregation behavior.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Custom Field Catalog
* 2. SLIS_T_FIELDCAT_ALV
* 3. Column Position
* 4. Column Headings
* 5. Technical Field
* 6. NO_OUT
* 7. Output Length
* 8. Alignment
* 9. Numeric Summation
* 10. REUSE_ALV_GRID_DISPLAY
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Build a custom ALV Field Catalog.
* - Customize column headings.
* - Control column visibility.
* - Configure numeric fields for totals.
* - Understand how Field Catalog controls ALV presentation.
*---------------------------------------------------------------------*

************************************************************************
* Selection Screen
************************************************************************

PARAMETERS:
  p_bukrs TYPE ekko-bukrs OBLIGATORY,
  p_bedat TYPE ekko-bedat DEFAULT sy-datum.

************************************************************************
* Types
************************************************************************

TYPES:
  BEGIN OF ty_purchase_order,
    ebeln    TYPE ekko-ebeln,
    ebelp    TYPE ekpo-ebelp,
    bukrs    TYPE ekko-bukrs,
    bedat    TYPE ekko-bedat,
    lifnr    TYPE ekko-lifnr,
    matnr    TYPE ekpo-matnr,
    txz01    TYPE ekpo-txz01,
    menge    TYPE ekpo-menge,
    meins    TYPE ekpo-meins,
    netpr    TYPE ekpo-netpr,
    peinh    TYPE ekpo-peinh,
    waers    TYPE ekko-waers,
  END OF ty_purchase_order.

************************************************************************
* Data
************************************************************************

DATA:
  gt_purchase_order TYPE STANDARD TABLE OF ty_purchase_order,
  gs_purchase_order TYPE ty_purchase_order.

DATA:
  gt_fieldcat TYPE slis_t_fieldcat_alv,
  gs_fieldcat TYPE slis_fieldcat_alv.

************************************************************************
* START-OF-SELECTION
************************************************************************

START-OF-SELECTION.

  PERFORM get_purchase_order_data.

  IF gt_purchase_order IS INITIAL.

    MESSAGE 'No purchase orders found for the selected criteria.'
      TYPE 'I'.

    RETURN.

  ENDIF.

  PERFORM build_field_catalog.
  PERFORM display_alv.

************************************************************************
* Get Purchase Order Data
************************************************************************

FORM get_purchase_order_data.

  SELECT
    FROM ekko AS header
    INNER JOIN ekpo AS item
      ON item~ebeln = header~ebeln
    FIELDS
      header~ebeln,
      item~ebelp,
      header~bukrs,
      header~bedat,
      header~lifnr,
      item~matnr,
      item~txz01,
      item~menge,
      item~meins,
      item~netpr,
      item~peinh,
      header~waers
    WHERE header~bukrs = @p_bukrs
      AND header~bedat = @p_bedat
    INTO TABLE @gt_purchase_order
    ORDER BY
      header~ebeln,
      item~ebelp.

ENDFORM.

************************************************************************
* Build Custom Field Catalog
************************************************************************

FORM build_field_catalog.

  CLEAR gt_fieldcat.

  "---------------------------------------------------------------*
  " Purchase Order
  "---------------------------------------------------------------*

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = 'EBELN'.
  gs_fieldcat-seltext_l = 'Purchase Order'.
  gs_fieldcat-seltext_m = 'PO Number'.
  gs_fieldcat-seltext_s = 'PO'.
  gs_fieldcat-col_pos   = 1.
  gs_fieldcat-outputlen = 12.

  APPEND gs_fieldcat TO gt_fieldcat.

  "---------------------------------------------------------------*
  " Item
  "---------------------------------------------------------------*

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = 'EBELP'.
  gs_fieldcat-seltext_m = 'Item'.
  gs_fieldcat-col_pos   = 2.
  gs_fieldcat-outputlen = 6.

  APPEND gs_fieldcat TO gt_fieldcat.

  "---------------------------------------------------------------*
  " Company Code
  "---------------------------------------------------------------*

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = 'BUKRS'.
  gs_fieldcat-seltext_m = 'Company'.
  gs_fieldcat-col_pos   = 3.
  gs_fieldcat-outputlen = 8.

  APPEND gs_fieldcat TO gt_fieldcat.

  "---------------------------------------------------------------*
  " Document Date
  "---------------------------------------------------------------*

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = 'BEDAT'.
  gs_fieldcat-seltext_m = 'PO Date'.
  gs_fieldcat-col_pos   = 4.
  gs_fieldcat-outputlen = 12.

  APPEND gs_fieldcat TO gt_fieldcat.

  "---------------------------------------------------------------*
  " Vendor
  "---------------------------------------------------------------*

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = 'LIFNR'.
  gs_fieldcat-seltext_m = 'Vendor'.
  gs_fieldcat-col_pos   = 5.
  gs_fieldcat-outputlen = 12.

  APPEND gs_fieldcat TO gt_fieldcat.

  "---------------------------------------------------------------*
  " Material
  "---------------------------------------------------------------*

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = 'MATNR'.
  gs_fieldcat-seltext_m = 'Material'.
  gs_fieldcat-col_pos   = 6.
  gs_fieldcat-outputlen = 18.

  APPEND gs_fieldcat TO gt_fieldcat.

  "---------------------------------------------------------------*
  " Short Text
  "---------------------------------------------------------------*

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = 'TXZ01'.
  gs_fieldcat-seltext_m = 'Description'.
  gs_fieldcat-col_pos   = 7.
  gs_fieldcat-outputlen = 30.

  APPEND gs_fieldcat TO gt_fieldcat.

  "---------------------------------------------------------------*
  " Quantity
  "---------------------------------------------------------------*

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = 'MENGE'.
  gs_fieldcat-seltext_m = 'Quantity'.
  gs_fieldcat-col_pos   = 8.
  gs_fieldcat-outputlen = 12.
  gs_fieldcat-do_sum    = 'X'.
  gs_fieldcat-just      = 'R'.

  APPEND gs_fieldcat TO gt_fieldcat.

  "---------------------------------------------------------------*
  " Unit
  "---------------------------------------------------------------*

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = 'MEINS'.
  gs_fieldcat-seltext_m = 'Unit'.
  gs_fieldcat-col_pos   = 9.
  gs_fieldcat-outputlen = 8.

  APPEND gs_fieldcat TO gt_fieldcat.

  "---------------------------------------------------------------*
  " Net Price
  "---------------------------------------------------------------*

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = 'NETPR'.
  gs_fieldcat-seltext_m = 'Net Price'.
  gs_fieldcat-col_pos   = 10.
  gs_fieldcat-outputlen = 14.
  gs_fieldcat-do_sum    = 'X'.
  gs_fieldcat-just      = 'R'.

  APPEND gs_fieldcat TO gt_fieldcat.

  "---------------------------------------------------------------*
  " Price Unit - Technical Information
  "---------------------------------------------------------------*

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = 'PEINH'.
  gs_fieldcat-seltext_m = 'Price Unit'.
  gs_fieldcat-col_pos   = 11.
  gs_fieldcat-outputlen = 10.
  gs_fieldcat-no_out    = 'X'.

  APPEND gs_fieldcat TO gt_fieldcat.

  "---------------------------------------------------------------*
  " Currency
  "---------------------------------------------------------------*

  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = 'WAERS'.
  gs_fieldcat-seltext_m = 'Currency'.
  gs_fieldcat-col_pos   = 12.
  gs_fieldcat-outputlen = 8.

  APPEND gs_fieldcat TO gt_fieldcat.

ENDFORM.

************************************************************************
* Display ALV
************************************************************************

FORM display_alv.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_grid_title       = 'Purchase Order - Custom Field Catalog'
      i_callback_program = sy-repid
      i_save             = 'A'
      it_fieldcat        = gt_fieldcat
    TABLES
      t_outtab           = gt_purchase_order
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.

  IF sy-subrc <> 0.

    MESSAGE 'ALV display failed.' TYPE 'E'.

  ENDIF.

ENDFORM.
