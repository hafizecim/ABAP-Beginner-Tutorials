REPORT ZOSQL_28_EXISTS.

*---------------------------------------------------------------------*
* Report : ZOSQL_28_EXISTS
* Purpose: Demonstrates the EXISTS concept in ABAP Open SQL
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. EXISTS Concept
* 2. Record Existence Check
* 3. SELECT SINGLE
* 4. sy-subrc
* 5. IF EXISTS Logic
* 6. Best Practices
*---------------------------------------------------------------------*

"=========================================================
" 1. Selection Parameter
"=========================================================
PARAMETERS:
  p_carrid TYPE scarr-carrid DEFAULT 'LH'.

"=========================================================
" 2. Data Objects
"=========================================================
DATA:
  gs_scarr TYPE scarr.

"=========================================================
" 3. Check Record Existence
"=========================================================
SELECT SINGLE *

  FROM scarr

  INTO @gs_scarr

 WHERE carrid = @p_carrid.

"=========================================================
" 4. Process Result
"=========================================================
IF sy-subrc = 0.

  WRITE: / 'Record exists.'.
  ULINE.

  WRITE: / 'Carrier ID   :', gs_scarr-carrid.
  WRITE: / 'Carrier Name :', gs_scarr-carrname.
  WRITE: / 'Currency     :', gs_scarr-currcode.
  WRITE: / 'URL          :', gs_scarr-url.

ELSE.

  WRITE: / 'Record does not exist.'.

ENDIF.

ULINE.

WRITE: / 'Program completed successfully.'.
