REPORT ZZ_12_NESTED_IF_STATEMENT.

*----------------------------------------------------------------------
* Program: ZZ_12_NESTED_IF_STATEMENT
* Konu   : ABAP’ta İç İçe (Nested) IF Kullanımı
* Açıklama:
*   Bu program, üç sayıyı karşılaştırarak en büyüğünü bulur.
*   İçerik:
*     - Birden fazla koşulun tek IF içinde kontrolü (AND kullanımı)
*     - İç içe IF blokları
*     - ELSEIF ve ELSE kullanımı
----------------------------------------------------------------------

* Değişken tanımları
DATA: num1 TYPE i,
      num2 TYPE i,
      num3 TYPE i.

* Örnek değerler
num1 = 1.
num2 = 2.
num3 = 3.

IF num1 = num2 AND num2 = num3.
  WRITE: / 'All numbers are equal'.
ELSEIF num1 > num2.
  IF num1 > num3.
    WRITE: / 'Biggest number is num1'.
  ELSE.
    WRITE: / 'Biggest number is num3'.
  ENDIF.
ELSEIF num1 > num3.
  WRITE: / 'Biggest number is num2'.
ELSE.
  WRITE: / 'Biggest number is num3'.
ENDIF.
