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
