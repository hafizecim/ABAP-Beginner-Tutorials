REPORT zoop_03_instance_and_static_components.

*---------------------------------------------------------------------*
* Program    : ZOOP_03_INSTANCE_AND_STATIC_COMPONENTS
* Title      : Instance and Static Components
* Purpose    : Demonstrate instance and static attributes and methods
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This program demonstrates the difference between instance
* components, which belong to individual objects, and static
* components, which belong to the class itself.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Instance Attributes
* 2. Static Attributes
* 3. Instance Methods
* 4. Static Methods
* 5. Accessing Static Components
* 6. Object-Specific and Class-Wide Data
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* Understand when to use instance components and when to use
* static components in ABAP Objects.
*---------------------------------------------------------------------*

************************************************************************
* Class Definition
************************************************************************
CLASS lcl_product DEFINITION.

  PUBLIC SECTION.

    " Instance attributes: Each object has its own values
    DATA:
      product_name  TYPE string,
      product_price TYPE p LENGTH 8 DECIMALS 2.

    " Static attribute: Shared by the class
    CLASS-DATA gv_object_count TYPE i.

    " Instance method
    METHODS display_product.

    " Static methods
    CLASS-METHODS:
      increment_object_count,
      display_object_count.

ENDCLASS.

************************************************************************
* Class Implementation
************************************************************************
CLASS lcl_product IMPLEMENTATION.

  METHOD display_product.

    WRITE: / 'Product Name :', product_name.
    WRITE: / 'Product Price:', product_price.
    ULINE.

  ENDMETHOD.

  METHOD increment_object_count.

    gv_object_count = gv_object_count + 1.

  ENDMETHOD.

  METHOD display_object_count.

    WRITE: / 'Total Product Objects Created:',
             gv_object_count.
    ULINE.

  ENDMETHOD.

ENDCLASS.

************************************************************************
* Data Declaration
************************************************************************
DATA:
  go_product_1 TYPE REF TO lcl_product,
  go_product_2 TYPE REF TO lcl_product,
  go_product_3 TYPE REF TO lcl_product.

************************************************************************
* Main Processing
************************************************************************
START-OF-SELECTION.

  " Create the first product object
  CREATE OBJECT go_product_1.

  go_product_1->product_name  = 'Keyboard'.
  go_product_1->product_price = '750.00'.

  lcl_product=>increment_object_count( ).

  " Create the second product object
  CREATE OBJECT go_product_2.

  go_product_2->product_name  = 'Mouse'.
  go_product_2->product_price = '350.00'.

  lcl_product=>increment_object_count( ).

  " Create the third product object
  CREATE OBJECT go_product_3.

  go_product_3->product_name  = 'Monitor'.
  go_product_3->product_price = '4500.00'.

  lcl_product=>increment_object_count( ).

  " Display each object's instance data
  WRITE: / 'INSTANCE COMPONENTS'.
  ULINE.

  go_product_1->display_product( ).
  go_product_2->display_product( ).
  go_product_3->display_product( ).

  " Display the shared static attribute
  WRITE: / 'STATIC COMPONENTS'.
  ULINE.

  lcl_product=>display_object_count( ).
