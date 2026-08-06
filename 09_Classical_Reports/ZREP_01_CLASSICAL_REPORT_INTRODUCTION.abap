REPORT ZREP_01_CLASSICAL_REPORT_INTRODUCTION.

*---------------------------------------------------------------------*
* Program    : ZREP_01_CLASSICAL_REPORT_INTRODUCTION
* Title      : Classical Report Introduction
* Author     : Hafize Şenyıl
* Purpose    : Introduction to Classical Reports in ABAP
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This program demonstrates the basic structure of a Classical Report.
*
* Topics Covered
* 1. REPORT statement
* 2. Declaration section
* 3. START-OF-SELECTION event
* 4. WRITE statement
* 5. Basic list output
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand the structure of a classical report.
* - Learn the execution flow of an executable ABAP program.
* - Display simple formatted output.
*---------------------------------------------------------------------*

************************************************************************
* Type Definitions
************************************************************************

************************************************************************
* Constants
************************************************************************
CONSTANTS:
  gc_title  TYPE string VALUE 'ABAP Classical Report',
  gc_line   TYPE string VALUE '========================================'.

************************************************************************
* Global Variables
************************************************************************
DATA:
  gv_message TYPE string.

************************************************************************
* START-OF-SELECTION
************************************************************************
START-OF-SELECTION.

  gv_message = 'Welcome to Classical Reporting in ABAP.'.

  WRITE: / gc_line.
  WRITE: / gc_title.
  WRITE: / gc_line.
  SKIP.

  WRITE: / 'Program Name :', sy-repid.
  WRITE: / 'Executed By  :', sy-uname.
  WRITE: / 'Client       :', sy-mandt.
  WRITE: / 'System Date  :', sy-datum.
  WRITE: / 'System Time  :', sy-uzeit.
  SKIP.

  WRITE: / gv_message.
  SKIP.

  WRITE: / 'This is your first Classical Report.'.
  WRITE: / 'The report output is generated using the WRITE statement.'.

************************************************************************
* END-OF-SELECTION
************************************************************************
END-OF-SELECTION.

  SKIP 2.
  ULINE.
  WRITE: / 'End of Report'.
