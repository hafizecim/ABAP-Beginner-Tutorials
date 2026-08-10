REPORT ZREP_19_INTERACTIVE_REPORT_INTRODUCTION.

*---------------------------------------------------------------------*
* Program    : ZREP_19_INTERACTIVE_REPORT_INTRODUCTION
* Title      : Interactive Report Introduction
* Purpose    : Demonstrates the basic structure of an interactive
*              Classical ABAP Report.
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* Interactive reports allow users to select data directly from a
* classical list and navigate to additional information.
*
* This report demonstrates a simple two-level interaction:
*
*   Basic List
*       ↓
*   User selects a company
*       ↓
*   Detail List
*
* Topics Covered
* 1. Interactive reporting
* 2. Basic list
* 3. HIDE
* 4. AT LINE-SELECTION
* 5. Secondary list
* 6. SY-LSIND
* 7. SY-LISEL
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand the concept of interactive classical reports.
* - Create a basic list with selectable rows.
* - Associate data with list lines using HIDE.
* - Process user selections using AT LINE-SELECTION.
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

  PERFORM display_basic_list.

************************************************************************
* AT LINE-SELECTION
************************************************************************
* Triggered when the user double-clicks a line in the basic list.

AT LINE-SELECTION.

  PERFORM display_detail_list.

************************************************************************
* FORM display_basic_list
************************************************************************

FORM display_basic_list.

*---------------------------------------------------------------------*
* Basic List Header
*---------------------------------------------------------------------*

  WRITE: / '============================================================'.
  WRITE: / '                 COMPANY OVERVIEW'.
  WRITE: / '============================================================'.

  SKIP 2.

  WRITE: / 'Company Code'.
  WRITE AT 25 'Company Name'.

  ULINE.

*---------------------------------------------------------------------*
* Basic List Data
*---------------------------------------------------------------------*

  PERFORM display_company
    USING '1000' 'Demo Company 1000'.

  PERFORM display_company
    USING '2000' 'Demo Company 2000'.

  PERFORM display_company
    USING '3000' 'Demo Company 3000'.

  SKIP 2.

  WRITE: / 'Double-click a company to display its details.'.

ENDFORM.

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
  WRITE AT 25 gv_butxt.

*---------------------------------------------------------------------*
* Associate company data with the current list line.
*---------------------------------------------------------------------*

  HIDE:
    gv_bukrs,
    gv_butxt.

ENDFORM.

************************************************************************
* FORM display_detail_list
************************************************************************

FORM display_detail_list.

*---------------------------------------------------------------------*
* Detail List Header
*---------------------------------------------------------------------*

  WRITE: / '============================================================'.
  WRITE: / '                  COMPANY DETAILS'.
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
* Interactive Report Information
*---------------------------------------------------------------------*

  WRITE: / 'Interactive Report Information'.
  ULINE.

  WRITE: / 'List Level    :', sy-lsind.
  WRITE: / 'Selected Line :', sy-lisel.

  SKIP 2.

  WRITE: / 'The selected company is displayed in the detail list.'.

ENDFORM.
