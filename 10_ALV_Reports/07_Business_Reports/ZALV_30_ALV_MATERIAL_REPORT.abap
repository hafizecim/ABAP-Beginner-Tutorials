REPORT ZALV_30_ALV_MATERIAL_REPORT.

*---------------------------------------------------------------------*
* Program    : ZALV_30_ALV_MATERIAL_REPORT
* Title      : Material Master ALV Report
* Purpose    : Display material master data and descriptions
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* Retrieves material master data from MARA and language-dependent
* material descriptions from MAKT and displays them in a classic ALV.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Joining MARA and MAKT
* 2. Selection Options
* 3. Language-Dependent Material Descriptions
* 4. Manual Field Catalog
* 5. Classic ALV Grid Display
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* Learn how to retrieve material master data, apply selection criteria,
* and display the results using the classic ALV Grid function module.
*---------------------------------------------------------------------*

************************************************************************
* Types
************************************************************************
TYPES:
  BEGIN OF ty_material,
    matnr TYPE mara-matnr,
    maktx TYPE makt-maktx,
    mtart TYPE mara-mtart,
    matkl TYPE mara-matkl,
    meins TYPE mara-meins,
    mbrsh TYPE mara-mbrsh,
    ersda TYPE mara-ersda,
    ernam TYPE mara-ernam,
    lvorm TYPE mara-lvorm,
  END OF ty_material.

************************************************************************
* Data
************************************************************************
DATA:
  gt_material TYPE STANDARD TABLE OF ty_material,
  gs_material TYPE ty_material,
  gt_fieldcat TYPE slis_t_fieldcat_alv,
  gs_fieldcat TYPE slis_fieldcat_alv,
  gs_layout   TYPE slis_layout_alv.

************************************************************************
* Selection Screen
************************************************************************
SELECT-OPTIONS:
  s_matnr FOR gs_material-matnr,
  s_mtart FOR gs_material-mtart,
  s_matkl FOR gs_material-matkl,
  s_meins FOR gs_material-meins.

PARAMETERS:
  p_spras TYPE spras DEFAULT sy-langu.

************************************************************************
* Main Processing
************************************************************************
START-OF-SELECTION.

  PERFORM get_material_data.

  IF gt_material IS INITIAL.
    MESSAGE 'No material data found for the selection.'
      TYPE 'S' DISPLAY LIKE 'E'.
    RETURN.
  ENDIF.

  PERFORM build_field_catalog.
  PERFORM build_layout.
  PERFORM display_alv
