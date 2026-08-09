REPORT ZREP_14_TOP_OF_PAGE_EVENT.

*---------------------------------------------------------------------*
* Program    : ZREP_14_TOP_OF_PAGE_EVENT
* Title      : TOP-OF-PAGE Event
* Purpose    : Demonstrates the TOP-OF-PAGE event in a
*              Classical ABAP Report.
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* TOP-OF-PAGE is triggered automatically when a new list page
* is started.
*
* It is commonly used to display:
* - Report titles
* - Company information
* - Page numbers
* - Report dates
* - Column headings
*
* Topics Covered
* 1. TOP-OF-PAGE
* 2. Page header
* 3. SY-PAGNO
* 4. SY-DATUM
* 5. SY-UZEIT
* 6. Column headings
* 7. NEW-PAGE
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand the purpose of TOP-OF-PAGE.
* - Create reusable page headers.
* - Display system information in a page header.
* - Understand how page headers behave across multiple pages.
*---------------------------------------------------------------------*

************************************************************************
* Global Data
************************************************************************

DATA:
  gv_counter TYPE i.

************************************************************************
* START-OF-SELECTION
************************************************************************

START-OF-SELECTION.

*---------------------------------------------------------------------*
* Page 1 - Report Data
*---------------------------------------------------------------------*

  DO 10 TIMES.

    gv_counter = sy-index.

    WRITE: / gv_counter.
    WRITE AT 10 'Employee'.
    WRITE AT 30 'Department'.
    WRITE AT 50 'Status'.

    WRITE AT 10 gv_counter.
    WRITE AT 30 'Finance'.
    WRITE AT 50 'Active'.

  ENDDO.

*---------------------------------------------------------------------*
* Start a New Page
*---------------------------------------------------------------------*

  NEW-PAGE.

*---------------------------------------------------------------------*
* Page 2 - Report Data
*---------------------------------------------------------------------*

  DO 10 TIMES.

    gv_counter = sy-index + 10.

    WRITE: / gv_counter.
    WRITE AT 10 'Employee'.
    WRITE AT 30 'Department'.
    WRITE AT 50 'Status'.

    WRITE AT 10 gv_counter.
    WRITE AT 30 'Sales'.
    WRITE AT 50 'Active'.

  ENDDO.

*---------------------------------------------------------------------*
* Start Another New Page
*---------------------------------------------------------------------*

  NEW-PAGE.

*---------------------------------------------------------------------*
* Page 3 - Report Data
*---------------------------------------------------------------------*

  DO 10 TIMES.

    gv_counter = sy-index + 20.

    WRITE: / gv_counter.
    WRITE AT 10 'Employee'.
    WRITE AT 30 'Department'.
    WRITE AT 50 'Status'.

    WRITE AT 10 gv_counter.
    WRITE AT 30 'Production'.
    WRITE AT 50 'Active'.

  ENDDO.

************************************************************************
* TOP-OF-PAGE
************************************************************************
* This event is triggered automatically at the beginning of each
* new list page.

TOP-OF-PAGE.

  FORMAT INTENSIFIED ON.

  WRITE: / '============================================================'.
  WRITE: / '                  EMPLOYEE REPORT'.
  WRITE: / '============================================================'.

  FORMAT INTENSIFIED OFF.

  WRITE: / 'Program :', sy-repid.
  WRITE AT 35 'Page :', sy-pagno.
  WRITE AT 55 'Date :', sy-datum.

  WRITE: / 'Time    :', sy-uzeit.
  WRITE AT 35 'User :', sy-uname.

  SKIP.

  WRITE: / 'ID'.
  WRITE AT 15 'EMPLOYEE'.
  WRITE AT 40 'DEPARTMENT'.
  WRITE AT 60 'STATUS'.

  ULINE.
