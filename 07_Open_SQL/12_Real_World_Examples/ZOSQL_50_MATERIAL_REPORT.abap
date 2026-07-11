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
*---------------------------------------------------------------------*
* Form Get Material Data
*---------------------------------------------------------------------*
FORM get_material_data.

  SELECT
         mara~matnr                                        AS material_number,
         COALESCE( makt~maktx,
                   'No Description' )                      AS material_text,
         mara~mtart                                        AS material_type,
         mara~matkl                                        AS material_group,
         marc~werks                                        AS plant,
         mara~meins                                        AS base_unit,
         mbew~stprs                                        AS standard_price,
         mbew~peinh                                        AS price_unit,

         ( mbew~stprs * mbew~peinh )                       AS total_value,

         CASE
           WHEN mbew~stprs < 100 THEN 'CHEAP'
           WHEN mbew~stprs BETWEEN 100 AND 500 THEN 'NORMAL'
           ELSE 'EXPENSIVE'
         END                                               AS category,

         CASE
           WHEN mara~lvorm = @space THEN 'ACTIVE'
           ELSE 'DELETED'
         END                                               AS status

    FROM mara

      INNER JOIN marc
        ON marc~matnr = mara~matnr

      LEFT OUTER JOIN makt
        ON makt~matnr = mara~matnr
       AND makt~spras = @p_langu

      LEFT OUTER JOIN mbew
        ON mbew~matnr = mara~matnr
       AND mbew~bwkey = marc~werks

    WHERE mara~matnr IN @s_matnr
      AND mara~mtart IN @s_mtart
      AND mara~matkl IN @s_matkl
      AND marc~werks IN @s_werks

    ORDER BY
      mara~matnr,
      marc~werks

    INTO TABLE @gt_material.

ENDFORM.
