*&---------------------------------------------------------------------*
*& Report ZFULL_DEBUG_DATA_TYPES
*&---------------------------------------------------------------------*
*& ABAP Veri Tipleri + Debug Örneği
*&---------------------------------------------------------------------*

REPORT zfull_debug_data_types.

"==============================
" 1️⃣ Temel Veri Tipleri
"==============================
DATA lv_char   TYPE c LENGTH 10 VALUE 'ABAPDEBUG'.
DATA lv_string TYPE string VALUE 'Merhaba ABAP'.
DATA lv_int    TYPE i VALUE 10.
DATA lv_dec    TYPE p LENGTH 8 DECIMALS 2 VALUE '123.45'.
DATA lv_flt    TYPE f VALUE 3.14.
DATA lv_bool   TYPE abap_bool VALUE abap_true.
DATA lv_date   TYPE d VALUE '20250815'.
DATA lv_time   TYPE t VALUE '113000'.

WRITE: / 'Char:', lv_char,
       / 'String:', lv_string,
       / 'Integer:', lv_int,
       / 'Decimal:', lv_dec,
       / 'Float:', lv_flt,
       / 'Boolean:', lv_bool,
       / 'Date:', lv_date,
       / 'Time:', lv_time.

"==============================
" 2️⃣ Yapı ve Internal Table
"==============================
TYPES: BEGIN OF ty_person,
         name   TYPE string,
         age    TYPE i,
         gender TYPE c LENGTH 1,
       END OF ty_person.

DATA ls_person TYPE ty_person.
ls_person-name = 'Ahmet'.
ls_person-age = 30.
ls_person-gender = 'M'.

WRITE: / 'Yapı:', ls_person-name, ls_person-age, ls_person-gender.

TYPES ty_numbers TYPE TABLE OF i WITH DEFAULT KEY.
DATA lt_numbers TYPE ty_numbers.

APPEND 10 TO lt_numbers.
APPEND 20 TO lt_numbers.
APPEND 30 TO lt_numbers.

LOOP AT lt_numbers INTO DATA(lv_num).
  WRITE: / 'Table sayı:', lv_num.
ENDLOOP.

"==============================
" 3️⃣ Kullanıcı Bazlı Breakpoint
"==============================
WRITE: / 'Kullanıcı bazlı breakpoint denemesi'.
BREAK USER 'HAFIZE'.  " Sadece kullanıcı Hafize debug başlatır

"==============================
" 4️⃣ Koşullu Breakpoint
"==============================
IF lv_int + lv_dec > 120.
  WRITE: / 'Koşul sağlandı, debug burada duracak'.
  BREAK-POINT.
ENDIF.

"==============================
" 5️⃣ Referans Tipleri ve Method Debug
"==============================
CLASS cl_calc DEFINITION.
  PUBLIC SECTION.
    METHODS sum IMPORTING iv_a TYPE i
                       iv_b TYPE i
               RETURNING VALUE(rv_sum) TYPE i.
ENDCLASS.

CLASS cl_calc IMPLEMENTATION.
  METHOD sum.
    " Debug tuşlarını denemek için burada dur
    BREAK-POINT.
    rv_sum = iv_a + iv_b.
  ENDMETHOD.
ENDCLASS.

DATA lo_calc TYPE REF TO cl_calc.
CREATE OBJECT lo_calc.

DATA lv_total TYPE i.
lv_total = lo_calc->sum( 7 8 ).

WRITE: / 'Toplam =', lv_total.

"==============================
" 6️⃣ LOOP ve F5/F6/F7/F8 için örnek
"==============================
DATA lt_employees TYPE TABLE OF ty_person.
APPEND VALUE #( name = 'Ayşe' age = 28 gender = 'F' ) TO lt_employees.
APPEND VALUE #( name = 'Mehmet' age = 35 gender = 'M' ) TO lt_employees.

LOOP AT lt_employees INTO DATA(ls_emp).
  " Debug sırasında F5 ile yapıya gir, F6 ile satır geç, F7 ile method çık, F8 ile devam et
  BREAK-POINT.
  WRITE: / 'Çalışan:', ls_emp-name, ls_emp-age, ls_emp-gender.
ENDLOOP.

"==============================
" 7️⃣ Special Types
"==============================
DATA lv_xstring TYPE xstring VALUE '4D5A'.
WRITE: / 'XSTRING örnek:', lv_xstring.

" Boolean örnek
IF lv_bool = abap_true.
  WRITE: / 'Boolean True çalıştı'.
ELSE.
  WRITE: / 'Boolean False çalıştı'.
ENDIF.

"==============================
" Program Sonu
"==============================
WRITE: / 'Program tamamlandı. Debug ve veri tipleri örnekleri gösterildi.'.



*---------------------------------------------------------------------
* Debug Tuşları Açıklaması
*---------------------------------------------------------------------
* | Tuş                                    | İşlevi                                                                                                    |
* | -------------------------------------- | --------------------------------------------------------------------------------------------------------- |
* | F5 (Step Into)                         | Bir method, fonksiyon veya include içine girer. Kod satır satır ilerler.                                  |
* | F6 (Step Over)                         | Bir fonksiyon/metod çağrısına girmez, çağrıyı tek satır olarak çalıştırır ve sonraki satıra geçer.        |
* | F7 (Return / Step Out)                 | Mevcut method veya fonksiyondan çıkar ve çağıran koda döner.                                              |
* | F8 (Continue / Resume)                 | Breakpoint’ten programın devam etmesini sağlar, bir sonraki breakpoint veya program sonuna kadar çalışır. |
* | Shift+F2 / Variables / Watchpoints     | Değişkenleri izlemek veya değerlerini kontrol etmek için kullanılır.                                      |
*---------------------------------------------------------------------
* | F9 (Run to Cursor)                     | İmlecin bulunduğu satıra kadar kodu çalıştırır.                                                            |
* | F3 (Exit)                              | Programdan çıkış yapar.                                                                                   |