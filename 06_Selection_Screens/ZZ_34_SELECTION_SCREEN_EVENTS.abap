*&---------------------------------------------------------------------*
*& Report ZZ_34_SELECTION_SCREEN_EVENTS
*&---------------------------------------------------------------------*
*& Purpose:
*&   Demonstrates Selection Screen Events in ABAP.
*&
*& Topics Covered:
*&   - INITIALIZATION
*&   - AT SELECTION-SCREEN OUTPUT
*&   - AT SELECTION-SCREEN
*&   - START-OF-SELECTION
*&   - Event-based report flow
*&---------------------------------------------------------------------*

REPORT ZZ_34_SELECTION_SCREEN_EVENTS.

*---------------------------------------------------------------------*
* Selection Screen
*---------------------------------------------------------------------*
PARAMETERS:
  p_empid TYPE n LENGTH 8,
  p_dept  TYPE c LENGTH 20.

*---------------------------------------------------------------------*
* INITIALIZATION
*---------------------------------------------------------------------*
INITIALIZATION.

  " Default values before screen is shown
  p_dept = 'IT'.

*---------------------------------------------------------------------*
* AT SELECTION-SCREEN OUTPUT
*---------------------------------------------------------------------*
AT SELECTION-SCREEN OUTPUT.

  " Dynamic screen modification can be done here
  " (for now just informational comment)

*---------------------------------------------------------------------*
* AT SELECTION-SCREEN
*---------------------------------------------------------------------*
AT SELECTION-SCREEN.

  IF p_empid IS INITIAL.
    MESSAGE 'Employee ID is required' TYPE 'E'.
  ENDIF.

*---------------------------------------------------------------------*
* START-OF-SELECTION
*---------------------------------------------------------------------*
START-OF-SELECTION.

  WRITE: / 'Selection Screen Events Demo'.
  WRITE: / sy-uline.

  WRITE: / 'Employee ID:', p_empid.
  WRITE: / 'Department :', p_dept.
