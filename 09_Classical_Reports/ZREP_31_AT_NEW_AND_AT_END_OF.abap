REPORT ZREP_31_AT_NEW_AND_AT_END_OF.

*---------------------------------------------------------------------*
* Program    : ZREP_31_AT_NEW_AND_AT_END_OF
* Title      : AT NEW and AT END OF
* Purpose    : Demonstrates AT NEW and AT END OF control break
*              processing in a Classical ABAP Report.
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* AT NEW and AT END OF are control break statements used inside
* LOOP processing to detect the beginning and end of groups.
*
* This report demonstrates:
* - AT NEW
* - AT END OF
* - Nested control breaks
* - Sorted internal table
* - Group headers
* - Group totals
*
* Hierarchy:
*
* Company
*   |
*   +-- Department
*          |
*          +-- Employee
*
* Topics Covered
* 1. AT NEW
* 2. AT END OF
* 3. Nested control breaks
* 4. SORT before control break processing
* 5. Group-level reporting
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Detect the beginning of a group with AT NEW.
* - Detect the end of a group with AT END OF.
* - Understand nested control breaks.
* - Understand why sorting is required.
*---------------------------------------------------------------------*

************************************************************************
* Types
************************************************************************

TYPES:
  BEGIN OF ty_employee,
    bukrs      TYPE bukrs,
    department TYPE char20,
    employee   TYPE char25,
    salary     TYPE p LENGTH 10 DECIMALS 2,
  END OF ty_employee.

************************************************************************
* Data
************************************************************************

DATA:
  gt_employee TYPE STANDARD TABLE OF ty_employee,
  gs_employee TYPE ty_employee.

************************************************************************
* START-OF-SELECTION
************************************************************************

START-OF-SELECTION.

  PERFORM prepare_data.
  PERFORM display_report.

************************************************************************
* FORM prepare_data
************************************************************************

FORM prepare_data.

*---------------------------------------------------------------------*
* Company 1000 - IT
*---------------------------------------------------------------------*

  APPEND VALUE #(
    bukrs      = '1000'
    department = 'IT'
    employee   = 'Alice'
    salary     = '45000.00'
  ) TO gt_employee.

  APPEND VALUE #(
    bukrs      = '1000'
    department = 'IT'
    employee   = 'Bob'
    salary     = '52000.00'
  ) TO gt_employee.

*---------------------------------------------------------------------*
* Company 1000 - Finance
*---------------------------------------------------------------------*

  APPEND VALUE #(
    bukrs      = '1000'
    department = 'Finance'
    employee   = 'Charlie'
    salary     = '48000.00'
  ) TO gt_employee.

  APPEND VALUE #(
    bukrs      = '1000'
    department = 'Finance'
    employee   = 'David'
    salary     = '55000.00'
  ) TO gt_employee.

*---------------------------------------------------------------------*
* Company 2000 - IT
*---------------------------------------------------------------------*

  APPEND VALUE #(
    bukrs      = '2000'
    department = 'IT'
    employee   = 'Emma'
    salary     = '47000.00'
  ) TO gt_employee.

  APPEND VALUE #(
    bukrs      = '2000'
    department = 'IT'
    employee   = 'Frank'
    salary     = '51000.00'
  ) TO gt_employee.

*---------------------------------------------------------------------*
* Company 2000 - Finance
*---------------------------------------------------------------------*

  APPEND VALUE #(
    bukrs      = '2000'
    department = 'Finance'
    employee   = 'Grace'
    salary     = '50000.00'
  ) TO gt_employee.

*---------------------------------------------------------------------*
* Required ordering for control break processing
*---------------------------------------------------------------------*

  SORT gt_employee BY bukrs department employee.

ENDFORM.

************************************************************************
* FORM display_report
************************************************************************

FORM display_report.

*---------------------------------------------------------------------*
* Report Header
*---------------------------------------------------------------------*

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE: / '============================================================'.
  WRITE: / '              AT NEW AND AT END OF REPORT'.
  WRITE: / '============================================================'.

  FORMAT RESET.

  SKIP 2.

*---------------------------------------------------------------------*
* Column Header
*---------------------------------------------------------------------*

  POSITION 1.
  WRITE: 'Company'.

  POSITION 15.
  WRITE: 'Department'.

  POSITION 32.
  WRITE: 'Employee'.

  POSITION 55.
  WRITE: 'Salary'.

  SKIP 1.

  ULINE.

*---------------------------------------------------------------------*
* Main Processing
*---------------------------------------------------------------------*

  LOOP AT gt_employee INTO gs_employee.

*---------------------------------------------------------------------*
* AT NEW BUKRS
*---------------------------------------------------------------------*
* Triggered at the beginning of a new company group.

    AT NEW bukrs.

      SKIP 1.

      FORMAT COLOR COL_HEADING INTENSIFIED ON.

      WRITE: / 'COMPANY:', gs_employee-bukrs.

      FORMAT RESET.

      ULINE.

    ENDAT.

*---------------------------------------------------------------------*
* AT NEW DEPARTMENT
*---------------------------------------------------------------------*
* Triggered at the beginning of a new department group.

    AT NEW department.

      FORMAT COLOR COL_TOTAL INTENSIFIED ON.

      WRITE: / 'DEPARTMENT:', gs_employee-department.

      FORMAT RESET.

    ENDAT.

*---------------------------------------------------------------------*
* Employee Detail
*---------------------------------------------------------------------*

    POSITION 1.
    WRITE: / gs_employee-bukrs.

    POSITION 15.
    WRITE: gs_employee-department.

    POSITION 32.
    WRITE: gs_employee-employee.

    POSITION 55.
    WRITE: gs_employee-salary.

*---------------------------------------------------------------------*
* AT END OF DEPARTMENT
*---------------------------------------------------------------------*
* Triggered when the current department group ends.

    AT END OF department.

      SKIP 1.

      FORMAT COLOR COL_TOTAL INTENSIFIED ON.

      WRITE: / 'END OF DEPARTMENT:', gs_employee-department.

      FORMAT RESET.

      SKIP 1.

    ENDAT.

*---------------------------------------------------------------------*
* AT END OF BUKRS
*---------------------------------------------------------------------*
* Triggered when the current company group ends.

    AT END OF bukrs.

      SKIP 1.

      FORMAT COLOR COL_POSITIVE INTENSIFIED ON.

      WRITE: / 'END OF COMPANY:', gs_employee-bukrs.

      FORMAT RESET.

      SKIP 2.

    ENDAT.

  ENDLOOP.

ENDFORM.
