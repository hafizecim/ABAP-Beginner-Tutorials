REPORT ZALV_06_ALV_DYNAMIC_FIELD_CATALOG.

*---------------------------------------------------------------------*
* Program    : ZALV_06_ALV_DYNAMIC_FIELD_CATALOG
* Title      : Dynamic Field Catalog in ALV
* Purpose    : Demonstrates dynamic Field Catalog generation
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This report demonstrates how to generate an ALV Field Catalog
* dynamically from an internal table structure.
*
* The Field Catalog is created using:
*   REUSE_ALV_FIELDCATALOG_MERGE
*
* The generated Field Catalog is then customized for selected fields.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Dynamic Field Catalog
* 2. REUSE_ALV_FIELDCATALOG_MERGE
* 3. Internal Table Structure
* 4. Field Catalog Customization
* 5. Column Position
* 6. Column Text
* 7. Output Length
* 8. Summation
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand dynamic Field Catalog generation.
* - Learn how to generate Field Catalog from an internal table.
* - Customize dynamically generated Field Catalog entries.
* - Display the result using REUSE_ALV_GRID_DISPLAY.
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
    ebeln TYPE ekko-ebeln,
    ebelp TYPE ekpo-ebelp,
    bukrs TYPE ekko-bukrs,
    bedat TYPE ekko-bedat,
    lifnr TYPE ekko-lifnr,
    matnr TYPE ekpo-matnr,
    txz01 TYPE ekpo-txz01,
    menge TYPE ekpo-menge,
    meins TYPE ekpo-meins,
    netpr TYPE ekpo-netpr,
    peinh TYPE ekpo-peinh,
    waers TYPE ekko-waers,
  END OF ty_purchase_order.

************************************************************************
* Data
************************************************************************

DATA:
  gt_purchase_order TYPE STANDARD TABLE OF ty_purchase_order,
  gs_purchase_order TYPE ty_purchase_order,

  gt_fieldcat       TYPE slis_t_fieldcat_alv,
  gs_fieldcat       TYPE slis_fieldcat_alv.

************************************************************************
* Start of Selection
************************************************************************

START-OF-SELECTION.

  PERFORM get_purchase_order_data.

  IF gt_purchase_order IS INITIAL.
    MESSAGE 'No purchase order data found.' TYPE 'I'.
    RETURN.
  ENDIF.

  PERFORM build_dynamic_field_catalog.
  PERFORM customize_field_catalog.
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
    WHERE header~bukrs = @p_bukrs
      AND header~bedat = @p_bedat
    INTO TABLE @gt_purchase_order
    ORDER BY header~ebeln,
             item~ebelp.

ENDFORM.

************************************************************************
* Form BUILD_DYNAMIC_FIELD_CATALOG
************************************************************************

FORM build_dynamic_field_catalog.

  DATA:
    lv_structure_name TYPE dd02l-tabname.

  lv_structure_name = 'TY_PURCHASE_ORDER'.

  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_program_name     = sy-repid
      i_internal_tabname = 'GT_PURCHASE_ORDER'
      i_inclname         = sy-repid
    CHANGING
      ct_fieldcat        = gt_fieldcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

  IF sy-subrc <> 0.
    MESSAGE 'Field Catalog could not be generated.' TYPE 'E'.
  ENDIF.

ENDFORM.

************************************************************************
* Form CUSTOMIZE_FIELD_CATALOG
************************************************************************

