REPORT ZOSQL_69_MODULAR_REPORT.

*---------------------------------------------------------------------*
* Report  : ZOSQL_69_MODULAR_REPORT
* Title   : Professional Modular ABAP Report
* Purpose : Demonstrates a complete modular report using INCLUDE
*           programs, FORM routines, USING, CHANGING and Open SQL.
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. INCLUDE Programs
* 2. TOP / SEL / F01 Includes
* 3. FORM Routines
* 4. PERFORM Statement
* 5. USING Parameters
* 6. CHANGING Parameters
* 7. Selection Screen Validation
* 8. Open SQL
* 9. Internal Tables
* 10. Clean ABAP Principles
*
*---------------------------------------------------------------------*

INCLUDE zosql_69_top.
INCLUDE zosql_69_sel.
INCLUDE zosql_69_f01.

*---------------------------------------------------------------------*
* INITIALIZATION
*---------------------------------------------------------------------*
INITIALIZATION.

  PERFORM initialize_program.

*---------------------------------------------------------------------*
* AT SELECTION-SCREEN
*---------------------------------------------------------------------*
AT SELECTION-SCREEN.

  PERFORM validate_selection_screen.

*---------------------------------------------------------------------*
* START-OF-SELECTION
*---------------------------------------------------------------------*
START-OF-SELECTION.

  PERFORM display_header.

  PERFORM get_material_data.

  IF gt_material IS INITIAL.

    MESSAGE 'No material found for the selected criteria.'
      TYPE 'S'.

    RETURN.

  ENDIF.

  PERFORM calculate_statistics
    CHANGING
      gv_total_records
      gv_processed_records.

  PERFORM display_materials
    USING
      gv_total_records.

*---------------------------------------------------------------------*
* END-OF-SELECTION
*---------------------------------------------------------------------*
END-OF-SELECTION.

  PERFORM display_footer
    USING
      gv_total_records
      gv_processed_records.
