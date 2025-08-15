REPORT ZZ_07_ARITHMETIC_OPERATIONS.

*---------------------------------------------------------------------
* Report: ZZ_07_ARITHMETIC_OPERATIONS
* Açıklama: ABAP Aritmetik Operatör Örnekleri
*---------------------------------------------------------------------

DATA: OPR1   TYPE i VALUE 14,
      OPR2   TYPE i VALUE 3,
      RESULT TYPE i.

WRITE: 'OPR1:', OPR1,
       / 'OPR2:', OPR2.
ULINE.

*---------------------------------------------------------------------
* Toplama
*---------------------------------------------------------------------
RESULT = OPR1 + OPR2.
WRITE: / 'RESULT = OPR1 + OPR2', RESULT.
ULINE.

*---------------------------------------------------------------------
* Çıkarma
*---------------------------------------------------------------------
RESULT = OPR1 - OPR2.
WRITE: / 'RESULT = OPR1 - OPR2', RESULT.
ULINE.

*---------------------------------------------------------------------
* Çarpma
*---------------------------------------------------------------------
RESULT = OPR1 * OPR2.
WRITE: / 'RESULT = OPR1 * OPR2', RESULT.
ULINE.

*---------------------------------------------------------------------
* Bölme
*---------------------------------------------------------------------
IF OPR2 <> 0.
  RESULT = OPR1 / OPR2.
  WRITE: / 'RESULT = OPR1 / OPR2', RESULT.
ELSE.
  WRITE: / 'Bölme işlemi için OPR2 sıfır olamaz!'.
ENDIF.
ULINE.

*---------------------------------------------------------------------
* Tam Bölme (DIV)
*---------------------------------------------------------------------
IF OPR2 <> 0.
  RESULT = OPR1 DIV OPR2.
  WRITE: / 'RESULT = OPR1 DIV OPR2', RESULT.
ELSE.
  WRITE: / 'Tam bölme işlemi için OPR2 sıfır olamaz!'.
ENDIF.

*---------------------------------------------------------------------
* Modül (Kalan Bulma)
*---------------------------------------------------------------------
IF OPR2 <> 0.
  RESULT = OPR1 MOD OPR2.
  WRITE: / 'RESULT = OPR1 MOD OPR2', RESULT.
ELSE.
  WRITE: / 'Modül işlemi için OPR2 sıfır olamaz!'.
ENDIF.
ULINE.

*---------------------------------------------------------------------
* Üst Alma (Exponentiation)
*---------------------------------------------------------------------
DATA OPR3 TYPE i VALUE 2.
RESULT = OPR1 ** OPR3.
WRITE: / 'RESULT = OPR1 ** OPR3', RESULT.
ULINE.

*---------------------------------------------------------------------
* Negatif Alma
*---------------------------------------------------------------------
DATA lv_negative TYPE i.
lv_negative = -OPR1.
WRITE: / 'Negatif OPR1:', lv_negative.
ULINE.
