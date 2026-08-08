REPORT ZREP_11_INITIALIZATION_EVENT.

*---------------------------------------------------------------------*
* Program    : ZREP_11_INITIALIZATION_EVENT
* Title      : INITIALIZATION Event
* Purpose    : Demonstrates the INITIALIZATION event in a
*              Classical ABAP Report.
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* The INITIALIZATION event is executed before the selection screen
* is displayed.
*
* It is commonly used to:
* - Set default values
* - Calculate initial values
* - Prepare selection-screen fields
* - Set initial program parameters
*
* Topics Covered
* 1. INITIALIZATION
* 2. Default values
* 3. Dynamic default values
* 4. System fields in initialization
* 5. Selection-screen preparation
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand when INITIALIZATION is executed.
* - Assign default values before the selection screen is displayed.
* - Use system fields to calculate dynamic defaults.
* - Understand the difference between static and dynamic defaults.
*---------------------------------------------------------------------*

************************************************************************
* Selection Screen
************************************************************************

SELECTION-SCREEN BEGIN OF BLOCK b1
  WITH FRAME TITLE text-001.

PARAMETERS:
  p_bukrs TYPE bukrs,
  p_gjahr TYPE gjahr,
  p_user  TYPE syuname.

SELECTION-SCREEN END OF BLOCK b1.

************************************************************************
* Text Symbols
************************************************************************

TEXT-001 = 'Initial Selection Values'.

************************************************************************
* INITIALIZATION
************************************************************************
* Executed before the selection screen is displayed.

INITIALIZATION.

*---------------------------------------------------------------------*
* Static Default Value
*---------------------------------------------------------------------*

  p_bukrs = '1000'.

*---------------------------------------------------------------------*
* Dynamic Default Value
*---------------------------------------------------------------------*
* The current year is obtained from the system date.

  p_gjahr = sy-datum(4).

*---------------------------------------------------------------------*
* Current User
*---------------------------------------------------------------------*
* The current SAP user is obtained from SY-UNAME.

  p_user = sy-uname.

************************************************************************
* START-OF-SELECTION
************************************************************************

START-OF-SELECTION.

*---------------------------------------------------------------------*
* Report Header
*---------------------------------------------------------------------*

  WRITE: / '============================================================'.
  WRITE: / '                 INITIALIZATION EVENT'.
  WRITE: / '============================================================'.

  SKIP 2.

*---------------------------------------------------------------------*
* Initial Values
*---------------------------------------------------------------------*

  WRITE: / 'Initialized Selection Values'.
  ULINE.

  WRITE: / 'Company Code :', p_bukrs.
  WRITE: / 'Fiscal Year  :', p_gjahr.
  WRITE: / 'User         :', p_user.

  SKIP 2.

*---------------------------------------------------------------------*
* Initialization Information
*---------------------------------------------------------------------*

  WRITE: / 'Initialization Information'.
  ULINE.

  WRITE: / 'Current Date :', sy-datum.
  WRITE: / 'Current Time :', sy-uzeit.
  WRITE: / 'Current User :', sy-uname.
  WRITE: / 'Program      :', sy-repid.

  SKIP 2.

*---------------------------------------------------------------------*
* Execution Result
*---------------------------------------------------------------------*

  WRITE: / 'Execution Result'.
  ULINE.

  WRITE: / 'Selection-screen default values were initialized'.
  WRITE: / 'before the selection screen was displayed.'.

************************************************************************
* END-OF-SELECTION
************************************************************************

END-OF-SELECTION.

  SKIP 2.
  ULINE.

  WRITE: / 'End of INITIALIZATION Event Demonstration'.
