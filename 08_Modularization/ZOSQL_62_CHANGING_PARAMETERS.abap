REPORT ZOSQL_62_CHANGING_PARAMETERS.

*---------------------------------------------------------------------*
* Report  : ZOSQL_62_CHANGING_PARAMETERS
* Purpose : Demonstrates CHANGING Parameters in FORM Routines
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. CHANGING Parameters
* 2. Updating Variables
* 3. Multiple CHANGING Parameters
* 4. Internal Table Processing
* 5. Modular Programming
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

  gv_total    TYPE i,
  gv_counter  TYPE i.

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

  PERFORM calculate_statistics
    CHANGING
      gv_total
      gv_counter.

  PERFORM display_materials.

*---------------------------------------------------------------------*
* End of Selection
*---------------------------------------------------------------------*
END-OF-SELECTION.

  PERFORM display_footer
    USING
      gv_total
      gv_counter.