FORM customize_field_catalog.

  LOOP AT gt_fieldcat INTO gs_fieldcat.

    CASE gs_fieldcat-fieldname.

      WHEN 'EBELN'.

        gs_fieldcat-seltext_l = 'Purchase Order'.
        gs_fieldcat-seltext_m = 'PO Number'.
        gs_fieldcat-seltext_s = 'PO'.
        gs_fieldcat-col_pos   = 1.
        gs_fieldcat-outputlen = 12.

      WHEN 'EBELP'.

        gs_fieldcat-seltext_l = 'PO Item'.
        gs_fieldcat-seltext_m = 'Item'.
        gs_fieldcat-seltext_s = 'Item'.
        gs_fieldcat-col_pos   = 2.
        gs_fieldcat-outputlen = 6.

      WHEN 'BUKRS'.

        gs_fieldcat-seltext_l = 'Company Code'.
        gs_fieldcat-seltext_m = 'Company'.
        gs_fieldcat-seltext_s = 'Company'.
        gs_fieldcat-col_pos   = 3.
        gs_fieldcat-outputlen = 10.

      WHEN 'BEDAT'.

        gs_fieldcat-seltext_l = 'Purchase Order Date'.
        gs_fieldcat-seltext_m = 'PO Date'.
        gs_fieldcat-seltext_s = 'Date'.
        gs_fieldcat-col_pos   = 4.
        gs_fieldcat-outputlen = 12.

      WHEN 'LIFNR'.

        gs_fieldcat-seltext_l = 'Vendor Number'.
        gs_fieldcat-seltext_m = 'Vendor'.
        gs_fieldcat-seltext_s = 'Vendor'.
        gs_fieldcat-col_pos   = 5.
        gs_fieldcat-outputlen = 12.

      WHEN 'MATNR'.

        gs_fieldcat-seltext_l = 'Material Number'.
        gs_fieldcat-seltext_m = 'Material'.
        gs_fieldcat-seltext_s = 'Material'.
        gs_fieldcat-col_pos   = 6.
        gs_fieldcat-outputlen = 18.

      WHEN 'TXZ01'.

        gs_fieldcat-seltext_l = 'Material Description'.
        gs_fieldcat-seltext_m = 'Description'.
        gs_fieldcat-seltext_s = 'Description'.
        gs_fieldcat-col_pos   = 7.
        gs_fieldcat-outputlen = 30.

      WHEN 'MENGE'.

        gs_fieldcat-seltext_l = 'Order Quantity'.
        gs_fieldcat-seltext_m = 'Quantity'.
        gs_fieldcat-seltext_s = 'Qty'.
        gs_fieldcat-col_pos   = 8.
        gs_fieldcat-outputlen = 12.
        gs_fieldcat-do_sum    = 'X'.
        gs_fieldcat-just      = 'R'.

      WHEN 'MEINS'.

        gs_fieldcat-seltext_l = 'Unit of Measure'.
        gs_fieldcat-seltext_m = 'Unit'.
        gs_fieldcat-seltext_s = 'Unit'.
        gs_fieldcat-col_pos   = 9.
        gs_fieldcat-outputlen = 8.

      WHEN 'NETPR'.

        gs_fieldcat-seltext_l = 'Net Price'.
        gs_fieldcat-seltext_m = 'Net Price'.
        gs_fieldcat-seltext_s = 'Price'.
        gs_fieldcat-col_pos   = 10.
        gs_fieldcat-outputlen = 14.
        gs_fieldcat-do_sum    = 'X'.
        gs_fieldcat-just      = 'R'.

      WHEN 'PEINH'.

        gs_fieldcat-seltext_l = 'Price Unit'.
        gs_fieldcat-seltext_m = 'Price Unit'.
        gs_fieldcat-seltext_s = 'Unit'.
        gs_fieldcat-col_pos   = 11.
        gs_fieldcat-outputlen = 10.
        gs_fieldcat-no_out    = 'X'.

      WHEN 'WAERS'.

        gs_fieldcat-seltext_l = 'Currency'.
        gs_fieldcat-seltext_m = 'Currency'.
        gs_fieldcat-seltext_s = 'Curr.'.
        gs_fieldcat-col_pos   = 12.
        gs_fieldcat-outputlen = 8.

    ENDCASE.

    MODIFY gt_fieldcat FROM gs_fieldcat.

  ENDLOOP.

ENDFORM.

************************************************************************
* Form DISPLAY_ALV
************************************************************************

FORM display_alv.

  DATA:
    lv_title TYPE lvc_title.

  lv_title = 'Purchase Order - Dynamic Field Catalog'.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
      i_grid_title       = lv_title
      i_save             = 'A'
      it_fieldcat        = gt_fieldcat
    TABLES
      t_outtab           = gt_purchase_order
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.

  IF sy-subrc <> 0.
    MESSAGE 'ALV display error occurred.' TYPE 'E'.
  ENDIF.

ENDFORM.
