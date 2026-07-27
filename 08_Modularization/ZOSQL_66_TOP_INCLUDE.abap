REPORT ZOSQL_66_TOP_INCLUDE.

*---------------------------------------------------------------------*
* Report  : ZOSQL_66_TOP_INCLUDE
* Purpose : Demonstrates TOP INCLUDE Usage in Classical ABAP
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. TOP INCLUDE
* 2. Global Data Declarations
* 3. Program Organization
* 4. INCLUDE Programs
* 5. Clean ABAP Principles
*
*---------------------------------------------------------------------*

INCLUDE zosql_66_top.
INCLUDE zosql_66_sel.
INCLUDE zosql_66_f01.

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

  PERFORM calculate_statistics.

  PERFORM display_materials.

*---------------------------------------------------------------------*
* End of Selection
*---------------------------------------------------------------------*
END-OF-SELECTION.

  PERFORM display_footer.
