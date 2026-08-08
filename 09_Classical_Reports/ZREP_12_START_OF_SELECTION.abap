REPORT ZREP_12_START_OF_SELECTION.

*---------------------------------------------------------------------*
* Program    : ZREP_12_START_OF_SELECTION
* Title      : START-OF-SELECTION Event
* Purpose    : Demonstrates the START-OF-SELECTION event in a
*              Classical ABAP Report.
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* START-OF-SELECTION is the main processing event of an executable
* ABAP report.
*
* It is executed after the selection screen has been processed
* successfully and is commonly used for the main business logic.
*
* Topics Covered
* 1. START-OF-SELECTION
* 2. Selection-screen input
* 3. Main report processing
* 4. Conditional processing
* 5. Basic calculations
* 6. Report output
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand the purpose of START-OF-SELECTION.
* - Process selection-screen values.
* - Separate input from business logic.
* - Perform calculations during report processing.
* - Generate the main report output.
*---------------------------------------------------------------------*

************************************************************************
* Selection Screen
************************************************************************

SELECTION-SCREEN BEGIN OF BLOCK b1
  WITH FRAME TITLE text-001.

PARAMETERS:
  p_name   TYPE string,
  p_amount TYPE p LENGTH 8 DECIMALS 2,
  p_qty    TYPE i.

SELECTION-SCREEN END OF BLOCK b1.

************************************************************************
* Text Symbols
************************************************************************

TEXT-001 = 'Report Input'.

************************************************************************
* START-OF-SELECTION
************************************************************************
* This is the main processing event of the report.

START-OF-SELECTION.

*---------------------------------------------------------------------*
* Input Validation
*---------------------------------------------------------------------*

  IF p_name IS INITIAL.
    MESSAGE 'Name must be entered.' TYPE 'E'.
  ENDIF.

  IF p_amount <= 0.
    MESSAGE 'Amount must be greater than zero.' TYPE 'E'.
  ENDIF.

  IF p_qty <= 0.
    MESSAGE 'Quantity must be greater than zero.' TYPE 'E'.
  ENDIF.

*---------------------------------------------------------------------*
* Calculation
*---------------------------------------------------------------------*

  DATA(lv_total) = p_amount * p_qty.

*---------------------------------------------------------------------*
* Report Header
*---------------------------------------------------------------------*

  WRITE: / '============================================================'.
  WRITE: / '               START-OF-SELECTION EVENT'.
  WRITE: / '============================================================'.

  SKIP 2.

*---------------------------------------------------------------------*
* Input Values
*---------------------------------------------------------------------*

  WRITE: / 'Input Values'.
  ULINE.

  WRITE: / 'Name       :', p_name.
  WRITE: / 'Unit Amount:', p_amount.
  WRITE: / 'Quantity   :', p_qty.

  SKIP 2.

*---------------------------------------------------------------------*
* Processing Result
*---------------------------------------------------------------------*

  WRITE: / 'Processing Result'.
  ULINE.

  WRITE: / 'Total Amount:', lv_total.

  SKIP 2.

*---------------------------------------------------------------------*
* Processing Information
*---------------------------------------------------------------------*

  WRITE: / 'Processing Information'.
  ULINE.

  WRITE: / 'The selection-screen input was processed successfully.'.
  WRITE: / 'The main report logic is executed in START-OF-SELECTION.'.

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

************************************************************************
* END-OF-SELECTION
************************************************************************

END-OF-SELECTION.

  SKIP 2.
  ULINE.

  WRITE: / 'End of START-OF-SELECTION Demonstration'.
