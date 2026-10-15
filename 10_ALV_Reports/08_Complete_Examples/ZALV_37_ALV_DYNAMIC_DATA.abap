REPORT ZALV_37_ALV_DYNAMIC_DATA.

*---------------------------------------------------------------------*
* Program    : ZALV_37_ALV_DYNAMIC_DATA
* Title      : Dynamic Data ALV Report
* Purpose    : Display database table data dynamically
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* Creates a dynamic internal table based on a selected DDIC table,
* retrieves data using dynamic Open SQL, builds the ALV field catalog
* from runtime metadata, and displays the result in classic ALV.
*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Dynamic Table and Work Area Creation
* 2. Runtime Type Information (RTTI)
* 3. Dynamic Open SQL
* 4. Dynamic Field Catalog
* 5. Classic ALV Grid Display
*---------------------------------------------------------------------*

************************************************************************
* Data
************************************************************************
DATA:
  gv_tabname TYPE tabname,
  gv_maxrows TYPE i,
  gr_table   TYPE REF TO data,
  gr_line    TYPE REF TO data,
  gt_fieldcat TYPE slis_t_fieldcat_alv,
  gs_fieldcat TYPE slis_fieldcat_alv,
  gs_layout   TYPE slis_layout_alv.

FIELD-SYMBOLS:
  <gt_data> TYPE STANDARD TABLE,
  <gs_data> TYPE any.

************************************************************************
* Selection Screen
************************************************************************
PARAMETERS:
  p_table TYPE tabname DEFAULT 'SCARR' OBLIGATORY,
  p_max   TYPE i DEFAULT 100 OBLIGATORY.

************************************************************************
* Main Processing
************************************************************************
START-OF-SELECTION.

  gv_tabname = p_table.
  gv_maxrows = p_max.

  PERFORM validate_selection.
  PERFORM create_dynamic_table.
  PERFORM get_table_data.

  IF <gt_data> IS INITIAL.
    MESSAGE 'No data found in the selected table.'
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

  IF gv_maxrows <= 0.
    MESSAGE 'Maximum number of rows must be greater than zero.'
      TYPE 'E'.
  ENDIF.

  lv_tabname = gv_tabname.
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

  gv_tabname = lv_tabname.

ENDFORM.

************************************************************************
* Form CREATE_DYNAMIC_TABLE
************************************************************************
FORM create_dynamic_table.

  TRY.
      CREATE DATA gr_table TYPE TABLE OF (gv_tabname).
      CREATE DATA gr_line  TYPE (gv_tabname).

      ASSIGN gr_table->* TO <gt_data>.
      ASSIGN gr_line->*  TO <gs_data>.

    CATCH cx_sy_create_data_error.
      MESSAGE 'Unable to create dynamic data objects.'
        TYPE 'E'.
  ENDTRY.

ENDFORM.

************************************************************************
* Form GET_TABLE_DATA
************************************************************************
FORM get_table_data.

  FIELD-SYMBOLS:
    <ls_data> TYPE any.

  DATA:
    lv_rows TYPE i.

  SELECT *
    FROM (gv_tabname)
    INTO TABLE @<gt_data>
    UP TO @gv_maxrows ROWS.

ENDFORM.

************************************************************************
* Form BUILD_FIELD_CATALOG
************************************************************************
FORM build_field_catalog.

  DATA:
    lo_struct TYPE REF TO cl_abap_structdescr,
    lt_comp   TYPE cl_abap_structdescr=>component_table,
    ls_comp   LIKE LINE OF lt_comp,
    lv_pos    TYPE i.

  FIELD-SYMBOLS:
    <ls_comp> LIKE LINE OF lt_comp.

  CLEAR gt_fieldcat.

  TRY.
      lo_struct ?= cl_abap_typedescr=>describe_by_name( gv_tabname ).
      lt_comp = lo_struct->components.

    CATCH cx_sy_move_cast_error.
      MESSAGE 'Unable to retrieve table field metadata.'
        TYPE 'E'.
  ENDTRY.

  LOOP AT lt_comp ASSIGNING <ls_comp>.

    CLEAR gs_fieldcat.

    gs_fieldcat-fieldname = <ls_comp>-name.
    gs_fieldcat-seltext_m = <ls_comp>-name.
    gs_fieldcat-outputlen = 20.
    gs_fieldcat-col_pos   = sy-tabix.

    APPEND gs_fieldcat TO gt_fieldcat.

  ENDLOOP.

ENDFORM.

************************************************************************
* Form BUILD_LAYOUT
************************************************************************
FORM build_layout.

  CLEAR gs_layout.

  gs_layout-zebra             = 'X'.
  gs_layout-colwidth_optimize = 'X'.

ENDFORM.

************************************************************************
* Form DISPLAY_ALV
************************************************************************
FORM display_alv.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
      i_grid_title       = gv_tabname
      is_layout          = gs_layout
      it_fieldcat        = gt_fieldcat
      i_save             = 'A'
    TABLES
      t_outtab           = <gt_data>
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.

  IF sy-subrc <> 0.
    MESSAGE 'Error displaying the dynamic ALV.'
      TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.

ENDFORM.
