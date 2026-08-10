REPORT ZREP_21_HOTSPOT_AND_HOTSPOT_CLICK.

*---------------------------------------------------------------------*
* Program    : ZREP_21_HOTSPOT_AND_HOTSPOT_CLICK
* Title      : Hotspot and Hotspot Click
* Purpose    : Demonstrates clickable hotspots in an interactive
*              Classical ABAP Report.
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* A hotspot is a clickable area in a classical ABAP list.
*
* Hotspots can be used to make selected list fields interactive.
* When the user clicks a hotspot, the AT LINE-SELECTION event is
* triggered and the selected list line can be processed.
*
* Topics Covered
* 1. HOTSPOT ON
* 2. HOTSPOT OFF
* 3. AT LINE-SELECTION
* 4. SY-LISEL
* 5. SY-LSIND
* 6. Interactive list navigation
* 7. Clickable list fields
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand the purpose of a hotspot.
* - Create clickable fields in a classical list.
* - Handle hotspot selection.
* - Distinguish a hotspot from ordinary list output.
*---------------------------------------------------------------------*

************************************************************************
* Global Data
************************************************************************

DATA:
  gv_bukrs TYPE bukrs,
  gv_butxt TYPE butxt.

************************************************************************
* START-OF-SELECTION
************************************************************************

START-OF-SELECTION.

*---------------------------------------------------------------------*
* Report Header
*---------------------------------------------------------------------*

  WRITE: / '============================================================'.
  WRITE: / '                COMPANY HOTSPOT REPORT'.
  WRITE: / '============================================================'.

  SKIP 2.

*---------------------------------------------------------------------*
* Column Header
*---------------------------------------------------------------------*

  WRITE: / 'Company Code'.
  WRITE AT 25 'Company Name'.

  ULINE.

*---------------------------------------------------------------------*
* Company 1000
*---------------------------------------------------------------------*

  gv_bukrs = '1000'.
  gv_butxt = 'Demo Company 1000'.

  FORMAT HOTSPOT ON.

  WRITE: / gv_bukrs.

  FORMAT HOTSPOT OFF.

  WRITE AT 25 gv_butxt.

  SKIP.

*---------------------------------------------------------------------*
* Company 2000
*---------------------------------------------------------------------*

  gv_bukrs = '2000'.
  gv_butxt = 'Demo Company 2000'.

  FORMAT HOTSPOT ON.

  WRITE: / gv_bukrs.

  FORMAT HOTSPOT OFF.

  WRITE AT 25 gv_butxt.

  SKIP.

*---------------------------------------------------------------------*
* Company 3000
*---------------------------------------------------------------------*

  gv_bukrs = '3000'.
  gv_butxt = 'Demo Company 3000'.

  FORMAT HOTSPOT ON.

  WRITE: / gv_bukrs.

  FORMAT HOTSPOT OFF.

  WRITE AT 25 gv_butxt.

  SKIP 2.

  WRITE: / 'Click a company code to display its details.'.

************************************************************************
* AT LINE-SELECTION
************************************************************************
* Triggered when the user clicks a hotspot or selects a list line.

AT LINE-SELECTION.

*---------------------------------------------------------------------*
* Secondary List Header
*---------------------------------------------------------------------*

  WRITE: / '============================================================'.
  WRITE: / '                  HOTSPOT DETAILS'.
  WRITE: / '============================================================'.

  SKIP 2.

*---------------------------------------------------------------------*
* Selected Line
*---------------------------------------------------------------------*

  WRITE: / 'Selected List Line'.
  ULINE.

  WRITE: / sy-lisel.

  SKIP 2.

*---------------------------------------------------------------------*
* Interactive Information
*---------------------------------------------------------------------*

  WRITE: / 'Interactive Information'.
  ULINE.

  WRITE: / 'List Level    :', sy-lsind.
  WRITE: / 'Selected Line :', sy-lisel.

  SKIP 2.

  WRITE: / 'The hotspot was selected successfully.'.
  WRITE: / 'AT LINE-SELECTION processed the user interaction.'.
