REPORT ZOSQL_27_MULTIPLE_JOIN.

*---------------------------------------------------------------------*
* Report : ZOSQL_27_MULTIPLE_JOIN
* Purpose: Demonstrates Multiple INNER JOIN in Open SQL
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Multiple INNER JOIN
* 2. Table Aliases (AS)
* 3. JOIN Conditions (ON)
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
    fldate    TYPE sflight-fldate,
    planetype TYPE sflight-planetype,
    seatsmax  TYPE sflight-seatsmax,
    seatsocc  TYPE sflight-seatsocc,
  END OF ty_result.

"=========================================================
" 3. Data Objects
"=========================================================
DATA:
  gt_result TYPE STANDARD TABLE OF ty_result,
  gs_result TYPE ty_result.

"=========================================================
" 4. Multiple INNER JOIN
"=========================================================
SELECT

       c~carrid,
       c~carrname,
       p~connid,
       p~cityfrom,
       p~cityto,
       f~fldate,
       f~planetype,
       f~seatsmax,
       f~seatsocc

  FROM scarr AS c

       INNER JOIN spfli AS p
               ON c~carrid = p~carrid

       INNER JOIN sflight AS f
               ON p~carrid = f~carrid
              AND p~connid = f~connid

 WHERE c~carrid = @p_carrid

 ORDER BY
       c~carrid,
       p~connid,
       f~fldate

 INTO CORRESPONDING FIELDS OF TABLE @gt_result.

"=========================================================
" 5. Validation
"=========================================================
IF gt_result IS INITIAL.

  WRITE: / 'No flight information found.'.
  RETURN.

ENDIF.

"=========================================================
" 6. Report Header
"=========================================================
WRITE: / 'Airline ID :', p_carrid.
WRITE: / 'Flights    :', lines( gt_result ).

ULINE.

"=========================================================
" 7. Display Result
"=========================================================
LOOP AT gt_result INTO gs_result.

  WRITE:
    / 'Carrier     :', gs_result-carrname,
    / 'Connection  :', gs_result-connid,
    / 'From        :', gs_result-cityfrom,
    / 'To          :', gs_result-cityto,
    / 'Flight Date :', gs_result-fldate,
    / 'Plane Type  :', gs_result-planetype,
    / 'Seats Max   :', gs_result-seatsmax,
    / 'Seats Used  :', gs_result-seatsocc.

  ULINE.

ENDLOOP.

"=========================================================
" End of Program
"=========================================================
WRITE: / 'Program completed successfully.'.
