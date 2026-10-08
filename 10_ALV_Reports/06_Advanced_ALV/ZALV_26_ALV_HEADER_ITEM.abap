REPORT ZALV_26_ALV_HEADER_ITEM.

*---------------------------------------------------------------------*
* Program    : ZALV_26_ALV_HEADER_ITEM
* Title      : ALV Header Item Report
* Purpose    : Demonstrates Header and Item Data in ALV
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This report combines purchase order header and item information
* from EKKO and EKPO and displays the result in a Classic ALV Grid.
*
* Each purchase order can contain multiple item records.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Header and Item Concept
* 2. EKKO Header Data
* 3. EKPO Item Data
* 4. INNER JOIN
* 5. Classic ALV Grid
* 6. Sorting and Subtotals
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand the relationship between header and item data.
* - Retrieve related data from EKKO and EKPO.
* - Display header-item information in ALV.
* - Group purchase order items using ALV sorting.
*---------------------------------------------------------------------*

************************************************************************
* Type Definitions
************************************************************************

TYPES:
  BEGIN OF ty_po,
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
  END OF ty_po.

************************************************************************
* Data Declarations
************************************************************************

DATA:
  gt_po TYPE STANDARD TABLE OF ty_po,
  gs_po TYPE ty_po.

DATA:
  gt_fieldcat TYPE slis_t_fieldcat_alv,
  gs_fieldcat TYPE slis_fieldcat_alv.

DATA:
  gt_sort TYPE slis_t_sortinfo_alv,
  gs_sort TYPE slis_sortinfo_alv.

DATA:
  gs_layout TYPE slis_layout_alv.

************************************************************************
* Selection Screen
************************************************************************

SELECT-OPTIONS:
  s_ebeln FOR gs_po-ebeln,
  s_bedat FOR gs_po-bedat.

PARAMETERS:
  p_bukrs TYPE ekko-bukrs.

************************************************************************
* Start of Selection
************************************************************************

START-OF-SELECTION.

  PERFORM get_purchase_order_data.

  IF gt_po IS INITIAL.
    MESSAGE 'No purchase order data found for the selection.' TYPE 'I'.
    RETURN.
  ENDIF.

  PERFORM build_field_catalog.
  PERFORM build_sort.
  PERFORM configure_layout.
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
      item~peinh,
      header~waers
    WHERE header~ebeln IN @s_ebeln
      AND header~bedat IN @s_bedat
      AND ( @p_bukrs IS INITIAL OR header~bukrs = @p_bukrs )
    INTO TABLE @gt_po
    ORDER BY
      header~ebeln,
      item~ebelp.

ENDFORM.

************************************************************************
* Form BUILD_FIELD_CATALOG
************************************************************************

FORM build_field_catalog.

  CLEAR gt_fieldcat.

  "---------------------------------------------------------------*
  " Header Fields
  "---------------------------------------------------------------*

  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'EBELN'.
  gs_fieldcat-seltext_l = 'Purchase Order'.
  gs_fieldcat-seltext_m = 'PO Number'.
  gs_fieldcat-seltext_s = 'PO'.
  gs_fieldcat-col_pos   = 1.
  gs_fieldcat-outputlen = 12.
  APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'BUKRS'.
  gs_fieldcat-seltext_l = 'Company Code'.
  gs_fieldcat-seltext_m = 'Company'.
  gs_fieldcat-seltext_s = 'Company'.
  gs_fieldcat-col_pos   = 2.
  gs_fieldcat-outputlen = 10.
  APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'BEDAT'.
  gs_fieldcat-seltext_l = 'Purchase Order Date'.
  gs_fieldcat-seltext_m = 'PO Date'.
  gs_fieldcat-seltext_s = 'Date'.
  gs_fieldcat-col_pos   = 3.
  gs_fieldcat-outputlen = 12.
  APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'LIFNR'.
  gs_fieldcat-seltext_l = 'Vendor'.
  gs_fieldcat-seltext_m = 'Vendor'.
  gs_fieldcat-seltext_s = 'Vendor'.
  gs_fieldcat-col_pos   = 4.
  gs_fieldcat-outputlen = 12.
  APPEND gs_fieldcat TO gt_fieldcat.

  "---------------------------------------------------------------*
  " Item Fields
  "---------------------------------------------------------------*

  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'EBELP'.
  gs_fieldcat-seltext_l = 'Purchase Order Item'.
  gs_fieldcat-seltext_m = 'Item'.
  gs_fieldcat-seltext_s = 'Item'.
  gs_fieldcat-col_pos   = 5.
  gs_fieldcat-outputlen = 8.
  APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'MATNR'.
  gs_fieldcat-seltext_l = 'Material Number'.
  gs_fieldcat-seltext_m = 'Material'.
  gs_fieldcat-seltext_s = 'Material'.
  gs_fieldcat-col_pos   = 6.
  gs_fieldcat-outputlen = 18.
  APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'TXZ01'.
  gs_fieldcat-seltext_l = 'Material Description'.
  gs_fieldcat-seltext_m = 'Description'.
  gs_fieldcat-seltext_s = 'Text'.
  gs_fieldcat-col_pos   = 7.
  gs_fieldcat-outputlen = 30.
  APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'MENGE'.
  gs_fieldcat-seltext_l = 'Order Quantity'.
  gs_fieldcat-seltext_m = 'Quantity'.
  gs_fieldcat-seltext_s = 'Qty'.
  gs_fieldcat-col_pos   = 8.
  gs_fieldcat-outputlen = 14.
  gs_fieldcat-do_sum    = 'X'.
  APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'MEINS'.
  gs_fieldcat-seltext_l = 'Order Unit'.
  gs_fieldcat-seltext_m = 'Unit'.
  gs_fieldcat-seltext_s = 'Unit'.
  gs_fieldcat-col_pos   = 9.
  gs_fieldcat-outputlen = 8.
  APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'NETPR'.
  gs_fieldcat-seltext_l = 'Net Price'.
  gs_fieldcat-seltext_m = 'Net Price
