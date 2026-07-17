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
