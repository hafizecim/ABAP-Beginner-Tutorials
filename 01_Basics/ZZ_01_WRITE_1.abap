*---------------------------------------------------------------------*
* Program Name : ZZ_01_WRITE_1
* Author       : Hafize
* Created Date : 24.05.2026
*
* Purpose      :
* Demonstrates the use of variables and colored output using WRITE
* statement in ABAP.
*
* Topics       :
* - DATA declaration
* - String variables
* - WRITE statement
* - COLOR addition
*---------------------------------------------------------------------*

REPORT zz_01_write_1.

*---------------------------------------------------------------------*
* Data Declarations
*---------------------------------------------------------------------*

" Text variables used for output demonstration
DATA:
  gv_text1 TYPE string VALUE 'Merhaba, ABAP!',
  gv_text2 TYPE string VALUE 'Merhaba, Dunya!'.

*---------------------------------------------------------------------*
* Output Section
*---------------------------------------------------------------------*

" COLOR 5 -> Green output in SAP GUI
WRITE: / gv_text1 COLOR 5,

" COLOR 6 -> Different colored output
       / gv_text2 COLOR 6.
