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
*---------------------------------------------------------------------*
* Form Get Material Data
*---------------------------------------------------------------------*
FORM get_material_data.

*----------------------------------------------------------------------*
* Open SQL (Recommended)
*----------------------------------------------------------------------*

  SELECT
         mara~matnr                                     AS material_number,
         COALESCE(
           makt~maktx,
           'No Description' )                           AS material_text,
         mara~mtart                                     AS material_type,
         mara~meins                                     AS base_unit,

         CASE
           WHEN mara~lvorm = @space
             THEN 'ACTIVE'
           ELSE 'MARKED'
         END                                            AS status

    FROM mara

      LEFT OUTER JOIN makt
        ON makt~matnr = mara~matnr
       AND makt~spras = @p_langu

   WHERE mara~matnr IN @s_matnr
     AND mara~mtart IN @s_mtart

   ORDER BY
       mara~matnr

   INTO TABLE @gt_material.

*---------------------------------------------------------------------*
* Native SQL Example (Do NOT use in this demo)
*---------------------------------------------------------------------*
*
* EXEC SQL.
*   SELECT MATNR,
*          MTART,
*          MEINS
*     INTO :lv_matnr,
*          :lv_mtart,
*          :lv_meins
*     FROM MARA
*    WHERE MATNR = :lv_matnr
* ENDEXEC.
*
* Notes
* - Database dependent
* - Bypasses Open SQL abstraction
* - May reduce portability
* - Requires database-specific SQL syntax
*
*---------------------------------------------------------------------*

ENDFORM.
*---------------------------------------------------------------------*
* Form Display Comparison
*---------------------------------------------------------------------*
FORM display_comparison.

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE:
    / '===============================================================',
    / '             OPEN SQL vs NATIVE SQL',
    / '==============================================================='.

  FORMAT RESET.

  WRITE:
    / 'Open SQL Advantages'.

  ULINE.

  WRITE: / '✔ Database independent'.
  WRITE: / '✔ Supported on all SAP databases'.
  WRITE: / '✔ Uses SAP Open SQL syntax'.
  WRITE: / '✔ Supports Host Variables (@)'.
  WRITE: / '✔ Integrates with SAP buffering'.
  WRITE: / '✔ Recommended for new developments'.

  SKIP.

  WRITE:
    / 'Native SQL Characteristics'.

  ULINE.

  WRITE: / '• Database dependent'.
  WRITE: / '• Uses database-specific SQL syntax'.
  WRITE: / '• Bypasses SAP buffering'.
  WRITE: / '• Limited portability'.
  WRITE: / '• Recommended only for special scenarios'.

  ULINE.

ENDFORM.

*---------------------------------------------------------------------*
* Form Display Report
*---------------------------------------------------------------------*
FORM display_report.

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE:
    / '===============================================================================',
    / 'Material      Description                  Type      Unit      Status',
    / '==============================================================================='.

  FORMAT RESET.

  LOOP AT gt_material INTO DATA(gs_material).

    WRITE:
      / gs_material-material_number UNDER 'Material',
        gs_material-material_text   UNDER 'Description',
        gs_material-material_type   UNDER 'Type',
        gs_material-base_unit       UNDER 'Unit',
        gs_material-status          UNDER 'Status'.

  ENDLOOP.

  ULINE.

  WRITE:
    / 'Total Records :', lines( gt_material ).

  SKIP 2.

  FORMAT COLOR COL_POSITIVE INTENSIFIED ON.

  WRITE:
    / 'Recommendation'.

  FORMAT RESET.

  WRITE:
    / '- Use Open SQL for all standard SAP developments.'.
  WRITE:
    / '- Prefer portable and database-independent SQL.'.
  WRITE:
    / '- Use Native SQL only when Open SQL cannot meet the requirement.'.
  WRITE:
    / '- Keep SQL statements readable and maintainable.'.
  WRITE:
    / '- Follow Clean ABAP and performance best practices.'.

ENDFORM.
