REPORT ZREP_13_END_OF_SELECTION.

*---------------------------------------------------------------------*
* Program    : ZREP_13_END_OF_SELECTION
* Title      : END-OF-SELECTION Event
* Purpose    : Demonstrates the END-OF-SELECTION event in a
*              Classical ABAP Report.
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* END-OF-SELECTION is an event used after the main report processing
* has been completed.
*
* It can be used for final processing and output operations that should
* take place after START-OF-SELECTION.
*
* Topics Covered
* 1. START-OF-SELECTION
* 2. END-OF-SELECTION
* 3. Main processing
* 4. Final processing
* 5. Report summary
* 6. Event execution sequence
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand when END-OF-SELECTION is triggered.
* - Distinguish START-OF-SELECTION from END-OF-SELECTION.
* - Perform final report processing.
* - Generate a final report summary.
*---------------------------------------------------------------------*

************************************************************************
* Selection Screen
************************************************************************

SELECTION-SCREEN BEGIN OF BLOCK b1
  WITH FRAME TITLE text-001.

PARAMETERS:
  p_amount TYPE p LENGTH 8 DECIMALS 2 DEFAULT '1000.00',
  p_qty    TYPE i DEFAULT 5.

SELECTION-SCREEN END OF BLOCK b1.

************************************************************************
* Text Symbols
************************************************************************

TEXT-001 = 'Report Input'.

************************************************************************
* Global Data
************************************************************************

DATA:
  gv_total TYPE p LENGTH 10 DECIMALS 2.

************************************************************************
* START-OF-SELECTION
************************************************************************
* Main report processing takes place here.

START-OF-SELECTION.

  gv_total = p_amount * p_qty.

*---------------------------------------------------------------------*
* Main Report Output
*---------------------------------------------------------------------*

  WRITE: / '============================================================'.
  WRITE: / '                 MAIN REPORT PROCESSING'.
  WRITE: / '============================================================'.

  SKIP 2.

  WRITE: / 'Input Values'.
  ULINE.

  WRITE: / 'Unit Amount :', p_amount.
  WRITE: / 'Quantity    :', p_qty.

  SKIP.

  WRITE: / 'Calculated Total:', gv_total.

************************************************************************
* END-OF-SELECTION
************************************************************************
* Executed after START-OF-SELECTION processing has finished.

END-OF-SELECTION.

*---------------------------------------------------------------------*
* Final Report Section
*---------------------------------------------------------------------*

  SKIP 2.

  WRITE: / '============================================================'.
  WRITE: / '                    REPORT SUMMARY'.
  WRITE: / '============================================================'.

  SKIP.

  WRITE: / 'Processing completed successfully.'.
  WRITE: / 'Final calculated amount:', gv_total.

  SKIP 2.

*---------------------------------------------------------------------*
* Event Information
*---------------------------------------------------------------------*

  WRITE: / 'Event Processing'.
  ULINE.

  WRITE: / 'START-OF-SELECTION : Main processing completed'.
  WRITE: / 'END-OF-SELECTION   : Final processing completed'.

  SKIP 2.

*---------------------------------------------------------------------*
* Runtime Information
*---------------------------------------------------------------------*

  WRITE: / 'Runtime Information'.
  ULINE.

  WRITE: / 'Program :', sy-repid.
  WRITE: / 'User    :', sy-uname.
  WRITE: / 'Client  :', sy-mandt.
  WRITE: / 'Date    :', sy-datum.
  WRITE: / 'Time    :', sy-uzeit.

  SKIP 2.
  ULINE.

  WRITE: / 'End of END-OF-SELECTION Demonstration'.
