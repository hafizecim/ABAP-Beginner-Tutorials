REPORT ZREP_03_WRITE_STATEMENT_OPTIONS.

*---------------------------------------------------------------------*
* Program    : ZREP_03_WRITE_STATEMENT_OPTIONS
* Title      : WRITE Statement Options
* Author     : Hafize Şenyıl
* Purpose    : Demonstrates various WRITE statement options used in
*              Classical ABAP Reports.
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This report explains the most commonly used WRITE statement options
* for formatting classical list output.
*
* Topics Covered
* 1. Basic WRITE
* 2. WRITE /
* 3. WRITE AT
* 4. NO-GAP
* 5. UNDER
* 6. CENTERED
* 7. RIGHT-JUSTIFIED
* 8. HOTSPOT
* 9. COLOR
* 10. INTENSIFIED
* 11. INVERSE
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Learn different WRITE formatting techniques.
* - Produce professional list outputs.
* - Understand text alignment and visual formatting.
*---------------------------------------------------------------------*

************************************************************************
* Constants
************************************************************************
CONSTANTS:
  gc_title TYPE string VALUE 'WRITE Statement Options',
  gc_line  TYPE string VALUE '============================================================'.

************************************************************************
* Global Variables
************************************************************************
DATA:
  gv_first_name TYPE string VALUE 'Hafize',
  gv_last_name  TYPE string VALUE 'Senyil',
  gv_city       TYPE string VALUE 'Konya',
  gv_salary     TYPE p LENGTH 8 DECIMALS 2 VALUE '27500.50',
  gv_percent    TYPE p LENGTH 5 DECIMALS 2 VALUE '18.75'.

************************************************************************
* START-OF-SELECTION
************************************************************************
START-OF-SELECTION.

*---------------------------------------------------------------------*
* Report Header
*---------------------------------------------------------------------*
  WRITE: / gc_line.
  WRITE: / gc_title CENTERED.
  WRITE: / gc_line.

  SKIP 2.

*---------------------------------------------------------------------*
* 1. Basic WRITE
*---------------------------------------------------------------------*
  WRITE: / '1. Basic WRITE'.
  ULINE.

  WRITE: / 'First Name :', gv_first_name.
  WRITE: / 'Last Name  :', gv_last_name.
  WRITE: / 'City       :', gv_city.

  SKIP 2.

*---------------------------------------------------------------------*
* 2. WRITE AT
*---------------------------------------------------------------------*
  WRITE: / '2. WRITE AT'.
  ULINE.

  WRITE AT 05 'Column 5'.
  WRITE AT 25 'Column 25'.
  WRITE AT 50 'Column 50'.
  WRITE AT 70 'Column 70'.

  SKIP 2.

*---------------------------------------------------------------------*
* 3. NO-GAP
*---------------------------------------------------------------------*
  WRITE: / '3. NO-GAP'.
  ULINE.

  WRITE: / gv_first_name NO-GAP,
           gv_last_name.

  WRITE: / gv_first_name,
           gv_last_name.

  SKIP 2.

*---------------------------------------------------------------------*
* 4. UNDER
*---------------------------------------------------------------------*
  WRITE: / '4. UNDER'.
  ULINE.

  WRITE: / 'Employee Name:'.
  WRITE: / gv_first_name UNDER 'Employee Name:'.

  SKIP 2.

*---------------------------------------------------------------------*
* 5. CENTERED
*---------------------------------------------------------------------*
  WRITE: / '5. CENTERED'.
  ULINE.

  WRITE: / 'ABAP Classical Reporting' CENTERED.

  SKIP 2.

*---------------------------------------------------------------------*
* 6. RIGHT-JUSTIFIED
*---------------------------------------------------------------------*
  WRITE: / '6. RIGHT-JUSTIFIED'.
  ULINE.

  WRITE: / gv_salary RIGHT-JUSTIFIED.

  SKIP 2.

*---------------------------------------------------------------------*
* 7. HOTSPOT
*---------------------------------------------------------------------*
  WRITE: / '7. HOTSPOT'.
  ULINE.

  WRITE: / 'Material Display' HOTSPOT.

  SKIP 2.

*---------------------------------------------------------------------*
* 8. COLOR
*---------------------------------------------------------------------*
  WRITE: / '8. COLOR'.
  ULINE.

  FORMAT COLOR COL_POSITIVE.
  WRITE: / 'Positive Status'.

  FORMAT COLOR COL_NEGATIVE.
  WRITE: / 'Negative Status'.

  FORMAT COLOR COL_TOTAL.
  WRITE: / 'Total Amount'.

  FORMAT RESET.

  SKIP 2.

*---------------------------------------------------------------------*
* 9. INTENSIFIED
*---------------------------------------------------------------------*
  WRITE: / '9. INTENSIFIED'.
  ULINE.

  FORMAT INTENSIFIED ON.
  WRITE: / 'Highlighted Text'.

  FORMAT INTENSIFIED OFF.
  WRITE: / 'Normal Text'.

  SKIP 2.

*---------------------------------------------------------------------*
* 10. INVERSE
*---------------------------------------------------------------------*
  WRITE: / '10. INVERSE'.
  ULINE.

  FORMAT INVERSE ON.
  WRITE: / 'Inverse Display'.

  FORMAT RESET.

  SKIP 2.

*---------------------------------------------------------------------*
* 11. Combined Formatting
*---------------------------------------------------------------------*
  WRITE: / '11. Combined Formatting'.
  ULINE.

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE: / 'Employee:', gv_first_name,
           35 'Salary:', gv_salary,
           60 'Bonus %:', gv_percent.

  FORMAT RESET.

************************************************************************
* END-OF-SELECTION
************************************************************************
END-OF-SELECTION.

  SKIP 2.
  ULINE.
  WRITE: / 'End of WRITE Statement Options Demonstration'.
