*---------------------------------------------------------------------*
* Program Name : ZZ_01_WRITE_2
* Author       : Hafize
* Created Date : 25.05.2026
*
* Purpose      :
* Demonstrates the use of PARAMETERS and dynamic user input
* handling with WRITE statement in ABAP.
*
* Topics       :
* - PARAMETERS
* - User Input
* - WRITE Statement
* - Colored Output
*---------------------------------------------------------------------*

REPORT zz_01_write_2.

*---------------------------------------------------------------------*
* Selection Screen
*---------------------------------------------------------------------*

" User enters a text value from the selection screen
PARAMETERS:
  p_text TYPE string.

*---------------------------------------------------------------------*
* Output Section
*---------------------------------------------------------------------*

" Displaying user input with colored output
WRITE: / 'Girilen Metin:', p_text COLOR 5.
