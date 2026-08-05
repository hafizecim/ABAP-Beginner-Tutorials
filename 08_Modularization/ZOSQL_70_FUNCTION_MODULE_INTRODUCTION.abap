REPORT ZOSQL_70_FUNCTION_MODULE_INTRODUCTION.

*---------------------------------------------------------------------*
* Report  : ZOSQL_70_FUNCTION_MODULE_INTRODUCTION
* Title   : Introduction to Function Modules
* Purpose : Demonstrates how to call standard SAP Function Modules
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. Function Module Overview
* 2. CALL FUNCTION Statement
* 3. IMPORTING Parameters
* 4. EXPORTING Parameters
* 5. EXCEPTIONS
* 6. Standard Function Modules
* 7. Clean ABAP Recommendations
*
*---------------------------------------------------------------------*

TABLES:
  mara.

*---------------------------------------------------------------------*
* Type Definitions
*---------------------------------------------------------------------*
TYPES:
  BEGIN OF ty_material,

    matnr TYPE mara-matnr,
    mtart TYPE mara-mtart,
    meins TYPE mara-meins,

  END OF ty_material.

*---------------------------------------------------------------------*
* Data Declarations
*---------------------------------------------------------------------*
DATA:
  gt_material TYPE STANDARD TABLE OF ty_material WITH EMPTY KEY,
  gs_material TYPE ty_material.

DATA:
  gv_date_text TYPE char10,
  gv_time_text TYPE char8,
  gv_record_count TYPE i.

*---------------------------------------------------------------------*
* Selection Screen
*---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b01
                 WITH FRAME
                 TITLE TEXT-001.

PARAMETERS:
  p_limit TYPE i DEFAULT 10.

SELECT-OPTIONS:
  s_matnr FOR mara-matnr.

SELECTION-SCREEN END OF BLOCK b01.

*---------------------------------------------------------------------*
* Initialization
*---------------------------------------------------------------------*
INITIALIZATION.

  TEXT-001 = 'Function Module Demonstration'.

*---------------------------------------------------------------------*
* Start of Selection
*---------------------------------------------------------------------*
START-OF-SELECTION.

  PERFORM display_header.

  PERFORM read_materials.

  PERFORM call_standard_function_modules.

  PERFORM display_materials.

  PERFORM display_footer.

*---------------------------------------------------------------------*
* Form Display Header
*---------------------------------------------------------------------*
FORM display_header.

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE:
    / '===============================================================',
    / '           FUNCTION MODULE INTRODUCTION DEMO',
    / '==============================================================='.

  FORMAT RESET.

  SKIP.

ENDFORM.

*---------------------------------------------------------------------*
* Form Read Materials
*---------------------------------------------------------------------*
FORM read_materials.

  SELECT
         matnr,
         mtart,
         meins
    FROM mara
    WHERE matnr IN @s_matnr
    ORDER BY matnr
    UP TO @p_limit ROWS
    INTO TABLE @gt_material.

  gv_record_count = lines( gt_material ).

ENDFORM.
*---------------------------------------------------------------------*
* Form Call Standard Function Modules
*---------------------------------------------------------------------*
FORM call_standard_function_modules.

  DATA:
    lv_date TYPE char10,
    lv_time TYPE char8.

*---------------------------------------------------------------------*
* Function Module : CONVERSION_EXIT_MATN1_OUTPUT
* Converts internal material number to external format
*---------------------------------------------------------------------*
  IF gt_material IS NOT INITIAL.

    READ TABLE gt_material
      INTO gs_material
      INDEX 1.

    IF sy-subrc = 0.

      CALL FUNCTION 'CONVERSION_EXIT_MATN1_OUTPUT'
        EXPORTING
          input  = gs_material-matnr
        IMPORTING
          output = gs_material-matnr.

    ENDIF.

  ENDIF.

*---------------------------------------------------------------------*
* Function Module : CONVERT_DATE_TO_EXTERNAL
* Converts SAP internal date to external format
*---------------------------------------------------------------------*
  CALL FUNCTION 'CONVERT_DATE_TO_EXTERNAL'
    EXPORTING
      date_internal = sy-datum
    IMPORTING
      date_external = lv_date
    EXCEPTIONS
      date_internal_is_invalid = 1
      OTHERS                   = 2.

  IF sy-subrc = 0.
    gv_date_text = lv_date.
  ELSE.
    gv_date_text = 'Invalid'.
  ENDIF.

*---------------------------------------------------------------------*
* Function Module : CONVERT_TIME_INPUT
* Validates and converts time value
*---------------------------------------------------------------------*
  CALL FUNCTION 'CONVERT_TIME_INPUT'
    EXPORTING
      input  = sy-uzeit
    IMPORTING
      output = lv_time
    EXCEPTIONS
      OTHERS = 1.

  IF sy-subrc = 0.
    gv_time_text = lv_time.
  ELSE.
    gv_time_text = sy-uzeit.
  ENDIF.

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
      / gs_material-matnr,
        25 gs_material-mtart,
        45 gs_material-meins.

  ENDLOOP.

ENDFORM.
*---------------------------------------------------------------------*
* Form Display Footer
*---------------------------------------------------------------------*
FORM display_footer.

  SKIP 2.

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE:
    / '===============================================================',
    / '                  FUNCTION MODULE SUMMARY',
    / '==============================================================='.

  FORMAT RESET.

  WRITE:
    / 'Execution Date :', gv_date_text,
    / 'Execution Time :', gv_time_text,
    / 'Material Count :', gv_record_count.

  SKIP.

  WRITE: / 'Function Modules Used'.

  ULINE.

  WRITE: / '- CONVERSION_EXIT_MATN1_OUTPUT'.
  WRITE: / '- CONVERT_DATE_TO_EXTERNAL'.
  WRITE: / '- CONVERT_TIME_INPUT'.

  SKIP.

  WRITE: / 'CALL FUNCTION Components'.

  ULINE.

  WRITE: / '- EXPORTING'.
  WRITE: / '- IMPORTING'.
  WRITE: / '- CHANGING'.
  WRITE: / '- TABLES (Legacy)'.
  WRITE: / '- EXCEPTIONS'.

  SKIP.

  WRITE: / 'Best Practices'.

  ULINE.

  WRITE: / '- Reuse existing SAP standard Function Modules whenever possible.'.
  WRITE: / '- Always check SY-SUBRC after CALL FUNCTION.'.
  WRITE: / '- Handle all documented exceptions.'.
  WRITE: / '- Keep custom Function Modules focused on a single responsibility.'.
  WRITE: / '- Use meaningful parameter names.'.
  WRITE: / '- Avoid unnecessary global data in Function Groups.'.

  SKIP.

  WRITE: / 'Standard FM vs Custom FM'.

  ULINE.

  WRITE: / 'Standard FM : Delivered by SAP and reusable.'.
  WRITE: / 'Custom FM   : Developed by customers (Z* / Y* namespace).'.

  SKIP.

  WRITE: / 'Modern ABAP Recommendation'.

  ULINE.

  WRITE: / '- Prefer global classes and methods for new developments.'.
  WRITE: / '- Use Function Modules mainly for RFC, BAPI, update tasks,'.
  WRITE: / '  workflow integration and legacy applications.'.
  WRITE: / '- Continue maintaining existing Function Modules where required.'.

  ULINE.

  FORMAT COLOR COL_POSITIVE INTENSIFIED ON.

  WRITE:
    / 'Function Module demonstration completed successfully.'.

  FORMAT RESET.

ENDFORM.
