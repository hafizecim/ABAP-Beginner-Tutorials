REPORT ZREP_28_ULINE_SKIP_POSITION.

*---------------------------------------------------------------------*
* Program    : ZREP_28_ULINE_SKIP_POSITION
* Title      : ULINE, SKIP and POSITION
* Purpose    : Demonstrates ULINE, SKIP and POSITION statements in
*              Classical ABAP list output.
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* ULINE creates horizontal lines in classical list reports.
* SKIP inserts blank lines.
* POSITION changes the current output position.
*
* Topics Covered
* 1. ULINE
* 2. SKIP
* 3. POSITION
* 4. Output positioning
* 5. Column alignment
* 6. Section separation
* 7. Structured list formatting
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Create horizontal lines using ULINE.
* - Control vertical spacing using SKIP.
* - Position output using POSITION.
* - Build a structured classical list.
*---------------------------------------------------------------------*

************************************************************************
* START-OF-SELECTION
************************************************************************

START-OF-SELECTION.

*---------------------------------------------------------------------*
* Report Header
*---------------------------------------------------------------------*

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE: / 'CLASSICAL ABAP LIST FORMAT DEMONSTRATION'.

  FORMAT RESET.

  SKIP 1.

*---------------------------------------------------------------------*
* Full Line
*---------------------------------------------------------------------*

  ULINE.

  SKIP 1.

*---------------------------------------------------------------------*
* Section 1 - Basic SKIP
*---------------------------------------------------------------------*

  WRITE: / '1. SKIP STATEMENT'.
  ULINE.

  WRITE: / 'First line of the section.'.

  SKIP 2.

  WRITE: / 'This line appears after two blank lines.'.

  SKIP 1.

  WRITE: / 'This line appears after one blank line.'.

  SKIP 1.

*---------------------------------------------------------------------*
* Section 2 - ULINE
*---------------------------------------------------------------------*

  WRITE: / '2. ULINE STATEMENT'.
  ULINE.

  WRITE: / 'ULINE creates a horizontal separator.'.

  SKIP 1.

  ULINE.

  SKIP 2.

*---------------------------------------------------------------------*
* Section 3 - POSITION
*---------------------------------------------------------------------*

  WRITE: / '3. POSITION STATEMENT'.
  ULINE.

  POSITION 1.
  WRITE: 'Column 1'.

  POSITION 20.
  WRITE: 'Column 20'.

  POSITION 40.
  WRITE: 'Column 40'.

  POSITION 60.
  WRITE: 'Column 60'.

  SKIP 2.

*---------------------------------------------------------------------*
* Section 4 - Structured Columns
*---------------------------------------------------------------------*

  WRITE: / '4. COLUMN POSITIONING'.
  ULINE.

  POSITION 1.
  WRITE: 'ID'.

  POSITION 10.
  WRITE: 'DESCRIPTION'.

  POSITION 40.
  WRITE: 'QUANTITY'.

  POSITION 55.
  WRITE: 'STATUS'.

  SKIP 1.

  ULINE.

*---------------------------------------------------------------------*
* Data Row 1
*---------------------------------------------------------------------*

  POSITION 1.
  WRITE: '001'.

  POSITION 10.
  WRITE: 'Laptop'.

  POSITION 40.
  WRITE: '10'.

  POSITION 55.
  WRITE: 'Available'.

*---------------------------------------------------------------------*
* Data Row 2
*---------------------------------------------------------------------*

  POSITION 1.
  WRITE: / '002'.

  POSITION 10.
  WRITE: 'Monitor'.

  POSITION 40.
  WRITE: '25'.

  POSITION 55.
  WRITE: 'Available'.

*---------------------------------------------------------------------*
* Data Row 3
*---------------------------------------------------------------------*

  POSITION 1.
  WRITE: / '003'.

  POSITION 10.
  WRITE: 'Keyboard'.

  POSITION 40.
  WRITE: '5'.

  POSITION 55.
  WRITE: 'Limited'.

  SKIP 2.

*---------------------------------------------------------------------*
* Section 5 - ULINE with Position
*---------------------------------------------------------------------*

  WRITE: / '5. POSITIONED LINE'.
  ULINE.

  POSITION 10.
  ULINE 30.

  SKIP 2.

*---------------------------------------------------------------------*
* Section 6 - Combined Layout
*---------------------------------------------------------------------*

  WRITE: / '6. COMBINED LIST LAYOUT'.
  ULINE.

  SKIP 1.

  POSITION 1.
  WRITE: 'Report'.

  POSITION 20.
  WRITE: sy-repid.

  POSITION 45.
  WRITE: 'Page'.

  POSITION 55.
  WRITE: sy-pagno.

  SKIP 1.

  POSITION 1.
  WRITE: 'Date'.

  POSITION 20.
  WRITE: sy-datum.

  POSITION 45.
  WRITE: 'Time'.

  POSITION 55.
  WRITE: sy-uzeit.

  SKIP 1.

  ULINE.

  SKIP 2.

*---------------------------------------------------------------------*
* Final Output
*---------------------------------------------------------------------*

  FORMAT COLOR COL_POSITIVE INTENSIFIED ON.

  WRITE: / 'ULINE, SKIP and POSITION demonstration completed.'.

  FORMAT RESET.
