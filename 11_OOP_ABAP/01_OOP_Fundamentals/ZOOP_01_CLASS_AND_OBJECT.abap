REPORT ZOOP_01_CLASS_AND_OBJECT.

*---------------------------------------------------------------------*
* Program    : ZOOP_01_CLASS_AND_OBJECT
* Title      : Introduction to Classes and Objects
* Purpose    : Demonstrate basic object-oriented programming in ABAP
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* Defines a local class, creates an object instance, and calls an
* instance method to display a message.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Local Class Definition
* 2. Public Section
* 3. Instance Method
* 4. Object Reference
* 5. Object Creation with CREATE OBJECT
* 6. Method Invocation
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* Understand how a class is defined, how an object is created,
* and how an instance method is called in ABAP.
*---------------------------------------------------------------------*

************************************************************************
* Class Definition
************************************************************************
CLASS lcl_greeting DEFINITION.

  PUBLIC SECTION.
    METHODS:
      display_message.

ENDCLASS.

************************************************************************
* Class Implementation
************************************************************************
CLASS lcl_greeting IMPLEMENTATION.

  METHOD display_message.

    WRITE: / 'Hello! Welcome to ABAP Object-Oriented Programming.'.

  ENDMETHOD.

ENDCLASS.

************************************************************************
* Data Declaration
************************************************************************
DATA:
  go_greeting TYPE REF TO lcl_greeting.

************************************************************************
* Main Processing
************************************************************************
START-OF-SELECTION.

  " Create an object from the local class
  CREATE OBJECT go_greeting.

  " Call the object's instance method
  go_greeting->display_message( ).
