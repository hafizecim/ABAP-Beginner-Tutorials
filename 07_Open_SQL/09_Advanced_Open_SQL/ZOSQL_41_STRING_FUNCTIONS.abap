REPORT ZOSQL_41_STRING_FUNCTIONS.

*---------------------------------------------------------------------*
* Report : ZOSQL_41_STRING_FUNCTIONS
* Purpose: Demonstrates String Functions in Modern ABAP Open SQL
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. CONCAT
* 2. CONCAT_WITH_SPACE
* 3. LOWER
* 4. UPPER
* 5. LPAD
* 6. RPAD
* 7. LENGTH
* 8. LEFT
* 9. RIGHT
* 10. SUBSTRING
* 11. INSTR
* 12. REPLACE
* 13. Best Practices
*
*---------------------------------------------------------------------*

TABLES: scarr.

*---------------------------------------------------------------------*
* 1. Read Data Using String Functions
*---------------------------------------------------------------------*
SELECT
       carrid,

       carrname,

       CONCAT( carrid,
               carrname )                         AS concat_text,

       CONCAT_WITH_SPACE(
               carrid,
               carrname,
               3 )                               AS concat_space,

       LOWER( carrname )                         AS lower_name,

       UPPER( carrname )                         AS upper_name,

       LPAD( carrid,
             5,
             '0' )                               AS left_pad,

       RPAD( carrid,
             5,
             '*' )                               AS right_pad,

       LENGTH( carrname )                        AS text_length,

       LEFT( carrname,
             5 )                                 AS left_text,

       RIGHT( carrname,
              5 )                                AS right_text,

       SUBSTRING(
             carrname,
             2,
             6 )                                 AS substring_text,

       INSTR(
             carrname,
             'A' )                               AS position_a,

       REPLACE(
             carrname,
             'Air',
             'AIR' )                             AS replaced_text

FROM scarr

INTO TABLE @DATA(lt_result)

ORDER BY carrid.

*---------------------------------------------------------------------*
* 2. Display Result
*---------------------------------------------------------------------*
IF lt_result IS INITIAL.

  WRITE: / 'No data found.'.
  RETURN.

ENDIF.

LOOP AT lt_result INTO DATA(ls_result).

  WRITE: / 'Carrier ID      :', ls_result-carrid.
  WRITE: / 'Carrier Name    :', ls_result-carrname.
  WRITE: / 'CONCAT          :', ls_result-concat_text.
  WRITE: / 'WITH SPACE      :', ls_result-concat_space.
  WRITE: / 'LOWER           :', ls_result-lower_name.
  WRITE: / 'UPPER           :', ls_result-upper_name.
  WRITE: / 'LPAD            :', ls_result-left_pad.
  WRITE: / 'RPAD            :', ls_result-right_pad.
  WRITE: / 'LENGTH          :', ls_result-text_length.
  WRITE: / 'LEFT            :', ls_result-left_text.
  WRITE: / 'RIGHT           :', ls_result-right_text.
  WRITE: / 'SUBSTRING       :', ls_result-substring_text.
  WRITE: / 'INSTR           :', ls_result-position_a.
  WRITE: / 'REPLACE         :', ls_result-replaced_text.

  ULINE.

ENDLOOP.

*---------------------------------------------------------------------*
* End of Program
*---------------------------------------------------------------------*
WRITE: / 'Program completed successfully.'.
