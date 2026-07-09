⁷REPORT ZOSQL_41_STRING_FUNCTIONS.

*---------------------------------------------------------------------*
* Program : ZOSQL_41_STRING_FUNCTIONS
* Author  : Hafize Şenyıl
* Purpose : Demonstrate Modern ABAP Open SQL String Functions
*---------------------------------------------------------------------*
*
* Topics
* -------
* 01. CONCAT
* 02. CONCAT_WITH_SPACE
* 03. LOWER
* 04. UPPER
* 05. LPAD
* 06. RPAD
* 07. LENGTH
* 08. LEFT
* 09. RIGHT
* 10. SUBSTRING
* 11. INSTR
* 12. REPLACE
* 13. CASE
* 14. Nested String Functions
* 15. WHERE with String Functions
* 16. ORDER BY
*
*---------------------------------------------------------------------*

TABLES scarr.

*---------------------------------------------------------------------*
* Selection Screen
*---------------------------------------------------------------------*
PARAMETERS:
  p_air TYPE scarr-carrid OBLIGATORY DEFAULT 'LH'.

*---------------------------------------------------------------------*
* Result Structure
*---------------------------------------------------------------------*
TYPES:
  BEGIN OF ty_result,

    carrid           TYPE scarr-carrid,
    carrname         TYPE scarr-carrname,
    currcode         TYPE scarr-currcode,
    url              TYPE scarr-url,

    concat_text      TYPE string,
    concat_space     TYPE string,

    lower_name       TYPE string,
    upper_name       TYPE string,

    left_pad         TYPE string,
    right_pad        TYPE string,

    text_length      TYPE i,

    left_text        TYPE string,
    right_text       TYPE string,
    substring_text   TYPE string,

    position_air     TYPE i,

    replaced_text    TYPE string,

    upper_concat     TYPE string,
    padded_concat    TYPE string,
    mixed_text       TYPE string,
    airline_code     TYPE string,

    name_category    TYPE string,
    contains_air     TYPE string,

  END OF ty_result.

DATA:
  gt_result TYPE STANDARD TABLE OF ty_result,
  gs_result TYPE ty_result.

*---------------------------------------------------------------------*
* Read Data
*---------------------------------------------------------------------*
START-OF-SELECTION.

TRY.

SELECT

       carrid,
       carrname,
       currcode,
       url,

*------------------------------------------------------------------*
* CONCAT
*------------------------------------------------------------------*
       CONCAT(
           carrid,
           carrname )                         AS concat_text,

*------------------------------------------------------------------*
* CONCAT WITH SPACE
*------------------------------------------------------------------*
       CONCAT_WITH_SPACE(
           carrid,
           carrname,
           3 )                               AS concat_space,

*------------------------------------------------------------------*
* LOWER
*------------------------------------------------------------------*
       LOWER(
           carrname )                        AS lower_name,

*------------------------------------------------------------------*
* UPPER
*------------------------------------------------------------------*
       UPPER(
           carrname )                        AS upper_name,

*------------------------------------------------------------------*
* LPAD
*------------------------------------------------------------------*
       LPAD(
           carrid,
           5,
           '0' )                             AS left_pad,

*------------------------------------------------------------------*
* RPAD
*------------------------------------------------------------------*
       RPAD(
           carrid,
           5,
           '*' )                             AS right_pad,

*------------------------------------------------------------------*
* LENGTH
*------------------------------------------------------------------*
       LENGTH(
           carrname )                        AS text_length,

*------------------------------------------------------------------*
* LEFT
*------------------------------------------------------------------*
       LEFT(
           carrname,
           5 )                               AS left_text,

*------------------------------------------------------------------*
* RIGHT
*------------------------------------------------------------------*
       RIGHT(
           carrname,
           5 )                               AS right_text,

*------------------------------------------------------------------*
* SUBSTRING
*------------------------------------------------------------------*
       SUBSTRING(
           carrname,
           2,
           6 )                               AS substring_text,

*------------------------------------------------------------------*
* INSTR
*------------------------------------------------------------------*
       INSTR(
           carrname,
           'Air' )                           AS position_air,

*------------------------------------------------------------------*
* REPLACE
*------------------------------------------------------------------*
       REPLACE(
           carrname,
           'Air',
           'AIR' )                           AS replaced_text,

*------------------------------------------------------------------*
* Nested Functions
*------------------------------------------------------------------*
       UPPER(
           CONCAT(
               carrid,
               carrname ) )                  AS upper_concat,

