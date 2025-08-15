REPORT ZZ_10_STRING_PROCESSING.

*----------------------------------------------------------------------
* Program: ZZ_10_STRING_PROCESSING
* Konu   : ABAP’ta String İşlemleri
* Açıklama:
*   Bu program ABAP dilinde string manipülasyonu örneklerini göstermektedir.
*   İçerik:
*     - CONCATENATE (String birleştirme)
*     - CONDENSE (Boşlukları kaldırma)
*     - STRLEN (Uzunluk bulma)
*     - REPLACE (Metin içinde değiştirme)
*     - SEARCH (Metin içinde arama)
*     - SHIFT (Karakter kaydırma)
*     - SPLIT (Metni parçalama)
*     - TRANSLATE (Büyük/küçük harf dönüşümü ve karakter değiştirme)
*     - SUBSTRING (Alt string alma)
*----------------------------------------------------------------------

*----------------------------------------------------------------------
DATA str1 TYPE string VALUE 'ABAP',
     str2 TYPE string VALUE 'Programing'. " Dikkat: 'Programing' yerine 'Programming' olabilir

DATA str3 TYPE string.
DATA str4 TYPE string.

*----------------------------------------------------------------------
* CONCATENATE - String birleştirme
*----------------------------------------------------------------------
CONCATENATE str1 str2 INTO str3. " İki stringi boşluksuz birleştir
WRITE: / 'Concatenated String:', str3.  " Çıktı: ABAPPrograming
ULINE.

CONCATENATE str1 str2 INTO str4 SEPARATED BY space. " Araya boşluk ekleyerek birleştir
WRITE: / 'Concatenated String with space:', str4. " Çıktı: ABAP Programing
ULINE.

CONCATENATE str1 str2 INTO str3 SEPARATED BY '_'. " Araya alt çizgi ekleyerek birleştir
WRITE: / 'Concatenated String with underscore:', str3. " Çıktı: ABAP_Programing
ULINE.

*----------------------------------------------------------------------
* CONDENSE - Boşlukları kaldırma
*----------------------------------------------------------------------
DATA lv_nogaps TYPE string VALUE 'Abap   Programing'. " Fazladan boşluklu ifade
CONDENSE lv_nogaps NO-GAPS. " Tüm boşlukları kaldır
WRITE: / 'Condensed String:', lv_nogaps. " Çıktı: AbapPrograming
ULINE.

*----------------------------------------------------------------------
* STRLEN - String uzunluğunu bulma
*----------------------------------------------------------------------
DATA lv_string TYPE string VALUE 'processing'.
DATA lv_strlen TYPE i.

lv_strlen = strlen( lv_string ).
WRITE: / 'String Length:', lv_strlen. " Çıktı: 10
ULINE.

*----------------------------------------------------------------------
* REPLACE - Metin içinde değiştirme
*----------------------------------------------------------------------
DATA lv_replace TYPE string VALUE 'ABAP Programming'.
REPLACE 'Programming' IN lv_replace WITH 'Development'. " 'Programming' kelimesini 'Development' ile değiştir
WRITE: / 'Replaced String:', lv_replace. " Çıktı: ABAP Development
ULINE.

*----------------------------------------------------------------------
* SEARCH - Metin içinde arama
*----------------------------------------------------------------------
DATA lv_search TYPE string VALUE 'ABAP Programming'.
DATA lv_pos TYPE i.

" Fonksiyon tarzı arama
lv_pos = search( val = lv_search sub = 'Programming' ).
IF lv_pos > 0.
  WRITE: / 'Search found at position:', lv_pos. " Çıktı: 5
ELSE.
  WRITE: / 'Search not found'.
ENDIF.
ULINE.

" Klasik arama
SEARCH lv_search FOR 'in'.
WRITE: / 'Search for "in":', sy-subrc, sy-fdpos.
" sy-subrc = 0 → bulundu
" sy-subrc = 4 → bulunamadı
" sy-fdpos → bulunduğu pozisyon
ULINE.

" Kısaltma ile arama (ABBREVIATED)
SEARCH lv_search FOR 'Progm' ABBREVIATED.
WRITE: / 'Search for "Progm" ABBREVIATED:', sy-subrc, sy-fdpos.
ULINE.

*----------------------------------------------------------------------
* SHIFT - Karakter kaydırma
*----------------------------------------------------------------------
DATA lv_shift TYPE string VALUE '0123450'.

SHIFT lv_shift BY 2 PLACES. " Baştan 2 karakter siler
WRITE: / 'Shifted String:', lv_shift. " Çıktı: 23450

SHIFT lv_shift LEFT BY 1 PLACES.
WRITE: / 'Shifted String Left:', lv_shift.

SHIFT lv_shift RIGHT BY 1 PLACES.
WRITE: / 'Shifted String Right:', lv_shift.

SHIFT lv_shift UP TO '3' RIGHT CIRCULAR. " '3' karakterine kadar sağa döngüsel kaydır
WRITE: / 'Shifted String Up to 3 Right Circular:', lv_shift.

SHIFT lv_shift LEFT DELETE LEADING '0'. " Baştaki '0' ları sil
WRITE: / 'Shifted String Left Delete Leading 0:', lv_shift.

SHIFT lv_shift RIGHT DELETE TRAILING '0'. " Sondaki '0' ları sil
WRITE: / 'Shifted String Right Delete Trailing 0:', lv_shift.
ULINE.

*----------------------------------------------------------------------
* SPLIT - Stringi parçalama
*----------------------------------------------------------------------
DATA lv_split TYPE string VALUE 'ABAP,Programming,Development'.
DATA lt_split TYPE TABLE OF string.

SPLIT lv_split AT ',' INTO TABLE lt_split. " Virgüle göre parçala
LOOP AT lt_split INTO DATA(lv_part).
  WRITE: / 'Split Part:', lv_part.
ENDLOOP.
ULINE.

*----------------------------------------------------------------------
* TRANSLATE - Karakter dönüşümü
*----------------------------------------------------------------------
DATA lv_translate TYPE string VALUE 'ABAP Programming'.

TRANSLATE lv_translate TO UPPER CASE. " Büyük harfe çevir
WRITE: / 'Translated String to Upper Case:', lv_translate.

TRANSLATE lv_translate TO LOWER CASE. " Küçük harfe çevir
WRITE: / 'Translated String to Lower Case:', lv_translate.

TRANSLATE lv_translate USING 'aA'. " 'a' → 'A', 'A' → 'a' dönüşümü
WRITE: / 'Translated String using Aa:', lv_translate.
ULINE.

*----------------------------------------------------------------------
* SUBSTRING - Alt string alma
*----------------------------------------------------------------------
DATA lv_substring TYPE string VALUE 'ABAP Programming'.
DATA lv_substr TYPE string.

lv_substr = lv_substring+5(11). " 5. karakterden başlayarak 11 karakter al
WRITE: / 'Substring:', lv_substr.

DATA lv_substring1 TYPE string VALUE 'Abap Programing'.
DATA lv_substring2 TYPE string.
DATA lv_substring3 TYPE string.
DATA lv_substring4 TYPE string.

lv_substring2 = lv_substring1+5(7). " 5. karakterden başlayarak 7 karakter al
WRITE: / 'Substring 1:', lv_substring2.

lv_substring3 = lv_substring1+5. " 5. karakterden başlayarak kalanını al
WRITE: / 'Substring 2:', lv_substring3.

lv_substring4 = lv_substring1(4). " İlk 4 karakteri al
WRITE: / 'Substring 3:', lv_substring4.
ULINE.
