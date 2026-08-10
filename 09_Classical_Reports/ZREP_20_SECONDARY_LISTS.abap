REPORT ZREP_20_SECONDARY_LISTS.

*---------------------------------------------------------------------*
* Program    : ZREP_20_SECONDARY_LISTS
* Title      : Secondary Lists
* Purpose    : Demonstrates secondary lists in an interactive
*              Classical ABAP Report.
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* A secondary list is a new list level created after the user
* interacts with a basic list.
*
* In classical interactive reporting, secondary lists can be used
* to display detailed information related to a selected line.
*
* This report demonstrates:
*
*   Basic List
*       ↓
*   User Selection
*       ↓
*   Secondary List
*
* Topics Covered
* 1. Basic list
* 2. Secondary list
* 3. HIDE
* 4. AT LINE-SELECTION
* 5. SY-LSIND
* 6. SY-LISEL
* 7. List levels
* 8. Interactive navigation
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand the concept of secondary lists.
* - Create a secondary list from a basic list.
* - Track the current list level.
* - Display selected-line details.
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
* Creates the secondary list when the user selects a line.

AT LINE-SELECTION.

  PERFORM display_secondary_list.

************************************************************************
* FORM display_basic_list
************************************************************************

FORM display_basic_list.

*---------------------------------------------------------------------*
* Basic List Header
*---------------------------------------------------------------------*

  WRITE: / '============================================================'.
  WRITE: / '                    BASIC LIST'.
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

  WRITE: / 'Double-click a company to open the secondary list.'.

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
* Store the values for the current list line.
*---------------------------------------------------------------------*

  HIDE:
    gv_bukrs,
    gv_butxt.

ENDFORM.

************************************************************************
* FORM display_secondary_list
************************************************************************

FORM display_secondary_list.

*---------------------------------------------------------------------*
* Secondary List Header
*---------------------------------------------------------------------*

  WRITE: / '============================================================'.
  WRITE: / '                  SECONDARY LIST'.
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
* List Level Information
*---------------------------------------------------------------------*

  WRITE: / 'List Navigation'.
  ULINE.

  WRITE: / 'Current List Level :', sy-lsind.
  WRITE: / 'Selected Line      :', sy-lisel.

  SKIP 2.

*---------------------------------------------------------------------*
* Secondary List Information
*---------------------------------------------------------------------*

  WRITE: / 'The selected company is displayed in a secondary list.'.
  WRITE: / 'The basic list remains available as the previous list level.'.

ENDFORM.
