REPORT ZOSQL_56_PERFORMANCE_CHECKLIST.

*---------------------------------------------------------------------*
* Report  : ZOSQL_56_PERFORMANCE_CHECKLIST
* Purpose : Open SQL Performance Checklist and Best Practices
* Author  : ABAP Beginner Tutorials
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. Read only required fields
* 2. Always use WHERE conditions
* 3. Prefer indexed fields
* 4. Use JOIN instead of nested SELECT
* 5. Handle NULL values with COALESCE
* 6. Use CASE expressions
* 7. Sort data with ORDER BY
* 8. Limit result set
* 9. Check returned data
*10. Follow Clean ABAP principles
*
*---------------------------------------------------------------------*

TABLES:
  mara,
  makt,
  marc.

*---------------------------------------------------------------------*
* Text Elements
*---------------------------------------------------------------------*
* TEXT-001 : Performance Selection Criteria

*---------------------------------------------------------------------*
* Selection Screen
*---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b01
                 WITH FRAME
                 TITLE TEXT-001.

SELECT-OPTIONS:
  s_matnr FOR mara-matnr,
  s_mtart FOR mara-mtart,
  s_werks FOR marc-werks.

PARAMETERS:
  p_langu TYPE sylangu DEFAULT sy-langu,
  p_limit TYPE i        DEFAULT 100.

SELECTION-SCREEN END OF BLOCK b01.

*---------------------------------------------------------------------*
* Types
*---------------------------------------------------------------------*

TYPES:
  BEGIN OF ty_material,

    material_number TYPE mara-matnr,
    material_text   TYPE makt-maktx,
    material_type   TYPE mara-mtart,
    plant           TYPE marc-werks,
    base_unit       TYPE mara-meins,
    status          TYPE char20,

  END OF ty_material.

*---------------------------------------------------------------------*
* Data
*---------------------------------------------------------------------*

DATA:
  gt_material TYPE STANDARD TABLE OF ty_material
              WITH EMPTY KEY.

*---------------------------------------------------------------------*
* Initialization
*---------------------------------------------------------------------*

INITIALIZATION.

  TEXT-001 = 'Performance Selection Criteria'.

*---------------------------------------------------------------------*
* Start of Selection
*---------------------------------------------------------------------*

START-OF-SELECTION.

  PERFORM display_checklist.

  SKIP.

  PERFORM get_material_data.

  IF gt_material IS INITIAL.

    MESSAGE 'No data found for the specified selection criteria.'
       TYPE 'S'.

    RETURN.

  ENDIF.

  PERFORM display_report.
*---------------------------------------------------------------------*
* Form Get Material Data
*---------------------------------------------------------------------*
FORM get_material_data.

  SELECT
         mara~matnr                                       AS material_number,

         COALESCE(
           makt~maktx,
           'No Description' )                             AS material_text,

         mara~mtart                                       AS material_type,

         marc~werks                                       AS plant,

         mara~meins                                       AS base_unit,

         CASE
           WHEN mara~lvorm = @abap_false
             THEN 'ACTIVE'
           ELSE 'MARKED'
         END                                              AS status

    FROM mara

      INNER JOIN marc
        ON marc~matnr = mara~matnr

      LEFT OUTER JOIN makt
        ON makt~matnr = mara~matnr
       AND makt~spras = @p_langu

   WHERE mara~matnr IN @s_matnr
     AND mara~mtart IN @s_mtart
     AND marc~werks IN @s_werks

   ORDER BY
       mara~matnr,
       marc~werks

   UP TO @p_limit ROWS

   INTO TABLE @gt_material.

ENDFORM.
