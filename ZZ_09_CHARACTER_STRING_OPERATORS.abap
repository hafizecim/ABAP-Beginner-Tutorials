REPORT ZZ_09_CHARACTER_STRING_OPERATORS.

*---------------------------------------------------------------------
* Report: ZZ_09_CHARACTER_STRING_OPERATORS
* Açıklama: ABAP Character/String Operatör Örnekleri
*---------------------------------------------------------------------

DATA: srt1  TYPE string,
      srt2  TYPE string,
      srt3  TYPE string,
      srt4  TYPE string,
      srt5  TYPE string,
      srt6  TYPE string,
      srt7  TYPE string,
      srt8  TYPE string,
      srt9  TYPE string,
      srt10 TYPE string,
      srt11 TYPE string,
      srt12 TYPE string,
      srt13 TYPE string,
      srt14 TYPE string,
      srt15 TYPE string,
      srt16 TYPE string,
      srt17 TYPE string,
      srt18 TYPE string.

*---------------------------------------------------------------------
* CO (Concatenation / İçeriyor mu?)
* Kontrol: STR1'in içinde STR2 var mı?
*---------------------------------------------------------------------
srt1 = 'Abap Programming'.
srt2 = 'Abap Programming for Beginners'.

IF srt1 CO srt2. " CO Operatörü: STR1, STR2'yi içeriyor mu?
  WRITE: / 'CO: Process True'.
ELSE.
  WRITE: / 'CO: Process False'.
ENDIF.
ULINE.

*---------------------------------------------------------------------
* CN (Contains / İçeriyor)
* Kontrol: STR2'nin içinde STR3 var mı?
*---------------------------------------------------------------------
srt3 = 'Abap Developer'.
srt4 = 'Abap Programming for Beginners'.

IF srt4 CN srt3. " CN Operatörü: STR4, STR3'ü içeriyor mu?
  WRITE: / 'CN: Process True'.
ELSE.
  WRITE: / 'CN: Process False'.
ENDIF.
ULINE.

*---------------------------------------------------------------------
* CA (Case Sensitive Contains / Büyük-küçük harf duyarlı)
* Kontrol: STR5'in içinde STR6 var mı? (büyük/küçük harf duyarlı)
*---------------------------------------------------------------------
srt5 = 'Ab'.
srt6 = 'Abap programming'.

IF srt5 CA srt6.
  WRITE: / 'CA: Process True'.
ELSE.
  WRITE: / 'CA: Process False'.
ENDIF.
ULINE.

*---------------------------------------------------------------------
* CS (Case Sensitive / Eşitlik büyük/küçük harf duyarlı)
* Kontrol: STR7'in içinde STR8 var mı? (büyük/küçük harf duyarlı)
*---------------------------------------------------------------------
srt7 = 'Abap Programming'.
srt8 = 'Abap Programming for Beginners'.

IF srt7 CS srt8.
  WRITE: / 'CS: Process True'.
ELSE.
  WRITE: / 'CS: Process False'.
ENDIF.
ULINE.

*---------------------------------------------------------------------
* CP (Contains Pattern / Desen içeriyor)
* Kontrol: STR9'un içinde STR10 deseni var mı?
*---------------------------------------------------------------------
srt9 = 'Abap Programming'.
srt10 = 'Abap*gramming*Beginners'.

IF srt9 CP srt10.
  WRITE: / 'CP: Process True'.
ELSE.
  WRITE: / 'CP: Process False'.
ENDIF.
ULINE.

*---------------------------------------------------------------------
* NA (Not Contains / İçermiyor)
* Kontrol: STR11, STR12'yi içermiyor mu?
*---------------------------------------------------------------------
srt11 = 'Abap Programming'.
srt12 = 'Abap Programming for Beginners'.

IF srt11 NA srt12.
  WRITE: / 'NA: Process True'.
ELSE.
  WRITE: / 'NA: Process False'.
ENDIF.
ULINE.

*---------------------------------------------------------------------
* NE (Not Equal / Eşit Değil)
* Kontrol: STR13, STR14'e eşit değil mi?
*---------------------------------------------------------------------
srt13 = 'Abap Programming'.
srt14 = 'Abap Programming for Beginners'.

IF srt13 NE srt14.
  WRITE: / 'NE: Process True'.
ELSE.
  WRITE: / 'NE: Process False'.
ENDIF.
ULINE.

*---------------------------------------------------------------------
* NS (Not Starts With / Başlamıyor)
* Kontrol: STR15, STR16 ile başlamıyor mu?
*---------------------------------------------------------------------
srt15 = 'Abap Programming'.
srt16 = 'Abap Programming for Beginners'.

IF srt15 NS srt16.
  WRITE: / 'NS: Process True'.
ELSE.
  WRITE: / 'NS: Process False'.
ENDIF.
ULINE.

*---------------------------------------------------------------------
* NP (Not Pattern / Desen ile eşleşmiyor)
* Kontrol: STR17, STR18 deseni ile eşleşmiyor mu?
*---------------------------------------------------------------------
srt17 = 'Abap Programming'.
srt18 = 'Abap*gramming*Beginners'.

IF srt17 NP srt18.
  WRITE: / 'NP: Process True'.
ELSE.
  WRITE: / 'NP: Process False'.
ENDIF.
ULINE.
