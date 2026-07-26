REPORT ZOSQL_61_USING_PARAMETERS.

*---------------------------------------------------------------------*
* Report  : ZOSQL_61_USING_PARAMETERS
* Purpose : Demonstrates USING Parameters in FORM Routines
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. USING Parameters
* 2. Passing Values to FORM Routines
* 3. Multiple USING Parameters
* 4. Modular Programming
* 5. Clean ABAP Principles
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
  p_limit TYPE i DEFAULT 10.

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

  PERFORM display_footer
    USING lines( gt_material )
          sy-datum
          sy-uzeit.
*---------------------------------------------------------------------*
* Form Display Header
*---------------------------------------------------------------------*
FORM display_header.

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE:
    / '===============================================================',
    / '             USING PARAMETERS DEMONSTRATION',
    / '==============================================================='.

  FORMAT RESET.

  WRITE: /.
  WRITE: / 'This report demonstrates USING parameters'.
  WRITE: / 'in FORM routines.'.

  SKIP.

  WRITE: / 'Execution Flow:'.
  WRITE: / ' 1. Display report header'.
  WRITE: / ' 2. Read material master data'.
  WRITE: / ' 3. Display materials using FORM routines'.
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

*---------------------------------------------------------------------*
* Form Display Material Information
*---------------------------------------------------------------------*
FORM display_material_info
  USING
    iv_material_number TYPE mara-matnr
    iv_material_type   TYPE mara-mtart
    iv_base_unit       TYPE mara-meins.

  WRITE:
    / iv_material_number,
      25 iv_material_type,
      45 iv_base_unit.

ENDFORM.
*---------------------------------------------------------------------*
* Form Display Materials
*---------------------------------------------------------------------*
FORM display_materials.

  DATA ls_material TYPE ty_material.

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE:
    / '===============================================================',
    / '                  MATERIAL LIST',
    / '==============================================================='.

  FORMAT RESET.

  WRITE:
    / 'Material Number',
      25 'Material Type',
      45 'Base Unit'.

  ULINE.

  LOOP AT gt_material INTO ls_material.

    PERFORM display_material_info
      USING ls_material-material_number
            ls_material-material_type
            ls_material-base_unit.

  ENDLOOP.

  ULINE.

ENDFORM.

*---------------------------------------------------------------------*
* Form Display Footer
*---------------------------------------------------------------------*
FORM display_footer
  USING
    iv_total TYPE i
    iv_date  TYPE sydatum
    iv_time  TYPE syuzeit.

  SKIP 2.

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE:
    / '===============================================================',
    / '                    REPORT SUMMARY',
    / '==============================================================='.

  FORMAT RESET.

  WRITE:
    / 'Total Materials :', iv_total,
    / 'Execution Date  :', iv_date,
    / 'Execution Time  :', iv_time.

  SKIP.

  WRITE: / 'USING Parameter Advantages'.

  ULINE.

  WRITE: / '- Transfers input values to FORM routines.'.
  WRITE: / '- Makes routines reusable.'.
  WRITE: / '- Improves program readability.'.
  WRITE: / '- Reduces duplicated code.'.
  WRITE: / '- Supports modular programming.'.
  WRITE: / '- Encourages Clean ABAP design.'.

  ULINE.

  FORMAT COLOR COL_POSITIVE INTENSIFIED ON.

  WRITE:
    / 'Report executed successfully.'.

  FORMAT RESET.

ENDFORM.
