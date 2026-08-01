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
