REPORT ZALV_29_ALV_PURCHASE_ORDER.

*---------------------------------------------------------------------*
* Program    : ZALV_29_ALV_PURCHASE_ORDER
* Title      : Purchase Order ALV Report
* Purpose    : Display purchase order header and item details
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* Retrieves purchase order data from EKKO and EKPO and displays the
* combined results in a classic ALV Grid.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Joining Header and Item Tables
* 2. Selection Options
* 3. Manual Field Catalog
* 4. ALV Sorting
* 5. Classic ALV Grid Display
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* Understand how to combine purchasing header and item data in a
* single output structure and present it using classic ALV.
*---------------------------------------------------------------------*

************************************************************************
* Types
************************************************************************
TYPES:
  BEGIN OF ty_purchase_order,
    ebeln TYPE ekko-ebeln,
    ebelp TYPE ekpo-ebelp,
    bukrs TYPE ekko-bukrs,
    bsart TYPE ekko-bsart,
    bedat TYPE ekko-bedat,
    lifnr TYPE ekko-lifnr,
    ekorg TYPE ekko-ekorg,
    ekgrp TYPE ekko-ekgrp,
    waers TYPE ekko-waers,
    matnr TYPE ekpo-matnr,
    txz01 TYPE ekpo-txz01,
    menge TYPE ekpo-menge,
    meins TYPE ekpo-meins,
    netpr TYPE ekpo-netpr,
    peinh TYPE ekpo-peinh,
    netwr TYPE ekpo-netwr,
  END OF ty_purchase_order.

************************************************************************
* Data
************************************************************************
DATA:
  gt_purchase_order TYPE STANDARD TABLE OF ty_purchase_order,
  gs_purchase_order TYPE ty_purchase_order,
  gt_fieldcat       TYPE slis_t_fieldcat_alv,
  gs_fieldcat       TYPE slis_fieldcat_alv,
  gt_sort           TYPE slis_t_sortinfo_alv,
  gs_sort           TYPE slis_sortinfo_alv,
  gs_layout         TYPE slis_layout_alv.

************************************************************************
* Selection Screen
************************************************************************
SELECT-OPTIONS:
  s_ebeln FOR gs_purchase_order-ebeln,
  s_bedat FOR gs_purchase_order-bedat,
  s_bukrs FOR gs_purchase_order-bukrs.

************************************************************************
* Main Processing
************************************************************************
START-OF-SELECTION.

  PERFORM get_purchase_order_data.

  IF gt_purchase_order IS INITIAL.
    MESSAGE 'No purchase order data found for the selection.'
      TYPE 'S' DISPLAY LIKE 'E'.
    RETURN.
  ENDIF.

  PERFORM build_field_catalog.
  PERFORM build_sort.
  PERFORM build_layout.
  PERFORM display_alv.

************************************************************************
* Form GET_PURCHASE_ORDER_DATA
************************************************************************
FORM get_purchase_order_data.

  SELECT
    h~ebeln,
    i~ebelp,
    h~bukrs,
    h~bsart,
    h~bedat,
    h~lifnr,
    h~ekorg,
    h~ekgrp,
    h~waers,
    i~matnr,
    i~txz01,
    i~menge,
    i~meins,
    i~netpr,
    i~peinh,
    i~netwr
    FROM ekko AS h
    INNER JOIN ekpo AS i
      ON i~ebeln = h~ebeln
    WHERE h~ebeln IN @s_ebeln
      AND h~bedat IN @s_bedat
      AND h~bukrs IN @s_bukrs
    ORDER BY h~ebeln, i~ebelp
    INTO TABLE @gt_purchase_order.

ENDFORM.

************************************************************************
* Form BUILD_FIELD_CATALOG
************************************************************************
FORM build_field_catalog.

  CLEAR gt_fieldcat.

  PERFORM add_fieldcat USING 'EBELN' 'Purchase Order' 10 'X'.
  PERFORM add_fieldcat USING 'EBELP' 'Item'            5 space.
  PERFORM add_fieldcat USING 'BUKRS' 'Company Code'    8 space.
  PERFORM add_fieldcat USING 'BSART' 'Document Type'   8 space.
  PERFORM add_fieldcat USING 'BEDAT' 'Document Date'   10 space.
  PERFORM add_fieldcat USING 'LIFNR' 'Vendor'          10 space.
  PERFORM add_fieldcat USING 'EKORG' 'Purch. Org.'      8 space.
  PERFORM add_fieldcat USING 'EKGRP' 'Purch. Group'     8 space.
  PERFORM add_fieldcat USING 'WAERS' 'Currency'         5 space.
  PERFORM add_fieldcat USING 'MATNR' 'Material'        18 space.
  PERFORM add_fieldcat USING 'TXZ01' 'Short Text'      30 space.
  PERFORM add_fieldcat USING 'MENGE' 'Quantity'        13 space.
  PERFORM add_fieldcat USING 'MEINS' 'Unit'             5 space.
  PERFORM add_fieldcat USING 'NETPR' 'Net Price'       13 space.
  PERFORM add_fieldcat USING 'PEINH' 'Price Unit'       8 space.
  PERFORM add_fieldcat USING 'NETWR' 'Net Value'       15 space.

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
FORM build
