*&---------------------------------------------------------------------*
*& Report ZZ_21_STRUCTURE_OPERATIONS
*&---------------------------------------------------------------------*
*& Purpose:
*&   Demonstrates common structure operations in ABAP.
*&
*& Topics Covered:
*&   - CLEAR
*&   - VALUE constructor
*&   - Structure assignment
*&   - Field-by-field copy
*&   - Overwriting values
*&---------------------------------------------------------------------*

REPORT ZZ_21_STRUCTURE_OPERATIONS.

*---------------------------------------------------------------------*
* Structure Definition
*---------------------------------------------------------------------*
TYPES: BEGIN OF ty_employee,
         employee_id TYPE i,
         first_name  TYPE string,
         last_name   TYPE string,
         department  TYPE string,
       END OF ty_employee.

*---------------------------------------------------------------------*
* Structure Variables
*---------------------------------------------------------------------*
DATA gs_employee1 TYPE ty_employee.
DATA gs_employee2 TYPE ty_employee.

*---------------------------------------------------------------------*
* 1. Direct Assignment
*---------------------------------------------------------------------*
gs_employee1-employee_id = 1001.
gs_employee1-first_name   = 'Demo'.
gs_employee1-last_name    = 'User'.
gs_employee1-department   = 'IT'.

*---------------------------------------------------------------------*
* 2. Structure Copy (Assignment)
*---------------------------------------------------------------------*
gs_employee2 = gs_employee1.

*---------------------------------------------------------------------*
* 3. Modify one field after copy
*---------------------------------------------------------------------*
gs_employee2-department = 'Finance'.

*---------------------------------------------------------------------*
* 4. CLEAR structure
*---------------------------------------------------------------------*
CLEAR gs_employee1.

*---------------------------------------------------------------------*
* 5. VALUE constructor usage
*---------------------------------------------------------------------*
gs_employee1 = VALUE ty_employee(
  employee_id = 2002
  first_name  = 'Test'
  last_name   = 'Employee'
  department  = 'HR'
).

*---------------------------------------------------------------------*
* Output
*---------------------------------------------------------------------*
WRITE: / 'Employee 1'.
WRITE: / 'ID:', gs_employee1-employee_id.
WRITE: / 'Name:', gs_employee1-first_name, gs_employee1-last_name.
WRITE: / 'Department:', gs_employee1-department.

WRITE: / sy-uline.

WRITE: / 'Employee 2 (Copied + Modified)'.
WRITE: / 'ID:', gs_employee2-employee_id.
WRITE: / 'Name:', gs_employee2-first_name, gs_employee2-last_name.
WRITE: / 'Department:', gs_employee2-department.
