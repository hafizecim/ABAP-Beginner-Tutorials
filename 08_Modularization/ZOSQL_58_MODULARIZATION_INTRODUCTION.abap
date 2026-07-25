REPORT ZOSQL_58_MODULARIZATION_INTRODUCTION.

*---------------------------------------------------------------------*
* Report  : ZOSQL_58_MODULARIZATION_INTRODUCTION
* Purpose : Introduction to Modularization in Classical ABAP
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. What is Modularization?
* 2. FORM and PERFORM
* 3. Program Organization
* 4. Separation of Responsibilities
* 5. Clean ABAP Principles
* 6. Readable and Maintainable Code
*
*---------------------------------------------------------------------*

TABLES:
  mara.

*---------------------------------------------------------------------*
* Text Elements
*---------------------------------------------------------------------*
* TEXT-001 : Material Selection

*---------------------------------------------------------------------*
* Selection Screen
*---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b01
                 WITH FRAME
                 TITLE TEXT-001.

SELECT-OPTIONS:
  s_matnr FOR mara-matnr.

PARAMETERS:
  p_max TYPE i DEFAULT 20.

SELECTION-SCREEN END OF BLOCK b01.

*---------------------------------------------------------------------*
* Types
*---------------------------------------------------------------------*

TYPES:
  BEGIN OF ty_material,

    material_number TYPE mara-matnr,
    material_type   TYPE mara-mtart,
    base_unit       TYPE mara-meins,

  END OF ty_material.

*---------------------------------------------------------------------*
* Data Declarations
*---------------------------------------------------------------------*

DATA:
  gt_material TYPE STANDARD TABLE OF ty_material
              WITH EMPTY KEY.

*---------------------------------------------------------------------*
* Initialization
*---------------------------------------------------------------------*

INITIALIZATION.

  TEXT-001 = 'Material Selection'.

*---------------------------------------------------------------------*
* Start of Selection
*---------------------------------------------------------------------*

START-OF-SELECTION.

  PERFORM display_program_info.

  SKIP.

  PERFORM get_materials.

  IF gt_material IS INITIAL.

    MESSAGE 'No materials found.' TYPE 'S'.

    RETURN.

  ENDIF.

  PERFORM display_materials.

*---------------------------------------------------------------------*
* End of Selection
*---------------------------------------------------------------------*

END-OF-SELECTION.

  PERFORM display_summary.
