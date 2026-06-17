*&---------------------------------------------------------------------*
*& Report ZZ_30_PARAMETERS_AND_SELECT_OPTIONS
*&---------------------------------------------------------------------*
*& Purpose:
*&   Demonstrates the combined usage of PARAMETERS and
*&   SELECT-OPTIONS in an ABAP report.
*&
*& Topics Covered:
*&   - PARAMETERS
*&   - SELECT-OPTIONS
*&   - Internal tables
*&   - Filtering logic
*&   - Report output
*&---------------------------------------------------------------------*

REPORT ZZ_30_PARAMETERS_AND_SELECT_OPTIONS.

*---------------------------------------------------------------------*
* Employee Structure
*---------------------------------------------------------------------*
TYPES: BEGIN OF ty_employee,
         employee_id TYPE n LENGTH 8,
         name        TYPE string,
         department  TYPE c LENGTH 20,
         salary      TYPE p LENGTH 8 DECIMALS 2,
       END OF ty_employee.

*---------------------------------------------------------------------*
* Data Declarations
*---------------------------------------------------------------------*
DATA:
  gt_employee TYPE STANDARD TABLE OF ty_employee,
  gs_employee TYPE ty_employee.

*---------------------------------------------------------------------*
* Selection Screen
*---------------------------------------------------------------------*
PARAMETERS:
  p_dept TYPE c LENGTH 20 DEFAULT 'IT'.

SELECT-OPTIONS:
  so_empid FOR gs_employee-employee_id.

*---------------------------------------------------------------------*
* Load Sample Data
*---------------------------------------------------------------------*
INITIALIZATION.

  gs_employee = VALUE #(
      employee_id = '00001001'
      name        = 'Employee A'
      department  = 'IT'
      salary      = '45000' ).
  APPEND gs_employee TO gt_employee.

  gs_employee = VALUE #(
      employee_id = '00001002'
      name        = 'Employee B'
      department  = 'HR'
      salary      = '38000' ).
  APPEND gs_employee TO gt_employee.

  gs_employee = VALUE #(
      employee_id = '00001003'
      name        = 'Employee C'
      department  = 'IT'
      salary      = '52000' ).
  APPEND gs_employee TO gt_employee.

  gs_employee = VALUE #(
      employee_id = '00001004'
      name        = 'Employee D'
      department  = 'FINANCE'
      salary      = '61000' ).
  APPEND gs_employee TO gt_employee.

*---------------------------------------------------------------------*
* Main Processing
*---------------------------------------------------------------------*
START-OF-SELECTION.

  WRITE: / 'Filtered Employee Report'.
  WRITE: / sy-uline.

  LOOP AT gt_employee INTO gs_employee.

    IF gs_employee-department = p_dept
       AND gs_employee-employee_id IN so_empid.

      WRITE: / 'ID        :', gs_employee-employee_id.
      WRITE: / 'Name      :', gs_employee-name.
      WRITE: / 'Department:', gs_employee-department.
      WRITE: / 'Salary    :', gs_employee-salary.
      WRITE: / sy-uline.

    ENDIF.

  ENDLOOP.
