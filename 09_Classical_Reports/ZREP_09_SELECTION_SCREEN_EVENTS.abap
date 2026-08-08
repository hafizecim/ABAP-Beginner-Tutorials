REPORT ZREP_09_SELECTION_SCREEN_EVENTS.

*---------------------------------------------------------------------*
* Program    : ZREP_09_SELECTION_SCREEN_EVENTS
* Title      : Selection Screen Events
* Purpose    : Demonstrates the main selection-screen events used in
*              Classical ABAP Reports.
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* Selection-screen events allow developers to control the behavior
* of a selection screen before, during, and after user interaction.
*
* Topics Covered
* 1. INITIALIZATION
* 2. AT SELECTION-SCREEN OUTPUT
* 3. AT SELECTION-SCREEN
* 4. START-OF-SELECTION
* 5. Default value assignment
* 6. Dynamic screen modification
* 7. User input validation
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand the execution sequence of selection-screen events.
* - Set default values during INITIALIZATION.
* - Modify screen elements dynamically.
* - Validate user input with AT SELECTION-SCREEN.
* - Understand the transition from selection screen to report logic.
*---------------------------------------------------------------------*

************************************************************************
* Selection Screen
************************************************************************

SELECTION-SCREEN BEGIN OF BLOCK b1
  WITH FRAME TITLE text-001.

PARAMETERS:
  p_bukrs TYPE bukrs,
  p_gjahr TYPE gjahr,
  p_test  AS CHECKBOX.

SELECTION-SCREEN END OF BLOCK b1.

************************************************************************
* Text Symbols
************************************************************************

TEXT-001 = 'Report Selection'.

************************************************************************
* INITIALIZATION
************************************************************************
* Executed when the selection screen is initialized.
* Commonly used for assigning default values.

INITIALIZATION.

  p_bukrs = '1000'.
  p_gjahr = sy-datum(4).

************************************************************************
* AT SELECTION-SCREEN OUTPUT
************************************************************************
* Executed before the selection screen is displayed.
* The SCREEN structure can be used to modify screen elements
* dynamically.

AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF screen-name = 'P_TEST'.

      screen-input = 1.
      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.

************************************************************************
* AT SELECTION-SCREEN
************************************************************************
* Executed when the user confirms the selection screen.
* Commonly used for input validation.

AT SELECTION-SCREEN.

  IF p_bukrs IS INITIAL.
    MESSAGE 'Company code must be entered.' TYPE 'E'.
  ENDIF.

  IF p_gjahr IS INITIAL.
    MESSAGE 'Fiscal year must be entered.' TYPE 'E'.
  ENDIF.

  IF p_gjahr < '2000' OR p_gjahr > '2100'.
    MESSAGE 'Enter a fiscal year between 2000 and 2100.' TYPE 'E'.
  ENDIF.

************************************************************************
* START-OF-SELECTION
************************************************************************
* Executed after the selection screen has been successfully processed.

START-OF-SELECTION.

*---------------------------------------------------------------------*
* Report Header
*---------------------------------------------------------------------*

  WRITE: / '============================================================'.
  WRITE: / '             SELECTION SCREEN EVENTS'.
  WRITE: / '============================================================'.

  SKIP 2.

*---------------------------------------------------------------------*
* Selected Values
*---------------------------------------------------------------------*

  WRITE: / 'Selected Values'.
  ULINE.

  WRITE: / 'Company Code :', p_bukrs.
  WRITE: / 'Fiscal Year  :', p_gjahr.

  IF p_test = abap_true.
    WRITE: / 'Test Mode    : Active'.
  ELSE.
    WRITE: / 'Test Mode    : Inactive'.
  ENDIF.

  SKIP 2.

*---------------------------------------------------------------------*
* Event Execution Information
*---------------------------------------------------------------------*

  WRITE: / 'Event Processing'.
  ULINE.

  WRITE: / 'INITIALIZATION         : Default values assigned'.
  WRITE: / 'AT SELECTION-SCREEN   : Input validated'.
  WRITE: / 'START-OF-SELECTION    : Report processing started'.

  SKIP 2.

*---------------------------------------------------------------------*
* Runtime Information
*---------------------------------------------------------------------*

  WRITE: / 'Runtime Information'.
  ULINE.

  WRITE: / 'Program :', sy-repid.
  WRITE: / 'User    :', sy-uname.
  WRITE: / 'Client  :', sy-mandt.
  WRITE: / 'Date    :', sy-datum.
  WRITE: / 'Time    :', sy-uzeit.

************************************************************************
* END-OF-SELECTION
************************************************************************

END-OF-SELECTION.

  SKIP 2.
  ULINE.

  WRITE: / 'End of Selection-Screen Events Demonstration'.
