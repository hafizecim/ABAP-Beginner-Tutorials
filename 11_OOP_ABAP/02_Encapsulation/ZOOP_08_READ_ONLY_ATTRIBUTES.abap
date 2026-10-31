REPORT zoop_08_read_only_attributes.

*---------------------------------------------------------------------*
* Program    : ZOOP_08_READ_ONLY_ATTRIBUTES
* Title      : Read-Only Attributes in ABAP Objects
* Purpose    : Demonstrate read-only access to private attributes
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* Defines an employee class with a private employee ID.
* The employee ID can be read through a getter method.
* No setter method is provided for changing the employee ID.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Read-Only Attributes
* 2. PRIVATE Attributes
* 3. Getter Methods
* 4. Attribute Protection
* 5. Controlled Access
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* Understand how to expose an attribute for reading without
* providing an external method to modify its value.
*---------------------------------------------------------------------*

************************************************************************
* Class Definition
************************************************************************
CLASS lcl_employee DEFINITION.

  PUBLIC SECTION.

    METHODS:
      constructor
        IMPORTING
          iv_employee_id   TYPE char10
          iv_employee_name TYPE string,

      get_employee_id
        RETURNING
          VALUE(rv_employee_id) TYPE char10,

      get_employee_name
        RETURNING
          VALUE(rv_employee_name) TYPE string,

      display_employee.

  PRIVATE SECTION.

    " Employee ID is initialized during object creation
    DATA:
      mv_employee_id   TYPE char10,
      mv_employee_name TYPE string.

ENDCLASS.

************************************************************************
* Class Implementation
************************************************************************
CLASS lcl_employee IMPLEMENTATION.

  METHOD constructor.

    mv_employee_id   = iv_employee_id.
    mv_employee_name = iv_employee_name.

  ENDMETHOD.

  METHOD get_employee_id.

    rv_employee_id = mv_employee_id.

  ENDMETHOD.

  METHOD get_employee_name.

    rv_employee_name = mv_employee_name.

  ENDMETHOD.

  METHOD display_employee.

    WRITE: / 'Employee Information'.
    ULINE.

    WRITE: / 'Employee ID:', mv_employee_id.
    WRITE: / 'Employee Name:', mv_employee_name.

    ULINE.

  ENDMETHOD.

ENDCLASS.

************************************************************************
* Data Declaration
************************************************************************
DATA:
  go_employee     TYPE REF TO lcl_employee,
  gv_employee_id TYPE char10,
  gv_employee_name TYPE string.

************************************************************************
* Main Processing
************************************************************************
START-OF-SELECTION.

  " Create an employee object
  CREATE OBJECT go_employee
    EXPORTING
      iv_employee_id   = 'EMP0001001'
      iv_employee_name = 'Alex Morgan'.

  " Read employee ID through getter method
  gv_employee_id = go_employee->get_employee_id( ).

  " Read employee name through getter method
  gv_employee_name = go_employee->get_employee_name( ).

  WRITE: / 'Read-Only Attribute Example'.
  WRITE: / 'Employee ID:', gv_employee_id.
  WRITE: / 'Employee Name:', gv_employee_name.

  ULINE.

  " Display employee information
  go_employee->display_employee( ).

  " Direct modification is not allowed because the attribute is private.
  " No setter method exists for employee ID.
  " The following statement would cause a syntax error:
  "* go_employee->mv_employee_id = 'EMP0002002'.
