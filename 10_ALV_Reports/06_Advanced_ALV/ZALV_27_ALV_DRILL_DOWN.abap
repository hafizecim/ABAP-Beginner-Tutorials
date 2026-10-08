REPORT ZALV_27_ALV_DRILL_DOWN.

*---------------------------------------------------------------------*
* Program    : ZALV_27_ALV_DRILL_DOWN
* Title      : ALV Drill-Down
* Purpose    : Demonstrates Drill-Down from Header ALV to Item ALV
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* The first ALV displays purchase order header information.
* When the user double-clicks a purchase order number, a second
* ALV displays the related purchase order items.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Classic ALV Grid
* 2. Header and Item Data
* 3. Double-Click Event
* 4. USER_COMMAND Callback
* 5. Drill-Down Reporting
* 6. Secondary ALV Display
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand the drill-down reporting concept.
* - Handle the ALV double-click event.
* - Retrieve detail data based on the selected header record.
* - Display a secondary ALV dynamically.
*---------------------------------------------------------------------*

************************************************************************
* Type Definitions
************************************************************************

TYPES:
  BEGIN OF ty_header,
    ebeln TYPE ekko-ebeln,
    bukrs TYPE ekko-bukrs,
    bedat TYPE ekko-bedat,
    lifnr TYPE ekko-lifnr,
    waers TYPE ekko-waers,
  END OF ty_header.

TYPES:
  BEGIN OF ty_item,
    ebeln TYPE ekpo-ebeln,
    ebelp TYPE ekpo-ebelp,
    matnr TYPE ekpo-matnr,
    txz01 TYPE ekpo-txz01,
    menge TYPE ekpo-menge,
    meins TYPE ekpo-meins,
    netpr TYPE ekpo-netpr,
    peinh TYPE ekpo-peinh,
  END OF ty_item.

************************************************************************
* Data Declarations
************************************************************************

DATA:
  gt_header TYPE STANDARD TABLE OF ty_header,
  gs_header TYPE ty_header.

DATA:
  gt_item TYPE STANDARD TABLE OF ty_item,
  gs_item TYPE ty_item.

DATA:
  gt_header_fieldcat TYPE slis_t_fieldcat_alv,
  gs_header_fieldcat TYPE slis_fieldcat_alv.

DATA:
  gt_item_fieldcat TYPE slis_t_fieldcat_alv,
  gs_item_fieldcat TYPE slis_fieldcat_alv.

DATA:
  gv_selected_ebeln TYPE ekko-ebeln.

************************************************************************
* Selection Screen
************************************************************************

SELECT-OPTIONS:
  s_ebeln FOR gs_header-ebeln,
  s_bedat FOR gs_header-bedat.

PARAMETERS:
  p_bukrs TYPE ekko-bukrs.

************************************************************************
* Start of Selection
************************************************************************

START-OF-SELECTION.

  PERFORM get_header_data.

  IF gt_header IS INITIAL.
    MESSAGE 'No purchase order data found for the selection.' TYPE 'I'.
    RETURN.
  ENDIF.

  PERFORM build_header_field_catalog.
  PERFORM display_header_alv.

************************************************************************
* Form GET_HEADER_DATA
************************************************************************

FORM get_header_data.

  SELECT FROM ekko
    FIELDS
      ebeln,
      bukrs,
      bedat,
      lifnr,
      waers
    WHERE ebeln IN @s_ebeln
      AND bedat IN @s_bedat
      AND ( @p_bukrs IS INITIAL OR bukrs = @p_bukrs )
    INTO TABLE @gt_header
    ORDER BY ebeln.

ENDFORM.

************************************************************************
* Form BUILD_HEADER_FIELD_CATALOG
************************************************************************

FORM build_header_field_catalog.

  CLEAR gt_header_fieldcat.

  "Purchase Order
  CLEAR gs_header_fieldcat.
  gs_header_fieldcat-fieldname = 'EBELN'.
  gs_header_fieldcat-seltext_l = 'Purchase Order'.
  gs_header_fieldcat-seltext_m = 'PO Number'.
  gs_header_fieldcat-seltext_s = 'PO'.
  gs_header_fieldcat-col_pos   = 1.
  gs_header_fieldcat-outputlen = 14.
  gs_header_fieldcat-hotspot   = 'X'.
  APPEND gs_header_fieldcat TO gt_header_fieldcat.

  "Company Code
  CLEAR gs_header_fieldcat.
  gs_header_fieldcat-fieldname = 'BUKRS'.
  gs_header_fieldcat-seltext_l = 'Company Code'.
  gs_header_fieldcat-seltext_m = 'Company'.
  gs_header_fieldcat-seltext_s = 'Company'.
  gs_header_fieldcat-col_pos   = 2.
  gs_header_fieldcat-outputlen = 10.
  APPEND gs_header_fieldcat TO gt_header_fieldcat.

  "Purchase Order Date
  CLEAR gs_header_fieldcat.
  gs_header_fieldcat-fieldname = 'BEDAT'.
  gs_header_fieldcat-seltext_l = 'Purchase Order Date'.
  gs_header_fieldcat-seltext_m = 'PO Date'.
  gs_header_fieldcat-seltext_s = 'Date'.
  gs_header_fieldcat-col_pos   = 3.
  gs_header_fieldcat-outputlen = 12.
  APPEND gs_header_fieldcat TO gt_header_fieldcat.

  "Vendor
  CLEAR gs_header_fieldcat.
  gs_header_fieldcat-fieldname = 'LIFNR'.
  gs_header_fieldcat-seltext_l = 'Vendor'.
  gs_header_fieldcat-seltext_m = 'Vendor'.
  gs_header_fieldcat-seltext_s = 'Vendor'.
  gs_header_fieldcat-col_pos   = 4.
  gs_header_fieldcat-outputlen = 12.
  APPEND gs_header_fieldcat TO gt_header_fieldcat.

  "Currency
  CLEAR gs_header_fieldcat.
  gs_header_fieldcat-fieldname = '
