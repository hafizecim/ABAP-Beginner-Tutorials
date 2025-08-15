REPORT ZZ_05_VARIABLE_NAMING_CONVENTIONS.

"=========================================================
" Tablo Tanımı
"=========================================================
TABLES: sflight.

"=========================================================
" Global Değişkenler
"=========================================================
DATA: gv_carrid   TYPE sflight-carrid.        " Global değişken (variable)
DATA: gt_sflight  TYPE TABLE OF sflight.      " Global iç tablo (internal table)
DATA: gs_sflight  LIKE LINE OF gt_sflight.    " Global iç tablo satırı (structure)
"DATA: gs_sflight TYPE sflight.             " Alternatif olarak doğrudan tablo satırı tipi

"=========================================================
" Parametre ve Seçenekler (Kullanıcı Girişi)
"=========================================================
PARAMETERS: p_carrid TYPE sflight-carrid.    " Parametre (tek değerli input)
SELECT-OPTIONS: s_carrid FOR sflight-carrid. " Seçenekler (select-options) ile kullanıcıdan çoklu giriş alabiliriz

"=========================================================
" Sabitler
"=========================================================
CONSTANTS: c_pi TYPE p VALUE '3.14'.         " Sabit (constant)

"=========================================================
" Program Başlangıcı
"=========================================================
START-OF-SELECTION.
  " Kullanıcıdan giriş alma ve seçimi hazırlama
  PERFORM build_select.

"=========================================================
" Form Tanımı
"=========================================================
FORM build_select.
    " Bu alanda tanımlanan değişkenler sadece form içinde geçerlidir (local)
    DATA: lv_fldate TYPE sflight-fldate.     " Local değişken (variable)

    " Global değişkenler form içinde de kullanılabilir
    SELECT SINGLE *
      FROM sflight
      INTO gs_sflight
      WHERE carrid = p_carrid.

ENDFORM.
