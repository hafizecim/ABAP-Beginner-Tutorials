REPORT zoop_06_encapsulation.

*---------------------------------------------------------------------*
* Program    : ZOOP_06_ENCAPSULATION
* Title      : Encapsulation in ABAP Objects
* Purpose    : Demonstrate data protection through encapsulation
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* Defines a bank account class that protects its internal balance.
* External programs cannot modify the balance directly.
* All balance operations are performed through public methods.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Encapsulation
* 2. PRIVATE Attributes
* 3. PUBLIC Methods
* 4. Data Protection
* 5. Controlled Data Modification
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* Understand how encapsulation protects object data and ensures
* that attributes are modified only through controlled methods.
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
          iv_amount TYPE p LENGTH 8 DECIMALS 2,

      withdraw
        IMPORTING
          iv_amount TYPE p LENGTH 8 DECIMALS 2,

      get_balance
        RETURNING
          VALUE(rv_balance) TYPE p LENGTH 8 DECIMALS 2.

  PRIVATE SECTION.

    " Internal data is protected from direct external access
    DATA:
      mv_account_holder TYPE string,
      mv_balance        TYPE p LENGTH 8 DECIMALS 2.

ENDCLASS.

************************************************************************
* Class Implementation
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

  METHOD display_account.

    WRITE: / 'Account Information'.
    ULINE.

    WRITE: / 'Account Holder:', mv_account_holder.
    WRITE: / 'Current Balance:', mv_balance.

    ULINE.

  ENDMETHOD.

  METHOD deposit.

    IF iv_amount <= 0.
      WRITE: / 'Error: Deposit amount must be greater than zero.'.
      RETURN.
    ENDIF.

    mv_balance = mv_balance + iv_amount.

    WRITE: / 'Deposit successful.'.
    WRITE: / 'Deposited Amount:', iv_amount.

  ENDMETHOD.

  METHOD withdraw.

    IF iv_amount <= 0.
      WRITE: / 'Error: Withdrawal amount must be greater than zero.'.
      RETURN.
    ENDIF.

    IF iv_amount > mv_balance.
      WRITE: / 'Error: Insufficient account balance.'.
      RETURN.
    ENDIF.

    mv_balance = mv_balance - iv_amount.

    WRITE: / 'Withdrawal successful.'.
    WRITE: / 'Withdrawn Amount:', iv_amount.

  ENDMETHOD.

  METHOD get_balance.

    rv_balance = mv_balance.

  ENDMETHOD.

ENDCLASS.

************************************************************************
* Data Declaration
************************************************************************
DATA:
  go_account TYPE REF TO lcl_bank_account,
  gv_balance TYPE p LENGTH 8 DECIMALS 2.

************************************************************************
* Main Processing
************************************************************************
START-OF-SELECTION.

  " Create a bank account
  CREATE OBJECT go_account
    EXPORTING
      iv_account_holder  = 'Customer A'
      iv_initial_balance = '2000.00'.

  " Display initial account information
  go_account->display_account( ).

  " Deposit money
  go_account->deposit(
    iv_amount = '500.00'
  ).

  " Withdraw money
  go_account->withdraw(
    iv_amount = '300.00'
  ).

  " Retrieve balance through a public method
  gv_balance = go_account->get_balance( ).

  WRITE: / 'Balance Retrieved Through Method:', gv_balance.

  " Direct access to the private attribute is not allowed.
  " The following statement would cause a syntax error:
  "* WRITE go_account->mv_balance.
