REPORT zosql_55_open_sql_best_practices.

*---------------------------------------------------------------------*
* Report  : ZOSQL_55_OPEN_SQL_BEST_PRACTICES
* Purpose : Demonstrates Modern ABAP Open SQL Best Practices
*---------------------------------------------------------------------*
*
* Best Practices Covered
*
* 1. Select only required fields
* 2. Always use WHERE conditions
* 3. Use Host Variables (@)
* 4. Prefer JOIN over nested SELECT
* 5. Use COALESCE
* 6. Use CASE expressions
* 7. Use SQL Expressions
* 8. Use ORDER BY
* 9. Use Inline Declarations
* 10. Check result before processing
*
*---------------------------------------------------------------------*

TABLES:
  mara.

*---------------------------------------------------------------------*
* Selection Screen
*---------------------------------------------------------------------*

SELECT-OPTIONS:
  s_matnr FOR mara-matnr,
  s_mtart FOR mara-mtart.

PARAMETERS:
  p_langu TYPE sylangu DEFAULT sy-langu.

*---------------------------------------------------------------------*
* Types
*---------------------------------------------------------------------*

TYPES:
  BEGIN OF ty_material,

    material_number TYPE mara-matnr,
    description     TYPE makt-maktx,
    material_type   TYPE mara-mtart,
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
* Start of Selection
*---------------------------------------------------------------------*

START-OF-SELECTION.

  PERFORM get_material_data.

  IF gt_material IS INITIAL.

    WRITE:
      / 'No materials found for the specified selection criteria.'.

    RETURN.

  ENDIF.

  PERFORM display_best_practices.

  SKIP.

  PERFORM display_materials.
