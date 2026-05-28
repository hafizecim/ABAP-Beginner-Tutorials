*---------------------------------------------------------------------*
* Program Name : ZZ_03_DATA_TYPES_EXAMPLES_2
* Author       : Hafize
* Created Date : 28.05.2026
*
* Purpose      :
* Demonstrates commonly used ABAP data types including
* elementary types, structures, internal tables,
* references, and basic object-oriented programming.
*
* Topics       :
* - Elementary Data Types
* - Structures
* - Internal Tables
* - Reference Types
* - Classes and Methods
* - Modern ABAP Syntax
*---------------------------------------------------------------------*

REPORT zz_03_data_types_examples_2.

*---------------------------------------------------------------------*
* 1. Elementary Data Types
*---------------------------------------------------------------------*

" Fixed-length character field
DATA lv_char TYPE c LENGTH 10.

" Dynamic-length string field
DATA lv_string TYPE string.

" Integer number
DATA lv_int TYPE i.

" Packed decimal number
DATA lv_dec TYPE p LENGTH 8 DECIMALS 2.

" Floating point number
DATA lv_flt TYPE f.

" Boolean value ('X' = true, space = false)
DATA lv_bool TYPE abap_bool.

" Date type (YYYYMMDD)
DATA lv_date TYPE d.

" Time type (HHMMSS)
DATA lv_time TYPE t.

*---------------------------------------------------------------------*
* Assign Values
*---------------------------------------------------------------------*

lv_char   = 'ABAP'.
lv_string = 'Modern ABAP Programming'.
lv_int    = 100.
lv_dec    = '1250.75'.
lv_flt    = '45.89'.
lv_bool   = abap_true.
lv_date   = sy-datum.
lv_time   = sy-uzeit.

*---------------------------------------------------------------------*
* Display Elementary Data Types
*---------------------------------------------------------------------*

WRITE: / '===== Elementary Data Types ====='.
ULINE.

WRITE: / 'Character Type        :', lv_char.
WRITE: / 'String Type           :', lv_string.
WRITE: / 'Integer Type          :', lv_int.
WRITE: / 'Packed Decimal Type   :', lv_dec.
WRITE: / 'Floating Point Type   :', lv_flt.
WRITE: / 'Boolean Type          :', lv_bool.
WRITE: / 'Date Type             :', lv_date.
WRITE: / 'Time Type             :', lv_time.

ULINE.

*---------------------------------------------------------------------*
* 2. Structured Data Types
*---------------------------------------------------------------------*

" Structure definition
TYPES: BEGIN OF ty_person,
         name   TYPE string,
         age    TYPE i,
         gender TYPE c LENGTH 1,
       END OF ty_person.

" Structure variable
DATA ls_person TYPE ty_person.

*---------------------------------------------------------------------*
* Assign Structure Values
*---------------------------------------------------------------------*

ls_person-name   = 'Ahmet'.
ls_person-age    = 30.
ls_person-gender = 'M'.

*---------------------------------------------------------------------*
* Display Structure Data
*---------------------------------------------------------------------*

WRITE: / '===== Structure Example ====='.
ULINE.

WRITE: / 'Name   :', ls_person-name.
WRITE: / 'Age    :', ls_person-age.
WRITE: / 'Gender :', ls_person-gender.

ULINE.

*---------------------------------------------------------------------*
* 3. Internal Tables
*---------------------------------------------------------------------*

" Internal table type definition
TYPES ty_numbers TYPE TABLE OF i WITH DEFAULT KEY.

" Internal table variable
DATA lt_numbers TYPE ty_numbers.

*---------------------------------------------------------------------*
* Populate Internal Table
*---------------------------------------------------------------------*

APPEND 10 TO lt_numbers.
APPEND 20 TO lt_numbers.
APPEND 30 TO lt_numbers.

*---------------------------------------------------------------------*
* Display Internal Table Contents
*---------------------------------------------------------------------*

WRITE: / '===== Internal Table Example ====='.
ULINE.

LOOP AT lt_numbers INTO DATA(lv_num).

  WRITE: / 'Table Value :', lv_num.

ENDLOOP.

ULINE.

*---------------------------------------------------------------------*
* 4. Object-Oriented ABAP Example
*---------------------------------------------------------------------*

CLASS lcl_demo DEFINITION.

  PUBLIC SECTION.

    METHODS:
      say_hello.

ENDCLASS.

CLASS lcl_demo IMPLEMENTATION.

  METHOD say_hello.

    WRITE: / 'Hello from ABAP Object!'.

  ENDMETHOD.

ENDCLASS.

*---------------------------------------------------------------------*
* Create Object Reference
*---------------------------------------------------------------------*

DATA lo_demo TYPE REF TO lcl_demo.

CREATE OBJECT lo_demo.

*---------------------------------------------------------------------*
* Call Object Method
*---------------------------------------------------------------------*

WRITE: / '===== Object-Oriented Example ====='.
ULINE.

lo_demo->say_hello( ).

ULINE.

*---------------------------------------------------------------------*
* 5. Structured Internal Tables
*---------------------------------------------------------------------*

" Employee structure definition
TYPES: BEGIN OF ty_employee,
         id   TYPE i,
         name TYPE string,
         age  TYPE i,
       END OF ty_employee.

" Employee internal table type
TYPES ty_emp_table TYPE TABLE OF ty_employee WITH DEFAULT KEY.

" Internal table variable
DATA lt_employees TYPE ty_emp_table.

*---------------------------------------------------------------------*
* Populate Employee Table
*---------------------------------------------------------------------*

APPEND VALUE #(
  id   = 1
  name = 'Ayse'
  age  = 28
) TO lt_employees.

APPEND VALUE #(
  id   = 2
  name = 'Mehmet'
  age  = 35
) TO lt_employees.

*---------------------------------------------------------------------*
* Display Employee Data
*---------------------------------------------------------------------*

WRITE: / '===== Employee Table Example ====='.
ULINE.

LOOP AT lt_employees INTO DATA(ls_employee).

  WRITE: / 'ID   :', ls_employee-id.
  WRITE: / 'Name :', ls_employee-name.
  WRITE: / 'Age  :', ls_employee-age.

  ULINE.

ENDLOOP.

*---------------------------------------------------------------------*
* 6. Reference Types
*---------------------------------------------------------------------*

" Binary data type
DATA lv_xstring TYPE xstring.

lv_xstring = '4D5A'.

" Data reference variable
DATA lr_person TYPE REF TO ty_person.

CREATE DATA lr_person.

*---------------------------------------------------------------------*
* Assign Values via Reference
*---------------------------------------------------------------------*

lr_person->name   = 'Zeynep'.
lr_person->age    = 25.
lr_person->gender = 'F'.

*---------------------------------------------------------------------*
* Display Reference Data
*---------------------------------------------------------------------*

WRITE: / '===== Reference Type Example ====='.
ULINE.

WRITE: / 'Name   :', lr_person->name.
WRITE: / 'Age    :', lr_person->age.
WRITE: / 'Gender :', lr_person->gender.

ULINE.

*---------------------------------------------------------------------*
* 7. Boolean Example
*---------------------------------------------------------------------*

WRITE: / '===== Boolean Example ====='.
ULINE.

IF lv_bool = abap_true.

  WRITE: / 'Boolean Result : TRUE'.

ELSE.

  WRITE: / 'Boolean Result : FALSE'.

ENDIF.

ULINE.
