REPORT ZREP_26_COLORING_LIST_OUTPUT.

*---------------------------------------------------------------------*
* Program    : ZREP_26_COLORING_LIST_OUTPUT
* Title      : Coloring List Output
* Purpose    : Demonstrates color formatting in a Classical ABAP
*              list report.
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* Classical ABAP list reports provide formatting options for
* highlighting important information.
*
* This report demonstrates:
* - FORMAT COLOR
* - FORMAT INTENSIFIED
* - FORMAT RESET
* - Colored headings
* - Colored status values
* - Colored sections
*
* Topics Covered
* 1. List colors
* 2. FORMAT COLOR
* 3. INTENSIFIED
* 4. FORMAT RESET
* 5. Visual status representation
* 6. Structured classical list output
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand how classical list colors are applied.
* - Use colors consistently in a report.
* - Highlight important report information.
* - Reset formatting after colored output.
*---------------------------------------------------------------------*

************************************************************************
* Constants
************************************************************************

CONSTANTS:
  gc_color_normal  TYPE i VALUE 0,
  gc_color_heading TYPE i VALUE 1,
  gc_color_success TYPE i VALUE 2,
  gc_color_warning TYPE i VALUE 3,
  gc_color_error   TYPE i VALUE 4.

************************************************************************
* Global Data
************************************************************************

DATA:
  gv_status TYPE string.

************************************************************************
* START-OF-SELECTION
************************************************************************

START-OF-SELECTION.

*---------------------------------------------------------------------*
* Report Header
*---------------------------------------------------------------------*

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE: / '============================================================'.
  WRITE: / '                 COLORING LIST OUTPUT'.
  WRITE: / '============================================================'.

  FORMAT RESET.

  SKIP 2.

*---------------------------------------------------------------------*
* Normal Output
*---------------------------------------------------------------------*

  WRITE: / 'This is a normal list output line.'.

  SKIP.

*---------------------------------------------------------------------*
* Colored Section Header
*---------------------------------------------------------------------*

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE: / 'REPORT INFORMATION'.

  FORMAT RESET.

  ULINE.

  WRITE: / 'Program :', sy-repid.
  WRITE: / 'User    :', sy-uname.
  WRITE: / 'Date    :', sy-datum.
  WRITE: / 'Time    :', sy-uzeit.

  SKIP 2.

*---------------------------------------------------------------------*
* Table Header
*---------------------------------------------------------------------*

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE: / 'ID'.
  WRITE AT 10 'DESCRIPTION'.
  WRITE AT 40 'STATUS'.

  FORMAT RESET.

  ULINE.

*---------------------------------------------------------------------*
* Row 1 - Success
*---------------------------------------------------------------------*

  FORMAT COLOR COL_POSITIVE INTENSIFIED ON.

  WRITE: / '001'.
  WRITE AT 10 'Data validation'.
  WRITE AT 40 'SUCCESS'.

  FORMAT RESET.

*---------------------------------------------------------------------*
* Row 2 - Warning
*---------------------------------------------------------------------*

  FORMAT COLOR COL_TOTAL INTENSIFIED ON.

  WRITE: / '002'.
  WRITE AT 10 'Stock level check'.
  WRITE AT 40 'WARNING'.

  FORMAT RESET.

*---------------------------------------------------------------------*
* Row 3 - Error
*---------------------------------------------------------------------*

  FORMAT COLOR COL_NEGATIVE INTENSIFIED ON.

  WRITE: / '003'.
  WRITE AT 10 'Authorization check'.
  WRITE AT 40 'ERROR'.

  FORMAT RESET.

*---------------------------------------------------------------------*
* Row 4 - Normal
*---------------------------------------------------------------------*

  FORMAT COLOR COL_NORMAL.

  WRITE: / '004'.
  WRITE AT 10 'Report generation'.
  WRITE AT 40 'IN PROCESS'.

  FORMAT RESET.

  SKIP 2.

*---------------------------------------------------------------------*
* Color Demonstration
*---------------------------------------------------------------------*

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE: / 'COLOR DEMONSTRATION'.

  FORMAT RESET.

  ULINE.

  FORMAT COLOR COL_NORMAL.
  WRITE: / 'Normal output'.

  FORMAT COLOR COL_HEADING.
  WRITE: / 'Heading color'.

  FORMAT COLOR COL_POSITIVE.
  WRITE: / 'Positive / success color'.

  FORMAT COLOR COL_TOTAL.
  WRITE: / 'Total / warning-style color'.

  FORMAT COLOR COL_NEGATIVE.
  WRITE: / 'Negative / error color'.

  FORMAT RESET.

  SKIP 2.

*---------------------------------------------------------------------*
* Final Message
*---------------------------------------------------------------------*

  FORMAT COLOR COL_POSITIVE INTENSIFIED ON.

  WRITE: / 'Report formatting demonstration completed successfully.'.

  FORMAT RESET.
