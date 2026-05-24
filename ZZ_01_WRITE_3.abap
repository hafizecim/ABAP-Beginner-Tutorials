REPORT ZZ_01_WRITE_3.

PARAMETERS:
  p_lang TYPE c LENGTH 2.

CASE p_lang.

  WHEN 'TR'.
    WRITE: / 'Merhaba Dunya!' COLOR 5.

  WHEN 'EN'.
    WRITE: / 'Hello World!' COLOR 6.

  WHEN OTHERS.
    WRITE: / 'Dil desteklenmiyor!' COLOR 7.

ENDCASE.
