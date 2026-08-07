REPORT ZREP_08_SELECTION_SCREEN_LAYOUT.

*---------------------------------------------------------------------*
* Program    : ZREP_08_SELECTION_SCREEN_LAYOUT
* Title      : Selection Screen Layout
* Purpose    : Demonstrates the layout and organization of a
*              Classical ABAP selection screen.
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This report demonstrates how to organize selection-screen elements
* into logical blocks and provide meaningful titles for users.
*
* Topics Covered
* 1. SELECTION-SCREEN BEGIN OF BLOCK
* 2. SELECTION-SCREEN END OF BLOCK
* 3. BLOCK TITLES
* 4. PARAMETERS
* 5. SELECT-OPTIONS
* 6. COMMENT
* 7. SELECTION-SCREEN SKIP
* 8. NO-DISPLAY
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Organize selection-screen fields logically.
* - Create readable selection-screen sections.
* - Use blocks to group related input fields.
* - Improve the usability of Classical Reports.
*---------------------------------------------------------------------*

************************************************************************
* Selection Screen
************************************************************************

SELECTION-SCREEN BEGIN OF BLOCK b1
  WITH FRAME TITLE TEXT-t01.

PARAMETERS:
  p_bukrs TYPE bukrs DEFAULT '1000',
  p_gjahr TYPE gjahr DEFAULT '2026'.

SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2
  WITH FRAME TITLE TEXT-t02.

SELECT-OPTIONS:
  s_budat FOR sy-datum,
  s_bldat FOR sy-datum.

SELECTION-SCREEN END OF BLOCK b2.

SELECTION-SCREEN BEGIN OF BLOCK b3
  WITH FRAME TITLE TEXT-t03.

PARAMETERS:
  p_test AS CHECKBOX DEFAULT abap_false,
  p_det  AS CHECKBOX DEFAULT abap_true.

SELECTION-SCREEN END OF BLOCK b3.

************************************************************************
* Text Symbols
************************************************************************

TEXT-T01 = 'Organizational Information'.
TEXT-T02 = 'Date Selection'.
TEXT-T03 = 'Report Options'.

************************************************************************
* START-OF-SELECTION
************************************************************************

START-OF-SELECTION.

*---------------------------------------------------------------------*
* Report Header
*---------------------------------------------------------------------*

  WRITE: / '============================================================'.
  WRITE: / '           SELECTION SCREEN LAYOUT'.
  WRITE: / '============================================================'.

  SKIP 2.

*---------------------------------------------------------------------*
* Organizational Information
*---------------------------------------------------------------------*

  WRITE: / 'Organizational Information'.
  ULINE.

  WRITE: / 'Company Code :', p_bukrs.
  WRITE: / 'Fiscal Year  :', p_gjahr.

  SKIP 2.

*---------------------------------------------------------------------*
* Date Selection
*---------------------------------------------------------------------*

  WRITE: / 'Date Selection'.
  ULINE.

  WRITE: / 'Posting Date From :', s_budat-low.
  WRITE: / 'Posting Date To   :', s_budat-high.

  WRITE: / 'Document Date From:', s_bldat-low.
  WRITE: / 'Document Date To  :', s_bldat-high.

  SKIP 2.

*---------------------------------------------------------------------*
* Report Options
*---------------------------------------------------------------------*

  WRITE: / 'Report Options'.
  ULINE.

  IF p_test = abap_true.
    WRITE: / 'Test Mode          : Active'.
  ELSE.
    WRITE: / 'Test Mode          : Inactive'.
  ENDIF.

  IF p_det = abap_true.
    WRITE: / 'Detailed Output    : Active'.
  ELSE.
    WRITE: / 'Detailed Output    : Inactive'.
  ENDIF.

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

  WRITE: / 'End of Selection Screen Layout Demonstration'.
