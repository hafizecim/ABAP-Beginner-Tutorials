*&---------------------------------------------------------------------*
*& Report ZZ_24_STRUCTURE_AND_LOOP
*&---------------------------------------------------------------------*
*& Purpose:
*&   Demonstrates structure usage inside LOOP with conditions.
*&
*& Topics Covered:
*&   - LOOP AT internal table
*&   - Conditional processing inside loop
*&   - Filtering logic
*&   - Structure handling in iterations
*&---------------------------------------------------------------------*

REPORT ZZ_24_STRUCTURE_AND_LOOP.

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
* Sample Data
*---------------------------------------------------------------------*
gs_employee = VALUE #( employee_id = 1001 name = 'Demo A' department = 'IT'     salary = '45000' ).
APPEND gs_employee TO gt_employee.

gs_employee = VALUE #( employee_id = 1002 name = 'Demo B' department = 'HR'     salary = '38000' ).
APPEND gs_employee TO gt_employee.

gs_employee = VALUE #( employee_id = 1003 name = 'Demo C' department = 'IT'     salary = '52000' ).
APPEND gs_employee TO gt_employee.

gs_employee = VALUE #( employee_id = 1004 name = 'Demo D' department = 'FINANCE' salary = '61000' ).
APPEND gs_employee TO gt_employee.

*---------------------------------------------------------------------*
* LOOP with Condition
*---------------------------------------------------------------------*
WRITE: / 'IT Department Employees Only'.
WRITE: / sy-uline.

LOOP AT gt_employee INTO gs_employee.

  " Only process IT department
  IF gs_employee-department = 'IT'.

    WRITE: / 'ID:', gs_employee-employee_id,
             'Name:', gs_employee-name,
             'Salary:', gs_employee-salary.

  ENDIF.

ENDLOOP.
