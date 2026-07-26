REPORT ZOSQL_63_TABLES_PARAMETERS.

*---------------------------------------------------------------------*
* Report  : ZOSQL_63_TABLES_PARAMETERS
* Purpose : Demonstrates TABLES Parameters in FORM Routines
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. TABLES Parameters
* 2. Passing Internal Tables
* 3. Classical ABAP Modularization
* 4. Modern ABAP Recommendation
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

  PERFORM display_materials
    TABLES gt_material.

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
    / '             TABLES PARAMETERS DEMONSTRATION',
    / '==============================================================='.

  FORMAT RESET.

  WRITE: /.
  WRITE: / 'This report demonstrates the classical TABLES'.
  WRITE: / 'parameter used in FORM routines.'.

  SKIP.

  WRITE: / 'Execution Flow:'.
  WRITE: / ' 1. Display report header'.
  WRITE: / ' 2. Read material master data'.
  WRITE: / ' 3. Pass internal table using TABLES'.
  WRITE: / ' 4. Display material list'.
  WRITE: / ' 5. Display report summary'.

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
FORM display_materials
  TABLES
    pt_material STRUCTURE ty_material.

  DATA:
    ls_material TYPE ty_material.

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE:
    / '===============================================================',
    / '                    MATERIAL LIST',
    / '==============================================================='.

  FORMAT RESET.

  WRITE:
    / 'Material Number',
      25 'Material Type',
      45 'Base Unit'.

  ULINE.

  LOOP AT pt_material INTO ls_material.

    WRITE:
      / ls_material-material_number,
        25 ls_material-material_type,
        45 ls_material-base_unit.

  ENDLOOP.

  ULINE.

ENDFORM.
*---------------------------------------------------------------------*
* Form Display Footer
*---------------------------------------------------------------------*
FORM display_footer
  USING
    iv_total TYPE i.

  SKIP 2.

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE:
    / '===============================================================',
    / '                     REPORT SUMMARY',
    / '==============================================================='.

  FORMAT RESET.

  WRITE:
    / 'Total Materials :', iv_total.

  SKIP.

  WRITE: / 'TABLES Parameter Characteristics'.

  ULINE.

  WRITE: / '- Used in Classical ABAP reports.'.
  WRITE: / '- Passes internal tables to FORM routines.'.
  WRITE: / '- Still exists for backward compatibility.'.
  WRITE: / '- Frequently found in legacy SAP systems.'.

  SKIP.

  WRITE: / 'Modern ABAP Recommendation'.

  ULINE.

  WRITE: / '- Prefer USING for input parameters.'.
  WRITE: / '- Prefer CHANGING for output parameters.'.
  WRITE: / '- Use explicit parameter typing.'.
  WRITE: / '- Avoid TABLES in new developments.'.
  WRITE: / '- Prefer methods in ABAP Objects.'.

  SKIP.

  WRITE: / 'TABLES vs CHANGING'.

  ULINE.

  WRITE: / 'TABLES    : Classical syntax (obsolete for new code).'.
  WRITE: / 'CHANGING  : Recommended for modern procedural ABAP.'.
  WRITE: / 'METHODS   : Recommended for new object-oriented ABAP.'.

  ULINE.

  FORMAT COLOR COL_POSITIVE INTENSIFIED ON.

  WRITE:
    / 'Program executed successfully.'.

  FORMAT RESET.

ENDFORM.
