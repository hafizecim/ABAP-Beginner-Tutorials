REPORT ZOSQL_57_OPEN_SQL_VS_NATIVE_SQL.

*---------------------------------------------------------------------*
* Report  : ZOSQL_57_OPEN_SQL_VS_NATIVE_SQL
* Purpose : Compare Open SQL and Native SQL in ABAP
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. Open SQL
* 2. Native SQL Overview
* 3. Database Independence
* 4. SAP Buffer
* 5. Host Variables (@)
* 6. JOIN Operations
* 7. Clean ABAP
* 8. Best Practices
*
*---------------------------------------------------------------------*

TABLES:
  mara,
  makt.

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
  s_matnr FOR mara-matnr,
  s_mtart FOR mara-mtart.

PARAMETERS:
  p_langu TYPE sylangu DEFAULT sy-langu.

SELECTION-SCREEN END OF BLOCK b01.

*---------------------------------------------------------------------*
* Types
*---------------------------------------------------------------------*

TYPES:
  BEGIN OF ty_material,

    material_number TYPE mara-matnr,
    material_text   TYPE makt-maktx,
    material_type   TYPE mara-mtart,
    base_unit       TYPE mara-meins,
    status          TYPE char15,

  END OF ty_material.

*---------------------------------------------------------------------*
* Internal Tables
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

  PERFORM display_comparison.

  SKIP.

  PERFORM get_material_data.

  IF gt_material IS INITIAL.

    MESSAGE 'No data found for the specified selection criteria.'
       TYPE 'S'.

    RETURN.

  ENDIF.

  PERFORM display_report.
