REPORT ZREP_25_MESSAGE_HANDLING_IN_REPORTS.

*---------------------------------------------------------------------*
* Program    : ZREP_25_MESSAGE_HANDLING_IN_REPORTS
* Title      : Message Handling in Classical Reports
* Purpose    : Demonstrates MESSAGE statement and message types in
*              an executable Classical ABAP Report.
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* Messages are used to provide information, warnings, errors, and
* system messages during report processing.
*
* Message Types
* S - Success
* I - Information
* W - Warning
* E - Error
* A - Termination
* X - Runtime Error / Short Dump
*
* Topics Covered
* 1. MESSAGE statement
* 2. Success messages
* 3. Information messages
* 4. Warning messages
* 5. Error messages
* 6. Termination messages
* 7. System message class
* 8. SY-MSGID
* 9. SY-MSGNO
* 10. SY-MSGTY
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand the different MESSAGE types.
* - Display messages during report processing.
* - Understand how message types affect program flow.
* - Read message-related system fields.
*---------------------------------------------------------------------*

************************************************************************
* Selection Screen
************************************************************************

SELECTION-SCREEN BEGIN OF BLOCK b1
  WITH FRAME TITLE text-001.

PARAMETERS:
  p_value TYPE i DEFAULT 100.

SELECTION-SCREEN END OF BLOCK b1.

************************************************************************
* Text Symbols
************************************************************************

TEXT-001 = 'Message Handling'.

************************************************************************
* START-OF-SELECTION
************************************************************************

START-OF-SELECTION.

*---------------------------------------------------------------------*
* Initial Report Output
*---------------------------------------------------------------------*

  WRITE: / '============================================================'.
  WRITE: / '              MESSAGE HANDLING IN REPORTS'.
  WRITE: / '============================================================'.

  SKIP 2.

  WRITE: / 'Input Value:', p_value.

  SKIP 2.

*---------------------------------------------------------------------*
* SUCCESS MESSAGE
*---------------------------------------------------------------------*
* Type S displays a success message in the status bar.

  MESSAGE 'Report processing started successfully.' TYPE 'S'.

*---------------------------------------------------------------------*
* INFORMATION MESSAGE
*---------------------------------------------------------------------*
* Type I displays an information dialog.

  MESSAGE 'This is an information message.' TYPE 'I'.

*---------------------------------------------------------------------*
* WARNING MESSAGE
*---------------------------------------------------------------------*
* Type W displays a warning message.
*
* In this example the warning is displayed conditionally.

  IF p_value < 50.

    MESSAGE 'The entered value is below the recommended level.'
      TYPE 'W'.

  ENDIF.

*---------------------------------------------------------------------*
* ERROR MESSAGE
*---------------------------------------------------------------------*
* Type E interrupts the current processing flow.
*
* Since this report has no special selection-screen processing here,
* the example is executed only when the value is invalid.

  IF p_value < 0.

    MESSAGE 'The value cannot be negative.' TYPE 'E'.

  ENDIF.

*---------------------------------------------------------------------*
* Processing Result
*---------------------------------------------------------------------*

  SKIP 2.

  WRITE: / '============================================================'.
  WRITE: / '                  PROCESSING RESULT'.
  WRITE: / '============================================================'.

  SKIP.

  WRITE: / 'The report completed its normal processing flow.'.

************************************************************************
* MESSAGE INFORMATION
************************************************************************

  SKIP 2.

  WRITE: / 'Message System Fields'.
  ULINE.

  WRITE: / 'Message ID   :', sy-msgid.
  WRITE: / 'Message No.  :', sy-msgno.
  WRITE: / 'Message Type :', sy-msgty.

************************************************************************
* END-OF-SELECTION
************************************************************************

END-OF-SELECTION.

  SKIP 2.

  MESSAGE 'Report processing completed.' TYPE 'S'.
