REPORT ZREP_22_USER_COMMAND_EVENT.

*---------------------------------------------------------------------*
* Program    : ZREP_22_USER_COMMAND_EVENT
* Title      : USER-COMMAND Event
* Purpose    : Demonstrates user command handling in an interactive
*              Classical ABAP Report.
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* The AT USER-COMMAND event is triggered when the user executes a
* function code from the list interface.
*
* User commands can originate from:
* - Application toolbar
* - Function keys
* - Menu functions
* - Custom PF-STATUS functions
*
* Topics Covered
* 1. AT USER-COMMAND
* 2. PF-STATUS
* 3. Function codes
* 4. SY-UCOMM
* 5. Interactive list processing
* 6. Custom user commands
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand the purpose of AT USER-COMMAND.
* - Understand how function codes are processed.
* - Read the current user command using SY-UCOMM.
* - Handle custom commands in a classical list.
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
* Set List Status
*---------------------------------------------------------------------*

  SET PF-STATUS 'ZREP22'.

*---------------------------------------------------------------------*
* Initial List
*---------------------------------------------------------------------*

  WRITE: / '============================================================'.
  WRITE: / '                  USER COMMAND DEMO'.
  WRITE: / '============================================================'.

  SKIP 2.

  WRITE: / 'Available Commands'.
  ULINE.

  WRITE: / 'REFRESH  - Refresh the report'.
  WRITE: / 'INFO     - Display report information'.
  WRITE: / 'EXIT     - Return from the interactive list'.

  SKIP 2.

  WRITE: / 'Use the application toolbar or assigned function'.
  WRITE: / 'key to execute a command.'.

************************************************************************
* AT USER-COMMAND
************************************************************************
* Triggered when a function code is executed by the user.

AT USER-COMMAND.

  CASE sy-ucomm.

*---------------------------------------------------------------------*
* Refresh Command
*---------------------------------------------------------------------*

    WHEN 'REFRESH'.

      gv_message = 'Report refresh command executed.'.

*---------------------------------------------------------------------*
* Information Command
*---------------------------------------------------------------------*

    WHEN 'INFO'.

      gv_message = 'USER-COMMAND event processed the INFO command.'.

*---------------------------------------------------------------------*
* Exit Command
*---------------------------------------------------------------------*

    WHEN 'EXIT'.

      LEAVE TO LIST-PROCESSING.

*---------------------------------------------------------------------*
* Unknown Command
*---------------------------------------------------------------------*

    WHEN OTHERS.

      gv_message = 'Unknown user command received.'.

  ENDCASE.

*---------------------------------------------------------------------*
* Display Command Result
*---------------------------------------------------------------------*

  SKIP 2.

  WRITE: / '============================================================'.
  WRITE: / '                    COMMAND RESULT'.
  WRITE: / '============================================================'.

  SKIP.

  WRITE: / 'Command :', sy-ucomm.
  WRITE: / 'Result  :', gv_message.

************************************************************************
* TOP-OF-PAGE
************************************************************************

TOP-OF-PAGE.

  WRITE: / '------------------------------------------------------------'.
  WRITE: / '                ZREP_22 USER COMMAND'.
  WRITE: / '------------------------------------------------------------'.

  WRITE: / 'Program :', sy-repid.
  WRITE AT 45 'Page :', sy-pagno.

  ULINE.
