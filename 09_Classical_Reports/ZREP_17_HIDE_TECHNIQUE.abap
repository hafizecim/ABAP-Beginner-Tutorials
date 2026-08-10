REPORT ZREP_17_HIDE_TECHNIQUE.

*---------------------------------------------------------------------*
* Program    : ZREP_17_HIDE_TECHNIQUE
* Title      : HIDE Technique
* Purpose    : Demonstrates the HIDE technique in an interactive
*              Classical ABAP Report.
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* The HIDE statement stores the value of a data object for the
* corresponding list line.
*
* When the user interacts with a list line, the stored value can be
* retrieved and processed.
*
* HIDE is mainly associated with classical interactive reports.
*
* Topics Covered
* 1. HIDE statement
* 2. Interactive list processing
* 3. Line selection
* 4. Hidden values
* 5. AT LINE-SELECTION
* 6. SY-LISEL
* 7. SY-LSIND
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand the purpose of HIDE.
* - Store values against list lines.
* - Retrieve hidden values after user interaction.
* - Understand the basic structure of an interactive classical report.
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
  WRITE: / '                    COMPANY REPORT'.
  WRITE: / '============================================================'.

  SKIP 2.

*---------------------------------------------------------------------*
* Column Header
*---------------------------------------------------------------------*

  WRITE: / 'Company Code'.
  WRITE AT 20 'Company Name'.

  ULINE.

*---------------------------------------------------------------------*
* Company Data
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
* Executed when the user double-clicks a list line.

AT LINE-SELECTION.

  WRITE: / '============================================================'.
  WRITE: / '                  SELECTED COMPANY'.
  WRITE: / '============================================================'.

  SKIP 2.

  WRITE: / 'Company Code :', gv_bukrs.
  WRITE: / 'Company Name :', gv_butxt.

  SKIP 2.

  WRITE: / 'List Level   :', sy-lsind.
  WRITE: / 'Selected Line:', sy-lisel.

  SKIP 2.

  WRITE: / 'The values stored by HIDE were retrieved successfully.'.

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
* Store values for the current list line.
*---------------------------------------------------------------------*

  HIDE:
    gv_bukrs,
    gv_butxt.

ENDFORM.
