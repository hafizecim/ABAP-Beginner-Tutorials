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
