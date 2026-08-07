REPORT ZREP_06_SELECTION_SCREEN_INTRODUCTION.

*---------------------------------------------------------------------*
* Program    : ZREP_06_SELECTION_SCREEN_INTRODUCTION
* Title      : Selection Screen Introduction
* Purpose    : Demonstrates the basic structure and usage of a
*              selection screen in a Classical ABAP Report.
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This report introduces the ABAP selection screen and demonstrates
* how users can enter input values before report execution.
*
* Topics Covered
* 1. PARAMETERS
* 2. Selection-screen input fields
* 3. Default values
* 4. User input
* 5. START-OF-SELECTION
* 6. Basic validation
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand the purpose of a selection screen.
* - Define input parameters.
* - Provide default values.
* - Read user input during report execution.
* - Perform basic input validation.
*---------------------------------------------------------------------*

************************************************************************
* Selection Screen
************************************************************************

PARAMETERS:
  p_name TYPE string DEFAULT 'Hafize',
  p_city TYPE string DEFAULT 'Konya',
  p_year TYPE i      DEFAULT 2026.

************************************************************************
* START-OF-SELECTION
************************************************************************

START-OF-SELECTION.

*---------------------------------------------------------------------*
* Basic Validation
*---------------------------------------------------------------------*

  IF p_name IS INITIAL.
    MESSAGE 'Name cannot be empty.' TYPE 'E'.
  ENDIF.

  IF p_city IS INITIAL.
    MESSAGE 'City cannot be empty.' TYPE 'E'.
  ENDIF.

  IF p_year < 2000 OR p_year > 2100.
    MESSAGE 'Please enter a valid year between 2000 and 2100.' TYPE 'E'.
  ENDIF.

*---------------------------------------------------------------------*
* Report Header
*---------------------------------------------------------------------*

  WRITE: / '============================================================'.
  WRITE: / '          SELECTION SCREEN INTRODUCTION'.
  WRITE: / '============================================================'.

  SKIP 2.

*---------------------------------------------------------------------*
* User Input
*---------------------------------------------------------------------*

  WRITE: / 'User Input'.
  ULINE.

  WRITE: / 'Name :', p_name.
  WRITE: / 'City :', p_city.
  WRITE: / 'Year :', p_year.

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

*---------------------------------------------------------------------*
* Execution Result
*---------------------------------------------------------------------*

  WRITE: / 'Execution Result'.
  ULINE.

  WRITE: / 'The selection screen input was successfully received.'.
  WRITE: / 'The report is now processing the selected values.'.

************************************************************************
* END-OF-SELECTION
************************************************************************

END-OF-SELECTION.

  SKIP 2.
  ULINE.

  WRITE: / 'End of Selection Screen Demonstration'.
