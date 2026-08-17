REPORT ZREP_30_CONTROL_BREAK_PROCESSING.

*---------------------------------------------------------------------*
* Program    : ZREP_30_CONTROL_BREAK_PROCESSING
* Title      : Control Break Processing
* Purpose    : Demonstrates control break processing in a
*              Classical ABAP List Report.
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* Control break processing allows a classical report to perform
* specific actions when the value of a control field changes.
*
* This report demonstrates:
* - AT NEW
* - AT END OF
* - SUM
* - Group headers
* - Group totals
* - Sorted internal table processing
*
* Topics Covered
* 1. Control break processing
* 2. AT NEW
* 3. AT END OF
* 4. SUM
* 5. Internal table sorting
* 6. Group-based reporting
* 7. Classical list totals
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand the purpose of control break processing.
* - Detect the beginning of a new group.
* - Detect the end of a group.
* - Calculate group totals.
* - Build grouped classical reports.
*---------------------------------------------------------------------*

************************************************************************
* Types
************************************************************************

TYPES:
  BEGIN OF ty_sales,
    bukrs    TYPE bukrs,
    category TYPE char20,
    material TYPE char20,
    quantity TYPE i,
    amount   TYPE p LENGTH 10 DECIMALS 2,
  END OF ty_sales.

************************************************************************
* Data
************************************************************************

DATA:
  gt_sales TYPE STANDARD TABLE OF ty_sales,
  gs_sales TYPE ty_sales.

************************************************************************
* START-OF-SELECTION
************************************************************************

START-OF-SELECTION.

  PERFORM prepare_data.
  PERFORM display_report.

************************************************************************
* FORM prepare_data
************************************************************************

FORM prepare_data.

*---------------------------------------------------------------------*
* Company 1000 - Hardware
*---------------------------------------------------------------------*

  APPEND VALUE #(
    bukrs    = '1000'
    category = 'Hardware'
    material = 'Laptop'
    quantity = 10
    amount   = '15000.00'
  ) TO gt_sales.

  APPEND VALUE #(
    bukrs    = '1000'
    category = 'Hardware'
    material = 'Monitor'
    quantity = 20
    amount   = '10000.00'
  ) TO gt_sales.

*---------------------------------------------------------------------*
* Company 1000 - Software
*---------------------------------------------------------------------*

  APPEND VALUE #(
    bukrs    = '1000'
    category = 'Software'
    material = 'License'
    quantity = 15
    amount   = '7500.00'
  ) TO gt_sales.

  APPEND VALUE #(
    bukrs    = '1000'
    category = 'Software'
    material = 'Support'
    quantity = 5
    amount   = '2500.00'
  ) TO gt_sales.

*---------------------------------------------------------------------*
* Company 2000 - Hardware
*---------------------------------------------------------------------*

  APPEND VALUE #(
    bukrs    = '2000'
    category = 'Hardware'
    material = 'Laptop'
    quantity = 8
    amount   = '12000.00'
  ) TO gt_sales.

  APPEND VALUE #(
    bukrs    = '2000'
    category = 'Hardware'
    material = 'Printer'
    quantity = 12
    amount   = '6000.00'
  ) TO gt_sales.

*---------------------------------------------------------------------*
* Company 2000 - Software
*---------------------------------------------------------------------*

  APPEND VALUE #(
    bukrs    = '2000'
    category = 'Software'
    material = 'License'
    quantity = 20
    amount   = '10000.00'
  ) TO gt_sales.

*---------------------------------------------------------------------*
* Control break processing requires sorted data.
*---------------------------------------------------------------------*

  SORT gt_sales BY bukrs category material.

ENDFORM.

************************************************************************
* FORM display_report
************************************************************************

FORM display_report.

*---------------------------------------------------------------------*
* Report Header
*---------------------------------------------------------------------*

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE: / '============================================================'.
  WRITE: / '              CONTROL BREAK PROCESSING'.
  WRITE: / '============================================================'.

  FORMAT RESET.

  SKIP 2.

*---------------------------------------------------------------------*
* Column Header
*---------------------------------------------------------------------*

  POSITION 1.
  WRITE: 'Company'.

  POSITION 15.
  WRITE: 'Category'.

  POSITION 32.
  WRITE: 'Material'.

  POSITION 52.
  WRITE: 'Quantity'.

  POSITION 65.
  WRITE: 'Amount'.

  SKIP 1.

  ULINE.

*---------------------------------------------------------------------*
* Main Loop
*---------------------------------------------------------------------*

  LOOP AT gt_sales INTO gs_sales.

*---------------------------------------------------------------------*
* AT NEW BUKRS
*---------------------------------------------------------------------*
* Triggered when the company code changes.

    AT NEW bukrs.

      FORMAT COLOR COL_HEADING INTENSIFIED ON.

      WRITE: / 'Company:', gs_sales-bukrs.

      FORMAT RESET.

      ULINE.

    ENDAT.

*---------------------------------------------------------------------*
* AT NEW CATEGORY
*---------------------------------------------------------------------*
* Triggered when the category changes within the current company.

    AT NEW category.

      FORMAT COLOR COL_TOTAL.

      WRITE: / 'Category:', gs_sales-category.

      FORMAT RESET.

    ENDAT.

*---------------------------------------------------------------------*
* Detail Line
*---------------------------------------------------------------------*

    POSITION 1.
    WRITE: / gs_sales-bukrs.

    POSITION 15.
    WRITE: gs_sales-category.

    POSITION 32.
    WRITE: gs_sales-material.

    POSITION 52.
    WRITE: gs_sales-quantity.

    POSITION 65.
    WRITE: gs_sales-amount.

*---------------------------------------------------------------------*
* AT END OF CATEGORY
*---------------------------------------------------------------------*
* Triggered when the category group ends.

    AT END OF category.

      SKIP 1.

      FORMAT COLOR COL_TOTAL INTENSIFIED ON.

      WRITE: / 'Category Total:'.

      SUM.

      FORMAT RESET.

      SKIP 1.

    ENDAT.

*---------------------------------------------------------------------*
* AT END OF BUKRS
*---------------------------------------------------------------------*
* Triggered when the company group ends.

    AT END OF bukrs.

      SKIP 1.

      FORMAT COLOR COL_POSITIVE INTENSIFIED ON.

      WRITE: / 'Company Total:'.

      SUM.

      FORMAT RESET.

      SKIP 2.

    ENDAT.

  ENDLOOP.

ENDFORM.
