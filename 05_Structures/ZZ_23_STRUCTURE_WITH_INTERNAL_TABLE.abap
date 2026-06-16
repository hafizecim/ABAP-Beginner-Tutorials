*&---------------------------------------------------------------------*
*& Report ZZ_23_STRUCTURE_WITH_INTERNAL_TABLE
*&---------------------------------------------------------------------*
*& Purpose:
*&   Demonstrates usage of Structures with Internal Tables.
*&
*& Topics Covered:
*&   - Structure definition
*&   - Internal table of structures
*&   - APPEND usage
*&   - LOOP AT internal table
*&---------------------------------------------------------------------*

REPORT ZZ_23_STRUCTURE_WITH_INTERNAL_TABLE.

*---------------------------------------------------------------------*
* Structure Definition
*---------------------------------------------------------------------*
TYPES: BEGIN OF ty_employee,
         employee_id TYPE i,
         name        TYPE string,
         department  TYPE string,
         salary      TYPE p LENGTH 8 DECIMALS 2,
       END OF ty_employee.

*---------------------------------------------------------------------*
* Internal Table and Work Area
*---------------------------------------------------------------------*
DATA gt_employee TYPE STANDARD TABLE OF ty_employee.
DATA gs_employee TYPE ty_employee.

*---------------------------------------------------------------------*
* Add Data to Internal Table
*---------------------------------------------------------------------*
gs_employee-employee_id = 1001.
gs_employee-name        = 'Demo User 1'.
gs_employee-department  = 'IT'.
gs_employee-salary      = '45000.00'.
APPEND gs_employee TO gt_employee.

CLEAR gs_employee.

gs_employee-employee_id = 1002.
gs_employee-name        = 'Demo User 2'.
gs_employee-department  = 'Finance'.
gs_employee-salary      = '52000.00'.
APPEND gs_employee TO gt_employee.

CLEAR gs_employee.

gs_employee-employee_id = 1003.
gs_employee-name        = 'Demo User 3'.
gs_employee-department  = 'HR'.
gs_employee-salary      = '40000.00'.
APPEND gs_employee TO gt_employee.

*---------------------------------------------------------------------*
* Output Internal Table
*---------------------------------------------------------------------*
WRITE: / 'Employee List'.
WRITE: / sy-uline.

LOOP AT gt_employee INTO gs_employee.

  WRITE: / 'ID:', gs_employee-employee_id,
           'Name:', gs_employee-name,
           'Department:', gs_employee-department,
           'Salary:', gs_employee-salary.

ENDLOOP.
