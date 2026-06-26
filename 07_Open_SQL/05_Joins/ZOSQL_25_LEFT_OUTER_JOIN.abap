REPORT ZOSQL_25_LEFT_OUTER_JOIN.

*---------------------------------------------------------------------*
* Report : ZOSQL_25_LEFT_OUTER_JOIN
* Purpose: Demonstrates LEFT OUTER JOIN in Open SQL
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. LEFT OUTER JOIN
* 2. Table Aliases
* 3. JOIN Condition
* 4. WHERE Clause
* 5. Missing Matching Records
* 6. INTO CORRESPONDING FIELDS
* 7. Result Validation
* 8. Performance Best Practices
*---------------------------------------------------------------------*

"=========================================================
" 1. Type Definition
"=========================================================
TYPES:
  BEGIN OF ty_result,
    carrid    TYPE scarr-carrid,
    carrname  TYPE scarr-carrname,
    connid    TYPE spfli-connid,
    cityfrom  TYPE spfli-cityfrom,
    cityto    TYPE spfli-cityto,
  END OF ty_result.

"=========================================================
" 2. Data Objects
"=========================================================
DATA:
  gt_result TYPE STANDARD TABLE OF ty_result,
  gs_result TYPE ty_result.

"=========================================================
" 3. LEFT OUTER JOIN
"=========================================================
SELECT

       c~carrid,
       c~carrname,
       f~connid,
       f~cityfrom,
       f~cityto

  FROM scarr AS c

  LEFT OUTER JOIN spfli AS f
    ON c~carrid = f~carrid

  ORDER BY c~carrid,
           f~connid

  INTO CORRESPONDING FIELDS OF TABLE @gt_result.

"=========================================================
" 4. Validation
"=========================================================
IF gt_result IS INITIAL.

  WRITE: / 'No records found.'.
  RETURN.

ENDIF.

"=========================================================
" 5. Report Header
"=========================================================
WRITE: / 'LEFT OUTER JOIN Result'.

ULINE.

"=========================================================
" 6. Display Result
"=========================================================
LOOP AT gt_result INTO gs_result.

  WRITE:
    / 'Carrier ID   :', gs_result-carrid,
    / 'Carrier Name :', gs_result-carrname.

  IF gs_result-connid IS INITIAL.

    WRITE:
      / 'Connection   : No flight connection',
      / 'From City    : -',
      / 'To City      : -'.

  ELSE.

    WRITE:
      / 'Connection   :', gs_result-connid,
      / 'From City    :', gs_result-cityfrom,
      / 'To City      :', gs_result-cityto.

  ENDIF.

  ULINE.

ENDLOOP.

"=========================================================
" End of Program
"=========================================================
WRITE: / 'Program completed successfully.'.
