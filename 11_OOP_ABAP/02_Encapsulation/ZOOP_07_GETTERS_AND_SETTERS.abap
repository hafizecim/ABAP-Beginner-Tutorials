REPORT zoop_07_getters_and_setters.

*---------------------------------------------------------------------*
* Program    : ZOOP_07_GETTERS_AND_SETTERS
* Title      : Getters and Setters in ABAP Objects
* Purpose    : Demonstrate controlled access to private attributes
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* Defines a product class with private attributes.
* Getter methods provide read access to product information.
* Setter methods validate input before modifying product data.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Getter Methods
* 2. Setter Methods
* 3. PRIVATE Attributes
* 4. Data Validation
* 5. Controlled Attribute Access
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* Understand how getter and setter methods provide controlled
* access to private class attributes.
*---------------------------------------------------------------------*

************************************************************************
* Class Definition
************************************************************************
CLASS lcl_product DEFINITION.

  PUBLIC SECTION.

    METHODS:
      constructor
        IMPORTING
          iv_product_name TYPE string
          iv_unit_price   TYPE p LENGTH 8 DECIMALS 2,

      " Getter methods
      get_product_name
        RETURNING
          VALUE(rv_product_name) TYPE string,

      get_unit_price
        RETURNING
          VALUE(rv_unit_price) TYPE p LENGTH 8 DECIMALS 2,

      " Setter methods
      set_product_name
        IMPORTING
          iv_product_name TYPE string,

      set_unit_price
        IMPORTING
          iv_unit_price TYPE p LENGTH 8 DECIMALS 2.

  PRIVATE SECTION.

    DATA:
      mv_product_name TYPE string,
      mv_unit_price   TYPE p LENGTH 8 DECIMALS 2.

ENDCLASS.

************************************************************************
* Class Implementation
************************************************************************
CLASS lcl_product IMPLEMENTATION.

  METHOD constructor.

    mv_product_name = iv_product_name.

    IF iv_unit_price > 0.
      mv_unit_price = iv_unit_price.
    ELSE.
      mv_unit_price = 0.
    ENDIF.

  ENDMETHOD.

  METHOD get_product_name.

    rv_product_name = mv_product_name.

  ENDMETHOD.

  METHOD get_unit_price.

    rv_unit_price = mv_unit_price.

  ENDMETHOD.

  METHOD set_product_name.

    IF iv_product_name IS INITIAL.
      WRITE: / 'Error: Product name cannot be empty.'.
      RETURN.
    ENDIF.

    mv_product_name = iv_product_name.

    WRITE: / 'Product name updated successfully.'.

  ENDMETHOD.

  METHOD set_unit_price.

    IF iv_unit_price <= 0.
      WRITE: / 'Error: Unit price must be greater than zero.'.
      RETURN.
    ENDIF.

    mv_unit_price = iv_unit_price.

    WRITE: / 'Product price updated successfully.'.

  ENDMETHOD.

ENDCLASS.

************************************************************************
* Data Declaration
************************************************************************
DATA:
  go_product      TYPE REF TO lcl_product,
  gv_product_name TYPE string,
  gv_unit_price   TYPE p LENGTH 8 DECIMALS 2.

************************************************************************
* Main Processing
************************************************************************
START-OF-SELECTION.

  " Create a product
  CREATE OBJECT go_product
    EXPORTING
      iv_product_name = 'Laptop'
      iv_unit_price   = '25000.00'.

  " Read product information using getter methods
  gv_product_name = go_product->get_product_name( ).
  gv_unit_price   = go_product->get_unit_price( ).

  WRITE: / 'Initial Product Information'.
  WRITE: / 'Product Name:', gv_product_name.
  WRITE: / 'Unit Price:', gv_unit_price.
  ULINE.

  " Update product name using a setter method
  go_product->set_product_name(
    iv_product_name = 'Business Laptop'
  ).

  " Update product price using a setter method
  go_product->set_unit_price(
    iv_unit_price = '27500.00'
  ).

  ULINE.

  " Read updated information using getter methods
  gv_product_name = go_product->get_product_name( ).
  gv_unit_price   = go_product->get_unit_price( ).

  WRITE: / 'Updated Product Information'.
  WRITE: / 'Product Name:', gv_product_name.
  WRITE: / 'Unit Price:', gv_unit_price.

  " Direct access to private attributes is not allowed.
  " The following statement would cause a syntax error:
  "* WRITE go_product->mv_unit_price.
