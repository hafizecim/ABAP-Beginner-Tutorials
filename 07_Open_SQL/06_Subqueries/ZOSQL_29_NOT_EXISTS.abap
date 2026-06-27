REPORT ZOSQL_29_NOT_EXISTS.

*---------------------------------------------------------------------*
* Report : ZOSQL_29_NOT_EXISTS
* Purpose: Demonstrates NOT EXISTS logic in ABAP Open SQL
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. NOT EXISTS Concept
* 2. SELECT SINGLE
* 3. sy-subrc Evaluation
* 4. Record Validation
* 5. Conditional Processing
* 6. Best Practices
*---------------------------------------------------------------------*

"=========================================================
" 1. Selection Parameter
"=========================================================
PARAMETERS:
  p_carrid TYPE scarr-carrid DEFAULT 'XX'.

"=========================================================
" 2. Data Declaration
"=========================================================
DATA:
  gs_scarr TYPE scarr.

"=========================================================
" 3. Check Record Existence
"=========================================================
SELECT SINGLE
       carrid,
       carrname,
       currcode

  FROM scarr

  INTO CORRESPONDING FIELDS OF @gs_scarr

 WHERE carrid = @p_carrid.

"=========================================================
" 4. Process Result
"=========================================================
IF sy-subrc <> 0.

  WRITE: / 'Record does NOT exist.'.
  WRITE: / 'Carrier ID:', p_carrid.
  WRITE: / 'A new record can be created.'.

ELSE.

  WRITE: / 'Record already exists.'.
  ULINE.

  WRITE: / 'Carrier ID   :', gs_scarr-carrid.
  WRITE: / 'Carrier Name :', gs_scarr-carrname.
  WRITE: / 'Currency     :', gs_scarr-currcode.

ENDIF.

ULINE.

WRITE: / 'Program completed successfully.'.
