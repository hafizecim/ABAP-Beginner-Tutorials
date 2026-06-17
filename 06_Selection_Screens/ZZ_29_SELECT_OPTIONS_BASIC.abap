*&---------------------------------------------------------------------*
*& Report ZZ_29_SELECT_OPTIONS_BASIC
*&---------------------------------------------------------------------*
*& Purpose:
*&   Demonstrates basic SELECT-OPTIONS usage in ABAP.
*&
*& Topics Covered:
*&   - SELECT-OPTIONS declaration
*&   - Range table structure
*&   - LOW and HIGH values
*&   - Multiple selection handling
*&   - LOOP on selection ranges
*&---------------------------------------------------------------------*

REPORT ZZ_29_SELECT_OPTIONS_BASIC.

*---------------------------------------------------------------------*
* Selection Screen
*---------------------------------------------------------------------*
SELECT-OPTIONS:
  so_empid FOR sy-tabix.

*---------------------------------------------------------------------*
* Processing
*---------------------------------------------------------------------*
START-OF-SELECTION.

  WRITE: / 'Employee Selection Entries'.
  WRITE: / sy-uline.

  IF so_empid[] IS INITIAL.

    WRITE: / 'No selection entered.'.

  ELSE.

    LOOP AT so_empid INTO DATA(ls_empid).

      WRITE: / 'SIGN  :', ls_empid-sign.
      WRITE: / 'OPTION:', ls_empid-option.
      WRITE: / 'LOW   :', ls_empid-low.
      WRITE: / 'HIGH  :', ls_empid-high.

      WRITE: / sy-uline.

    ENDLOOP.

  ENDIF.
