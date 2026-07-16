REPORT ZOSQL_55_OPEN_SQL_BEST_PRACTICES_1.

*---------------------------------------------------------------------*
* Report  : ZOSQL_55_OPEN_SQL_BEST_PRACTICES_1
* Author  : ABAP Beginner Tutorials
* Purpose : Demonstrates Modern ABAP Open SQL Best Practices
*---------------------------------------------------------------------*
*
* Best Practices Covered
* 1. Select only required fields
* 2. Always use WHERE conditions
* 3. Use Host Variables (@)
* 4. Prefer JOIN instead of Nested SELECT
* 5. Use COALESCE
* 6. Use CASE Expressions
* 7. Use SQL Expressions
* 8. Use ORDER BY
* 9. Use Inline Declarations
*10. Check Result Before Processing
*
*---------------------------------------------------------------------*

TABLES:
  mara,
  makt,
  marc.

*---------------------------------------------------------------------*
* Selection Screen
*---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b01 WITH FRAME
                 TITLE TEXT-001.

SELECT-OPTIONS:
  s_matnr FOR mara-matnr,
  s_mtart FOR mara-mtart,
  s_matkl FOR mara-matkl,
  s_werks FOR marc-werks.

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
    material_group  TYPE mara-matkl,

    plant           TYPE marc-werks,

    base_unit       TYPE mara-meins,

    text_length     TYPE i,

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

  TEXT-001 = 'Selection Criteria'.

*---------------------------------------------------------------------*
* Start of Selection
*---------------------------------------------------------------------*

START-OF-SELECTION.

  PERFORM get_material_data.

  IF gt_material IS INITIAL.

    MESSAGE 'No materials found for the given selection criteria.'
       TYPE 'S'.

    RETURN.

  ENDIF.

  PERFORM display_best_practices.

  SKIP 2.

  PERFORM display_material_report.
