REPORT ZALV_28_ALV_SALES_ORDER.

*---------------------------------------------------------------------*
* Program    : ZALV_28_ALV_SALES_ORDER
* Title      : Sales Order ALV Report
* Purpose    : Displays Sales Order Header and Item Data
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This report retrieves sales order header data from VBAK and item
* data from VBAP, then displays the combined result in a Classic ALV.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. SAP SD Sales Order Data
* 2. VBAK and VBAP
* 3. INNER JOIN
* 4. Selection Screen
* 5. ALV Field Catalog
* 6. Sorting and Totals
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand the relationship between VBAK and VBAP.
* - Retrieve sales order header and item data.
* - Display business data using Classic ALV.
*---------------------------------------------------------------------*

************************************************************************
* Type Definitions
************************************************************************

TYPES:
  BEGIN OF ty_sales_order,
    vbeln  TYPE vbak-vbeln,
    posnr  TYPE vbap-posnr,
    auart  TYPE vbak-auart,
    audat  TYPE vbak-audat,
    vkorg  TYPE vbak-vkorg,
    vtweg  TYPE vbak-vtweg,
    kunnr  TYPE vbak-kunnr,
    matnr  TYPE vbap-matnr,
    arktx  TYPE vbap-arktx,
    kwmeng TYPE vbap-kwmeng,
    vrkme  TYPE vbap-vrkme,
    netwr  TYPE vbap-netwr,
    waerk  TYPE vbak-waerk,
  END OF ty_sales_order.

************************************************************************
* Data Declarations
************************************************************************

DATA:
  gt_sales_order TYPE STANDARD TABLE OF ty_sales_order,
  gs_sales_order TYPE ty_sales_order.

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
  s_vbeln FOR gs_sales_order-vbeln,
  s_audat FOR gs_sales_order-audat.

PARAMETERS:
  p_vkorg TYPE vbak-vkorg.

************************************************************************
* Start of Selection
************************************************************************

START-OF-SELECTION.

  PERFORM get_sales_order_data.

  IF gt_sales_order IS INITIAL.
    MESSAGE 'No sales order data found for the selection.' TYPE 'I'.
    RETURN.
  ENDIF.

  PERFORM build_field_catalog.
  PERFORM build_sort.
  PERFORM configure_layout.
  PERFORM display_alv.

************************************************************************
* Form GET_SALES_ORDER_DATA
************************************************************************

FORM get_sales_order_data.

  SELECT
    FROM vbak AS header
    INNER JOIN vbap AS item
      ON item~vbeln = header~vbeln
    FIELDS
      header~vbeln,
      item~posnr,
      header~auart,
      header~audat,
      header~vkorg,
      header~vtweg,
      header~kunnr,
      item~matnr,
      item~arktx,
      item~kwmeng,
      item~vrkme,
      item~netwr,
      header~waerk
    WHERE header~vbeln IN @s_vbeln
      AND header~audat IN @s_audat
      AND ( @p_vkorg IS INITIAL OR header~vkorg = @p_vkorg )
    INTO TABLE @gt_sales_order
    ORDER BY
      header~vbeln,
      item~posnr.

ENDFORM.

************************************************************************
* Form BUILD_FIELD_CATALOG
************************************************************************

FORM build_field_catalog.

  CLEAR gt_fieldcat.

  "Sales Order
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'VBELN'.
  gs_fieldcat-seltext_l = 'Sales Order'.
  gs_fieldcat-seltext_m = 'Order Number'.
  gs_fieldcat-seltext_s = 'Order'.
  gs_fieldcat-col_pos   = 1.
  gs_fieldcat-outputlen = 12.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Item Number
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'POSNR'.
  gs_fieldcat-seltext_l = 'Sales Order Item'.
  gs_fieldcat-seltext_m = 'Item'.
  gs_fieldcat-seltext_s = 'Item'.
  gs_fieldcat-col_pos   = 2.
  gs_fieldcat-outputlen = 8.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Document Type
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'AUART'.
  gs_fieldcat-seltext_l = 'Sales Document Type'.
  gs_fieldcat-seltext_m = 'Document Type'.
  gs_fieldcat-seltext_s = 'Type'.
  gs_fieldcat-col_pos   = 3.
  gs_fieldcat-outputlen = 12.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Document Date
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'AUDAT'.
  gs_fieldcat-seltext_l = 'Sales Document Date'.
  gs_fieldcat-seltext_m = 'Document Date'.
  gs_fieldcat-seltext_s = 'Date'.
  gs_fieldcat-col_pos   = 4.
  gs_fieldcat-outputlen = 12.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Sales Organization
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'VKORG'.
  gs_fieldcat-seltext_l = 'Sales Organization'.
  gs_fieldcat-seltext_m = 'Sales Org.'.
  gs_fieldcat-seltext_s = 'Sales Org.'.
  gs_fieldcat-col_pos   = 5.
  gs_fieldcat-outputlen = 12.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Distribution Channel
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'VTWEG'.
  gs_fieldcat-seltext_l = 'Distribution Channel'.
  gs_fieldcat-seltext_m = 'Distr. Channel'.
  gs_fieldcat-seltext_s = 'Channel'.
  gs_fieldcat-col_pos   = 6.
  gs_fieldcat-outputlen = 12.
  APPEND gs_fieldcat TO gt_fieldcat.

  "Customer
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'KUNNR'.
  gs_fieldcat-seltext_l = 'Customer'.
  gs_fieldcat-seltext_m = 'Customer'.
  gs_fieldcat-seltext_s = '
