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
*---------------------------------------------------------------------*
* Form Get Material Data
*---------------------------------------------------------------------*
FORM get_material_data.

  SELECT
         mara~matnr                                        AS material_number,

         COALESCE(
             makt~maktx,
             'No Description' )                            AS description,

         mara~mtart                                        AS material_type,

         mara~meins                                        AS base_unit,

         LENGTH( makt~maktx )                              AS text_length,

         CASE
           WHEN mara~lvorm = @space THEN 'ACTIVE'
           ELSE 'MARKED'
         END                                               AS status

    FROM mara

      LEFT OUTER JOIN makt
        ON makt~matnr = mara~matnr
       AND makt~spras = @p_langu

    WHERE mara~matnr IN @s_matnr
      AND mara~mtart IN @s_mtart

    ORDER BY
      mara~matnr

    INTO TABLE @gt_material.

ENDFORM.
*---------------------------------------------------------------------*
* Form Display Best Practices
*---------------------------------------------------------------------*
FORM display_best_practices.

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE:
    / '==============================================================',
    / '        MODERN ABAP OPEN SQL BEST PRACTICES',
    / '=============================================================='.

  FORMAT RESET.

  WRITE: / '✓ Select only required fields (Avoid SELECT *)'.
  WRITE: / '✓ Always use WHERE conditions'.
  WRITE: / '✓ Prefer JOIN instead of nested SELECT'.
  WRITE: / '✓ Use Host Variables (@)'.
  WRITE: / '✓ Use COALESCE for NULL handling'.
  WRITE: / '✓ Use CASE expressions'.
  WRITE: / '✓ Perform calculations in SQL when appropriate'.
  WRITE: / '✓ Always use ORDER BY if record order matters'.
  WRITE: / '✓ Use Inline Declarations'.
  WRITE: / '✓ Check the result before processing'.

ENDFORM.

*---------------------------------------------------------------------*
* Form Display Materials
*---------------------------------------------------------------------*
FORM display_materials.

  ULINE.

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE:
    / '=========================================================================================',
    / 'Material      Description                  Type     Unit   Length   Status',
    / '========================================================================================='.

  FORMAT RESET.

  LOOP AT gt_material INTO DATA(gs_material).

    WRITE:
      / gs_material-material_number UNDER 'Material',
        gs_material-description     UNDER 'Description',
        gs_material-material_type   UNDER 'Type',
        gs_material-base_unit       UNDER 'Unit',
        gs_material-text_length     UNDER 'Length',
        gs_material-status          UNDER 'Status'.

  ENDLOOP.

  ULINE.

  WRITE:
    / 'Total Materials :',
      lines( gt_material ).

ENDFORM.
