REPORT ZOSQL_41_STRING_FUNCTIONS.

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