*------------------------------------------------------------------*
* LPAD + CONCAT
*------------------------------------------------------------------*
       CONCAT(

            LPAD(
                carrid,
                5,
                '0' ),

            carrname )                       AS padded_concat,

*------------------------------------------------------------------*
* LEFT + RIGHT
*------------------------------------------------------------------*
       CONCAT_WITH_SPACE(

            LEFT(
                carrname,
                3 ),

            RIGHT(
                carrname,
                3 ),

            2 )                              AS mixed_text,

*------------------------------------------------------------------*
* Airline Code
*------------------------------------------------------------------*
       CONCAT(

             carrid,

             CONCAT(

                    '-',

                    UPPER(
                        carrname ) ) )       AS airline_code,

*------------------------------------------------------------------*
* CASE + LENGTH
*------------------------------------------------------------------*
       CASE

         WHEN LENGTH( carrname ) >= 20
           THEN 'VERY LONG'

         WHEN LENGTH( carrname ) >= 10
           THEN 'LONG'

         ELSE 'SHORT'

       END                                   AS name_category,

*------------------------------------------------------------------*
* CASE + INSTR
*------------------------------------------------------------------*
       CASE

         WHEN INSTR(
                 carrname,
                 'Air' ) > 0

         THEN 'YES'

         ELSE 'NO'

       END                                   AS contains_air

FROM scarr

WHERE carrid >= @p_air

ORDER BY LENGTH( carrname ) DESCENDING

INTO CORRESPONDING FIELDS OF TABLE @gt_result.

CATCH cx_sy_open_sql_db INTO DATA(lx_sql).

  MESSAGE lx_sql->get_text( ) TYPE 'E'.

ENDTRY.

IF gt_result IS INITIAL.

  MESSAGE 'No data found.' TYPE 'I'.
  RETURN.

ENDIF.

*---------------------------------------------------------------------*
* Additional Variables
*---------------------------------------------------------------------*
DATA:
  gv_total_records TYPE i,
  gv_long_names    TYPE i,
  gv_short_names   TYPE i.

*---------------------------------------------------------------------*
* Process Result
*---------------------------------------------------------------------*
LOOP AT gt_result INTO gs_result.

* Count long/short airline names
  CASE gs_result-name_category.

    WHEN 'LONG' OR 'VERY LONG'.
      gv_long_names += 1.

    WHEN OTHERS.
      gv_short_names += 1.

  ENDCASE.

* Example business rule
  IF gs_result-position_air > 0.
    gs_result-contains_air = 'FOUND'.
  ELSE.
    gs_result-contains_air = 'NOT FOUND'.
  ENDIF.

  MODIFY gt_result FROM gs_result.

ENDLOOP.

gv_total_records = lines( gt_result ).

*---------------------------------------------------------------------*
* Display Statistics
*---------------------------------------------------------------------*
WRITE: / '============================================='.
WRITE: / 'Open SQL String Functions Statistics'.
WRITE: / '============================================='.

WRITE: / 'Total Records      :', gv_total_records.
WRITE: / 'Long Names         :', gv_long_names.
WRITE: / 'Short Names        :', gv_short_names.

ULINE.

*---------------------------------------------------------------------*
* Display Using SALV
*---------------------------------------------------------------------*
DATA:
  lo_alv      TYPE REF TO cl_salv_table,
  lo_columns  TYPE REF TO cl_salv_columns_table,
  lo_column   TYPE REF TO cl_salv_column.

TRY.

    cl_salv_table=>factory(

      IMPORTING
        r_salv_table = lo_alv

      CHANGING
        t_table      = gt_result ).

*------------------------------------------------------------------*
* Optimize Column Width
*------------------------------------------------------------------*
    lo_columns = lo_alv->get_columns( ).

    lo_columns->set_optimize(
      abap_true ).

