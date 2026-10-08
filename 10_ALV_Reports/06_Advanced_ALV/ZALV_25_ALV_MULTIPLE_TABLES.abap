REPORT ZALV_25_ALV_MULTIPLE_TABLES.

*---------------------------------------------------------------------*
* Program    : ZALV_25_ALV_MULTIPLE_TABLES
* Title      : ALV Multiple Internal Tables
* Purpose    : Demonstrates Combining Multiple Data Sources in ALV
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This report demonstrates how data retrieved from multiple database
* tables can be combined into a single internal table and displayed
* in a Classic ALV Grid.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Multiple Database Tables
* 2. INNER JOIN
* 3. Combined Internal Table
* 4. Classic ALV Grid
* 5. Custom Field Catalog
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand how multiple database tables can provide ALV data.
* - Combine header and item information into one output structure.
* - Display the combined result using Classic ALV.
*---------------------------------------------------------------------*

************************************************************************
* Type Definitions
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
    waers    TYPE ekko-waers,
  END OF ty_purchase_order.

************************************************************************
* Data Declarations
************************************************************************

DATA:
  gt_purchase_order TYPE STANDARD TABLE OF ty_purchase_order,
  gs_purchase_order TYPE ty_purchase_order.

DATA:
  gt_fieldcat TYPE slis_t_fieldcat_alv,
  gs_fieldcat TYPE slis_fieldcat_alv.

************************************************************************
* Selection Screen
************************************************************************

PARAMETERS:
  p_bukrs TYPE ekko-bukrs OBLIGATORY,
  p_bedat TYPE ekko-bedat DEFAULT sy-datum.

************************************************************************
* Start of Selection
************************************************************************

START-OF-SELECTION.

  PERFORM get_purchase_order_data.

  IF gt_purchase_order IS INITIAL.
    MESSAGE 'No purchase order data found for the selection.' TYPE 'I'.
    RETURN.
  ENDIF.

  PERFORM build_field_catalog.
  PERFORM display_alv.

************************************************************************
* Form GET_PURCHASE_ORDER_DATA
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
      header~waers
    WHERE header~bukrs = @p_bukrs
      AND header~bedat = @p_bedat
    INTO TABLE @gt_purchase_order
    ORDER BY
      header~ebeln,
      item~ebelp.

ENDFORM.

************************************************************************
* Form BUILD_FIELD_CATALOG
************************************************************************

FORM build_field_catalog.

  CLEAR gt_fieldcat.

  "Purchase Order
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'EBELN'.
  gs_fieldcat-seltext_l = 'Purchase Order'.
  gs_fieldcat-seltext_m = 'PO Number'.
  gs_fieldcat-seltext_s = 'PO'.
  gs_fieldcat-col_pos   = 1.
  gs_fieldcat-outputlen = 12.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Item
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'EBELP'.
  gs_fieldcat-seltext_l = 'PO Item'.
  gs_fieldcat-seltext_m = 'Item'.
  gs_fieldcat-seltext_s = 'Item'.
  gs_fieldcat-col_pos   = 2.
  gs_fieldcat-outputlen = 8.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Company Code
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'BUKRS'.
  gs_fieldcat-seltext_l = 'Company Code'.
  gs_fieldcat-seltext_m = 'Company'.
  gs_fieldcat-seltext_s = 'Company'.
  gs_fieldcat-col_pos   = 3.
  gs_fieldcat-outputlen = 10.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Document Date
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'BEDAT'.
  gs_fieldcat-seltext_l = 'Purchase Order Date'.
  gs_fieldcat-seltext_m = 'PO Date'.
  gs_fieldcat-seltext_s = 'Date'.
  gs_fieldcat-col_pos   = 4.
  gs_fieldcat-outputlen = 12.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Vendor
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'LIFNR'.
  gs_fieldcat-seltext_l = 'Vendor'.
  gs_fieldcat-seltext_m = 'Vendor'.
  gs_fieldcat-seltext_s = 'Vendor'.
  gs_fieldcat-col_pos   = 5.
  gs_fieldcat-outputlen = 12.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Material
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'MATNR'.
  gs_fieldcat-seltext_l = 'Material Number'.
  gs_fieldcat-seltext_m = 'Material'.
  gs_fieldcat-seltext_s = 'Material'.
  gs_fieldcat-col_pos   = 6.
  gs_fieldcat-outputlen = 18.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Description
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'TXZ01'.
  gs_fieldcat-seltext_l = 'Short Text'.
  gs_fieldcat-seltext_m = 'Description'.
  gs_fieldcat-seltext_s = 'Text'.
  gs_fieldcat-col_pos   = 7.
  gs_fieldcat-outputlen = 30.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Quantity
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'MENGE'.
  gs_fieldcat-seltext_l = 'Order Quantity'.
  gs_fieldcat-seltext_m = 'Quantity'.
  gs_fieldcat-seltext_s = 'Qty'.
  gs_fieldcat-col_pos   = 8.
  gs_fieldcat-outputlen = 14.
  gs_fieldcat-do_sum    = 'X'.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Unit
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'MEINS'.
  gs_fieldcat-seltext_l = 'Order Unit'.
  gs_fieldcat-seltext_m = 'Unit'.
  gs_fieldcat-seltext_s = 'Unit'.
  gs_fieldcat-col_pos   = 9.
  gs_fieldcat-outputlen = 8.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Net Price
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'NETPR'.
  gs_fieldcat-seltext_l = 'Net Price'.
  gs_fieldcat-seltext_m = 'Net Price'.
  gs_fieldcat-seltext_s = 'Price'.
  gs_fieldcat-col_pos   = 10.
  gs_fieldcat-outputlen = 14.
  gs_fieldcat-do_sum    = 'X'.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Currency
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'WAERS'.
  gs_fieldcat-seltext_l = 'Currency'.
  gs_fieldcat-seltext_m = 'Currency'.
  gs_fieldcat-seltext_s = 'Curr.'.
  gs_fieldcat-col_pos   = 11.
  gs_fieldcat-outputlen = 8.
  APPEND gs_fieldcat TO gt_fieldcat.

ENDFORM.

************************************************************************
* Form DISPLAY_ALV
************************************************************************

FORM display_alv.

  DATA:
    lv_title TYPE lvc_title.

 
