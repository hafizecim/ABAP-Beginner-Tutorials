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
