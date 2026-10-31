REPORT zoop_09_friends_and_local_classes.

*---------------------------------------------------------------------*
* Program    : ZOOP_09_FRIENDS_AND_LOCAL_CLASSES
* Title      : Friends and Local Classes in ABAP Objects
* Purpose    : Demonstrate local classes and friend access
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* Defines two local classes:
* 1. A bank account class with private account information.
* 2. An account auditor class declared as its friend.
*
* The friend class can access private components of the bank
* account class.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Local Classes
* 2. FRIENDS Declaration
* 3. Friend Class Access
* 4. PRIVATE Attributes
* 5. Controlled Access
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* Understand how local classes are defined and how friend classes
* can access private and protected components of another class.
*---------------------------------------------------------------------*

************************************************************************
* Class Definitions
************************************************************************

CLASS lcl_account_auditor DEFINITION DEFERRED.

************************************************************************
* Bank Account Class
************************************************************************
CLASS lcl_bank_account DEFINITION.

  PUBLIC SECTION.

    METHODS:
      constructor
        IMPORTING
          iv_account_holder TYPE string
          iv_initial_balance TYPE p LENGTH 8 DECIMALS 2,

      deposit
        IMPORTING
          iv_amount TYPE p LENGTH 8 DECIMALS 2,

      display_account.

  PRIVATE SECTION.

    " Grant access to the auditor class
    FRIENDS lcl_account_auditor.

    DATA:
      mv_account_holder TYPE string,
      mv_balance        TYPE p LENGTH 8 DECIMALS 2.

ENDCLASS.

************************************************************************
* Account Auditor Class
************************************************************************
CLASS lcl_account_auditor DEFINITION.

  PUBLIC SECTION.

    METHODS:
      audit_account
        IMPORTING
          io_account TYPE REF TO lcl_bank_account.

ENDCLASS.

************************************************************************
* Class Implementations
************************************************************************

CLASS lcl_bank_account IMPLEMENTATION.

  METHOD constructor.

    mv_account_holder = iv_account_holder.

    IF iv_initial_balance >= 0.
      mv_balance = iv_initial_balance.
    ELSE.
      mv_balance = 0.
    ENDIF.

  ENDMETHOD.

  METHOD deposit.

    IF iv_amount <= 0.
      WRITE: / 'Error: Deposit amount must be greater than zero.'.
      RETURN.
    ENDIF.

    mv_balance = mv_balance + iv_amount.

    WRITE: / 'Deposit successful.'.

  ENDMETHOD.

  METHOD display_account.

    WRITE: / 'Bank Account Information'.
    ULINE.

    WRITE: / 'Account Holder:', mv_account_holder.
    WRITE: / 'Account Balance:', mv_balance.

    ULINE.

  ENDMETHOD.

ENDCLASS.

CLASS lcl_account_auditor IMPLEMENTATION.

  METHOD audit_account.

    " Friend class can access private attributes
    WRITE: / 'Account Audit Report'.
    ULINE.

    WRITE: / 'Account Holder:',
             io_account->mv_account_holder.

    WRITE: / 'Audited Balance:',
             io_account->mv_balance.

    ULINE.

  ENDMETHOD.

ENDCLASS.

************************************************************************
* Data Declaration
************************************************************************
DATA:
  go_account TYPE REF TO lcl_bank_account,
  go_auditor TYPE REF TO lcl_account_auditor.

************************************************************************
* Main Processing
************************************************************************
START-OF-SELECTION.

  " Create a bank account
  CREATE OBJECT go_account
    EXPORTING
      iv_account_holder  = 'Customer A'
      iv_initial_balance = '3000.00'.

  " Create an auditor object
  CREATE OBJECT go_auditor.

  " Display account information
  go_account->display_account( ).

  " Deposit money
  go_account->deposit(
    iv_amount = '500.00'
  ).

  " Audit account using friend class
  go_auditor->audit_account(
    io_account = go_account
  ).
