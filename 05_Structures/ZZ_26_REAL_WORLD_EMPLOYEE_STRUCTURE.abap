*&---------------------------------------------------------------------*
*& Report ZZ_26_REAL_WORLD_EMPLOYEE_STRUCTURE
*&---------------------------------------------------------------------*
*& Purpose:
*&   Real-world style employee report using structures.
*&
*& Topics Covered:
*&   - Complex structure handling
*&   - Business logic in ABAP reports
*&   - Filtering + calculation
*&   - Nested data processing
*&---------------------------------------------------------------------*

REPORT ZZ_26_REAL_WORLD_EMPLOYEE_STRUCTURE.

*---------------------------------------------------------------------*
* Structure Definition
*---------------------------------------------------------------------*
TYPES: BEGIN OF ty_address,
         city    TYPE string,
         country TYPE string,
       END OF ty_address.

TYPES: BEGIN OF ty_employee,
         employee_id TYPE i,
         name        TYPE string,
         department  TYPE string,
         salary      TYPE p LENGTH 8 DECIMALS 2,
         address     TYPE ty_address,
       END OF ty_employee.

*---------------------------------------------------------------------*
* Internal Table
*---------------------------------------------------------------------*
DATA gt_employee TYPE STANDARD TABLE OF ty_employee.
DATA gs_employee TYPE ty_employee.

DATA gv_total_salary TYPE p LENGTH 10 DECIMALS 2 VALUE 0.

*---------------------------------------------------------------------*
* Sample Data
*---------------------------------------------------------------------*
gs_employee = VALUE #( employee_id = 1001
                       name        = 'Demo A'
                       department  = 'IT'
                       salary      = '45000'
                       address-city    = 'Berlin'
                       address-country = 'Germany' ).
APPEND gs_employee TO gt_employee.

gs_employee = VALUE #( employee_id = 1002
                       name        = 'Demo B'
                       department  = 'HR'
                       salary      = '38000'
                       address-city    = 'Paris'
                       address-country = 'France' ).
APPEND gs_employee TO gt_employee.

gs_employee = VALUE #( employee_id = 1003
                       name        = 'Demo C'
                       department  = 'IT'
                       salary      = '52000'
                       address-city    = 'Berlin'
                       address-country = 'Germany' ).
APPEND gs_employee TO gt_employee.

*---------------------------------------------------------------------*
* Business Logic
*---------------------------------------------------------------------*
WRITE: / 'IT Department Employee Report'.
WRITE: / sy-uline.

LOOP AT gt_employee INTO gs_employee.

  IF gs_employee-department = 'IT'.

    gv_total_salary = gv_total_salary + gs_employee-salary.

    WRITE: / 'ID:', gs_employee-employee_id,
             'Name:', gs_employee-name,
             'City:', gs_employee-address-city,
             'Salary:', gs_employee-salary.

  ENDIF.

ENDLOOP.

*---------------------------------------------------------------------*
* Summary Section
*---------------------------------------------------------------------*
WRITE: / sy-uline.
WRITE: / 'Total IT Salary Cost:', gv_total_salary.
