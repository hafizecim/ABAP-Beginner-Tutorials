REPORT ZREP_32_AT_FIRST_AND_AT_LAST.

*---------------------------------------------------------------------*
* Program    : ZREP_32_AT_FIRST_AND_AT_LAST
* Title      : AT FIRST and AT LAST
* Purpose    : Demonstrates AT FIRST and AT LAST control break
*              processing in a Classical ABAP List Report.
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* AT FIRST is triggered before processing the first record of a LOOP.
*
* AT LAST is triggered when the last record of a LOOP is processed.
*
* These statements are useful for:
* - Report-level headers
* - Initial information
* - Final totals
* - Report-level summaries
* - End-of-report processing
*
* Topics Covered
* 1. AT FIRST
* 2. AT LAST
* 3. LOOP AT
* 4. SUM
* 5. Report-level totals
* 6. Control break processing
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand when AT FIRST is triggered.
* - Understand when AT LAST is triggered.
* - Use AT FIRST for initial processing.
* - Use AT LAST for final processing.
* - Combine AT LAST with SUM for a grand total.
*---------------------------------------------------------------------*

************************************************************************
* Types
************************************************************************

TYPES:
  BEGIN OF ty_sales,
    bukrs    TYPE bukrs,
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
* Sample Data
*---------------------------------------------------------------------*

  APPEND VALUE #(
    bukrs    = '1000'
    material = 'Laptop'
    quantity = 10
    amount   = '15000.00'
  ) TO gt_sales.

  APPEND VALUE #(
    bukrs    = '1000'
    material = 'Monitor'
    quantity = 20
    amount   = '10000.00'
  ) TO gt_sales.

  APPEND VALUE #(
    bukrs    = '2000'
    material = 'Printer'
    quantity = 15
    amount   = '7500.00'
  ) TO gt_sales.

  APPEND VALUE #(
    bukrs    = '2000'
    material = 'Keyboard'
    quantity = 30
    amount   = '6000.00'
  ) TO gt_sales.

  APPEND VALUE #(
    bukrs    = '3000'
    material = 'Mouse'
    quantity = 40
    amount   = '4000.00'
  ) TO gt_sales.

*---------------------------------------------------------------------*
* Sort data for predictable report output.
*---------------------------------------------------------------------*

  SORT gt_sales BY bukrs material.

ENDFORM.

************************************************************************
* FORM display_report
************************************************************************

FORM display_report.

*---------------------------------------------------------------------*
* Main Loop
*---------------------------------------------------------------------*

  LOOP AT gt_sales INTO gs_sales.

*---------------------------------------------------------------------*
* AT FIRST
*---------------------------------------------------------------------*
* Executed before the first loop record is processed.

    AT FIRST.

      FORMAT COLOR COL_HEADING INTENSIFIED ON.

      WRITE: / '============================================================'.
      WRITE: / '                  SALES REPORT'.
      WRITE: / '============================================================'.

      FORMAT RESET.

      SKIP 1.

      WRITE: / 'Report Program :', sy-repid.
      WRITE: / 'Report Date    :', sy-datum.
      WRITE: / 'Report Time    :', sy-uzeit.

      SKIP 2.

      POSITION 1.
      WRITE: 'Company'.

      POSITION 15.
      WRITE: 'Material'.

      POSITION 40.
      WRITE: 'Quantity'.

      POSITION 55.
      WRITE: 'Amount'.

      SKIP 1.

      ULINE.

    ENDAT.

*---------------------------------------------------------------------*
* Detail Line
*---------------------------------------------------------------------*

    POSITION 1.
    WRITE: / gs_sales-bukrs.

    POSITION 15.
    WRITE: gs_sales-material.

    POSITION 40.
    WRITE: gs_sales-quantity.

    POSITION 55.
    WRITE: gs_sales-amount.

*---------------------------------------------------------------------*
* AT LAST
*---------------------------------------------------------------------*
* Executed when the last loop record is processed.

    AT LAST.

      SKIP 2.

      ULINE.

      FORMAT COLOR COL_TOTAL INTENSIFIED ON.

      WRITE: / 'GRAND TOTAL'.

      SUM.

      FORMAT RESET.

      SKIP 2.

      FORMAT COLOR COL_POSITIVE INTENSIFIED ON.

      WRITE: / 'Report processing completed successfully.'.

      FORMAT RESET.

    ENDAT.

  ENDLOOP.

ENDFORM.
