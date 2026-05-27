*---------------------------------------------------------------------*
* Program Name : ZZ_06_DATA_TYPES_EXAMPLES_1
* Author       : Hafize
* Created Date : 27.05.2026
*
* Purpose      :
* Demonstrates commonly used ABAP built-in data types
* and their basic usage examples.
*
* Topics       :
* - Type C (Character)
* - Type N (Numeric Text)
* - Type D (Date)
* - Type T (Time)
* - Type I (Integer)
* - Type F (Floating Point)
* - Type P (Packed Number)
* - Type X (Hexadecimal)
*---------------------------------------------------------------------*

REPORT zz_06_data_types_examples_1.

*---------------------------------------------------------------------*
* Type C (Character)
*---------------------------------------------------------------------*

" Fixed-length character field
DATA lv_character(50) TYPE c VALUE 'Hello World'.

WRITE: / 'Type C (Character) :', lv_character.
ULINE.

*---------------------------------------------------------------------*
* Type N (Numeric Text)
*---------------------------------------------------------------------*

" Numeric character field
DATA lv_numeric(10) TYPE n.

lv_numeric = '1234567'.

WRITE: / 'Type N (Numeric Text) :', lv_numeric.
ULINE.

*---------------------------------------------------------------------*
* Type T (Time)
*---------------------------------------------------------------------*

" System time (HHMMSS format)
DATA lv_time TYPE t.

lv_time = sy-uzeit.

WRITE: / 'Type T (Time) :', lv_time.
ULINE.

*---------------------------------------------------------------------*
* Type D (Date)
*---------------------------------------------------------------------*

DATA:
  lv_date     TYPE d,
  lv_tomorrow TYPE d.

" Current system date
lv_date = sy-datum.

" Calculate next day
lv_tomorrow = lv_date + 1.

WRITE: / 'Type D (Date) :', lv_tomorrow.
ULINE.

*---------------------------------------------------------------------*
* Type I (Integer)
*---------------------------------------------------------------------*

" Integer number
DATA lv_integer TYPE i VALUE 50.

WRITE: / 'Type I (Integer) :', lv_integer.
ULINE.

*---------------------------------------------------------------------*
* Type F (Floating Point)
*---------------------------------------------------------------------*

" Floating point calculation
DATA lv_float TYPE f.

lv_float = lv_integer / 12.

WRITE: / 'Type F (Floating Point) :', lv_float.
ULINE.

*---------------------------------------------------------------------*
* Type P (Packed Number)
*---------------------------------------------------------------------*

" Decimal number with fixed precision
DATA lv_packed TYPE p DECIMALS 2.

lv_packed = '123.90'.

WRITE: / 'Type P (Packed Number) :', lv_packed.
ULINE.

*---------------------------------------------------------------------*
* Type X (Hexadecimal)
*---------------------------------------------------------------------*

" Hexadecimal value
DATA lv_hexadecimal TYPE x VALUE '0A'.

WRITE: / 'Type X (Hexadecimal) :', lv_hexadecimal.
ULINE.WRITE: 'Type D (Date) :', lv_tomorrow.
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
