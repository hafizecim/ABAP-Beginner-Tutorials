REPORT ZREP_04_LINE_AND_PAGE_FORMATTING.

*---------------------------------------------------------------------*
* Program    : ZREP_04_LINE_AND_PAGE_FORMATTING
* Title      : Line and Page Formatting
* Author     : Hafize Şenyıl
* Purpose    : Demonstrates line and page formatting techniques
*              in Classical ABAP Reports.
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This report explains how to format report output using line and
* page formatting statements.
*
* Topics Covered
* 1. SKIP
* 2. ULINE
* 3. NEW-LINE
* 4. NEW-PAGE
* 5. POSITION
* 6. WRITE AT
* 7. Report Sections
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Control vertical spacing.
* - Draw separator lines.
* - Position output on the page.
* - Create readable report layouts.
*---------------------------------------------------------------------*

************************************************************************
* Constants
************************************************************************
CONSTANTS:
  gc_title TYPE string VALUE 'Line and Page Formatting',
  gc_line  TYPE string VALUE
             '==============================================================='.

************************************************************************
* Global Variables
************************************************************************
DATA:
  gv_empid   TYPE n LENGTH 6 VALUE '100001',
  gv_name    TYPE string VALUE 'John Miller',
  gv_dept    TYPE string VALUE 'Finance',
  gv_salary  TYPE p LENGTH 8 DECIMALS 2 VALUE '45000.75'.

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

*---------------------------------------------------------------------*
* 1. SKIP
*---------------------------------------------------------------------*
  SKIP 2.

  WRITE: / '1. SKIP Statement'.
  ULINE.

  WRITE: / 'First Line'.
  SKIP.
  WRITE: / 'After SKIP 1'.
  SKIP 2.
  WRITE: / 'After SKIP 2'.

*---------------------------------------------------------------------*
* 2. ULINE
*---------------------------------------------------------------------*
  SKIP 2.

  WRITE: / '2. ULINE Statement'.
  ULINE.

  WRITE: / 'Employee Information'.
  ULINE.

*---------------------------------------------------------------------*
* 3. WRITE AT
*---------------------------------------------------------------------*
  SKIP 2.

  WRITE: / '3. WRITE AT'.
  ULINE.

  WRITE AT 05 'Employee ID'.
  WRITE AT 25 'Name'.
  WRITE AT 55 'Department'.

  WRITE: /.
  WRITE AT 05 gv_empid.
  WRITE AT 25 gv_name.
  WRITE AT 55 gv_dept.

*---------------------------------------------------------------------*
* 4. POSITION
*---------------------------------------------------------------------*
  SKIP 2.

  WRITE: / '4. POSITION'.
  ULINE.

  POSITION 10.
  WRITE 'Column 10'.

  POSITION 35.
  WRITE 'Column 35'.

  POSITION 60.
  WRITE 'Column 60'.

*---------------------------------------------------------------------*
* 5. NEW-LINE
*---------------------------------------------------------------------*
  SKIP 2.

  WRITE: / '5. NEW-LINE'.
  ULINE.

  WRITE 'Employee:'.
  NEW-LINE.

  WRITE gv_name.
  NEW-LINE.

  WRITE gv_salary.

*---------------------------------------------------------------------*
* 6. NEW-PAGE
*---------------------------------------------------------------------*
  NEW-PAGE.

  WRITE: / gc_title CENTERED.
  ULINE.

  WRITE: / 'This output starts on a new page.'.
  SKIP.

  WRITE: / 'Employee Summary'.
  ULINE.

  WRITE: / 'Employee ID :', gv_empid.
  WRITE: / 'Name        :', gv_name.
  WRITE: / 'Department  :', gv_dept.
  WRITE: / 'Salary      :', gv_salary.

*---------------------------------------------------------------------*
* 7. Professional Layout Example
*---------------------------------------------------------------------*
  SKIP 2.

  WRITE: / gc_line.
  WRITE: / 'EMPLOYEE REPORT' CENTERED.
  WRITE: / gc_line.

  WRITE: / 'ID'.
  WRITE AT 15 'NAME'.
  WRITE AT 45 'DEPARTMENT'.
  WRITE AT 70 'SALARY'.

  ULINE.

  WRITE: / gv_empid.
  WRITE AT 15 gv_name.
  WRITE AT 45 gv_dept.
  WRITE AT 70 gv_salary.

  ULINE.

************************************************************************
* END-OF-SELECTION
************************************************************************
END-OF-SELECTION.

  SKIP 2.
  WRITE: / 'End of Line and Page Formatting Demonstration'.
