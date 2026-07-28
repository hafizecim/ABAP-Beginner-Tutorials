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
*---------------------------------------------------------------------*
* Include ZOSQL_67_F01
* Purpose : FORM Routines
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Form Initialize Program
*---------------------------------------------------------------------*
FORM initialize_program.

  TEXT-001 = 'Material Selection'.
  TEXT-002 = 'Additional Filters'.
  TEXT-003 = 'Report Options'.
  TEXT-004 = 'Enter the required selection criteria and execute the report.'.

  gv_button = 'Help'.

ENDFORM.

*---------------------------------------------------------------------*
* Form Validate Selection Screen
*---------------------------------------------------------------------*
FORM validate_selection_screen.

  IF p_limit <= 0.

    MESSAGE 'Maximum number of records must be greater than zero.'
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
    / '          SELECTION SCREEN INCLUDE DEMONSTRATION',
    / '==============================================================='.

  FORMAT RESET.

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
      AND mtart = @p_mtart
      AND meins = @p_meins
    ORDER BY matnr
    UP TO @p_limit ROWS
    INTO TABLE @gt_material.

ENDFORM.

*---------------------------------------------------------------------*
* Form Display Materials
*---------------------------------------------------------------------*
FORM display_materials.

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE:
    / 'Material Number',
      25 'Material Type',
      45 'Base Unit'.

  ULINE.

  LOOP AT gt_material INTO gs_material.

    WRITE:
      / gs_material-material_number,
        25 gs_material-material_type,
        45 gs_material-base_unit.

  ENDLOOP.

ENDFORM.

*---------------------------------------------------------------------*
* Form Display Footer
*---------------------------------------------------------------------*
FORM display_footer.

  SKIP 2.

  ULINE.

  WRITE:
    / 'Total Materials :', lines( gt_material ).

  SKIP.

  WRITE: / 'Selection Screen Include Best Practices'.

  ULINE.

  WRITE: / '- Keep all selection screen objects in SEL include.'.
  WRITE: / '- Validate user input in AT SELECTION-SCREEN.'.
  WRITE: / '- Group related fields into logical blocks.'.
  WRITE: / '- Use meaningful titles and comments.'.
  WRITE: / '- Keep the main program clean and readable.'.

  SKIP.

  WRITE: / 'Program executed successfully.'.

ENDFORM.
