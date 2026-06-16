*&---------------------------------------------------------------------*
*& Report ZZ_18_STRUCTURES_BASIC
*&---------------------------------------------------------------------*
*& Purpose:
*&   Demonstrates the basic usage of Structures in ABAP.
*&
*& Topics Covered:
*&   - Defining a Structure with TYPES
*&   - Creating a Structure Variable
*&   - Assigning Values
*&   - Displaying Structure Fields
*&---------------------------------------------------------------------*

REPORT ZZ_18_STRUCTURES_BASIC.

*---------------------------------------------------------------------*
* Structure Definition
*---------------------------------------------------------------------*
TYPES: BEGIN OF ty_employee,
         employee_id TYPE i,
         first_name  TYPE string,
         last_name   TYPE string,
         department  TYPE string,
         salary      TYPE p LENGTH 8 DECIMALS 2,
       END OF ty_employee.

*---------------------------------------------------------------------*
* Structure Variable
*---------------------------------------------------------------------*
DATA gs_employee TYPE ty_employee.

*---------------------------------------------------------------------*
* Assign Values to Structure Fields
*---------------------------------------------------------------------*
gs_employee-employee_id = 1001.
gs_employee-first_name  = 'Emir'.
gs_employee-last_name   = 'Koroglu'.
gs_employee-department  = 'SAP ABAP'.
gs_employee-salary      = '45000.00'.

*---------------------------------------------------------------------*
* Output
*---------------------------------------------------------------------*
WRITE: / 'Employee Information'.
WRITE: / sy-uline.

WRITE: / 'Employee ID :', gs_employee-employee_id.
WRITE: / 'First Name  :', gs_employee-first_name.
WRITE: / 'Last Name   :', gs_employee-last_name.
WRITE: / 'Department  :', gs_employee-department.
WRITE: / 'Salary      :', gs_employee-salary.

WRITE: / sy-uline.
