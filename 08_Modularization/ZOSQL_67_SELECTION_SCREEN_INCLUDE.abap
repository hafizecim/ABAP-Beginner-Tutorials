REPORT ZOSQL_67_SELECTION_SCREEN_INCLUDE.

*---------------------------------------------------------------------*
* Report  : ZOSQL_67_SELECTION_SCREEN_INCLUDE
* Purpose : Demonstrates Selection Screen INCLUDE Usage
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. Selection Screen INCLUDE
* 2. Selection Screen Blocks
* 3. PARAMETERS
* 4. SELECT-OPTIONS
* 5. Modular Program Organization
* 6. Clean ABAP Principles
*
*---------------------------------------------------------------------*

INCLUDE zosql_67_top.
INCLUDE zosql_67_sel.
INCLUDE zosql_67_f01.

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

  PERFORM display_materials.

*---------------------------------------------------------------------*
* End of Selection
*---------------------------------------------------------------------*
END-OF-SELECTION.

  PERFORM display_footer..

*---------------------------------------------------------------------*
* Report  : REPORT zosql_67_selection_screen_include.

*---------------------------------------------------------------------*
* Report  : ZOSQL_67_SELECTION_SCREEN_INCLUDE
* Purpose : Demonstrates Selection Screen INCLUDE Usage
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. Selection Screen INCLUDE
* 2. Selection Screen Blocks
* 3. PARAMETERS
* 4. SELECT-OPTIONS
* 5. Modular Program Organization
* 6. Clean ABAP Principles
*
*---------------------------------------------------------------------*

INCLUDE zosql_67_top.
INCLUDE zosql_67_sel.
INCLUDE zosql_67_f01.

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

  PERFORM display_materials.

*---------------------------------------------------------------------*
* End of Selection
*---------------------------------------------------------------------*
END-OF-SELECTION.

  PERFORM display_footer.
* Purpose : Demonstrates Selection Screen INCLUDE Usage
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. Selection Screen INCLUDE
* 2. Selection Screen Blocks
* 3. PARAMETERS
* 4. SELECT-OPTIONS
* 5. Modular Program Organization
* 6. Clean ABAP Principles
*
*---------------------------------------------------------------------*

INCLUDE zosql_67_top.
INCLUDE zosql_67_sel.
INCLUDE zosql_67_f01.

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

  PERFORM display_materials.

*---------------------------------------------------------------------*
* End of Selection
*---------------------------------------------------------------------*
END-OF-SELECTION.

  PERFORM display_footer.
