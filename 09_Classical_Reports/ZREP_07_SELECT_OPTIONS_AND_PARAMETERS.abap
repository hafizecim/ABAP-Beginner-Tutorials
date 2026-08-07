REPORT ZREP_07_SELECT_OPTIONS_AND_PARAMETERS.

*---------------------------------------------------------------------*
* Program    : ZREP_07_SELECT_OPTIONS_AND_PARAMETERS
* Title      : SELECT-OPTIONS and PARAMETERS
* Purpose    : Demonstrates PARAMETERS and SELECT-OPTIONS in
*              Classical ABAP Reports.
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This report demonstrates how PARAMETERS and SELECT-OPTIONS are
* defined and processed on the selection screen.
*
* PARAMETERS is generally used when the user should enter one value.
*
* SELECT-OPTIONS is used when the user may enter:
* - A single value
* - Multiple values
* - A range
* - Multiple ranges
* - Exclusion conditions
*
* Topics Covered
* 1. PARAMETERS
* 2. SELECT-OPTIONS
* 3. Single-value input
* 4. Multiple-value selection
* 5. Range selection
* 6. Selection table
* 7. Basic selection processing
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand the difference between PARAMETERS and SELECT-OPTIONS.
* - Define input fields on a selection screen.
* - Read selection criteria during report execution.
* - Understand the structure of a SELECT-OPTIONS selection table.
*---------------------------------------------------------------------*

************************************************************************
* Selection Screen
************************************************************************

PARAMETERS:
  p_bukrs TYPE bukrs DEFAULT '1000',
  p_year  TYPE gjahr DEFAULT '2026'.

SELECT-OPTIONS:
  s_bukrs FOR p_bukrs,
  s_year  FOR p_year.

************************************************************************
* START-OF-SELECTION
************************************************************************

START-OF-SELECTION.

*---------------------------------------------------------------------*
* Report Header
*---------------------------------------------------------------------*

  WRITE: / '============================================================'.
  WRITE: / '       SELECT-OPTIONS AND PARAMETERS'.
  WRITE: / '============================================================'.

  SKIP 2.

*---------------------------------------------------------------------*
* PARAMETERS
*---------------------------------------------------------------------*

  WRITE: / '1. PARAMETERS'.
  ULINE.

  WRITE: / 'Company Code :', p_bukrs.
  WRITE: / 'Fiscal Year  :', p_year.

  SKIP 2.

*---------------------------------------------------------------------*
* SELECT-OPTIONS
*---------------------------------------------------------------------*

  WRITE: / '2. SELECT-OPTIONS'.
  ULINE.

  WRITE: / 'Company Code Selection:'.
  PERFORM display_selection
    USING s_bukrs[].

  SKIP.

  WRITE: / 'Fiscal Year Selection:'.
  PERFORM display_selection
    USING s_year[].

  SKIP 2.

*---------------------------------------------------------------------*
* Selection Table Information
*---------------------------------------------------------------------*

  WRITE: / '3. SELECTION TABLE INFORMATION'.
  ULINE.

  WRITE: / 'Company Code Entries :', lines( s_bukrs ).
  WRITE: / 'Fiscal Year Entries  :', lines( s_year ).

  SKIP 2.

*---------------------------------------------------------------------*
* Report Runtime Information
*---------------------------------------------------------------------*

  WRITE: / '4. RUNTIME INFORMATION'.
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

  WRITE: / 'End of SELECT-OPTIONS and PARAMETERS Demonstration'.

************************************************************************
* FORM display_selection
************************************************************************

FORM display_selection
  USING
    pt_selection TYPE ANY TABLE.

  FIELD-SYMBOLS:
    <ls_selection> TYPE any.

  LOOP AT pt_selection ASSIGNING <ls_selection>.

    WRITE: / <ls_selection>.

  ENDLOOP.

ENDFORM.
