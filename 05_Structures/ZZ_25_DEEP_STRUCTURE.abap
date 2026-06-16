*&---------------------------------------------------------------------*
*& Report ZZ_25_DEEP_STRUCTURE
*&---------------------------------------------------------------------*
*& Purpose:
*&   Demonstrates deep structures (nested structure + internal table).
*&
*& Topics Covered:
*&   - Nested structures
*&   - Internal table inside structure
*&   - Complex data modeling
*&   - LOOP on deep structures
*&---------------------------------------------------------------------*

REPORT zz_25_deep_structure.

*---------------------------------------------------------------------*
* Address Structure
*---------------------------------------------------------------------*
TYPES: BEGIN OF ty_address,
         city    TYPE string,
         country TYPE string,
       END OF ty_address.

*---------------------------------------------------------------------*
* Phone Structure
*---------------------------------------------------------------------*
TYPES: BEGIN OF ty_phone,
         phone_number TYPE string,
       END OF ty_phone.

*---------------------------------------------------------------------*
* Phone Table Type
*---------------------------------------------------------------------*
TYPES ty_phone_tab TYPE STANDARD TABLE OF ty_phone WITH EMPTY KEY.

*---------------------------------------------------------------------*
* Employee Deep Structure
*---------------------------------------------------------------------*
TYPES: BEGIN OF ty_employee,
         employee_id TYPE i,
         name        TYPE string,
         address     TYPE ty_address,
         phones      TYPE ty_phone_tab,
       END OF ty_employee.

*---------------------------------------------------------------------*
* Data Declarations
*---------------------------------------------------------------------*
DATA gs_employee TYPE ty_employee.
DATA gt_employee TYPE STANDARD TABLE OF ty_employee.

DATA gs_phone TYPE ty_phone.

*---------------------------------------------------------------------*
* Fill Data
*---------------------------------------------------------------------*
gs_employee-employee_id = 1001.
gs_employee-name        = 'Demo User'.

gs_employee-address-city    = 'Berlin'.
gs_employee-address-country = 'Germany'.

gs_phone-phone_number = '+49-111-1111'.
APPEND gs_phone TO gs_employee-phones.

gs_phone-phone_number = '+49-222-2222'.
APPEND gs_phone TO gs_employee-phones.

APPEND gs_employee TO gt_employee.

CLEAR gs_employee.
CLEAR gs_phone.

*---------------------------------------------------------------------*
* Output Deep Structure
*---------------------------------------------------------------------*
WRITE: / 'Employee Details (Deep Structure)'.
WRITE: / sy-uline.

LOOP AT gt_employee INTO gs_employee.

  WRITE: / 'ID:', gs_employee-employee_id,
           'Name:', gs_employee-name.

  WRITE: / 'City:', gs_employee-address-city,
           'Country:', gs_employee-address-country.

  WRITE: / 'Phone Numbers:'.

  LOOP AT gs_employee-phones INTO gs_phone.
    WRITE: / '-', gs_phone-phone_number.
  ENDLOOP.

  WRITE: / sy-uline.

ENDLOOP.
