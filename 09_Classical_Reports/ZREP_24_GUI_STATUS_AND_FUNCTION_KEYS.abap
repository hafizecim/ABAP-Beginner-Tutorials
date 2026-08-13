REPORT ZREP_24_GUI_STATUS_AND_FUNCTION_KEYS.

*---------------------------------------------------------------------*
* Program    : ZREP_24_GUI_STATUS_AND_FUNCTION_KEYS
* Title      : GUI Status and Function Keys
* Purpose    : Demonstrates GUI status, function keys, and function
*              codes in a Classical ABAP Report.
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* A GUI Status defines the functions available to the user while a
* classical ABAP report is running.
*
* Function keys can be assigned to function codes in the GUI Status.
* When the user presses the assigned function key, the corresponding
* function code is transferred to SY-UCOMM.
*
* Topics Covered
* 1. GUI Status
* 2. PF-STATUS
* 3. SET PF-STATUS
* 4. Function keys
* 5. Function codes
* 6. SY-UCOMM
* 7. AT USER-COMMAND
* 8. LEAVE LIST-PROCESSING
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand the relationship between GUI Status and function keys.
* - Activate a custom GUI Status.
* - Process function-key commands.
* - Use SY-UCOMM to identify the executed function.
*---------------------------------------------------------------------*

************************************************************************
* Global Data
************************************************************************

DATA:
  gv_message TYPE string.

************************************************************************
* START-OF-SELECTION
************************************************************************

START-OF-SELECTION.

*---------------------------------------------------------------------*
* Activate GUI Status
*---------------------------------------------------------------------*

  SET PF-STATUS 'ZREP24'.

*---------------------------------------------------------------------*
* Display Initial List
*---------------------------------------------------------------------*

  PERFORM display_main_list.

************************************************************************
* AT USER-COMMAND
************************************************************************
* Handles function codes received from the GUI status.

AT USER-COMMAND.

  CASE sy-ucomm.

*---------------------------------------------------------------------*
* F5 - Refresh
*---------------------------------------------------------------------*

    WHEN 'REFRESH'.

      gv_message = 'Refresh function executed with the assigned key.'.

*---------------------------------------------------------------------*
* F6 - Information
*---------------------------------------------------------------------*

    WHEN 'INFO'.

      gv_message = 'Information function executed successfully.'.

*---------------------------------------------------------------------*
* F7 - Clear
*---------------------------------------------------------------------*

    WHEN 'CLEAR'.

      CLEAR gv_message.

*---------------------------------------------------------------------*
* F8 - Exit
*---------------------------------------------------------------------*

    WHEN 'EXIT'.

      LEAVE LIST-PROCESSING.

*---------------------------------------------------------------------*
* Unknown Function
*---------------------------------------------------------------------*

    WHEN OTHERS.

      gv_message = 'Unknown function code received.'.

  ENDCASE.

*---------------------------------------------------------------------*
* Display Result
*---------------------------------------------------------------------*

  PERFORM display_command_result.

************************************************************************
* FORM display_main_list
************************************************************************

FORM display_main_list.

  WRITE: / '============================================================'.
  WRITE: / '              GUI STATUS AND FUNCTION KEYS'.
  WRITE: / '============================================================'.

  SKIP 2.

  WRITE: / 'GUI Status'.
  ULINE.

  WRITE: / 'Status Name :', 'ZREP24'.

  SKIP 2.

  WRITE: / 'Function Key Mapping'.
  ULINE.

  WRITE: / 'F5  -> REFRESH'.
  WRITE: / 'F6  -> INFO'.
  WRITE: / 'F7  -> CLEAR'.
  WRITE: / 'F8  -> EXIT'.

  SKIP 2.

  WRITE: / 'Press one of the assigned function keys.'.

ENDFORM.

************************************************************************
* FORM display_command_result
************************************************************************

FORM display_command_result.

  SKIP 2.

  WRITE: / '============================================================'.
  WRITE: / '                    COMMAND RESULT'.
  WRITE: / '============================================================'.

  SKIP.

  WRITE: / 'Function Code :', sy-ucomm.
  WRITE: / 'Message       :', gv_message.

ENDFORM.

************************************************************************
* TOP-OF-PAGE
************************************************************************

TOP-OF-PAGE.

  WRITE: / '------------------------------------------------------------'.
  WRITE: / '              ZREP_24 FUNCTION KEY DEMO'.
  WRITE: / '------------------------------------------------------------'.

  WRITE: / 'Program :', sy-repid.
  WRITE AT 45 'Page :', sy-pagno.

  ULINE.
