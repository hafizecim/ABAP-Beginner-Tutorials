REPORT ZREP_33_REPORT_WITH_INTERNAL_TABLES.

*---------------------------------------------------------------------*
* Program    : ZREP_33_REPORT_WITH_INTERNAL_TABLES
* Title      : Report with Internal Tables
* Purpose    : Demonstrates the use of internal tables as the data
*              source of a Classical ABAP List Report.
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* Internal tables are temporary data structures used to store and
* process multiple records during ABAP program execution.
*
* This report demonstrates:
* - Local type definition
* - Internal table declaration
* - Work area declaration
* - APPEND
* - SORT
* - LOOP AT
* - Field access
* - Classical list output
* - Simple report statistics
*
* Topics Covered
* 1. Internal tables
* 2. Work areas
* 3. APPEND
* 4. SORT
* 5. LOOP AT
* 6. WRITE
* 7. List formatting
* 8. Record counting
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand how an internal table can feed a classical report.
* - Populate an internal table.
* - Process internal table records with LOOP AT.
* - Sort report data before displaying it.
* - Separate data preparation from report output.
*---------------------------------------------------------------------*

************************************************************************
* Type Definition
************************************************************************

TYPES:
  BEGIN OF ty_sales,
    bukrs    TYPE bukrs,
    customer TYPE char20,
    material TYPE char20,
    quantity TYPE i,
    amount   TYPE p LENGTH 10 DECIMALS 2,
  END OF ty_sales.

************************************************************************
* Internal Table and Work Area
************************************************************************

DATA:
  gt_sales TYPE STANDARD TABLE OF ty_sales,
  gs_sales TYPE ty_sales.

************************************************************************
* Report Statistics
************************************************************************

DATA:
  gv_record_count  TYPE i,
  gv_total_quantity TYPE i,
  gv_total_amount   TYPE p LENGTH 12 DECIMALS 2.

************************************************************************
* START-OF-SELECTION
************************************************************************

START-OF-SELECTION.

  PERFORM prepare_data.
  PERFORM calculate_statistics.
  PERFORM display_report.

************************************************************************
* FORM prepare_data
************************************************************************
* Creates the report data in an internal table.

FORM prepare_data.

*---------------------------------------------------------------------*
* Sales Record 1
*---------------------------------------------------------------------*

  APPEND VALUE #(
    bukrs    = '1000'
    customer = 'Customer A'
    material = 'Laptop'
    quantity = 10
    amount   = '15000.00'
  ) TO gt_sales.

*---------------------------------------------------------------------*
* Sales Record 2
*---------------------------------------------------------------------*

  APPEND VALUE #(
    bukrs    = '1000'
    customer = 'Customer B'
    material = 'Monitor'
    quantity = 20
    amount   = '10000.00'
  ) TO gt_sales.

*---------------------------------------------------------------------*
* Sales Record 3
*---------------------------------------------------------------------*

  APPEND VALUE #(
    bukrs    = '2000'
    customer = 'Customer C'
    material = 'Printer'
    quantity = 15
    amount   = '7500.00'
  ) TO gt_sales.

*---------------------------------------------------------------------*
* Sales Record 4
*---------------------------------------------------------------------*

  APPEND VALUE #(
    bukrs    = '2000'
    customer = 'Customer D'
    material = 'Keyboard'
    quantity = 30
    amount   = '6000.00'
  ) TO gt_sales.

*---------------------------------------------------------------------*
* Sales Record 5
*---------------------------------------------------------------------*

  APPEND VALUE #(
    bukrs    = '3000'
    customer = 'Customer E'
    material = 'Mouse'
    quantity = 40
    amount   = '4000.00'
  ) TO gt_sales.

*---------------------------------------------------------------------*
* Sort the internal table before reporting.
*---------------------------------------------------------------------*

  SORT gt_sales BY bukrs customer material.

ENDFORM.

************************************************************************
* FORM calculate_statistics
************************************************************************
* Calculates basic report statistics.

FORM calculate_statistics.

  CLEAR:
    gv_record_count,
    gv_total_quantity,
    gv_total_amount.

  LOOP AT gt_sales INTO gs_sales.

    gv_record_count  = gv_record_count + 1.
    gv_total_quantity = gv_total_quantity + gs_sales-quantity.
    gv_total_amount   = gv_total_amount + gs_sales-amount.

  ENDLOOP.

ENDFORM.

************************************************************************
* FORM display_report
************************************************************************
* Displays the internal table contents as a classical list.

FORM display_report.

*---------------------------------------------------------------------*
* Report Header
*---------------------------------------------------------------------*

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE: / '============================================================'.
  WRITE: / '              REPORT WITH INTERNAL TABLES'.
  WRITE: / '============================================================'.

  FORMAT RESET.

  SKIP 2.

*---------------------------------------------------------------------*
* Report Information
*---------------------------------------------------------------------*

  WRITE: / 'Program       :', sy-repid.
  WRITE: / 'Report Date   :', sy-datum.
  WRITE: / 'Report Time   :', sy-uzeit.
  WRITE: / 'Record Count  :', gv_record_count.

  SKIP 2.

*---------------------------------------------------------------------*
* Column Header
*---------------------------------------------------------------------*

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  POSITION 1.
  WRITE: 'Company'.

  POSITION 15.
  WRITE: 'Customer'.

  POSITION 32.
  WRITE: 'Material'.

  POSITION 52.
  WRITE: 'Quantity'.

  POSITION 65.
  WRITE: 'Amount'.

  FORMAT RESET.

  SKIP 1.

  ULINE.

*---------------------------------------------------------------------*
* Internal Table Processing
*---------------------------------------------------------------------*

  LOOP AT gt_sales INTO gs_sales.

    POSITION 1.
    WRITE: / gs_sales-bukrs.

    POSITION 15.
    WRITE: gs_sales-customer.

    POSITION 32.
    WRITE: gs_sales-material.

    POSITION 52.
    WRITE: gs_sales-quantity.

    POSITION 65.
    WRITE: gs_sales-amount.

  ENDLOOP.

*---------------------------------------------------------------------*
* Total Section
*---------------------------------------------------------------------*

  SKIP 1.

  ULINE.

  FORMAT COLOR COL_TOTAL INTENSIFIED ON.

  WRITE: / 'TOTAL QUANTITY :', gv_total_quantity.
  WRITE: / 'TOTAL AMOUNT   :', gv_total_amount.

  FORMAT RESET.

  SKIP 2.

*---------------------------------------------------------------------*
* Final Message
*---------------------------------------------------------------------*

  FORMAT COLOR COL_POSITIVE INTENSIFIED ON.

  WRITE: / 'Report generated successfully from internal table data.'.

  FORMAT RESET.

ENDFORM.
