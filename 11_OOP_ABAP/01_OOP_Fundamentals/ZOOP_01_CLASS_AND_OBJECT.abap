REPORT zoop_01_class_and_object.

*---------------------------------------------------------------------*
* Program    : ZOOP_01_CLASS_AND_OBJECT
* Title      : Introduction to Classes and Objects
* Purpose    : Demonstrate classes, objects, attributes, and methods
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This program introduces the basic concepts of object-oriented
* programming in ABAP.
*
* A local class represents a bank account. Two separate objects are
* created from the same class, each holding its own account holder
* and balance information.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Local Class Definition and Implementation
* 2. Public Attributes
* 3. Instance Methods
* 4. Object References
* 5. Object Creation
* 6. Independent Object Data
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* Understand the difference between a class and an object.
* Learn how attributes store data and methods define behavior.
* Observe how separate objects maintain independent state.
*---------------------------------------------------------------------*

************************************************************************
* Class Definition
************************************************************************
CLASS lcl_bank_account DEFINITION.

  PUBLIC SECTION.

    " Attributes: Data belonging to each account object
    DATA:
      account_holder TYPE string,
      balance        TYPE p LENGTH 8 DECIMALS 2.

    " Methods: Behaviors provided by the class
    METHODS:
      display_account,
      deposit
        IMPORTING
          iv_amount TYPE p LENGTH 8 DECIMALS 2.

ENDCLASS.

************************************************************************
* Class Implementation
************************************************************************
CLASS lcl_bank_account IMPLEMENTATION.

  METHOD display_account.

    WRITE: / 'Account Holder:', account_holder.
    WRITE: / 'Balance:', balance.
    ULINE.

  ENDMETHOD.

  METHOD deposit.

    IF iv_amount <= 0.
      WRITE: / 'Deposit amount must be greater than zero.'.
      RETURN.
    ENDIF.

    balance = balance + iv_amount.

    WRITE: / 'Deposit completed successfully.'.
    WRITE: / 'Deposited Amount:', iv_amount.
    WRITE: / 'Updated Balance:', balance.
    ULINE.

  ENDMETHOD.

ENDCLASS.

************************************************************************
* Data Declaration
************************************************************************
DATA:
  go_account_1 TYPE REF TO lcl_bank_account,
  go_account_2 TYPE REF TO lcl_bank_account.

************************************************************************
* Main Processing
************************************************************************
START-OF-SELECTION.

  " Create the first bank account object
  CREATE OBJECT go_account_1.

  " Assign initial values to the first object
  go_account_1->account_holder = 'Customer A'.
  go_account_1->balance = '1500.00'.

  " Create the second bank account object
  CREATE OBJECT go_account_2.

  " Assign initial values to the second object
  go_account_2->account_holder = 'Customer B'.
  go_account_2->balance = '3000.00'.

  " Display the initial account information
  WRITE: / 'INITIAL ACCOUNT INFORMATION'.
  ULINE.

  go_account_1->display_account( ).
  go_account_2->display_account( ).

  " Deposit money into the first account
  WRITE: / 'DEPOSIT TRANSACTION'.
  ULINE.

  go_account_1->deposit(
    iv_amount = '500.00'
  ).

  " Display both accounts after the transaction
  WRITE: / 'ACCOUNT INFORMATION AFTER DEPOSIT'.
  ULINE.

  go_account_1->display_account( ).
  go_account_2->display_account( ).
