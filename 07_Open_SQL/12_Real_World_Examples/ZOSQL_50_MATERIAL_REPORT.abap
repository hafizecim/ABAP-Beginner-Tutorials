REPORT ZOSQL_50_MATERIAL_REPORT.

*---------------------------------------------------------------------*
* Report  : ZOSQL_50_MATERIAL_REPORT
* Author  : ABAP Beginner Tutorials
* Purpose : Professional Material Report using Modern ABAP Open SQL
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. Modern Open SQL
* 2. INNER JOIN
* 3. LEFT OUTER JOIN
* 4. CASE Expression
* 5. COALESCE
* 6. Arithmetic Expressions
* 7. Host Variables (@)
* 8. Inline Declarations
* 9. Clean ABAP
* 10. ORDER BY
*
*---------------------------------------------------------------------*

TABLES:
    mara,
    marc.

*---------------------------------------------------------------------*
* Selection Screen
*---------------------------------------------------------------------*

SELECT-OPTIONS:
    s_matnr FOR mara-matnr,
    s_mtart FOR mara-mtart,
    s_matkl FOR mara-matkl,
    s_werks FOR marc-werks.

PARAMETERS:
    p_langu TYPE sylangu DEFAULT sy-langu.

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

    standard_price  TYPE mbew-stprs,
    price_unit      TYPE mbew-peinh,

    total_value     TYPE mbew-stprs,

    category        TYPE char15,
    status          TYPE char10,

  END OF ty_material.

*---------------------------------------------------------------------*
* Internal Table
*---------------------------------------------------------------------*

DATA:
    gt_material TYPE STANDARD TABLE OF ty_material WITH EMPTY KEY.

*---------------------------------------------------------------------*
* Start of Selection
*---------------------------------------------------------------------*

START-OF-SELECTION.

  PERFORM get_material_data.

  IF gt_material IS INITIAL.

    WRITE: / 'No material found for the given selection.'.

    RETURN.

  ENDIF.

  PERFORM display_report.
