REPORT ZREP_36_MATERIAL_MASTER_REPORT.

*---------------------------------------------------------------------*
* Program    : ZREP_36_MATERIAL_MASTER_REPORT
* Title      : Material Master Report
* Purpose    : Demonstrates a Classical ABAP Material Master Report
*              using Open SQL and internal tables.
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This report retrieves material master data from MARA and material
* descriptions from MAKT.
*
* The report demonstrates:
* - Open SQL
* - MARA material master data
* - MAKT material descriptions
* - INNER JOIN
* - Language-dependent descriptions
* - Internal tables
* - SELECT with WHERE
* - ORDER BY
* - LOOP AT
* - Classical list formatting
*
* Topics Covered
* 1. Material master data
* 2. MARA
* 3. MAKT
* 4. INNER JOIN
* 5. Open SQL
* 6. Language-dependent data
* 7. Internal tables
* 8. Classical list output
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand a real SAP material master reporting scenario.
* - Retrieve material data using Open SQL.
* - Join master data with language-dependent text.
* - Store database results in an internal table.
* - Display material information using classical list processing.
*---------------------------------------------------------------------*

************************************************************************
* Types
************************************************************************

TYPES:
  BEGIN OF ty_material,
    matnr TYPE mara-matnr,
    mtart TYPE mara-mtart,
    matkl TYPE mara-matkl,
    meins TYPE mara-meins,
    mbrsh TYPE mara-mbrsh,
    maktx TYPE makt-maktx,
  END OF ty_material.

************************************************************************
* Data
************************************************************************

DATA:
  gt_material TYPE STANDARD TABLE OF ty_material,
  gs_material TYPE ty_material.

DATA:
  gv_record_count TYPE i.

************************************************************************
* START-OF-SELECTION
************************************************************************

START-OF-SELECTION.

  PERFORM get_material_data.

  IF gt_material IS INITIAL.

    MESSAGE 'No material master data found.' TYPE 'I'.

    RETURN.

  ENDIF.

  PERFORM calculate_statistics.
  PERFORM display_report.

************************************************************************
* FORM get_material_data
************************************************************************
* Retrieves material master data and material descriptions.

FORM get_material_data.

  SELECT
    FROM mara AS material
    INNER JOIN makt AS description
      ON description~matnr = material~matnr
    FIELDS
      material~matnr,
      material~mtart,
      material~matkl,
      material~meins,
      material~mbrsh,
      description~maktx
    WHERE description~spras = @sy-langu
    INTO TABLE @gt_material
    ORDER BY material~matnr.

ENDFORM.

************************************************************************
* FORM calculate_statistics
************************************************************************
* Calculates the number of materials retrieved.

FORM calculate_statistics.

  gv_record_count = lines( gt_material ).

ENDFORM.

************************************************************************
* FORM display_report
************************************************************************
* Displays material master data as a classical list.

FORM display_report.

*---------------------------------------------------------------------*
* Report Header
*---------------------------------------------------------------------*

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE: / '============================================================'.
  WRITE: / '                  MATERIAL MASTER REPORT'.
  WRITE: / '============================================================'.

  FORMAT RESET.

  SKIP 1.

*---------------------------------------------------------------------*
* Report Information
*---------------------------------------------------------------------*

  WRITE: / 'Program       :', sy-repid.
  WRITE: / 'Report Date   :', sy-datum.
  WRITE: / 'Report Time   :', sy-uzeit.
  WRITE: / 'Language      :', sy-langu.
  WRITE: / 'Materials     :', gv_record_count.

  SKIP 2.

*---------------------------------------------------------------------*
* Column Header
*---------------------------------------------------------------------*

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  POSITION 1.
  WRITE: 'Material'.

  POSITION 20.
  WRITE: 'Description'.

  POSITION 55.
  WRITE: 'Type'.

  POSITION 67.
  WRITE: 'Material Group'.

  POSITION 82.
  WRITE: 'UoM'.

  POSITION 90.
  WRITE: 'Industry'.

  FORMAT RESET.

  SKIP 1.

  ULINE.

*---------------------------------------------------------------------*
* Material Data
*---------------------------------------------------------------------*

  LOOP AT gt_material INTO gs_material.

    POSITION 1.
    WRITE: / gs_material-matnr.

    POSITION 20.
    WRITE: gs_material-maktx.

    POSITION 55.
    WRITE: gs_material-mtart.

    POSITION 67.
    WRITE: gs_material-matkl.

    POSITION 82.
    WRITE: gs_material-meins.

    POSITION 90.
    WRITE: gs_material-mbrsh.

  ENDLOOP.

*---------------------------------------------------------------------*
* Footer
*---------------------------------------------------------------------*

  SKIP 1.

  ULINE.

  FORMAT COLOR COL_TOTAL INTENSIFIED ON.

  WRITE: / 'TOTAL MATERIALS:', gv_record_count.

  FORMAT RESET.

  SKIP 2.

  FORMAT COLOR COL_POSITIVE INTENSIFIED ON.

  WRITE: / 'Material master report completed successfully.'.

  FORMAT RESET.

ENDFORM.
