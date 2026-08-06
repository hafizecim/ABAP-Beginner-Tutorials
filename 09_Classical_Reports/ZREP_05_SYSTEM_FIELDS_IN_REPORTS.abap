REPORT ZREP_05_SYSTEM_FIELDS_IN_REPORTS.

*---------------------------------------------------------------------*
* Program    : ZREP_05_SYSTEM_FIELDS_IN_REPORTS
* Title      : System Fields in Reports
* Author     : Hafize Şenyıl
* Purpose    : Demonstrates frequently used system fields (SY)
*              in Classical ABAP Reports.
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This report introduces the most commonly used system fields that are
* automatically provided by the ABAP runtime environment.
*
* Topics Covered
* 1. SY-REPID
* 2. SY-UNAME
* 3. SY-MANDT
* 4. SY-DATUM
* 5. SY-UZEIT
* 6. SY-LANGU
* 7. SY-HOST
* 8. SY-SYSID
* 9. SY-BATCH
* 10. SY-INDEX
* 11. SY-SUBRC
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand ABAP system fields.
* - Display runtime information.
* - Learn how SY fields are used in reports.
*---------------------------------------------------------------------*

************************************************************************
* Constants
************************************************************************
CONSTANTS:
  gc_title TYPE string VALUE 'System Fields in Classical Reports',
  gc_line  TYPE string VALUE
  '===================================================================='.

************************************************************************
* Global Variables
************************************************************************
DATA:
  gv_text TYPE string.

************************************************************************
* START-OF-SELECTION
************************************************************************
START-OF-SELECTION.

*---------------------------------------------------------------------*
* Report Header
*---------------------------------------------------------------------*
  WRITE: / gc_line.
  WRITE: / gc_title CENTERED.
  WRITE: / gc_line.

  SKIP.

*---------------------------------------------------------------------*
* Runtime Information
*---------------------------------------------------------------------*
  WRITE: / 'Runtime Information'.
  ULINE.

  WRITE: / 'Program Name      :', sy-repid.
  WRITE: / 'User Name         :', sy-uname.
  WRITE: / 'Client            :', sy-mandt.
  WRITE: / 'Logon Language    :', sy-langu.
  WRITE: / 'System Date       :', sy-datum.
  WRITE: / 'System Time       :', sy-uzeit.
  WRITE: / 'Application Server:', sy-host.
  WRITE: / 'System ID         :', sy-sysid.

*---------------------------------------------------------------------*
* Background Execution
*---------------------------------------------------------------------*
  SKIP 2.

  WRITE: / 'Background Processing'.
  ULINE.

  IF sy-batch = abap_true.
    WRITE: / 'Program is running in Background Mode.'.
  ELSE.
    WRITE: / 'Program is running in Dialog Mode.'.
  ENDIF.

*---------------------------------------------------------------------*
* Loop Example (SY-INDEX)
*---------------------------------------------------------------------*
  SKIP 2.

  WRITE: / 'SY-INDEX Example'.
  ULINE.

  DO 5 TIMES.
    WRITE: / 'Current Loop Index:', sy-index.
  ENDDO.

*---------------------------------------------------------------------*
* SY-SUBRC Example
*---------------------------------------------------------------------*
  SKIP 2.

  WRITE: / 'SY-SUBRC Example'.
  ULINE.

  CLEAR gv_text.

  FIND 'ABAP' IN 'Modern ABAP Programming'
       MATCH OFFSET DATA(lv_offset).

  IF sy-subrc = 0.
    WRITE: / 'Text found successfully.'.
    WRITE: / 'Offset:', lv_offset.
  ELSE.
    WRITE: / 'Text not found.'.
  ENDIF.

*---------------------------------------------------------------------*
* Additional Useful Fields
*---------------------------------------------------------------------*
  SKIP 2.

  WRITE: / 'Additional System Fields'.
  ULINE.

  WRITE: / 'Current Page Number :', sy-pagno.
  WRITE: / 'Current Line Number :', sy-linno.
  WRITE: / 'List Level          :', sy-lsind.
  WRITE: / 'Current Column      :', sy-colno.

************************************************************************
* END-OF-SELECTION
************************************************************************
END-OF-SELECTION.

  SKIP 2.
  ULINE.

  WRITE: / 'Summary'.
  WRITE: / 'System fields provide runtime information about the'.
  WRITE: / 'current user, program, client, execution environment,',
           'and processing status.'.

  SKIP.
  WRITE: / 'End of System Fields Demonstration'.
