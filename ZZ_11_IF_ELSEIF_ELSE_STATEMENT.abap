REPORT ZZ_11_IF_ELSEIF_ELSE_STATEMENT.

*----------------------------------------------------------------------
* Program: ZZ_11_IF_ELSEIF_ELSE_STATEMENT
* Konu   : ABAP’ta IF-ELSEIF-ELSE ve farklı kontrol yapıları
* Açıklama:
*   Bu program ABAP dilinde IF koşulları ile çeşitli veri kontrollerini
*   göstermektedir.
*   İçerik:
*     - Sayısal karşılaştırmalar (=, <>, >, <, >=, <=)
*     - Aralık kontrolü (BETWEEN)
*     - Liste kontrolü (IN)
*     - Veri tipi kontrolleri (IS NUMERIC, IS INITIAL vb.)
*     - Field-symbol ve referans nesne kontrolleri
*     - Internal table kontrolü
----------------------------------------------------------------------

*---------------------------
* 1) Basit karşılaştırmalar
*---------------------------
DATA: num1 TYPE i VALUE 10,
      num2 TYPE i VALUE 20,
      result TYPE i.

" Eşitlik kontrolü
IF num1 EQ num2. " EQ ya da = kullanılabilir
  WRITE: / 'Num1 is equal to Num2'.
ENDIF.

" Eşit değil kontrolü
IF num1 NE num2. " NE ya da <> kullanılabilir
  WRITE: / 'Num1 is not equal to Num2'.
ENDIF.

" IF - ELSE kullanımı
IF num1 EQ num2.
  WRITE: / 'Num1 is equal to Num2'.
ELSE.
  WRITE: / 'Num1 is not equal to Num2'.
ENDIF.

" IF - ELSEIF - ELSE zinciri
IF num1 EQ num2.
  WRITE: / 'Num1 is equal to Num2'.
ELSEIF num1 NE num2.
  WRITE: / 'Num1 is not equal to Num2'.
ELSEIF num1 GT num2.
  WRITE: / 'Num1 is greater than Num2'.
ELSEIF num1 LT num2.
  WRITE: / 'Num1 is less than Num2'.
ELSEIF num1 GE num2.
  WRITE: / 'Num1 is greater than or equal to Num2'.
ELSEIF num1 LE num2.
  WRITE: / 'Num1 is less than or equal to Num2'.
ELSE.
  WRITE: / 'Num1 and Num2 are not equal'.
ENDIF.


*------------------------------------------
* 2) Özel durumlar ve veri tipi kontrolleri
*------------------------------------------
DATA(num1_val) = 0.                        " Başlangıç değeri 0
DATA(num_str) TYPE string VALUE '123'.     " Metin olarak sayı örneği
DATA(lr_ref) TYPE REF TO data.             " Generic data reference
FIELD-SYMBOLS: <fs_any> TYPE any.

" Num1 için sıralı kontrol örneği
IF num1_val IS INITIAL.
  WRITE: / 'Num1 is initial (zero) ->', num1_val.
ELSEIF num1_val BETWEEN 115 AND 2215.
  WRITE: / 'Num1 is between 115 and 2215 ->', num1_val.
ELSEIF num1_val IN 10 20 30.
  WRITE: / 'Num1 is in the list (10,20,30) ->', num1_val.
ELSE.
  WRITE: / 'Num1 did not match previous checks ->', num1_val.
ENDIF.

" Karakter dizesinin sayısal olup olmadığını kontrol etme
IF num_str IS NUMERIC.
  WRITE: / 'num_str IS NUMERIC (metin sayısal):', num_str.
ELSE.
  WRITE: / 'num_str is NOT numeric text:', num_str.
ENDIF.


*---------------------------------
* 3) Field-symbol atama kontrolü
*---------------------------------
CREATE DATA lr_ref TYPE i.          " Referans veri oluştur
ASSIGN lr_ref->* TO <fs_any>.       " Field-symbol'e ata

IF <fs_any> IS ASSIGNED.
  WRITE: / 'Field-symbol is assigned.'.
  <fs_any> = 42.
  WRITE: / 'Value via field-symbol:', <fs_any>.
ELSE.
  WRITE: / 'Field-symbol is NOT assigned.'.
ENDIF.


*-----------------------------------
* 4) Nesne referansı IS BOUND kontrolü
*-----------------------------------
CLASS lcl_demo DEFINITION.
  PUBLIC SECTION.
    METHODS: ctor.
ENDCLASS.

CLASS lcl_demo IMPLEMENTATION.
  METHOD ctor.
  ENDMETHOD.
ENDCLASS.

DATA(obj) TYPE REF TO lcl_demo.
CREATE OBJECT obj.

IF obj IS BOUND.
  WRITE: / 'Object reference is BOUND (nesne mevcut).'.
ELSE.
  WRITE: / 'Object reference is NOT BOUND.'.
ENDIF.


*-----------------------------------
* 5) Internal table boş/dolu kontrolü
*-----------------------------------
DATA lt_tab TYPE STANDARD TABLE OF i WITH EMPTY KEY.

IF lt_tab IS INITIAL.
  WRITE: / 'Internal table is empty (IS INITIAL).'.
ELSE.
  WRITE: / 'Internal table has entries, lines =', lines( lt_tab ).
ENDIF.
