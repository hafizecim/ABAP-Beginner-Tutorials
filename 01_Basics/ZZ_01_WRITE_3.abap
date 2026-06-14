*---------------------------------------------------------------------*
* Program Name : ZZ_01_WRITE_3
* Author       : Hafize
* Created Date : 25.05.2026
*
* Purpose      :
* Demonstrates the use of CASE structure with user input
* and colored output in ABAP.
*
* Topics       :
* - PARAMETERS
* - CASE Statement
* - Conditional Logic
* - WRITE Statement
* - Colored Output
*---------------------------------------------------------------------*

REPORT zz_01_write_3.

*---------------------------------------------------------------------*
* Selection Screen
*---------------------------------------------------------------------*

" User enters language code
" TR = Turkish
" EN = English
PARAMETERS:
  p_lang TYPE c LENGTH 2.

*---------------------------------------------------------------------*
* Conditional Output Section
*---------------------------------------------------------------------*

CASE p_lang.

  WHEN 'TR'.

    " Display Turkish message
    WRITE: / 'Merhaba Dunya!' COLOR 5.

  WHEN 'EN'.

    " Display English message
    WRITE: / 'Hello World!' COLOR 6.

  WHEN OTHERS.

    " Invalid language selection
    WRITE: / 'Dil desteklenmiyor!' COLOR 7.

ENDCASE.
