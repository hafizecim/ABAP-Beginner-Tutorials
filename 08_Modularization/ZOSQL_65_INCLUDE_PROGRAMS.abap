REPORT ZOSQL_65_INCLUDE_PROGRAMS.

*---------------------------------------------------------------------*
* Report  : ZOSQL_65_INCLUDE_PROGRAMS
* Purpose : Demonstrates INCLUDE Programs in Classical ABAP
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. INCLUDE Programs
* 2. Program Organization
* 3. Modular Development
* 4. Large Program Structure
* 5. Clean ABAP Guidelines
*
*---------------------------------------------------------------------*

INCLUDE zosql_65_top.
INCLUDE zosql_65_sel.
INCLUDE zosql_65_f01.

*---------------------------------------------------------------------*
* Initialization
*---------------------------------------------------------------------*
INITIALIZATION.

  PERFORM initialize_program.

*---------------------------------------------------------------------*
* Start of Selection
*---------------------------------------------------------------------*
START-OF-SELECTION.

  PERFORM display_header.

  PERFORM get_material_data.

  IF gt_material IS INITIAL.

    MESSAGE 'No material found for the selected criteria.'
      TYPE 'S'.

    RETURN.

  ENDIF.

  PERFORM display_materials.

*---------------------------------------------------------------------*
* End of Selection
*---------------------------------------------------------------------*
END-OF-SELECTION.

  PERFORM display_footer.
*---------------------------------------------------------------------*
* Include ZOSQL_65_F01
* Purpose : FORM Routines
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Form Initialize Program
*---------------------------------------------------------------------*
FORM initialize_program.

  TEXT-001 = 'Material Selection'.

ENDFORM.

*---------------------------------------------------------------------*
* Form Display Header
*---------------------------------------------------------------------*
FORM display_header.

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE:
    / '===============================================================',
    / '               INCLUDE PROGRAMS DEMONSTRATION',
    / '==============================================================='.

  FORMAT RESET.

  WRITE: /.
  WRITE: / 'This report demonstrates how INCLUDE programs'.
  WRITE: / 'are used to organize large ABAP applications.'.

  SKIP.

  WRITE: / 'Program Structure:'.
  WRITE: / '  - ZOSQL_65_INCLUDE_PROGRAMS (Main Program)'.
  WRITE: / '  - ZOSQL_65_TOP'.
  WRITE: / '  - ZOSQL_65_SEL'.
  WRITE: / '  - ZOSQL_65_F01'.

  ULINE.

ENDFORM.

*---------------------------------------------------------------------*
* Form Get Material Data
*---------------------------------------------------------------------*
FORM get_material_data.

  SELECT
         matnr AS material_number,
         mtart AS material_type,
         meins AS base_unit
    FROM mara
   WHERE matnr IN @s_matnr
   ORDER BY matnr
   UP TO @p_limit ROWS
   INTO TABLE @gt_material.

ENDFORM.

*---------------------------------------------------------------------*
* Form Display Materials
*---------------------------------------------------------------------*
FORM display_materials.

  DATA ls_material TYPE ty_material.

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE:
    / 'Material Number',
      25 'Material Type',
      45 'Base Unit'.

  ULINE.

  LOOP AT gt_material INTO ls_material.

    WRITE:
      / ls_material-material_number,
        25 ls_material-material_type,
        45 ls_material-base_unit.

  ENDLOOP.

  ULINE.

ENDFORM.
