REPORT ZZ_13_CASE_STATEMENT.

*----------------------------------------------------------------------
* Program: ZZ_13_CASE_STATEMENT
* Konu   : ABAP'ta CASE ve Nested CASE (İç İçe CASE) Kullanımı
* Açıklama:
*   Bu program, isim ve soyad bilgisine göre farklı mesajlar üretir.
*   İçerik:
*     - CASE ile çoklu koşul kontrolü
*     - Nested CASE (CASE içinde CASE)
*     - WHEN OTHERS kullanımı
----------------------------------------------------------------------

* Değişken tanımları
DATA : name    TYPE string,
       surname TYPE string.

* Örnek değer atamaları
name    = 'Joe'.
surname = 'Smith'.

" --------------------------------------------
" 1) İsme göre kontrol
" --------------------------------------------
CASE name.
  WHEN 'Joe'.

    " Eğer isim 'Joe' ise, soyadına göre ikinci kontrol
    CASE surname.
      WHEN 'Smith'.
        WRITE: / 'You are Joe Smith'.
      WHEN OTHERS.
        WRITE: / 'You are not Joe Smith'.
    ENDCASE.

  WHEN OTHERS.
    WRITE: / 'You are not Joe'.
ENDCASE.
