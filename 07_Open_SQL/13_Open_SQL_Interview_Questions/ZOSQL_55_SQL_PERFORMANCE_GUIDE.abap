REPORT ZOSQL_55_SQL_PERFORMANCE_GUIDE.

*---------------------------------------------------------------------*
* Report  : ZOSQL_55_SQL_PERFORMANCE_GUIDE
* Purpose : Modern ABAP Open SQL Performance Best Practices
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. Select only required fields
* 2. WHERE conditions
* 3. Database indexes
* 4. INNER JOIN
* 5. LEFT OUTER JOIN
* 6. CASE Expression
* 7. COALESCE
* 8. SQL Expressions
* 9. ORDER BY
*10. UP TO n ROWS
*11. PACKAGE SIZE
*12. Host Variables (@)
*13. Inline Declarations
*14. Clean ABAP
*
*---------------------------------------------------------------------*

TABLES:
  mara,
  marc,
  makt.

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
  p_max   TYPE i DEFAULT 100.

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
* Internal Tables
*---------------------------------------------------------------------*

DATA:
  gt_material TYPE STANDARD TABLE OF ty_material
              WITH EMPTY KEY.

*---------------------------------------------------------------------*
* Initialization
*---------------------------------------------------------------------*

INITIALIZATION.

  TEXT-001 = 'SQL Performance Selection'.

*---------------------------------------------------------------------*
* Start of Selection
*---------------------------------------------------------------------*

START-OF-SELECTION.

  PERFORM get_material_data.

  IF gt_material IS INITIAL.

    MESSAGE 'No data found.' TYPE 'S'.

    RETURN.

  ENDIF.

  PERFORM display_performance_guide.

  SKIP 2.

  PERFORM display_report.
*---------------------------------------------------------------------*
* Form Get Material Data
*---------------------------------------------------------------------*
FORM get_material_data.

  SELECT
         mara~matnr                                     AS material_number,
         COALESCE(
           makt~maktx,
           'No Description' )                           AS material_text,
         mara~mtart                                     AS material_type,
         marc~werks                                     AS plant,
         mara~meins                                     AS base_unit,

         CASE
           WHEN mara~lvorm = @abap_true
             THEN 'MARKED FOR DELETION'
           ELSE 'ACTIVE'
         END                                            AS status

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

   UP TO @p_max ROWS

   INTO TABLE @gt_material.

ENDFORM.
*---------------------------------------------------------------------*
* Form Display Performance Guide
*---------------------------------------------------------------------*
FORM display_performance_guide.

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE:
    / '===============================================================',
    / '            OPEN SQL PERFORMANCE GUIDELINES',
    / '==============================================================='.

  FORMAT RESET.

  WRITE: /.
  WRITE: / '1. Read only the required database fields.'.
  WRITE: / '2. Never use SELECT * unless it is really necessary.'.
  WRITE: / '3. Always filter data using WHERE conditions.'.
  WRITE: / '4. Prefer indexed fields in WHERE clauses.'.
  WRITE: / '5. Use JOIN instead of nested SELECT statements.'.
  WRITE: / '6. Handle NULL values with COALESCE.'.
  WRITE: / '7. Use CASE expressions in SQL when appropriate.'.
  WRITE: / '8. Sort data in the database using ORDER BY.'.
  WRITE: / '9. Limit the result set using UP TO n ROWS.'.
  WRITE: / '10. Use Host Variables (@) in Open SQL.'.
  WRITE: / '11. Avoid unnecessary DISTINCT operations.'.
  WRITE: / '12. Analyze SQL performance using ST05 and SQL Monitor.'.

  ULINE.

ENDFORM.

*---------------------------------------------------------------------*
* Form Display Report
*---------------------------------------------------------------------*
FORM display_report.

  DATA(ls_material) = VALUE ty_material( ).

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE:
    / '======================================================================================================',
    / 'Material      Description                  Type    Plant   Unit   Status',
    / '======================================================================================================'.

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
    / 'Number of Retrieved Records :', lines( gt_material ).

  SKIP.

  WRITE:
    / 'Performance Recommendation:'.

  WRITE:
    / '- Read only required columns.'.
  WRITE:
    / '- Filter data in the database.'.
  WRITE:
    / '- Avoid unnecessary database access.'.
  WRITE:
    / '- Keep SQL statements simple and readable.'.
  WRITE:
    / '- Use modern Open SQL syntax consistently.'.

ENDFORM.