*------------------------------------------------------------------*
* Column Texts
*------------------------------------------------------------------*

    lo_column ?= lo_columns->get_column( 'CARRID' ).
    lo_column->set_short_text( 'ID' ).
    lo_column->set_medium_text( 'Carrier ID' ).
    lo_column->set_long_text( 'Carrier Identifier' ).

    lo_column ?= lo_columns->get_column( 'CARRNAME' ).
    lo_column->set_long_text( 'Carrier Name' ).

    lo_column ?= lo_columns->get_column( 'CONCAT_TEXT' ).
    lo_column->set_long_text( 'CONCAT()' ).

    lo_column ?= lo_columns->get_column( 'CONCAT_SPACE' ).
    lo_column->set_long_text( 'CONCAT_WITH_SPACE()' ).

    lo_column ?= lo_columns->get_column( 'LOWER_NAME' ).
    lo_column->set_long_text( 'LOWER()' ).

    lo_column ?= lo_columns->get_column( 'UPPER_NAME' ).
    lo_column->set_long_text( 'UPPER()' ).

    lo_column ?= lo_columns->get_column( 'LEFT_PAD' ).
    lo_column->set_long_text( 'LPAD()' ).

    lo_column ?= lo_columns->get_column( 'RIGHT_PAD' ).
    lo_column->set_long_text( 'RPAD()' ).

    lo_column ?= lo_columns->get_column( 'TEXT_LENGTH' ).
    lo_column->set_long_text( 'LENGTH()' ).

    lo_column ?= lo_columns->get_column( 'LEFT_TEXT' ).
    lo_column->set_long_text( 'LEFT()' ).

    lo_column ?= lo_columns->get_column( 'RIGHT_TEXT' ).
    lo_column->set_long_text( 'RIGHT()' ).

    lo_column ?= lo_columns->get_column( 'SUBSTRING_TEXT' ).
    lo_column->set_long_text( 'SUBSTRING()' ).

    lo_column ?= lo_columns->get_column( 'POSITION_AIR' ).
    lo_column->set_long_text( 'INSTR()' ).

    lo_column ?= lo_columns->get_column( 'REPLACED_TEXT' ).
    lo_column->set_long_text( 'REPLACE()' ).

    lo_column ?= lo_columns->get_column( 'AIRLINE_CODE' ).
    lo_column->set_long_text( 'Generated Airline Code' ).

*------------------------------------------------------------------*
* Functions
*------------------------------------------------------------------*
    lo_alv->get_functions( )->set_all(
      abap_true ).

*------------------------------------------------------------------*
* Display Settings
*------------------------------------------------------------------*
    lo_alv->get_display_settings( )->set_striped_pattern(
      abap_true ).

    lo_alv->get_display_settings( )->set_list_header(
      'Modern ABAP Open SQL String Functions Demo' ).

*------------------------------------------------------------------*
* Show ALV
*------------------------------------------------------------------*
    lo_alv->display( ).

  CATCH cx_salv_msg INTO DATA(lx_salv).

    MESSAGE lx_salv->get_text( ) TYPE 'I'.

ENDTRY.

*---------------------------------------------------------------------*
* Additional Examples
*---------------------------------------------------------------------*

DATA:
  gt_airlines      TYPE TABLE OF scarr,
  gt_air_names     TYPE TABLE OF scarr,
  gt_long_names    TYPE TABLE OF scarr,
  gt_codes         TYPE TABLE OF scarr.

*---------------------------------------------------------------------*
* Example 1
* Airlines containing "Air"
*---------------------------------------------------------------------*
SELECT *

  FROM scarr

  WHERE instr( carrname, 'Air' ) > 0

  INTO TABLE @gt_airlines.

WRITE: /
'----------------------------------------------'.

WRITE:
/ 'Example 1 : Airlines containing "Air"'.

WRITE:
/ 'Records :', lines( gt_airlines ).

ULINE.

*---------------------------------------------------------------------*
* Example 2
* Carrier names starting with A
*---------------------------------------------------------------------*
SELECT *

FROM scarr

WHERE upper( carrname ) LIKE 'A%'

INTO TABLE @gt_air_names.

WRITE:
/ 'Example 2 : Names starting with A'.

WRITE:
/ 'Records :', lines( gt_air_names ).

ULINE.

*---------------------------------------------------------------------*
* Example 3
* Long airline names
*---------------------------------------------------------------------*
SELECT *

FROM scarr

WHERE length( carrname ) >= 10

INTO TABLE @gt_long_names.

WRITE:
/ 'Example 3 : Long airline names'.

WRITE:
/ 'Records :', lines( gt_long_names ).

ULINE.

*---------------------------------------------------------------------*
* Example 4
* Airline IDs
*---------------------------------------------------------------------*
SELECT *

FROM scarr

WHERE left( carrid,1 ) = 'L'

INTO TABLE @gt_codes.

WRITE:
/ 'Example 4 : IDs beginning with L'.

WRITE:
/ 'Records :', lines( gt_codes ).

ULINE.

*---------------------------------------------------------------------*
* Detailed Output
*---------------------------------------------------------------------*

WRITE:
/ '==============================='.

WRITE:
/ 'Detailed Airline Information'.

WRITE:
/ '==============================='.

LOOP AT gt_result INTO gs_result.

  WRITE:
/ 'Carrier ID        :', gs_result-carrid.

  WRITE:
