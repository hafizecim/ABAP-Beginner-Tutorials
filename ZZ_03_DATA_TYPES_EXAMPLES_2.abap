*&---------------------------------------------------------------------*
*& Report ZZ_03_DATA_TYPES_EXAMPLES_2
*&---------------------------------------------------------------------*
*& ABAP Veri Tipleri Örneği
*&---------------------------------------------------------------------*

REPORT zz_03_data_types_examples_2.

"==============================
" 1️⃣ Temel Veri Tipleri (Elementary)
"==============================

" Karakter tipleri
DATA lv_char TYPE c LENGTH 10.      " Sabit uzunlukta karakter (CHAR)
DATA lv_string TYPE string.         " Dinamik uzunlukta karakter (STRING)

" Sayısal tipler
DATA lv_int TYPE i.                 " Integer (tam sayı)
DATA lv_dec TYPE p LENGTH 8 DECIMALS 2. " Packed number (decimal)
DATA lv_flt TYPE f.                 " Floating point sayı

" Boolean tip
DATA lv_bool TYPE abap_bool.        " ABAP'ta boolean: 'X' veya space

" Tarih ve saat tipleri
DATA lv_date TYPE d.                " Tarih YYYYMMDD
DATA lv_time TYPE t.                " Saat HHMMSS

"==============================
" 2️⃣ Yapısal Veri Tipleri (Structured)
"==============================

" Yapı (Structure) tanımlama ve kullanma
TYPES: BEGIN OF ty_person,
         name TYPE string,
         age  TYPE i,
         gender TYPE c LENGTH 1,
       END OF ty_person.

DATA ls_person TYPE ty_person.      " Yapıdan bir değişken oluşturma
ls_person-name = 'Ahmet'.
ls_person-age = 30.
ls_person-gender = 'M'.

"==============================
" 3️⃣ İçerikli Veri Tipleri (Internal Tables / Arrays)
"==============================

" Tek boyutlu tablo (Internal Table) oluşturma
TYPES: ty_numbers TYPE TABLE OF i WITH DEFAULT KEY.
DATA lt_numbers TYPE ty_numbers.

" Veri ekleme
APPEND 10 TO lt_numbers.
APPEND 20 TO lt_numbers.

" Satır bazlı okuma
LOOP AT lt_numbers INTO DATA(lv_num).
  WRITE: / 'Sayı:', lv_num.
ENDLOOP.

"==============================
" 4️⃣ Referans Tipleri
"==============================

" Obje referans tipi
CLASS cl_demo_class DEFINITION.
  PUBLIC SECTION.
    METHODS: say_hello.
ENDCLASS.

CLASS cl_demo_class IMPLEMENTATION.
  METHOD say_hello.
    WRITE: / 'Merhaba ABAP!'.
  ENDMETHOD.
ENDCLASS.

DATA lo_demo TYPE REF TO cl_demo_class. " Referans oluşturma
CREATE OBJECT lo_demo.
lo_demo->say_hello( ).

"==============================
" 5️⃣ Tablo satır tipleri ve nested tipler
"==============================

TYPES: BEGIN OF ty_employee,
         id   TYPE i,
         name TYPE string,
         age  TYPE i,
       END OF ty_employee.

TYPES: ty_emp_table TYPE TABLE OF ty_employee WITH DEFAULT KEY.
DATA lt_employees TYPE ty_emp_table.

APPEND VALUE #( id = 1 name = 'Ayşe' age = 28 ) TO lt_employees.
APPEND VALUE #( id = 2 name = 'Mehmet' age = 35 ) TO lt_employees.

LOOP AT lt_employees INTO DATA(ls_emp).
  WRITE: / ls_emp-id, ls_emp-name, ls_emp-age.
ENDLOOP.

"==============================
" 6️⃣ Diğer özel tipler
"==============================

" STRING ve XSTRING
DATA lv_xstring TYPE xstring.        " Binary veri tipleri
lv_xstring = '4D5A'.

" REF TO veri tipleri (pointer gibi)
DATA lr_person TYPE REF TO ty_person.
CREATE DATA lr_person.
lr_person->name = 'Zeynep'.

" Boolean kullanım örneği
IF lv_bool = abap_true.
  WRITE: / 'Doğru'.
ELSE.
  WRITE: / 'Yanlış'.
ENDIF.
