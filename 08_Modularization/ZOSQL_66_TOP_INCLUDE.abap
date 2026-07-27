REPORT ZOSQL_66_TOP_INCLUDE.

*---------------------------------------------------------------------*
* Report  : ZOSQL_66_TOP_INCLUDE
* Purpose : Demonstrates TOP INCLUDE Usage in Classical ABAP
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. TOP INCLUDE
* 2. Global Data Declarations
* 3. Program Organization
* 4. INCLUDE Programs
* 5. Clean ABAP Principles
*
*---------------------------------------------------------------------*

INCLUDE zosql_66_top.
INCLUDE zosql_66_sel.
INCLUDE zosql_66_f01.

*---------------------------------------------------------------------*
* Initialization
*---------------------------------------------------------------------*
INITIALIZATION.

  PERFORM initialize_program.

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

  PERFORM calculate_statistics.

  PERFORM display_materials.

*---------------------------------------------------------------------*
* End of Selection
*---------------------------------------------------------------------*
END-OF-SELECTION.

  PERFORM display_footer.
*---------------------------------------------------------------------*
* Include ZOSQL_66_TOP
* Purpose : Global Definitions
*---------------------------------------------------------------------*

TABLES:
  mara.

*---------------------------------------------------------------------*
* Text Elements
*---------------------------------------------------------------------*
* TEXT-001 : Material Selection

*---------------------------------------------------------------------*
* Constants
*---------------------------------------------------------------------*
CONSTANTS:
  gc_default_limit TYPE i VALUE 20,
  gc_true          TYPE abap_bool VALUE abap_true,
  gc_false         TYPE abap_bool VALUE abap_false.

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
* Internal Tables
*---------------------------------------------------------------------*
DATA:
  gt_material TYPE STANDARD TABLE OF ty_material
              WITH EMPTY KEY.

*---------------------------------------------------------------------*
* Work Areas
*---------------------------------------------------------------------*
DATA:
  gs_material TYPE ty_material.

*---------------------------------------------------------------------*
* Global Variables
*---------------------------------------------------------------------*
DATA:
  gv_total_materials TYPE i,
  gv_program_name    TYPE syrepid,
  gv_execution_date  TYPE sydatum,
  gv_execution_time  TYPE syuzeit.

*---------------------------------------------------------------------*
* Initialization Values
*---------------------------------------------------------------------*
INITIALIZATION.

  gv_program_name   = sy-repid.
  gv_execution_date = sy-datum.
  gv_execution_time = sy-uzeit.
*---------------------------------------------------------------------*
* Include ZOSQL_66_F01
* Purpose : FORM Routines
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Form Initialize Program
*---------------------------------------------------------------------*
FORM initialize_program.

  TEXT-001 = 'Material Selection'.

ENDFORM.

*---------------------------------------------------------------------*
* Form Display Header
*---------------------------------------------------------------------*
FORM display_header.

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE:
    / '===============================================================',
    / '                 TOP INCLUDE DEMONSTRATION',
    / '==============================================================='.

  FORMAT RESET.

  WRITE: /.
  WRITE: / 'Program Name   :', gv_program_name.
  WRITE: / 'Execution Date :', gv_execution_date.
  WRITE: / 'Execution Time :', gv_execution_time.

  SKIP.

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
    UP TO @gc_default_limit ROWS
    INTO TABLE @gt_material.

ENDFORM.

*---------------------------------------------------------------------*
* Form Calculate Statistics
*---------------------------------------------------------------------*
FORM calculate_statistics.

  gv_total_materials = lines( gt_material ).

ENDFORM.

*---------------------------------------------------------------------*
* Form Display Materials
*---------------------------------------------------------------------*
FORM display_materials.

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE:
    / 'Material Number',
      25 'Material Type',
      45 'Base Unit'.

  ULINE.

  LOOP AT gt_material INTO gs_material.

    WRITE:
      / gs_material-material_number,
        25 gs_material-material_type,
        45 gs_material-base_unit.

  ENDLOOP.

ENDFORM.

*---------------------------------------------------------------------*
* Form Display Footer
*---------------------------------------------------------------------*
FORM display_footer.

  SKIP 2.

  ULINE.

  WRITE:
    / 'Total Materials :', gv_total_materials.

  SKIP.

  WRITE: / 'TOP INCLUDE Best Practices'.

  ULINE.

  WRITE: / '- Store only global definitions.'.
  WRITE: / '- Keep business logic in FORM routines.'.
  WRITE: / '- Group similar declarations together.'.
  WRITE: / '- Avoid unnecessary global variables.'.
  WRITE: / '- Use meaningful names for TYPES and DATA.'.
  WRITE: / '- Keep TOP include clean and organized.'.

  SKIP.

  WRITE: / 'Modern ABAP Recommendation'.

  ULINE.

  WRITE: / '- Prefer local classes and methods.'.
  WRITE: / '- Use INCLUDE mainly in legacy programs.'.
  WRITE: / '- Follow Clean ABAP naming conventions.'.

  ULINE.

  FORMAT COLOR COL_POSITIVE INTENSIFIED ON.

  WRITE:
    / 'Program executed successfully.'.

  FORMAT RESET.

ENDFORM.
