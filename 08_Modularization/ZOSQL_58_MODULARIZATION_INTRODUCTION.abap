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
*---------------------------------------------------------------------*
* Form Display Program Information
*---------------------------------------------------------------------*
FORM display_program_info.

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE:
    / '==============================================================',
    / '          ABAP MODULARIZATION INTRODUCTION',
    / '=============================================================='.

  FORMAT RESET.

  WRITE: /.
  WRITE: / 'This report demonstrates the fundamentals of'.
  WRITE: / 'modular programming in Classical ABAP.'.

  SKIP.

  WRITE: / 'Program Flow:'.
  WRITE: / ' 1. Display introduction'.
  WRITE: / ' 2. Read material master data'.
  WRITE: / ' 3. Display retrieved data'.
  WRITE: / ' 4. Display execution summary'.

  ULINE.

ENDFORM.

*---------------------------------------------------------------------*
* Form Get Materials
*---------------------------------------------------------------------*
FORM get_materials.

  SELECT
         matnr AS material_number,
         mtart AS material_type,
         meins AS base_unit

    FROM mara

   WHERE matnr IN @s_matnr

   ORDER BY matnr

   UP TO @p_max ROWS

   INTO TABLE @gt_material.

ENDFORM.
