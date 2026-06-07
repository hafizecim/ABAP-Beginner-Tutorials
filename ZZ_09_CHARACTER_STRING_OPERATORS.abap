REPORT zz_09_character_string_operators.

*---------------------------------------------------------------------*
* Report : ZZ_09_CHARACTER_STRING_OPERATORS
* Purpose: Demonstrates character and string comparison operators
*---------------------------------------------------------------------*

DATA:
  lv_text    TYPE string,
  lv_pattern TYPE string.

"=========================================================
" CO - Contains Only
"=========================================================
lv_text    = 'ABAP'.
lv_pattern = 'ABAPXYZ'.

IF lv_text CO lv_pattern.

  WRITE: / 'CO (Contains Only): TRUE'.

ELSE.

  WRITE: / 'CO (Contains Only): FALSE'.

ENDIF.

ULINE.

"=========================================================
" CN - Contains Not Only
"=========================================================
lv_text    = 'ABAP123'.
lv_pattern = 'ABAP'.

IF lv_text CN lv_pattern.

  WRITE: / 'CN (Contains Not Only): TRUE'.

ELSE.

  WRITE: / 'CN (Contains Not Only): FALSE'.

ENDIF.

ULINE.

"=========================================================
" CA - Contains Any
"=========================================================
lv_text    = 'ABAP'.
lv_pattern = 'XYZA'.

IF lv_text CA lv_pattern.

  WRITE: / 'CA (Contains Any): TRUE'.

ELSE.

  WRITE: / 'CA (Contains Any): FALSE'.

ENDIF.

ULINE.

"=========================================================
" CS - Contains String
"=========================================================
lv_text    = 'ABAP Programming'.
lv_pattern = 'ABAP'.

IF lv_text CS lv_pattern.

  WRITE: / 'CS (Contains String): TRUE'.

ELSE.

  WRITE: / 'CS (Contains String): FALSE'.

ENDIF.

ULINE.

"=========================================================
" CP - Contains Pattern
"=========================================================
lv_text    = 'ABAP Programming'.
lv_pattern = 'ABAP*'.

IF lv_text CP lv_pattern.

  WRITE: / 'CP (Contains Pattern): TRUE'.

ELSE.

  WRITE: / 'CP (Contains Pattern): FALSE'.

ENDIF.

ULINE.

"=========================================================
" NA - Not Contains Any
"=========================================================
lv_text    = 'ABAP'.
lv_pattern = 'XYZ'.

IF lv_text NA lv_pattern.

  WRITE: / 'NA (Not Contains Any): TRUE'.

ELSE.

  WRITE: / 'NA (Not Contains Any): FALSE'.

ENDIF.

ULINE.

"=========================================================
" NS - Not Contains String
"=========================================================
lv_text    = 'ABAP Programming'.
lv_pattern = 'JAVA'.

IF lv_text NS lv_pattern.

  WRITE: / 'NS (Not Contains String): TRUE'.

ELSE.

  WRITE: / 'NS (Not Contains String): FALSE'.

ENDIF.

ULINE.

"=========================================================
" NP - Not Contains Pattern
"=========================================================
lv_text    = 'ABAP Programming'.
lv_pattern = 'JAVA*'.

IF lv_text NP lv_pattern.

  WRITE: / 'NP (Not Contains Pattern): TRUE'.

ELSE.

  WRITE: / 'NP (Not Contains Pattern): FALSE'.

ENDIF.

ULINE.

WRITE: / 'Program completed successfully'.
