REPORT ZREP_29_SUM_AND_TOTALS.

*---------------------------------------------------------------------*
* Program    : ZREP_29_SUM_AND_TOTALS
* Title      : SUM and Totals
* Purpose    : Demonstrates SUM and total calculations in a
*              Classical ABAP List Report.
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* The SUM statement is used in classical list processing to calculate
* the total of numeric values displayed in a list.
*
* This report demonstrates:
* - Numeric list output
* - SUM statement
* - Column-based totals
* - Manual total calculation
* - Total line formatting
* - Difference between SUM and manual aggregation
*
* Topics Covered
* 1. SUM
* 2. Numeric list output
* 3. Column totals
* 4. Manual aggregation
* 5. Total formatting
* 6. Classical list calculations
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand the purpose of SUM.
* - Calculate totals in a classical list.
* - Understand column-based SUM behavior.
* - Compare SUM with manual calculations.
*---------------------------------------------------------------------*

************************************************************************
* Global Data
************************************************************************

DATA:
  gv_quantity TYPE i,
  gv_amount   TYPE p LENGTH 10 DECIMALS 2.

************************************************************************
* START-OF-SELECTION
************************************************************************

START-OF-SELECTION.

*---------------------------------------------------------------------*
* Report Header
*---------------------------------------------------------------------*

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE: / '============================================================'.
  WRITE: / '                   SALES TOTAL REPORT'.
  WRITE: / '============================================================'.

  FORMAT RESET.

  SKIP 2.

*---------------------------------------------------------------------*
* Column Header
*---------------------------------------------------------------------*

  POSITION 1.
  WRITE: 'Material'.

  POSITION 20.
  WRITE: 'Description'.

  POSITION 45.
  WRITE: 'Quantity'.

  POSITION 60.
  WRITE: 'Amount'.

  SKIP 1.

  ULINE.

*---------------------------------------------------------------------*
* Data Row 1
*---------------------------------------------------------------------*

  POSITION 1.
  WRITE: 'MAT-001'.

  POSITION 20.
  WRITE: 'Laptop'.

  POSITION 45.
  gv_quantity = 10.
  WRITE: gv_quantity.

  POSITION 60.
  gv_amount = '15000.00'.
  WRITE: gv_amount.

*---------------------------------------------------------------------*
* Data Row 2
*---------------------------------------------------------------------*

  POSITION 1.
  WRITE: / 'MAT-002'.

  POSITION 20.
  WRITE: 'Monitor'.

  POSITION 45.
  gv_quantity = 25.
  WRITE: gv_quantity.

  POSITION 60.
  gv_amount = '12500.00'.
  WRITE: gv_amount.

*---------------------------------------------------------------------*
* Data Row 3
*---------------------------------------------------------------------*

  POSITION 1.
  WRITE: / 'MAT-003'.

  POSITION 20.
  WRITE: 'Keyboard'.

  POSITION 45.
  gv_quantity = 50.
  WRITE: gv_quantity.

  POSITION 60.
  gv_amount = '5000.00'.
  WRITE: gv_amount.

*---------------------------------------------------------------------*
* Data Row 4
*---------------------------------------------------------------------*

  POSITION 1.
  WRITE: / 'MAT-004'.

  POSITION 20.
  WRITE: 'Mouse'.

  POSITION 45.
  gv_quantity = 75.
  WRITE: gv_quantity.

  POSITION 60.
  gv_amount = '3750.00'.
  WRITE: gv_amount.

*---------------------------------------------------------------------*
* Total Line
*---------------------------------------------------------------------*

  SKIP 1.

  ULINE.

  FORMAT COLOR COL_TOTAL INTENSIFIED ON.

  WRITE: / 'TOTAL'.

*---------------------------------------------------------------------*
* SUM statement
*---------------------------------------------------------------------*
* SUM calculates the totals of numeric columns displayed in the
* current list level.

  SUM.

  FORMAT RESET.

  SKIP 2.

*---------------------------------------------------------------------*
* Manual Total Demonstration
*---------------------------------------------------------------------*

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE: / 'MANUAL TOTAL CALCULATION'.

  FORMAT RESET.

  SKIP 1.

  DATA:
    gv_total_quantity TYPE i,
    gv_total_amount   TYPE p LENGTH 10 DECIMALS 2.

  gv_total_quantity = 10 + 25 + 50 + 75.
  gv_total_amount   = '15000.00'
                    + '12500.00'
                    + '5000.00'
                    + '3750.00'.

  WRITE: / 'Total Quantity :', gv_total_quantity.
  WRITE: / 'Total Amount   :', gv_total_amount.

  SKIP 2.

*---------------------------------------------------------------------*
* Final Output
*---------------------------------------------------------------------*

  FORMAT COLOR COL_POSITIVE INTENSIFIED ON.

  WRITE: / 'SUM and total demonstration completed successfully.'.

  FORMAT RESET.
