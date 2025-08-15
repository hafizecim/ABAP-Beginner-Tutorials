REPORT ZZ_06_DATA_TYPES_EXAMPLES_1.

*---------------------------------------------------------------------
* ABAP Veri Tipleri Örnekleri
*---------------------------------------------------------------------

*---------------------------------------------------------------------
* Type C (Character) 
*---------------------------------------------------------------------
DATA lv_character(50) TYPE c VALUE 'Hello World'.  " Karakter tipi, sabit uzunluk (50)
WRITE: 'Type C (Character) :', lv_character.
ULINE.  " Yatay çizgi ekleme

*---------------------------------------------------------------------
* Type N (Numeric Text)
*---------------------------------------------------------------------
DATA lv_numeric(10) TYPE n.                        " Sayısal karakter tipi (Numeric Text)
lv_numeric = '1234567'.
WRITE: 'Type N (Numeric Text) :', lv_numeric.
ULINE.

*---------------------------------------------------------------------
* Type T (Time)
*---------------------------------------------------------------------
DATA lv_time TYPE t.                               " Saat tipi (HHMMSS)
lv_time = sy-uzeit.  " Sistem saatini al - current time system time server
WRITE: 'Type T (Time) :', lv_time.
ULINE.

*---------------------------------------------------------------------
* Type D (Date)
*---------------------------------------------------------------------
DATA: lv_date TYPE d,                              " Tarih tipi (YYYYMMDD)
      lv_tomorrow TYPE d.
lv_date = sy-datum.       " Sistem tarihini al -current date system date server
lv_tomorrow = lv_date + 1. " Yarın tarihini hesapla
WRITE: 'Type D (Date) :', lv_tomorrow.
ULINE.

*---------------------------------------------------------------------
* Type I (Integer)
*---------------------------------------------------------------------
DATA lv_integer TYPE i VALUE 50.                   " Tam sayı tipi (Integer)
WRITE: 'Type I (Integer) :', lv_integer.
ULINE.

*---------------------------------------------------------------------
* Type F (Floating Point)
*---------------------------------------------------------------------
DATA lv_float TYPE f.                               " Ondalıklı sayı (Floating Point)
lv_float = lv_integer / 12.                        " 50 / 12 işlemi
WRITE: 'Type F (Floating Point) :', lv_float.
ULINE.

*---------------------------------------------------------------------
* Type P (Packed Number)
*---------------------------------------------------------------------
DATA lv_packed TYPE p DECIMALS 2.                 " Packed number, 2 ondalık basamak
lv_packed = '123.90'.
WRITE: 'Type P (Packed Number) :', lv_packed.
ULINE.

*---------------------------------------------------------------------
* Type X (Hexadecimal)
*---------------------------------------------------------------------
DATA lv_hexadecimal TYPE x VALUE '0A'.            " Hexadecimal tip
WRITE: 'Type X (Hexadecimal) :', lv_hexadecimal.
ULINE.
