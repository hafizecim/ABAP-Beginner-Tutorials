REPORT ZOSQL_24_INNER_JOIN.

*---------------------------------------------------------------------*
* Report : ZOSQL_24_INNER_JOIN
* Purpose: Demonstrates INNER JOIN in Open SQL
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. INNER JOIN
* 2. Table Aliases (AS)
* 3. JOIN Condition (ON)
* 4. WHERE Clause
* 5. ORDER BY
* 6. INTO CORRESPONDING FIELDS
* 7. Inline Declaration
* 8. Result Validation
* 9. Performance Best Practices
*---------------------------------------------------------------------*

"=========================================================
" 1. Selection Parameters
"=========================================================
PARAMETERS:
  p_carrid TYPE scarr-carrid DEFAULT 'LH'.

"=========================================================
" 2. Result Structure
"=========================================================
TYPES:
  BEGIN OF ty_result,
    carrid    TYPE scarr-carrid,
    carrname  TYPE scarr-carrname,
    connid    TYPE spfli-connid,
    cityfrom  TYPE spfli-cityfrom,
    cityto    TYPE spfli-cityto,
    countryfr TYPE spfli-countryfr,
    countryto TYPE spfli-countryto,
  END OF ty_result.

"=========================================================
" 3. Data Declarations
"=========================================================
DATA:
  gt_result TYPE STANDARD TABLE OF ty_result,
  gs_result TYPE ty_result.

"=========================================================
" 4. INNER JOIN
"=========================================================
SELECT

       c~carrid,
       c~carrname,
       f~connid,
       f~cityfrom,
       f~cityto,
       f~countryfr,
       f~countryto

  FROM scarr AS c

       INNER JOIN spfli AS f
          ON c~carrid = f~carrid

 WHERE c~carrid = @p_carrid

 ORDER BY f~connid

 INTO CORRESPONDING FIELDS OF TABLE @gt_result.

"=========================================================
" 5. Validation
"=========================================================
IF gt_result IS INITIAL.

  WRITE: / 'No matching records found.'.
  RETURN.

ENDIF.

"=========================================================
" 6. Report Header
"=========================================================
WRITE: / 'Carrier ID   :', p_carrid.
WRITE: / 'Connections  :', lines( gt_result ).

ULINE.

"=========================================================
" 7. Display Result
"=========================================================
LOOP AT gt_result INTO gs_result.

  WRITE:
    / 'Carrier ID   :', gs_result-carrid,
    / 'Carrier Name :', gs_result-carrname,
    / 'Connection   :', gs_result-connid,
    / 'From City    :', gs_result-cityfrom,
    / 'To City      :', gs_result-cityto,
    / 'Country From :', gs_result-countryfr,
    / 'Country To   :', gs_result-countryto.

  ULINE.

ENDLOOP.

"=========================================================
" End of Program
"=========================================================
WRITE: / 'Program completed successfully.'.
