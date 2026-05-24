REPORT zz_01_write_1.

DATA:
  gv_text1 TYPE string VALUE 'Merhaba, ABAP!',
  gv_text2 TYPE string VALUE 'Merhaba, Dunya!'.

WRITE: / gv_text1 COLOR 5,
       / gv_text2 COLOR 6.
