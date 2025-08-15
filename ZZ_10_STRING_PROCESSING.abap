REPORT ZZ_10_STRING_PROCESSING.

Data str1 type string value 'ABAP',
     str2 type string value 'Programing'.

DATA str3 type string.
DATA str4 type string.

*Concatenate ( string birleştirme)
Concatenate str1 str2 into str3.
WRITE: / 'Concatenated String:', str3. " Çıktı => Concatenated String: ABAPPrograming
ULINE.

Concatenate str1 str2 into str4  Separated by space. " değişkenleri birleştir ve arlarına boşluk ekle ( character ve symbol kullanabiliriz)
WRITE: / 'Concatenated String with space:', str4. " Çıktı => Concatenated String with space: ABAP Programing
unLINE.

Concatenate str1 str2 into str3 Separated by '_'.
WRITE: / 'Concatenated String with underscore:', str3. " Çıktı => Concatenated String with underscore: ABAP_Programing
ULINE.


*Condense ( boşlukları kaldırma)
data lv_nogaps type string value 'Abap Programing'.
CONDENSE lv_nogaps NO-GAPS.
WRITE: / 'Condensed String:', lv_nogaps. " Çıktı => Condensed String: AbapPrograming
ULINE.

*strlen ( string uzunluğu)
DATA lv_string TYPE value 'processing'.
data lv_strlen type i.

lv_strlen = strlen( lv_string ).
WRITE: / 'String Length:', lv_strlen. " Çıktı => String Length: 10
ULINE.

*Replace ( string içinde değişiklik yapma)
DATA lv_replace type string value 'ABAP Programming'.
REPLACE 'Programming' IN lv_replace WITH 'Development'.
WRITE: / 'Replaced String:', lv_replace. " Çıktı => Replaced String: ABAP Development
ULINE.


*search ( string içinde arama)
DATA lv_search type string value 'ABAP Programming'.
DATA lv_pos type i.
lv_pos = search( val = lv_search sub = 'Programming' ).
IF lv_pos > 0.
  WRITE: / 'Search found at position:', lv_pos. " Çıktı => Search found at position: 5
ELSE.
  WRITE: / 'Search not found'.
ENDIF.
ULINE.

search lv_search for 'in'.
WRITE: / 'Search for "in":', sy-subrc , sy-fdpos . " Çıktı => Search for "in": 0 3
" sy-subrc 0 ise aranan değişken metin içinde bulundu. 
" sy-subrc 4 ise aranan değişken metin içinde bulunamadı.
" sy-fdpos ise bulunduğu konum başlangıç pozisyonudur.


search lv_search for 'kywrd' ABBREVIATED.
WRITE: / 'Search for "kywrd" ABBREVIATED:', sy-subrc , sy-fdpos. " Çıktı => Search for "kywrd" ABBREVIATED: 0 7
ULINE.

*shift ( string kaydırma)
DATA lv_shift type string value '0123450'.
SHIFT lv_shift by 2 places.
WRITE: / 'Shifted String:', lv_shift. " Çıktı => Shifted String: 345
 

shift lv_shift left by 1 places.
WRITE: / 'Shifted String Left:', lv_shift. " Çıktı => Shifted String Left: 45


shift lv_shift right by 1 places.
WRITE: / 'Shifted String Right:', lv_shift. " Çıktı => Shifted String Right: 45
  

shift lv_shift up to '3' right circular.
WRITE: / 'Shifted String Up to 3 Right Circular:', lv_shift. " Çıktı => Shifted String Up to 3 Right Circular: 45123


shift lv_shift left delete leading '0'.
WRITE: / 'Shifted String Left Delete Leading 0:', lv_shift. " Çıktı => Shifted String Left Delete Leading 0: 45123


shift lv_shift right delete trailing '0'.
WRITE: / 'Shifted String Right Delete Trailing 3:', lv_shift. " Çıktı => Shifted String Right Delete Trailing 3: 
ULINE.

*split ( string bölme)
DATA lv_split type string value 'ABAP,Programming,Development'.
DATA lt_split TYPE TABLE OF string.
SPLIT lv_split AT ',' INTO TABLE lt_split.
LOOP AT lt_split INTO DATA(lv_part).
  WRITE: / 'Split Part:', lv_part. " Çıktı => Split Part: ABAP, Programming, Development    
ENDLOOP.
ULINE.

*translate ( string çevirme)
DATA lv_translate type string value 'ABAP Programming'.
TRANSLATE lv_translate TO UPPER CASE.
WRITE: / 'Translated String to Upper Case:', lv_translate. " Çıktı => Translated String to Upper Case: ABAP PROGRAMMING


TRANSLATE lv_translate TO LOWER CASE.
WRITE: / 'Translated String to Lower Case:', lv_translate. " Çıktı => Translated String to Lower Case: abap programming

translate lv_translate USING 'a' TO 'A'.
WRITE: / 'Translated String using a to A:', lv_translate. " Çıktı   => Translated String using a to A: AbAp Programming


translate lv_translate USING 'aA'.
WRITE: / 'Translated String using Aa:', lv_translate. " Çıktı => Translated String using Aa: AbAp ProgrAmming
ULINE.

*SUBSTRING ( string alt dize alma)
DATA lv_substring type string value 'ABAP Programming'.
DATA lv_substr TYPE string.
lv_substr = lv_substring+5(11). " 5. karakterden başlayp 11 karakter al
WRITE: / 'Substring:', lv_substr. " Çıktı => Substring: Programming


DATA lv_substring1 TYPE string VALUE 'Abap Programing'.
DATA lv_substring2 TYPE string.
data lv_substring3 type string.
data lv_substring4 type string.

lv_substring2 = lv_substring1+4(6). " 4. karakterden başlayp 6 karakter al  
WRITE: / 'Substring 1:', lv_substring2. " Çıktı => Substring 1: Program
lv_substring3 = lv_substring1+4. " 4. karakterden başlayp kalanını al
WRITE: / 'Substring 2:', lv_substring3. " Çıktı => Substring 2: Programing
lv_substring4 = lv_substring1(4). " İlk 4 karakteri al
WRITE: / 'Substring 3:', lv_substring4. " Çıktı => Substring 3: Abap
ULINE. 

