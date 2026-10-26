REPORT zoop_02_attributes_and_methods.

*---------------------------------------------------------------------*
* Program    : ZOOP_02_ATTRIBUTES_AND_METHODS
* Title      : Attributes and Methods in ABAP Objects
* Purpose    : Demonstrate object attributes and instance methods
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This program defines a product class with attributes for product
* information and methods to display details and calculate total
* price based on unit price and quantity.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Class Attributes
* 2. Instance Attributes
* 3. Method Definition and Implementation
* 4. IMPORTING Parameters
* 5. RETURNING Parameters
* 6. Object State and Method Behavior
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* Understand how attributes store object data and how methods
* operate on that data or return calculated results.
*---------------------------------------------------------------------*

************************************************************************
* Class Definition
************************************************************************
CLASS lcl_product DEFINITION.

  PUBLIC SECTION.

    " Product attributes
    DATA:
      product_id   TYPE char10,
      product_name TYPE string,
      unit_price   TYPE p LENGTH 8 DECIMALS 2,
      quantity     TYPE i.

    " Display product information
    METHODS display_details.

    " Calculate the total price
    METHODS calculate_total
      RETURNING
        VALUE(rv_total) TYPE p LENGTH 8 DECIMALS 2.

    " Update the product quantity
    METHODS update_quantity
      IMPORTING
        iv_quantity TYPE i.

ENDCLASS.

************************************************************************
* Class Implementation
************************************************************************
CLASS lcl_product IMPLEMENTATION.

  METHOD display_details.

    WRITE: / 'Product ID   :', product_id.
    WRITE: / 'Product Name :', product_name.
    WRITE: / 'Unit Price   :', unit_price.
    WRITE: / 'Quantity     :', quantity.

    ULINE.

  ENDMETHOD.

  METHOD calculate_total.

    rv_total = unit_price * quantity.

  ENDMETHOD.

  METHOD update_quantity.

    IF iv_quantity < 0.
      WRITE: / 'Error: Quantity cannot be negative.'.
      RETURN.
    ENDIF.

    quantity = iv_quantity.

    WRITE: / 'Quantity updated successfully.'.

  ENDMETHOD.

ENDCLASS.

************************************************************************
* Data Declaration
************************************************************************
DATA:
  go_product_1 TYPE REF TO lcl_product,
  go_product_2 TYPE REF TO lcl_product,
  gv_total     TYPE p LENGTH 8 DECIMALS 2.

************************************************************************
* Main Processing
************************************************************************
START-OF-SELECTION.

  " Create the first product object
  CREATE OBJECT go_product_1.

  go_product_1->product_id   = 'PRD-001'.
  go_product_1->product_name = 'Keyboard'.
  go_product_1->unit_price   = '750.00'.
  go_product_1->quantity     = 2.

  " Create the second product object
  CREATE OBJECT go_product_2.

  go_product_2->product_id   = 'PRD-002'.
  go_product_2->product_name = 'Mouse'.
  go_product_2->unit_price   = '350.00'.
  go_product_2->quantity     = 3.

  " Display the first product
  WRITE: / 'PRODUCT 1'.
  ULINE.

  go_product_1->display_details( ).

  gv_total = go_product_1->calculate_total( ).

  WRITE: / 'Total Price:', gv_total.
  ULINE.

  " Display the second product
  WRITE: / 'PRODUCT 2'.
  ULINE.

  go_product_2->display_details( ).

  gv_total = go_product_2->calculate_total( ).

  WRITE: / 'Total Price:', gv_total.
  ULINE.

  " Update the first product quantity
  WRITE: / 'QUANTITY UPDATE'.
  ULINE.

  go_product_1->update_quantity(
    iv_quantity = 4
  ).

  " Calculate the total again after the update
  gv_total = go_product_1->calculate_total( ).

  WRITE: / 'Updated Quantity:', go_product_1->quantity.
  WRITE: / 'Updated Total  :', gv_total.
  ULINE.
