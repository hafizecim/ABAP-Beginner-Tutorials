REPORT ZREP_18_AT_LINE_SELECTION.

*---------------------------------------------------------------------*
* Program    : ZREP_18_AT_LINE_SELECTION
* Title      : AT LINE-SELECTION Event
* Purpose    : Demonstrates interactive list processing using the
*              AT LINE-SELECTION event.
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* AT LINE-SELECTION is triggered when the user selects a line in a
* classical ABAP list, typically by double-clicking the line.
*
* The event can be used to create a second-level detail list based
* on the selected line.
*
* Topics Covered
* 1. AT LINE-SELECTION
* 2. Interactive list processing
* 3. HIDE
* 4. Secondary list
* 5. SY-LISEL
* 6. SY-LSIND
* 7. Selected-line processing
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand how AT LINE-SELECTION is triggered.
* - Create an interactive classical list.
* - Retrieve data associated with a selected line.
* - Navigate from a basic list to a detail list.
*---------------------------------------------------------------------*

************************************************************************
* Global Data
************************************************************************

DATA:
  gv_bukrs TYPE bukrs,
  gv_butxt TYPE butxt.

************************************************************************
* START-OF-SELECTION
************************************************************************

START-OF-SELECTION.

*---------------------------------------------------------------------*
* Report Header
*---------------------------------------------------------------------*

  WRITE: / '============================================================'.
  WRITE: / '                  COMPANY OVERVIEW'.
  WRITE: / '============================================================'.

  SKIP 2.

*---------------------------------------------------------------------*
* Column Header
*---------------------------------------------------------------------*

  WRITE: / 'Company Code'.
  WRITE AT 20 'Company Name'.

  ULINE.

*---------------------------------------------------------------------*
* Company List
*---------------------------------------------------------------------*

  PERFORM display_company
    USING '1000' 'Demo Company 1000'.

  PERFORM display_company
    USING '2000' 'Demo Company 2000'.

  PERFORM display_company
    USING '3000' 'Demo Company 3000'.

************************************************************************
* AT LINE-SELECTION
************************************************************************
* Triggered when the user double-clicks a list line.

AT LINE-SELECTION.

*---------------------------------------------------------------------*
* Secondary List Header
*---------------------------------------------------------------------*

  WRITE: / '============================================================'.
  WRITE: / '                   COMPANY DETAILS'.
  WRITE: / '============================================================'.

  SKIP 2.

*---------------------------------------------------------------------*
* Selected Company
*---------------------------------------------------------------------*

  WRITE: / 'Selected Company'.
  ULINE.

  WRITE: / 'Company Code :', gv_bukrs.
  WRITE: / 'Company Name :', gv_butxt.

  SKIP 2.

*---------------------------------------------------------------------*
* Interactive List Information
*---------------------------------------------------------------------*

  WRITE: / 'Interactive List Information'.
  ULINE.

  WRITE: / 'List Level   :', sy-lsind.
  WRITE: / 'Selected Line:', sy-lisel.

  SKIP 2.

  WRITE: / 'Double-clicked line was processed by AT LINE-SELECTION.'.

************************************************************************
* FORM display_company
************************************************************************

FORM display_company
  USING
    iv_bukrs TYPE bukrs
    iv_butxt TYPE butxt.

  gv_bukrs = iv_bukrs.
  gv_butxt = iv_butxt.

  WRITE: / gv_bukrs.
  WRITE AT 20 gv_butxt.

*---------------------------------------------------------------------*
* Associate the values with the current list line.
*---------------------------------------------------------------------*

  HIDE:
    gv_bukrs,
    gv_butxt.

ENDFORM.
