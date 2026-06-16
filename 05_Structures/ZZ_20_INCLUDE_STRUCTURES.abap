*&---------------------------------------------------------------------*
*& Report ZZ_20_INCLUDE_STRUCTURES
*&---------------------------------------------------------------------*
*& Purpose:
*&   Demonstrates the usage of INCLUDE TYPE in ABAP Structures.
*&
*& Topics Covered:
*&   - Base Structure Definition
*&   - INCLUDE TYPE Usage
*&   - Structure Composition
*&   - Accessing Included Fields
*&---------------------------------------------------------------------*

REPORT ZZ_20_INCLUDE_STRUCTURES.

*---------------------------------------------------------------------*
* Base Structure
*---------------------------------------------------------------------*
TYPES: BEGIN OF ty_person,
         first_name TYPE string,
         last_name  TYPE string,
       END OF ty_person.

*---------------------------------------------------------------------*
* Employee Structure with INCLUDE TYPE
*---------------------------------------------------------------------*
TYPES: BEGIN OF ty_employee,

         INCLUDE TYPE ty_person.

TYPES:   employee_id TYPE i,
         department  TYPE string,
         salary      TYPE p LENGTH 8 DECIMALS 2,

       END OF ty_employee.

*---------------------------------------------------------------------*
* Structure Variable
*---------------------------------------------------------------------*
DATA gs_employee TYPE ty_employee.

*---------------------------------------------------------------------*
* Assign Values
*---------------------------------------------------------------------*
gs_employee-first_name = 'Demo'.
gs_employee-last_name  = 'User'.

gs_employee-employee_id = 1001.
gs_employee-department  = 'Information Technology'.
gs_employee-salary      = '45000.00'.

*---------------------------------------------------------------------*
* Output
*---------------------------------------------------------------------*
WRITE: / 'Employee Information'.
WRITE: / sy-uline.

WRITE: / 'First Name  :', gs_employee-first_name.
WRITE: / 'Last Name   :', gs_employee-last_name.
WRITE: / 'Employee ID :', gs_employee-employee_id.
WRITE: / 'Department  :', gs_employee-department.
WRITE: / 'Salary      :', gs_employee-salary.

WRITE: / sy-uline.
