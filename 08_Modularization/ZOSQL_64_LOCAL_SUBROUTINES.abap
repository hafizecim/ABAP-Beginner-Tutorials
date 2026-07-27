REPORT ZOSQL_64_LOCAL_SUBROUTINES.

*---------------------------------------------------------------------*
* Report  : ZOSQL_64_LOCAL_SUBROUTINES
* Purpose : Demonstrates Local Subroutines in Classical ABAP
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. Local Subroutines
* 2. FORM and ENDFORM
* 3. PERFORM Statement
* 4. Modular Programming
* 5. Program Organization
* 6. Clean ABAP Principles
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
              WITH EMPTY KEY,

  gv_total TYPE i.

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

  gv_total = lines( gt_material ).

  PERFORM display_materials.

*---------------------------------------------------------------------*
* End of Selection
*---------------------------------------------------------------------*
END-OF-SELECTION.

  PERFORM display_footer
    USING gv_total.
*---------------------------------------------------------------------*
* Form Display Header
*---------------------------------------------------------------------*
FORM display_header.

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE:
    / '===============================================================',
    / '             LOCAL SUBROUTINES DEMONSTRATION',
    / '==============================================================='.

  FORMAT RESET.

  WRITE: /.
  WRITE: / 'This report demonstrates the use of local'.
  WRITE: / 'subroutines in Classical ABAP programs.'.

  SKIP.

  WRITE: / 'Program Flow:'.
  WRITE: / ' 1. Display report header'.
  WRITE: / ' 2. Read material master data'.
  WRITE: / ' 3. Display material list'.
  WRITE: / ' 4. Display execution summary'.

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

*---------------------------------------------------------------------*
* Form Display Materials
*---------------------------------------------------------------------*
FORM display_materials.

  DATA ls_material TYPE ty_material.

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE:
    / '===============================================================',
    / '                     MATERIAL LIST',
    / '==============================================================='.

  FORMAT RESET.

  WRITE:
    / 'Material Number',
      25 'Material Type',
      45 'Base Unit'.

  ULINE.

  LOOP AT gt_material INTO ls_material.

    WRITE:
      / ls_material-material_number,
        25 ls_material-material_type,
        45 ls_material-base_unit.

  ENDLOOP.

  ULINE.

ENDFORM.
