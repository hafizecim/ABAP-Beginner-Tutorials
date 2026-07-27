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
