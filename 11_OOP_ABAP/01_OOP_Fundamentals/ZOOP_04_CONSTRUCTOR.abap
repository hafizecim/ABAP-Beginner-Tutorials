REPORT zoop_04_constructor.

*---------------------------------------------------------------------*
* Program    : ZOOP_04_CONSTRUCTOR
* Title      : Instance Constructor in ABAP Objects
* Purpose    : Initialize object attributes during object creation
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* Defines a product class whose instance constructor receives product
* information and initializes the object's attributes automatically
* when an object is created.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Instance Constructor
* 2. IMPORTING Parameters
* 3. Automatic Constructor Invocation
* 4. Object Initialization
* 5. CREATE OBJECT
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* Understand how to initialize objects using a constructor and how
* constructor parameters are passed during object creation.
*---------------------------------------------------------------------*

************************************************************************
* Class Definition
************************************************************************
CLASS lcl_product DEFINITION.

  PUBLIC SECTION.

    DATA:
      product_id   TYPE char10,
      product_name TYPE string,
      unit_price   TYPE p LENGTH 8 DECIMALS 2.

    METHODS:
      constructor
        IMPORTING
          iv_product_id   TYPE char10
          iv_product_name TYPE string
          iv_unit_price   TYPE p LENGTH 8 DECIMALS 2,

      display_details.

ENDCLASS.

************************************************************************
* Class Implementation
************************************************************************
CLASS lcl_product IMPLEMENTATION.

  METHOD constructor.

    " Initialize the object's attributes
    product_id   = iv_product_id.
    product_name = iv_product_name.
    unit_price   = iv_unit_price.

  ENDMETHOD.

  METHOD display_details.

    WRITE: / 'Product ID  :', product_id.
    WRITE: / 'Product Name:', product_name.
    WRITE: / 'Unit Price  :', unit_price.
    ULINE.

  ENDMETHOD.

ENDCLASS.

************************************************************************
* Data Declaration
************************************************************************
DATA:
  go_product_1 TYPE REF TO lcl_product,
  go_product_2 TYPE REF TO lcl_product.

************************************************************************
* Main Processing
************************************************************************
START-OF-SELECTION.

  " Create the first object and initialize its attributes
  CREATE OBJECT go_product_1
    EXPORTING
      iv_product_id   = 'PRD-001'
      iv_product_name = 'Keyboard'
      iv_unit_price   = '750.00'.

  " Create the second object with different initial values
  CREATE OBJECT go_product_2
    EXPORTING
      iv_product_id   = 'PRD-002'
      iv_product_name = 'Monitor'
      iv_unit_price   = '4500.00'.

  " Display the initialized objects
  WRITE: / 'PRODUCT 1'.
  ULINE.
  go_product_1->display_details( ).

  WRITE: / 'PRODUCT 2'.
  ULINE.
  go_product_2->display_details( ).
