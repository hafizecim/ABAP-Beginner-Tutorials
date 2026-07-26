REPORT ZOSQL_62_CHANGING_PARAMETERS.

*---------------------------------------------------------------------*
* Report  : ZOSQL_62_CHANGING_PARAMETERS
* Purpose : Demonstrates CHANGING Parameters in FORM Routines
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. CHANGING Parameters
* 2. Updating Variables
* 3. Multiple CHANGING Parameters
* 4. Internal Table Processing
* 5. Modular Programming
* 6. Clean ABAP Principles
*
*---------------------------------------------------------------------*

TABLES:
  mara.

*---------------------------------------------------------------------*
* Text Elements
*---------------------------------------------------------------------*
* TEXT-001 : Material Selection

*---------------------------------------------------------------------*
* Selection Screen
*---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b01
                 WITH FRAME
                 TITLE TEXT-001.

SELECT-OPTIONS:
  s_matnr FOR mara-matnr.

PARAMETERS:
  p_limit TYPE i DEFAULT 20.

SELECTION-SCREEN END OF BLOCK b01.

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
* Data Declarations
*---------------------------------------------------------------------*
DATA:
  gt_material TYPE STANDARD TABLE OF ty_material
              WITH EMPTY KEY,

  gv_total    TYPE i,
  gv_counter  TYPE i.

*---------------------------------------------------------------------*
* Initialization
*---------------------------------------------------------------------*
INITIALIZATION.

  TEXT-001 = 'Material Selection'.

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

  PERFORM calculate_statistics
    CHANGING
      gv_total
      gv_counter.

  PERFORM display_materials.

*---------------------------------------------------------------------*
* End of Selection
*---------------------------------------------------------------------*
END-OF-SELECTION.

  PERFORM display_footer
    USING
      gv_total
      gv_counter.
*---------------------------------------------------------------------*
* Form Display Header
*---------------------------------------------------------------------*
FORM display_header.

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE:
    / '===============================================================',
    / '            CHANGING PARAMETERS DEMONSTRATION',
    / '==============================================================='.

  FORMAT RESET.

  WRITE: /.
  WRITE: / 'This report demonstrates how CHANGING parameters'.
  WRITE: / 'allow FORM routines to modify caller variables.'.

  SKIP.

  WRITE: / 'Execution Flow:'.
  WRITE: / ' 1. Display report header'.
  WRITE: / ' 2. Read material master data'.
  WRITE: / ' 3. Calculate statistics using CHANGING'.
  WRITE: / ' 4. Display material list'.
  WRITE: / ' 5. Display report summary'.

  ULINE.

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
    cv_total   TYPE i
    cv_counter TYPE i.

  CLEAR:
    cv_total,
    cv_counter.

  cv_total = lines( gt_material ).

  LOOP AT gt_material INTO DATA(ls_material).

    cv_counter = cv_counter + 1.

  ENDLOOP.

ENDFORM.
