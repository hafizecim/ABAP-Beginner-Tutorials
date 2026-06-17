*&---------------------------------------------------------------------*
*& Report ZZ_33_SELECTION_SCREEN_VALIDATION
*&---------------------------------------------------------------------*
*& Purpose:
*&   Demonstrates validation on Selection Screen.
*&
*& Topics Covered:
*&   - AT SELECTION-SCREEN
*&   - Input validation
*&   - Mandatory logic control
*&   - Error messaging
*&---------------------------------------------------------------------*

REPORT ZZ_33_SELECTION_SCREEN_VALIDATION.

*---------------------------------------------------------------------*
* Selection Screen
*---------------------------------------------------------------------*
PARAMETERS:
  p_empid TYPE n LENGTH 8,
  p_name  TYPE string,
  p_sal   TYPE p LENGTH 8 DECIMALS 2,
  p_date  TYPE d.

*---------------------------------------------------------------------*
* Validation Logic
*---------------------------------------------------------------------*
AT SELECTION-SCREEN.

  " Employee ID check
  IF p_empid IS INITIAL.
    MESSAGE 'Employee ID cannot be empty' TYPE 'E'.
  ENDIF.

  " Name check
  IF p_name IS INITIAL.
    MESSAGE 'Employee Name is required' TYPE 'E'.
  ENDIF.

  " Salary check
  IF p_sal <= 0.
    MESSAGE 'Salary must be greater than zero' TYPE 'E'.
  ENDIF.

  " Date check (cannot be future date)
  IF p_date > sy-datum.
    MESSAGE 'Date cannot be in the future' TYPE 'E'.
  ENDIF.

*---------------------------------------------------------------------*
* Processing
*---------------------------------------------------------------------*
START-OF-SELECTION.

  WRITE: / 'Validation Successful'.
  WRITE: / sy-uline.

  WRITE: / 'Employee ID:', p_empid.
  WRITE: / 'Name       :', p_name.
  WRITE: / 'Salary     :', p_sal.
  WRITE: / 'Date       :', p_date.
