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
*---------------------------------------------------------------------*
* Form Display Report
*---------------------------------------------------------------------*
FORM display_report.

  DATA(ls_material) = VALUE ty_material( ).

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE:
    / '=====================================================================================================',
    / 'Material      Description                  Type    Plant    Unit    Status',
    / '====================================================================================================='.

  FORMAT RESET.

  LOOP AT gt_material INTO ls_material.

    WRITE:
      / ls_material-material_number UNDER 'Material',
        ls_material-material_text   UNDER 'Description',
        ls_material-material_type   UNDER 'Type',
        ls_material-plant           UNDER 'Plant',
        ls_material-base_unit       UNDER 'Unit',
        ls_material-status          UNDER 'Status'.

  ENDLOOP.

  ULINE.

  WRITE:
    / 'Total Retrieved Records :', lines( gt_material ).

  SKIP 2.

  FORMAT COLOR COL_POSITIVE INTENSIFIED ON.

  WRITE:
    / 'Performance Evaluation'.

  FORMAT RESET.

  WRITE: / '--------------------------------------------------------------'.
  WRITE: / '✔ Only required columns are selected.'.
  WRITE: / '✔ WHERE conditions reduce database workload.'.
  WRITE: / '✔ JOIN minimizes unnecessary database access.'.
  WRITE: / '✔ ORDER BY is executed by the database.'.
  WRITE: / '✔ COALESCE prevents NULL-related issues.'.
  WRITE: / '✔ CASE expressions simplify application logic.'.
  WRITE: / '✔ Result set is limited using UP TO n ROWS.'.
  WRITE: / '✔ Modern Open SQL syntax improves readability.'.
  WRITE: / '✔ Host Variables (@) ensure safe parameter handling.'.
  WRITE: / '✔ Clean ABAP principles improve maintainability.'.

  ULINE.

  WRITE:
    / 'Recommendation:'.

  WRITE:
    / '- Use ST05 SQL Trace for SQL performance analysis.'.
  WRITE:
    / '- Use SQL Monitor (SQLM) to identify expensive statements.'.
  WRITE:
    / '- Run ATC or Code Inspector regularly.'.
  WRITE:
    / '- Review database indexes before optimizing ABAP code.'.

ENDFORM.
