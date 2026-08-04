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
*---------------------------------------------------------------------*
* Include ZOSQL_69_TOP
* Purpose : Global Definitions
*---------------------------------------------------------------------*

TABLES:
  mara.

*---------------------------------------------------------------------*
* Text Elements
*---------------------------------------------------------------------*
* TEXT-001 : Material Selection
* TEXT-002 : Report Options

*---------------------------------------------------------------------*
* Constants
*---------------------------------------------------------------------*
CONSTANTS:
  gc_default_limit TYPE i VALUE 20.

*---------------------------------------------------------------------*
* Type Definitions
*---------------------------------------------------------------------*
TYPES:
  BEGIN OF ty_material,

    material_number TYPE mara-matnr,
    material_type   TYPE mara-mtart,
    base_unit       TYPE mara-meins,

  END OF ty_material.

*---------------------------------------------------------------------*
* Internal Tables
*---------------------------------------------------------------------*
DATA:
  gt_material TYPE STANDARD TABLE OF ty_material
              WITH EMPTY KEY.

*---------------------------------------------------------------------*
* Work Areas
*---------------------------------------------------------------------*
DATA:
  gs_material TYPE ty_material.

*---------------------------------------------------------------------*
* Global Variables
*---------------------------------------------------------------------*
DATA:
  gv_total_records     TYPE i,
  gv_processed_records TYPE i,
  gv_button            TYPE c LENGTH 20.

*---------------------------------------------------------------------*
* Include ZOSQL_69_SEL
* Purpose : Selection Screen Definitions
*---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b01
                 WITH FRAME
                 TITLE TEXT-001.

SELECT-OPTIONS:
  s_matnr FOR mara-matnr.

PARAMETERS:
  p_limit TYPE i DEFAULT gc_default_limit.

SELECTION-SCREEN END OF BLOCK b01.

SELECTION-SCREEN SKIP.

SELECTION-SCREEN BEGIN OF BLOCK b02
                 WITH FRAME
                 TITLE TEXT-002.

PARAMETERS:
  p_detail AS CHECKBOX DEFAULT 'X',
  p_active AS CHECKBOX DEFAULT 'X'.

SELECTION-SCREEN END OF BLOCK b02.

SELECTION-SCREEN ULINE.

SELECTION-SCREEN COMMENT /1(60) TEXT-003.

SELECTION-SCREEN PUSHBUTTON /1(20)
                  gv_button
                  USER-COMMAND INFO.
*---------------------------------------------------------------------*
* Include ZOSQL_69_F01
* Purpose : FORM Routines
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Form Initialize Program
*---------------------------------------------------------------------*
FORM initialize_program.

  TEXT-001 = 'Material Selection'.
  TEXT-002 = 'Report Options'.
  TEXT-003 = 'Select the required criteria and execute the report.'.

  gv_button = 'Help'.

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
    / '             MODULAR REPORT DEMONSTRATION',
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
FORM calculate_statistics
  CHANGING
    cv_total_records     TYPE i
    cv_processed_records TYPE i.

  cv_total_records = lines( gt_material ).
  cv_processed_records = cv_total_records.

ENDFORM.

*---------------------------------------------------------------------*
* Form Display Materials
*---------------------------------------------------------------------*
FORM display_materials
  USING
    iv_total_records TYPE i.

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

  ULINE.

  WRITE:
    / 'Displayed Records :', iv_total_records.

ENDFORM.

*---------------------------------------------------------------------*
* Form Display Footer
*---------------------------------------------------------------------*
FORM display_footer
  USING
    iv_total_records     TYPE i
    iv_processed_records TYPE i.

  SKIP 2.

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE:
    / '===============================================================',
    / '                    REPORT SUMMARY',
    / '==============================================================='.

  FORMAT RESET.

  WRITE:
    / 'Total Records     :', iv_total_records,
    / 'Processed Records :', iv_processed_records.

  SKIP.

  WRITE: / 'Techniques Used'.

  ULINE.

  WRITE: / '- INCLUDE Programs'.
  WRITE: / '- TOP / SEL / F01 Includes'.
  WRITE: / '- FORM Routines'.
  WRITE: / '- PERFORM Statement'.
  WRITE: / '- USING Parameters'.
  WRITE: / '- CHANGING Parameters'.
  WRITE: / '- Selection Screen Validation'.
  WRITE: / '- Modern Open SQL'.
  WRITE: / '- Internal Tables'.
  WRITE: / '- Modular Program Design'.

  SKIP.

  WRITE: / 'Clean ABAP Recommendations'.

  ULINE.

  WRITE: / '- Keep the main program short.'.
  WRITE: / '- Place global declarations in TOP include.'.
  WRITE: / '- Place selection screens in SEL include.'.
  WRITE: / '- Place business logic in F01 include.'.
  WRITE: / '- Keep every FORM routine focused on one task.'.
  WRITE: / '- Prefer classes and methods in new developments.'.

  ULINE.

  FORMAT COLOR COL_POSITIVE INTENSIFIED ON.

  WRITE:
    / 'Modular report executed successfully.'.

  FORMAT RESET.

ENDFORM.
