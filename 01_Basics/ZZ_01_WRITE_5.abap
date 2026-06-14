*---------------------------------------------------------------------*
* Program Name : ZZ_01_WRITE_5
* Author       : Hafize
* Created Date : 25.05.2026
*
* Purpose      :
* Demonstrates modern ABAP syntax using VALUE constructor
* expression and inline declarations with LOOP processing.
*
* Topics       :
* - Modern ABAP (VALUE)
* - Internal Table Construction
* - Inline DATA Declaration
* - LOOP AT
* - WRITE Statement
*---------------------------------------------------------------------*

REPORT zz_01_write_5.

*---------------------------------------------------------------------*
* Data Declarations (Modern ABAP)
*---------------------------------------------------------------------*

" Internal table created using VALUE constructor expression
DATA(gt_messages) = VALUE stringtab(
  ( `Merhaba ABAP` )
  ( `Hello ABAP` )
  ( `Hallo ABAP` )
).

*---------------------------------------------------------------------*
* Processing & Output
*---------------------------------------------------------------------*

" Inline declaration used for loop work area
LOOP AT gt_messages INTO DATA(gv_message).

  WRITE: / gv_message.

ENDLOOP.
