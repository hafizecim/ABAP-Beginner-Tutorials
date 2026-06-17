*&---------------------------------------------------------------------*
*& Report ZZ_32_SELECTION_SCREEN_BLOCKS
*&---------------------------------------------------------------------*
*& Purpose:
*&   Demonstrates Selection Screen Blocks usage in ABAP.
*&
*& Topics Covered:
*&   - SELECTION-SCREEN BLOCK
*&   - FRAME and TITLE
*&   - Organized UI design
*&   - Grouped parameters
*&---------------------------------------------------------------------*

REPORT ZZ_32_SELECTION_SCREEN_BLOCKS.

*---------------------------------------------------------------------*
* Selection Screen Blocks
*---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.

PARAMETERS:
  p_empid TYPE n LENGTH 8 OBLIGATORY,
  p_name  TYPE string.

SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE text-002.

PARAMETERS:
  p_dept TYPE c LENGTH 20 DEFAULT 'IT',
  p_sal  TYPE p LENGTH 8 DECIMALS 2.

SELECTION-SCREEN END OF BLOCK b2.

SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE text-003.

PARAMETERS:
  p_active AS CHECKBOX DEFAULT 'X'.

SELECTION-SCREEN END OF BLOCK b3.

*---------------------------------------------------------------------*
* Text Elements (Simulated)
*---------------------------------------------------------------------*
* text-001 = "Employee Basic Information"
* text-002 = "Employment Details"
* text-003 = "Control Options"

*---------------------------------------------------------------------*
* Processing
*---------------------------------------------------------------------*
START-OF-SELECTION.

  IF p_active IS INITIAL.
    WRITE: / 'Report is inactive.'.
    EXIT.
  ENDIF.

  WRITE: / 'Employee Report'.
  WRITE: / sy-uline.

  WRITE: / 'ID        :', p_empid.
  WRITE: / 'Name      :', p_name.
  WRITE: / 'Department:', p_dept.
  WRITE: / 'Salary    :', p_sal.

  WRITE: / sy-uline.
