REPORT ZALV_38_ALV_DYNAMIC_REPORT.

*---------------------------------------------------------------------*
* Program    : ZALV_38_ALV_DYNAMIC_REPORT
* Title      : Dynamic Table ALV Report
* Purpose    : Display selected table fields dynamically
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* Allows the user to select a transparent database table and specify
* the fields to display. Creates a dynamic output table, retrieves
* the requested data, and displays it using classic ALV.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Dynamic Table Selection
* 2. Dynamic Field Selection
* 3. Runtime Type Services (RTTS)
* 4. Dynamic Open SQL
* 5. Dynamic ALV Field Catalog
*---------------------------------------------------------------------*

************************************************************************
* Data
************************************************************************
DATA:
  gv_tabname  TYPE tabname,
  gv_maxrows  TYPE i,
  gv_fieldstr TYPE string,
  gt_fields   TYPE STANDARD TABLE OF fieldname,
  gv_field    TYPE fieldname,
  gr_table    TYPE REF TO data,
  gr_line     TYPE REF TO data,
  gt_fieldcat TYPE slis_t_fieldcat_alv,
  gs_fieldcat TYPE slis_fieldcat_alv,
  gs_layout   TYPE slis_layout_alv.

FIELD-SYMBOLS:
  <gt_data> TYPE STANDARD TABLE,
  <gs_data> TYPE any.

************************************************************************
* Selection Screen
************************************************************************
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.

  PARAMETERS:
    p_table TYPE tabname DEFAULT 'SCARR' OBLIGATORY,
    p_max   TYPE i DEFAULT 100 OBLIGATORY.

SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE text-002.

  PARAMETERS:
    p_fields TYPE char255 LOWER CASE
             DEFAULT 'CARRID,CARRNAME,CURRCODE'.

SELECTION-SCREEN END OF BLOCK b2.

************************************************************************
* Text Symbols
************************************************************************
* TEXT-001: Table Selection
* TEXT-002: Field Selection

************************************************************************
* Main Processing
************************************************************************
START-OF-SELECTION.

  PERFORM validate_selection.
  PERFORM parse_field_list.
  PERFORM create_dynamic_table.
  PERFORM get_table_data.

  IF <gt_data> IS INITIAL.
    MESSAGE 'No data found for the selected criteria.'
      TYPE 'S' DISPLAY LIKE 'E'.
    RETURN.
  ENDIF.

  PERFORM build_field_catalog.
  PERFORM build_layout.
  PERFORM display_alv.

************************************************************************
* Form VALIDATE_SELECTION
************************************************************************
FORM validate_selection.

  DATA:
    lv_tabname TYPE tabname,
    lv_exists  TYPE dd02l-tabname.

  IF p_max <= 0.
    MESSAGE 'Maximum number of rows must be greater than zero.'
      TYPE 'E'.
  ENDIF.

  lv_tabname = p_table.
  TRANSLATE lv_tabname TO UPPER CASE.

  SELECT SINGLE tabname
    FROM dd02l
    WHERE tabname = @lv_tabname
      AND as4local = 'A'
      AND tabclass = 'TRANSP'
    INTO @lv_exists.

  IF sy-subrc <> 0.
    MESSAGE 'Enter a valid active transparent table name.'
      TYPE 'E'.
  ENDIF.

  p_table = lv_tabname.

ENDFORM.

************************************************************************
* Form PARSE_FIELD_LIST
************************************************************************
FORM parse_field_list.

  DATA:
    lv_remaining TYPE string,
    lv_token     TYPE string,
    lv_length    TYPE i,
    lv_offset    TYPE i.

  FIELD-SYMBOLS:
    <lv_field> TYPE fieldname.

  CLEAR gt_fields.
  lv_remaining = p_fields.

  TRANSLATE lv_remaining TO UPPER CASE.

  WHILE lv_remaining IS NOT INITIAL.

    FIND FIRST OCCURRENCE OF ','
      IN lv_remaining
      MATCH OFFSET lv_offset.

    IF sy-subrc = 0.
      lv_length = lv_offset.
      lv_token = lv_remaining(lv_length).
      lv_offset = lv_offset + 1.
      lv_remaining = lv_remaining+lv_offset.
    ELSE.
      lv_token = lv_remaining.
      CLEAR lv_remaining.
    ENDIF.

    CONDENSE lv_token.

    IF lv_token IS NOT INITIAL.
      APPEND CONV fieldname( lv_token ) TO gt_fields.
    ENDIF.

  ENDWHILE.

  SORT gt_fields.
  DELETE ADJACENT DUPLICATES FROM gt_fields.

  IF gt_fields IS INITIAL.
    MESSAGE 'Specify at least one field name.' TYPE 'E'.
  ENDIF.

ENDFORM.

************************************************************************
* Form CREATE_DYNAMIC_TABLE
************************************************************************
FORM create_dynamic_table.

  DATA:
    lo_table_descr TYPE REF TO cl_abap_tabledescr,
    lo_struct_descr TYPE REF TO cl_abap_structdescr,
    lt_components
