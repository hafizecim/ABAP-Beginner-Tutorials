REPORT ZREP_02_BASIC_LIST_OUTPUT.

*---------------------------------------------------------------------*
* Program    : ZREP_02_BASIC_LIST_OUTPUT
* Title      : Basic List Output
* Author     : Hafize Şenyıl
* Purpose    : Demonstrates basic list output techniques in
*              Classical ABAP Reports
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This report introduces the WRITE statement and basic formatting
* options used in Classical Reports.
*
* Topics Covered
* 1. WRITE statement
* 2. Output positions (/ and AT)
* 3. SKIP
* 4. ULINE
* 5. Basic formatting
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Display text and variables.
* - Control line positions.
* - Separate report sections.
* - Create readable list output.
*---------------------------------------------------------------------*

************************************************************************
* Constants
************************************************************************
CONSTANTS:
  gc_title TYPE string VALUE 'Basic List Output Demo',
  gc_line  TYPE string VALUE '=================================================='.

************************************************************************
* Global Variables
************************************************************************
DATA:
  gv_name    TYPE string VALUE 'Hafize Senyil',
  gv_company TYPE string VALUE 'SAP Training System',
  gv_course  TYPE string VALUE 'ABAP Classical Reports',
  gv_year    TYPE i      VALUE 2026.

************************************************************************
* START-OF-SELECTION
************************************************************************
START-OF-SELECTION.

* Report Header
  WRITE: / gc_line.
  WRITE: / gc_title.
  WRITE: / gc_line.

  SKIP.

* Basic WRITE Statements
  WRITE: / 'Name       :', gv_name.
  WRITE: / 'Company    :', gv_company.
  WRITE: / 'Course     :', gv_course.
  WRITE: / 'Year       :', gv_year.

  SKIP 2.
  ULINE.

* Output Position Examples
  WRITE: / 'Output Position Examples'.
  ULINE.

  WRITE: / 'Column 01'.
  WRITE AT 20 'Column 20'.
  WRITE AT 45 'Column 45'.
  WRITE AT 65 'Column 65'.

  SKIP 2.
  ULINE.

* Multiple Values on Same Line
  WRITE: / 'Client:', sy-mandt,
           25 'User:', sy-uname,
           55 'Language:', sy-langu.

  WRITE: / 'Program:', sy-repid,
           35 'Date:', sy-datum,
           60 'Time:', sy-uzeit.

************************************************************************
* END-OF-SELECTION
************************************************************************
END-OF-SELECTION.

  SKIP 2.
  ULINE.
  WRITE: / 'End of Basic List Output Demonstration'.
