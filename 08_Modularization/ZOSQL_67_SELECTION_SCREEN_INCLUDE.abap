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
*---------------------------------------------------------------------*
* Include ZOSQL_67_SEL
* Purpose : Selection Screen Definitions
*---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b01
                 WITH FRAME
                 TITLE TEXT-001.

SELECT-OPTIONS:
  s_matnr FOR mara-matnr.

PARAMETERS:
  p_limit TYPE i DEFAULT 20.

SELECTION-SCREEN END OF BLOCK b01.

SELECTION-SCREEN SKIP.

SELECTION-SCREEN BEGIN OF BLOCK b02
                 WITH FRAME
                 TITLE TEXT-002.

PARAMETERS:
  p_mtart TYPE mara-mtart,
  p_meins TYPE mara-meins.

SELECTION-SCREEN END OF BLOCK b02.

SELECTION-SCREEN SKIP.

SELECTION-SCREEN BEGIN OF BLOCK b03
                 WITH FRAME
                 TITLE TEXT-003.

PARAMETERS:
  p_active AS CHECKBOX DEFAULT 'X',
  p_detail AS CHECKBOX.

SELECTION-SCREEN END OF BLOCK b03.

SELECTION-SCREEN ULINE.

SELECTION-SCREEN COMMENT /1(60) TEXT-004.

SELECTION-SCREEN PUSHBUTTON /1(20) gv_button
                         USER-COMMAND INFO.
