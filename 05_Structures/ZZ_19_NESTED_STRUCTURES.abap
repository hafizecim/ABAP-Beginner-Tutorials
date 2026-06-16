*&---------------------------------------------------------------------*
*& Report ZZ_19_NESTED_STRUCTURES
*&---------------------------------------------------------------------*
*& Purpose:
*&   Demonstrates Nested Structures in ABAP.
*&
*& Topics Covered:
*&   - Structure within another Structure
*&   - Accessing Nested Fields
*&   - Displaying Nested Structure Data
*&---------------------------------------------------------------------*

REPORT ZZ_19_NESTED_STRUCTURES.

*---------------------------------------------------------------------*
* Address Structure
*---------------------------------------------------------------------*
TYPES: BEGIN OF ty_address,
         city        TYPE string,
         country     TYPE string,
         postal_code TYPE string,
       END OF ty_address.

*---------------------------------------------------------------------*
* Employee Structure (Nested Structure)
*---------------------------------------------------------------------*
TYPES: BEGIN OF ty_employee,
         employee_id TYPE i,
         first_name  TYPE string,
         last_name   TYPE string,
         department  TYPE string,
         address     TYPE ty_address,
       END OF ty_employee.

*---------------------------------------------------------------------*
* Structure Variable
*---------------------------------------------------------------------*
DATA gs_employee TYPE ty_employee.

*---------------------------------------------------------------------*
* Assign Values
*---------------------------------------------------------------------*
gs_employee-employee_id = 1001.
gs_employee-first_name  = 'Emre'.
gs_employee-last_name   = 'Kaya'.
gs_employee-department  = 'SAP ABAP'.

gs_employee-address-city        = 'Istanbul'.
gs_employee-address-country     = 'Turkey'.
gs_employee-address-postal_code = '42000'.

*---------------------------------------------------------------------*
* Output
*---------------------------------------------------------------------*
WRITE: / 'Employee Information'.
WRITE: / sy-uline.

WRITE: / 'Employee ID :', gs_employee-employee_id.
WRITE: / 'First Name  :', gs_employee-first_name.
WRITE: / 'Last Name   :', gs_employee-last_name.
WRITE: / 'Department  :', gs_employee-department.

WRITE: /.
WRITE: / 'Address Information'.
WRITE: / sy-uline.

WRITE: / 'City        :', gs_employee-address-city.
WRITE: / 'Country     :', gs_employee-address-country.
WRITE: / 'Postal Code :', gs_employee-address-postal_code.

WRITE: / sy-uline.
