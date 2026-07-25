REPORT ZOSQL_59_FORM_ROUTINES.

*---------------------------------------------------------------------*
* Report  : ZOSQL_59_FORM_ROUTINES
* Purpose : Demonstrates FORM Routines in Classical ABAP
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. FORM Routine
* 2. PERFORM Statement
* 3. Program Modularization
* 4. Single Responsibility Principle
* 5. Clean ABAP Structure
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
  p_limit TYPE i DEFAULT 20.

SELECTION-SCREEN END OF BLOCK b01.

*---------------------------------------------------------------------*
* Type Definitions
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

  PERFORM display_header.

  PERFORM get_material_data.

  IF gt_material IS INITIAL.

    MESSAGE 'No material found for the selected criteria.'
      TYPE 'S'.

    RETURN.

  ENDIF.

  PERFORM display_materials.

*---------------------------------------------------------------------*
* End of Selection
*---------------------------------------------------------------------*

END-OF-SELECTION.

  PERFORM display_footer.
*---------------------------------------------------------------------*
* Form Display Header
*---------------------------------------------------------------------*
FORM display_header.

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE:
    / '==============================================================',
    / '                FORM ROUTINES DEMONSTRATION',
    / '=============================================================='.

  FORMAT RESET.

  WRITE: /.
  WRITE: / 'This report demonstrates how FORM routines'.
  WRITE: / 'can be used to organize ABAP programs.'.

  SKIP.

  WRITE: / 'Execution Steps:'.
  WRITE: / ' 1. Display report header'.
  WRITE: / ' 2. Read material master data'.
  WRITE: / ' 3. Display material list'.
  WRITE: / ' 4. Display report summary'.

  ULINE.

ENDFORM.

*---------------------------------------------------------------------*
* Form Get Material Data
*---------------------------------------------------------------------*
FORM get_material_data.

  SELECT
         matnr AS material_number,
         mtart AS material_type,
         meins AS base_unit

    FROM mara

   WHERE matnr IN @s_matnr

   ORDER BY matnr

   UP TO @p_limit ROWS

   INTO TABLE @gt_material.

ENDFORM.