/ 'Carrier Name      :', gs_result-carrname.

  WRITE:
/ 'Currency          :', gs_result-currcode.

  WRITE:
/ 'URL               :', gs_result-url.

  WRITE:
/ 'Upper             :', gs_result-upper_name.

  WRITE:
/ 'Lower             :', gs_result-lower_name.

  WRITE:
/ 'Length            :', gs_result-text_length.

  WRITE:
/ 'Left              :', gs_result-left_text.

  WRITE:
/ 'Right             :', gs_result-right_text.

  WRITE:
/ 'Substring         :', gs_result-substring_text.

  WRITE:
/ 'Replace           :', gs_result-replaced_text.

  WRITE:
/ 'Concat            :', gs_result-concat_text.

  WRITE:
/ 'Concat Space      :', gs_result-concat_space.

  WRITE:
/ 'Upper Concat      :', gs_result-upper_concat.

  WRITE:
/ 'Padded            :', gs_result-padded_concat.

  WRITE:
/ 'Mixed Text        :', gs_result-mixed_text.

  WRITE:
/ 'Airline Code      :', gs_result-airline_code.

  WRITE:
/ 'Contains AIR      :', gs_result-contains_air.

  WRITE:
/ 'Category          :', gs_result-name_category.

  ULINE.

ENDLOOP.

*---------------------------------------------------------------------*
* Summary
*---------------------------------------------------------------------*

WRITE:
/ '========================================='.

WRITE:
/ 'Program Summary'.

WRITE:
/ '========================================='.

WRITE:
/ 'Total Airlines          :', gv_total_records.

WRITE:
/ 'Long Names              :', gv_long_names.

WRITE:
/ 'Short Names             :', gv_short_names.

WRITE:
/ 'Finished Successfully'.

ULINE.

*---------------------------------------------------------------------*
* Final Statistics
*---------------------------------------------------------------------*

DATA:
  lv_max_length TYPE i,
  lv_min_length TYPE i VALUE 999,
  lv_average    TYPE p LENGTH 8 DECIMALS 2,
  lv_sum        TYPE i.

LOOP AT gt_result INTO gs_result.

  lv_sum = lv_sum + gs_result-text_length.

  IF gs_result-text_length > lv_max_length.
    lv_max_length = gs_result-text_length.
  ENDIF.

  IF gs_result-text_length < lv_min_length.
    lv_min_length = gs_result-text_length.
  ENDIF.

ENDLOOP.

IF gv_total_records > 0.

  lv_average = lv_sum / gv_total_records.

ENDIF.

ULINE.

WRITE: /
'================ FINAL REPORT ================'.

WRITE: /
'Total Airlines        :', gv_total_records.

WRITE: /
'Longest Name Length   :', lv_max_length.

WRITE: /
'Shortest Name Length  :', lv_min_length.

WRITE: /
'Average Name Length   :', lv_average.

ULINE.

*---------------------------------------------------------------------*
* Best Practice Examples
*---------------------------------------------------------------------*

WRITE: /
'Best Practices'.

WRITE: /
'- Use Open SQL string functions instead of ABAP LOOP processing.'.

WRITE: /
'- Filter data in the database whenever possible.'.

WRITE: /
'- Use CONCAT_WITH_SPACE instead of manual concatenation.'.

WRITE: /
'- Prefer UPPER/LOWER in SQL for case-insensitive searches.'.

WRITE: /
'- Keep SELECT lists explicit (avoid SELECT *).'.

WRITE: /
'- Use aliases for calculated columns.'.

WRITE: /
'- Use CASE expressions instead of post-processing in ABAP.'.

WRITE: /
'- Execute calculations on the database layer.'.

ULINE.

*---------------------------------------------------------------------*
* Performance Notes
*---------------------------------------------------------------------*

WRITE: /
'Performance Notes'.

WRITE: /
'- Database string functions reduce network traffic.'.

WRITE: /
'- Smaller result sets improve response time.'.

WRITE: /
'- Avoid unnecessary LOOP/READ statements.'.

WRITE: /
'- Use WHERE conditions to filter early.'.

WRITE: /
'- Keep SQL readable and maintainable.'.

ULINE.

*---------------------------------------------------------------------*
* End of Program
*---------------------------------------------------------------------*

WRITE: /
'============================================='.

WRITE: /
'Modern ABAP Open SQL String Functions Demo'.

WRITE: /
'Status : SUCCESS'.

WRITE: /
'Database : SCARR'.

WRITE: /
'Program completed successfully.'.

WRITE: /
'============================================='.
