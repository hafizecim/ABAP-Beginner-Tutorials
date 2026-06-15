Report : ZZ_14_INTERNAL_TABLES_BASIC.

*---------------------------------------------------------------------*
* Report : ZZ_14_INTERNAL_TABLES_BASIC
* Purpose: Demonstrates basic internal table operations in ABAP
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Define a Structure
* 2. Define an Internal Table
* 3. Insert Data with APPEND
* 4. Loop Through an Internal Table
* 5. Display Table Contents
* 6. Count Table Entries
*---------------------------------------------------------------------*

"=========================================================
" 1. Define a Structure
"=========================================================
TYPES:
  BEGIN OF ty_employee,
    employee_id TYPE i,
    employee_name TYPE string,
    salary TYPE p LENGTH 8 DECIMALS 2,
  END OF ty_employee.

"=========================================================
" 2. Define an Internal Table
"=========================================================
DATA:
  lt_employees TYPE STANDARD TABLE OF ty_employee,
  ls_employee  TYPE ty_employee.

"=========================================================
" 3. Insert Data with APPEND
"=========================================================
ls_employee-employee_id   = 1.
ls_employee-employee_name = 'Ahmet'.
ls_employee-salary        = '25000'.
APPEND ls_employee TO lt_employees.

ls_employee-employee_id   = 2.
ls_employee-employee_name = 'Ayse'.
ls_employee-salary        = '32000'.
APPEND ls_employee TO lt_employees.

ls_employee-employee_id   = 3.
ls_employee-employee_name = 'Mehmet'.
ls_employee-salary        = '41000'.
APPEND ls_employee TO lt_employees.

WRITE: / 'Total Employees:',
       lines( lt_employees ).

ULINE.

"=========================================================
" 4. Loop Through an Internal Table
"=========================================================
LOOP AT lt_employees INTO ls_employee.

  WRITE: / 'Employee ID :', ls_employee-employee_id,
         / 'Name        :', ls_employee-employee_name,
         / 'Salary      :', ls_employee-salary.

  ULINE.

ENDLOOP.

"=========================================================
" End of Program
"=========================================================
WRITE: / 'Program completed successfully'.
