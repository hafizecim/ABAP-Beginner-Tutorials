REPORT zoop_10_inheritance_basics.

*---------------------------------------------------------------------*
* Program    : ZOOP_10_INHERITANCE_BASICS
* Title      : Inheritance Basics in ABAP Objects
* Purpose    : Demonstrate inheritance between local classes
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* Defines a base employee class and a derived manager class.
* The manager class inherits employee attributes and methods.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Inheritance
* 2. Superclass and Subclass
* 3. INHERITING FROM
* 4. Inherited Attributes
* 5. Inherited Methods
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* Understand how a subclass inherits accessible components
* from a superclass in ABAP Objects.
*---------------------------------------------------------------------*

************************************************************************
* Superclass Definition
************************************************************************
CLASS lcl_employee DEFINITION.

  PUBLIC SECTION.

    METHODS:
      constructor
        IMPORTING
          iv_employee_id   TYPE char10
          iv_employee_name TYPE string,

      display_employee.

  PROTECTED SECTION.

    DATA:
      mv_employee_id   TYPE char10,
      mv_employee_name TYPE string.

ENDCLASS.

************************************************************************
* Subclass Definition
************************************************************************
CLASS lcl_manager DEFINITION
  INHERITING FROM lcl_employee.

  PUBLIC SECTION.

    METHODS:
      set_department
        IMPORTING
          iv_department TYPE string,

      display_manager.

  PRIVATE SECTION.

    DATA mv_department TYPE string.

ENDCLASS.

************************************************************************
* Superclass Implementation
************************************************************************
CLASS lcl_employee IMPLEMENTATION.

  METHOD constructor.

    mv_employee_id   = iv_employee_id.
    mv_employee_name = iv_employee_name.

  ENDMETHOD.

  METHOD display_employee.

    WRITE: / 'Employee Information'.
    WRITE: / 'Employee ID:', mv_employee_id.
    WRITE: / 'Employee Name:', mv_employee_name.

  ENDMETHOD.

ENDCLASS.

************************************************************************
* Subclass Implementation
************************************************************************
CLASS lcl_manager IMPLEMENTATION.

  METHOD set_department.

    mv_department = iv_department.

  ENDMETHOD.

  METHOD display_manager.

    WRITE: / 'Manager Information'.
    ULINE.

    " Call inherited method
    display_employee( ).

    WRITE: / 'Department:', mv_department.

    ULINE.

  ENDMETHOD.

ENDCLASS.

************************************************************************
* Data Declaration
************************************************************************
DATA go_manager TYPE REF TO lcl_manager.

************************************************************************
* Main Processing
************************************************************************
START-OF-SELECTION.

  " Create a manager object
  CREATE OBJECT go_manager
    EXPORTING
      iv_employee_id   = 'EMP0001001'
      iv_employee_name = 'Alex Morgan'.

  " Set subclass-specific information
  go_manager->set_department(
    iv_department = 'Information Technology'
  ).

  " Display inherited and subclass information
  go_manager->display_manager( ).
