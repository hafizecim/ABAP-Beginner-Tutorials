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
*---------------------------------------------------------------------*
* Form Get Material Data
*---------------------------------------------------------------------*
FORM get_material_data.

  SELECT
         mara~matnr                                        AS material_number,

         COALESCE(
           makt~maktx,
           'No Description' )                              AS material_text,

         mara~mtart                                        AS material_type,
         mara~matkl                                        AS material_group,
         marc~werks                                        AS plant,
         mara~meins                                        AS base_unit,

         CHAR_LENGTH( COALESCE(
             makt~maktx,
             '' ) )                                        AS text_length,

         CASE
           WHEN mara~lvorm = @space THEN 'ACTIVE'
           ELSE 'MARKED FOR DELETION'
         END                                               AS status

    FROM mara

      INNER JOIN marc
        ON marc~matnr = mara~matnr

      LEFT OUTER JOIN makt
        ON makt~matnr = mara~matnr
       AND makt~spras = @p_langu

   WHERE mara~matnr IN @s_matnr
     AND mara~mtart IN @s_mtart
     AND mara~matkl IN @s_matkl
     AND marc~werks IN @s_werks

   ORDER BY
       mara~matnr,
       marc~werks

   INTO TABLE @gt_material.

ENDFORM.
*---------------------------------------------------------------------*
* Form Display Best Practices
*---------------------------------------------------------------------*
FORM display_best_practices.

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE:
    / '===============================================================',
    / '          MODERN ABAP OPEN SQL BEST PRACTICES',
    / '==============================================================='.

  FORMAT RESET.

  WRITE: /.

  WRITE: / '[1] Select only the required fields (Avoid SELECT *)'.
  WRITE: / '[2] Always use WHERE conditions'.
  WRITE: / '[3] Use Host Variables (@)'.
  WRITE: / '[4] Prefer JOIN instead of Nested SELECT'.
  WRITE: / '[5] Handle NULL values with COALESCE'.
  WRITE: / '[6] Use CASE expressions'.
  WRITE: / '[7] Perform calculations in SQL whenever possible'.
  WRITE: / '[8] Always use ORDER BY when record order matters'.
  WRITE: / '[9] Use Inline Declarations'.
  WRITE: / '[10] Validate the result before processing'.

  ULINE.

ENDFORM.

*---------------------------------------------------------------------*
* Form Display Material Report
*---------------------------------------------------------------------*
FORM display_material_report.

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE:
    / '===============================================================================================================',
    / 'Material      Description                  Type   Group   Plant  Unit Length Status',
    / '==============================================================================================================='.

  FORMAT RESET.

  LOOP AT gt_material INTO DATA(gs_material).

    WRITE:
      / gs_material-material_number UNDER '
