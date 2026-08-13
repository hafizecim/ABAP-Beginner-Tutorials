REPORT ZREP_23_PF_STATUS_IN_REPORTS.

*---------------------------------------------------------------------*
* Program    : ZREP_23_PF_STATUS_IN_REPORTS
* Title      : PF-STATUS in Classical Reports
* Purpose    : Demonstrates the use of a custom PF-STATUS in a
*              Classical ABAP Report.
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* PF-STATUS defines the functions available in the SAP GUI interface
* of a classical report.
*
* A PF-STATUS can contain:
* - Application toolbar functions
* - Menu functions
* - Function keys
* - Custom function codes
*
* This report demonstrates how a custom PF-STATUS is activated and
* how its function codes can be processed.
*
* Topics Covered
* 1. PF-STATUS
* 2. SET PF-STATUS
* 3. GUI Status
* 4. Function codes
* 5. AT USER-COMMAND
* 6. SY-UCOMM
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand the purpose of PF-STATUS.
* - Activate a GUI status from an ABAP report.
* - Understand the relationship between PF-STATUS and function codes.
* - Process custom user commands.
*---------------------------------------------------------------------*

************************************************************************
* Global Data
************************************************************************

DATA:
  gv_status_message TYPE string.

************************************************************************
* START-OF-SELECTION
************************************************************************

START-OF-SELECTION.

*---------------------------------------------------------------------*
* Activate Custom PF-STATUS
*---------------------------------------------------------------------*

  SET PF-STATUS 'ZREP23'.

*---------------------------------------------------------------------*
* Display Report
*---------------------------------------------------------------------*

  WRITE: / '============================================================'.
  WRITE: / '                 PF-STATUS IN REPORTS'.
  WRITE: / '============================================================'.

  SKIP 2.

  WRITE: / 'Custom PF-STATUS:'.
  WRITE: / 'ZREP23'.

  SKIP 2.

  WRITE: / 'Available Functions'.
  ULINE.

  WRITE: / 'INFO    - Display report information'.
  WRITE: / 'CLEAR   - Clear the current message'.
  WRITE: / 'EXIT    - Leave the list'.

  SKIP 2.

  WRITE: / 'Use the functions defined in the application toolbar.'.

************************************************************************
* AT USER-COMMAND
************************************************************************
* Processes function codes defined in the PF-STATUS.

AT USER-COMMAND.

  CASE sy-ucomm.

*---------------------------------------------------------------------*
* INFO
*---------------------------------------------------------------------*

    WHEN 'INFO'.

      gv_status_message =
        'PF-STATUS ZREP23 is active and INFO was selected.'.

*---------------------------------------------------------------------*
* CLEAR
*---------------------------------------------------------------------*

    WHEN 'CLEAR'.

      CLEAR gv_status_message.

*---------------------------------------------------------------------*
* EXIT
*---------------------------------------------------------------------*

    WHEN 'EXIT'.

      LEAVE LIST-PROCESSING.

*---------------------------------------------------------------------*
* Unknown Function Code
*---------------------------------------------------------------------*

    WHEN OTHERS.

      gv_status_message =
        'An unsupported function code was received.'.

  ENDCASE.

*---------------------------------------------------------------------*
* Display Command Result
*---------------------------------------------------------------------*

  SKIP 2.

  WRITE: / '============================================================'.
  WRITE: / '                    COMMAND RESULT'.
  WRITE: / '============================================================'.

  SKIP.

  WRITE: / 'Function Code :', sy-ucomm.
  WRITE: / 'Message       :', gv_status_message.

************************************************************************
* TOP-OF-PAGE
************************************************************************

TOP-OF-PAGE.

  WRITE: / '------------------------------------------------------------'.
  WRITE: / '                  PF-STATUS REPORT'.
  WRITE: / '------------------------------------------------------------'.

  WRITE: / 'Program :', sy-repid.
  WRITE AT 45 'Page :', sy-pagno.

  ULINE.
