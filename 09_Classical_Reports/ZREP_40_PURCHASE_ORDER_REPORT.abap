REPORT ZREP_40_PURCHASE_ORDER_REPORT.

*---------------------------------------------------------------------*
* Program    : ZREP_40_PURCHASE_ORDER_REPORT
* Title      : Purchase Order Report
* Purpose    : Demonstrates a Classical Report for Purchase Orders
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This report retrieves purchase order header and item data from EKKO
* and EKPO using an INNER JOIN and displays the result as a classical
* list report.
*
* EKKO contains purchase order header information.
* EKPO contains purchase order item information.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Classical Reports
* 2. Selection-Screen Parameters
* 3. EKKO - Purchase Order Header
* 4. EKPO - Purchase Order Item
* 5. INNER JOIN
* 6. Modern Open SQL
* 7. Internal Tables
* 8. Local Types
* 9. FORMs
* 10. Classical List Output
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand the relationship between EKKO and EKPO.
* - Retrieve header and item data with INNER JOIN.
* - Use selection parameters in Open SQL.
* - Store database results in an internal table.
* - Display transactional data in a classical report.
*---------------------------------------------------------------------*

************************************************************************
* Selection Screen
************************************************************************

PARAMETERS:
  p_bukrs TYPE ekko-bukrs OBLIGATORY,
  p_date  TYPE ekko-bedat DEFAULT sy-datum.

************************************************************************
* Types
************************************************************************

TYPES:
  BEGIN OF ty_purchase_order,
    ebeln TYPE ekko-ebeln,
    bedat TYPE ekko-bedat,
    bsart TYPE ekko-bsart,
    bukrs TYPE ekko-bukrs,
    ekorg TYPE ekko-ekorg,
    ekgrp TYPE ekko-ekgrp,
    lifnr TYPE ekko-lifnr,
    ebelp TYPE ekpo-ebelp,
    matnr TYPE ekpo-matnr,
    txz01 TYPE ekpo-txz01,
    menge TYPE ekpo-menge,
    meins TYPE ekpo-meins,
    netpr TYPE ekpo-netpr,
    peinh TYPE ekpo-peinh,
  END OF ty_purchase_order.

************************************************************************
* Data
************************************************************************

DATA:
  gt_purchase_order TYPE STANDARD TABLE OF ty_purchase_order,
  gs_purchase_order TYPE ty_purchase_order.

************************************************************************
* START-OF-SELECTION
************************************************************************

START-OF-SELECTION.

  PERFORM get_purchase_order_data.
  PERFORM display_report.

************************************************************************
* Forms
************************************************************************

FORM get_purchase_order_data.

  SELECT
    FROM ekko AS header
    INNER JOIN ekpo AS item
      ON item~ebeln = header~ebeln
    FIELDS
      header~ebeln,
      header~bedat,
      header~bsart,
      header~bukrs,
      header~ekorg,
      header~ekgrp,
      header~lifnr,
      item~ebelp,
      item~matnr,
      item~txz01,
      item~menge,
      item~meins,
      item~netpr,
      item~peinh
    WHERE header~bukrs = @p_bukrs
      AND header~bedat = @p_date
    INTO TABLE @gt_purchase_order
    ORDER BY
      header~ebeln,
      item~ebelp.

  IF gt_purchase_order IS INITIAL.

    MESSAGE 'No purchase orders found for the selected criteria.'
      TYPE 'I'.

    RETURN.

  ENDIF.

ENDFORM.

*---------------------------------------------------------------------*
* Display Report
*---------------------------------------------------------------------*

FORM display_report.

  DATA(lv_count) = lines( gt_purchase_order ).

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE:
    / 'PURCHASE ORDER REPORT',
    / 'Company Code:', p_bukrs,
    / 'Document Date:', p_date,
    / 'Total Items:', lv_count.

  FORMAT RESET.

  SKIP 2.

  ULINE.

  POSITION 1.
  WRITE 'PO Number'.

  POSITION 13.
  WRITE 'Item'.

  POSITION 20.
  WRITE 'Vendor'.

  POSITION 32.
  WRITE 'Material'.

  POSITION 50.
  WRITE 'Description'.

  POSITION 83.
  WRITE 'Quantity'.

  POSITION 97.
  WRITE 'Unit'.

  POSITION 104.
  WRITE 'Net Price'.

  POSITION 120.
  WRITE 'Currency'.

  ULINE.

  LOOP AT gt_purchase_order INTO gs_purchase_order.

    WRITE:
      / gs_purchase_order-ebeln.

    POSITION 13.
    WRITE gs_purchase_order-ebelp.

    POSITION 20.
    WRITE gs_purchase_order-lifnr.

    POSITION 32.
    WRITE gs_purchase_order-matnr.

    POSITION 50.
    WRITE gs_purchase_order-txz01.

    POSITION 83.
    WRITE gs_purchase_order-menge.

    POSITION 97.
    WRITE gs_purchase_order-meins.

    POSITION 104.
    WRITE gs_purchase_order-netpr.

    POSITION 120.
    WRITE p_bukrs.

  ENDLOOP.

  SKIP 1.

  ULINE.

  FORMAT COLOR COL_TOTAL INTENSIFIED ON.

  WRITE:
    / 'Total Purchase Order Items:', lv_count.

  FORMAT RESET.

ENDFORM.
