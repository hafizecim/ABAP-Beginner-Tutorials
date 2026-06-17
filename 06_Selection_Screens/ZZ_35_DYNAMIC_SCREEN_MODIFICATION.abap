*&---------------------------------------------------------------------*
*& Report ZZ_35_DYNAMIC_SCREEN_MODIFICATION
*&---------------------------------------------------------------------*
*& Purpose:
*&   Demonstrates dynamic modification of Selection Screen fields.
*&
*& Topics Covered:
*&   - AT SELECTION-SCREEN OUTPUT
*&   - Screen field modification
*&   - LOOP AT SCREEN
*&   - Dynamic enable/disable logic
*&---------------------------------------------------------------------*

REPORT ZZ_35_DYNAMIC_SCREEN_MODIFICATION.

*---------------------------------------------------------------------*
* Selection Screen
*---------------------------------------------------------------------*
PARAMETERS:
  p_show  AS CHECKBOX DEFAULT 'X',
  p_empid TYPE n LENGTH 8,
  p_dept  TYPE c LENGTH 20,
  p_sal   TYPE p LENGTH 8 DECIMALS 2.

*---------------------------------------------------------------------*
* Dynamic Screen Logic
*---------------------------------------------------------------------*
AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    " If checkbox is not selected, hide all input fields
    IF p_show IS INITIAL.

      IF screen-name = 'P_EMPID'
      OR screen-name = 'P_DEPT'
      OR screen-name = 'P_SAL'.

        screen-active = 0.
        MODIFY SCREEN.

      ENDIF.

    ELSE.

      " If checkbox is selected, ensure fields are active
      IF screen-name = 'P_EMPID'
      OR screen-name = 'P_DEPT'
      OR screen-name = 'P_SAL'.

        screen-active = 1.
        MODIFY SCREEN.

      ENDIF.

    ENDIF.

  ENDLOOP.

*---------------------------------------------------------------------*
* Validation / Processing
*---------------------------------------------------------------------*
START-OF-SELECTION.

  WRITE: / 'Dynamic Screen Example'.
  WRITE: / sy-uline.

  IF p_show = 'X'.

    WRITE: / 'Employee ID:', p_empid.
    WRITE: / 'Department :', p_dept.
    WRITE: / 'Salary     :', p_sal.

  ELSE.

    WRITE: / 'Input fields were hidden via dynamic screen logic.'.

  ENDIF.
