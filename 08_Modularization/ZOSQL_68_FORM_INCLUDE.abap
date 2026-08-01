REPORT ZOSQL_68_FORM_INCLUDE.

*---------------------------------------------------------------------*
* Report  : ZOSQL_68_FORM_INCLUDE
* Purpose : Demonstrates FORM INCLUDE Usage in Classical ABAP
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. FORM INCLUDE
* 2. Modular Program Organization
* 3. FORM Routines
* 4. PERFORM Statement
* 5. INCLUDE Programs
* 6. Clean ABAP Principles
*
*---------------------------------------------------------------------*

INCLUDE zosql_68_top.
INCLUDE zosql_68_sel.
INCLUDE zosql_68_f01.

*---------------------------------------------------------------------*
* Initialization
*---------------------------------------------------------------------*
INITIALIZATION.

  PERFORM initialize_program.

*---------------------------------------------------------------------*
* At Selection-Screen
*---------------------------------------------------------------------*
AT SELECTION-SCREEN.

  PERFORM validate_selection_screen.

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

  PERFORM calculate_statistics.

  PERFORM display_materials.

*---------------------------------------------------------------------*
* End of Selection
*---------------------------------------------------------------------*
END-OF-SELECTION.

  PERFORM display_footer.
*---------------------------------------------------------------------*
* Include ZOSQL_68_F01
* Purpose : FORM Routines
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Form Initialize Program
*---------------------------------------------------------------------*
FORM initialize_program.

  TEXT-001 = 'Material Selection'.

ENDFORM.

*---------------------------------------------------------------------*
* Form Validate Selection Screen
*---------------------------------------------------------------------*
FORM validate_selection_screen.

  IF p_limit <= 0.

    MESSAGE 'Record limit must be greater than zero.'
      TYPE 'E'.

  ENDIF.

ENDFORM.

*---------------------------------------------------------------------*
* Form Display Header
*---------------------------------------------------------------------*
FORM display_header.

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE:
    / '===============================================================',
    / '                FORM INCLUDE DEMONSTRATION',
    / '==============================================================='.

  FORMAT RESET.

  WRITE:
    / 'Program :', sy-repid,
    / 'Date    :', sy-datum,
    / 'Time    :', sy-uzeit.

  SKIP.

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
* Form Calculate Statistics
*---------------------------------------------------------------------*
FORM calculate_statistics.

  gv_total_materials = lines( gt_material ).

ENDFORM.
*---------------------------------------------------------------------*
* Form Display Materials
*---------------------------------------------------------------------*
FORM display_materials.

  DATA ls_material TYPE ty_material.

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE:
    / '===============================================================',
    / '                     MATERIAL REPORT',
    / '==============================================================='.

  FORMAT RESET.

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

*---------------------------------------------------------------------*
* Form Display Footer
*---------------------------------------------------------------------*
FORM display_footer.

  SKIP 2.

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE:
    / '===============================================================',
    / '                     REPORT SUMMARY',
    / '==============================================================='.

  FORMAT RESET.

  WRITE:
    / 'Total Materials :', gv_total_materials.

  SKIP.

  WRITE: / 'FORM INCLUDE Best Practices'.

  ULINE.

  WRITE: / '- Keep business logic inside F01 include.'.
  WRITE: / '- Keep each FORM routine focused on one task.'.
  WRITE: / '- Use meaningful FORM names.'.
  WRITE: / '- Minimize the use of global variables.'.
  WRITE: / '- Reuse FORM routines where appropriate.'.
  WRITE: / '- Keep the main report short and readable.'.

  SKIP.

  WRITE: / 'Recommended Project Structure'.

  ULINE.

  WRITE: / 'TOP : Global declarations'.
  WRITE: / 'SEL : Selection-screen definitions'.
  WRITE: / 'F01 : FORM routines and business logic'.

  SKIP.

  WRITE: / 'Modern ABAP Recommendation'.

  ULINE.

  WRITE: / '- Prefer local/global classes for new developments.'.
  WRITE: / '- Use methods instead of FORM routines where possible.'.
  WRITE: / '- Maintain legacy FORM INCLUDE programs when required.'.

  ULINE.

  FORMAT COLOR COL_POSITIVE INTENSIFIED ON.

  WRITE:
    / 'Program executed successfully.'.

  FORMAT RESET.

ENDFORM.
