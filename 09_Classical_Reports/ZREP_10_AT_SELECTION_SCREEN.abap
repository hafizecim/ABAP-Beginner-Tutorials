REPORT ZREP_10_AT_SELECTION_SCREEN.

*---------------------------------------------------------------------*
* Program    : ZREP_10_AT_SELECTION_SCREEN
* Title      : AT SELECTION-SCREEN
* Purpose    : Demonstrates input validation using the
*              AT SELECTION-SCREEN event.
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* The AT SELECTION-SCREEN event is triggered when the user attempts
* to execute the report from the selection screen.
*
* It is commonly used to:
* - Validate user input
* - Check dependencies between fields
* - Display error messages
* - Prevent invalid selections
*
* Topics Covered
* 1. AT SELECTION-SCREEN
* 2. Input validation
* 3. Mandatory input checks
* 4. Range validation
* 5. Field dependency validation
* 6. Error messages
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand when AT SELECTION-SCREEN is triggered.
* - Validate individual selection fields.
* - Validate relationships between fields.
* - Prevent report execution when input is invalid.
*---------------------------------------------------------------------*

************************************************************************
* Selection Screen
************************************************************************

SELECTION-SCREEN BEGIN OF BLOCK b1
  WITH FRAME TITLE text-001.

PARAMETERS:
  p_bukrs TYPE bukrs,
  p_gjahr TYPE gjahr,
  p_amount TYPE p LENGTH 8 DECIMALS 2.

SELECTION-SCREEN END OF BLOCK b1.

************************************************************************
* Text Symbols
************************************************************************

TEXT-001 = 'Report Selection'.

************************************************************************
* AT SELECTION-SCREEN
************************************************************************
* This event is triggered when the user presses Execute.
* TYPE 'E' messages return the user to the selection screen.

AT SELECTION-SCREEN.

*---------------------------------------------------------------------*
* 1. Mandatory Field Validation
*---------------------------------------------------------------------*

  IF p_bukrs IS INITIAL.
    MESSAGE 'Company code must be entered.' TYPE 'E'.
  ENDIF.

  IF p_gjahr IS INITIAL.
    MESSAGE 'Fiscal year must be entered.' TYPE 'E'.
  ENDIF.

*---------------------------------------------------------------------*
* 2. Fiscal Year Validation
*---------------------------------------------------------------------*

  IF p_gjahr < '2000' OR p_gjahr > '2100'.
    MESSAGE 'Fiscal year must be between 2000 and 2100.' TYPE 'E'.
  ENDIF.

*---------------------------------------------------------------------*
* 3. Amount Validation
*---------------------------------------------------------------------*

  IF p_amount <= 0.
    MESSAGE 'Amount must be greater than zero.' TYPE 'E'.
  ENDIF.

*---------------------------------------------------------------------*
* 4. Field Dependency Validation
*---------------------------------------------------------------------*

  IF p_bukrs = '1000' AND p_gjahr < '2020'.
    MESSAGE 'Company code 1000 requires fiscal year 2020 or later.'
      TYPE 'E'.
  ENDIF.

************************************************************************
* START-OF-SELECTION
************************************************************************

START-OF-SELECTION.

*---------------------------------------------------------------------*
* Report Header
*---------------------------------------------------------------------*

  WRITE: / '============================================================'.
  WRITE: / '                AT SELECTION-SCREEN'.
  WRITE: / '============================================================'.

  SKIP 2.

*---------------------------------------------------------------------*
* Validated Input
*---------------------------------------------------------------------*

  WRITE: / 'Validated Selection'.
  ULINE.

  WRITE: / 'Company Code :', p_bukrs.
  WRITE: / 'Fiscal Year  :', p_gjahr.
  WRITE: / 'Amount       :', p_amount.

  SKIP 2.

*---------------------------------------------------------------------*
* Validation Result
*---------------------------------------------------------------------*

  WRITE: / 'Validation Result'.
  ULINE.

  WRITE: / 'All selection-screen values are valid.'.
  WRITE: / 'Report execution can continue.'.

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

  WRITE: / 'End of AT SELECTION-SCREEN Demonstration'.
