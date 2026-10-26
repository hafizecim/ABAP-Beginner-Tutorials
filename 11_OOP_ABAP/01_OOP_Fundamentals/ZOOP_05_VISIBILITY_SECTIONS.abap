REPORT zoop_05_visibility_sections.

*---------------------------------------------------------------------*
* Program    : ZOOP_05_VISIBILITY_SECTIONS
* Title      : Visibility Sections in ABAP Objects
* Purpose    : Demonstrate PUBLIC, PROTECTED, and PRIVATE components
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* Defines a bank account class to demonstrate visibility rules.
* The account balance is private, while public methods provide
* controlled access to account operations.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. PUBLIC SECTION
* 2. PROTECTED SECTION
* 3. PRIVATE SECTION
* 4. Encapsulation Basics
* 5. Controlled Access Through Methods
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* Understand how visibility sections control access to class
* attributes and methods in ABAP Objects.
*---------------------------------------------------------------------*

************************************************************************
* Class Definition
************************************************************************
CLASS lcl_bank_account DEFINITION.

  PUBLIC SECTION.

    METHODS:
      constructor
        IMPORTING
          iv_account_holder TYPE string
          iv_initial_balance TYPE p LENGTH 8 DECIMALS 2,

      display_account,
      deposit
        IMPORTING
          iv_amount TYPE p LENGTH 8 DECIMALS 2.

  PROTECTED SECTION.

    " Accessible in this class and its subclasses
    DATA account_holder TYPE string.

    METHODS display_holder.

  PRIVATE SECTION.

    " Accessible only within this class
    DATA balance TYPE p LENGTH 8 DECIMALS 2.

    METHODS validate_amount
      IMPORTING
        iv_amount TYPE p LENGTH 8 DECIMALS 2
      RETURNING
        VALUE(rv_valid) TYPE abap_bool.

ENDCLASS.

************************************************************************
* Class Implementation
************************************************************************
CLASS lcl_bank_account IMPLEMENTATION.

  METHOD constructor.

    account_holder = iv_account_holder.

    IF iv_initial_balance >= 0.
      balance = iv_initial_balance.
    ELSE.
      balance = 0.
    ENDIF.

  ENDMETHOD.

  METHOD display_account.

    WRITE: / 'Account Information'.
    ULINE.

    display_holder( ).

    WRITE: / 'Balance:', balance.
    ULINE.

  ENDMETHOD.

  METHOD display_holder.

    WRITE: / 'Account Holder:', account_holder.

  ENDMETHOD.

  METHOD validate_amount.

    rv_valid = abap_false.

    IF iv_amount > 0.
      rv_valid = abap_true.
    ENDIF.

  ENDMETHOD.

  METHOD deposit.

    IF validate_amount( iv_amount ) = abap_false.
      WRITE: / 'Error: Deposit amount must be greater than zero.'.
      RETURN.
    ENDIF.

    balance = balance + iv_amount.

    WRITE: / 'Deposit successful.'.
    WRITE: / 'Deposited Amount:', iv_amount.
    WRITE: / 'New Balance:', balance.
    ULINE.

  ENDMETHOD.

ENDCLASS.

************************************************************************
* Data Declaration
************************************************************************
DATA go_account TYPE REF TO lcl_bank_account.

************************************************************************
* Main Processing
************************************************************************
START-OF-SELECTION.

  " Create an account with an initial balance
  CREATE OBJECT go_account
    EXPORTING
      iv_account_holder  = 'Customer A'
      iv_initial_balance = '1500.00'.

  " Display account information
  go_account->display_account( ).

  " Deposit money through a public method
  go_account->deposit(
    iv_amount = '250.00'
  ).

  " Display the updated account information
  go_account->display_account( ).

  " Direct access to the private BALANCE attribute is not allowed.
  " The following statement would cause a syntax error:
  "* WRITE go_account->balance.
