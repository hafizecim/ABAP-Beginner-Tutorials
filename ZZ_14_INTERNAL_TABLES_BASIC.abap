REPORT ZZ_14_INTERNAL_TABLES_BASIC.

*----------------------------------------------------------------------
* Program : ZZ_14_INTERNAL_TABLES_BASIC
* Konu    : ABAP Internal Tables (İç Tablolar)
* Açıklama:
*   Bu program ABAP'ta internal table kullanımının temel mantığını
*   göstermektedir.
*
* İçerik:
*   - Internal table tanımlama
*   - Veri ekleme (APPEND)
*   - LOOP AT kullanımı
*   - Satırları ekrana yazdırma
*---------------------------------------------------------------------*

* Structure tanımı
TYPES: BEGIN OF ty_employee,
         id     TYPE i,
         name   TYPE string,
         salary TYPE p DECIMALS 2,
       END OF ty_employee.

* Internal table ve work area tanımı
DATA: gt_employee TYPE TABLE OF ty_employee,
      gs_employee TYPE ty_employee.

" ------------------------------------------------------------
" 1) İlk çalışan verisi
" ------------------------------------------------------------
gs_employee-id     = 1.
gs_employee-name   = 'Ahmet'.
gs_employee-salary = '25000'.

APPEND gs_employee TO gt_employee.

" ------------------------------------------------------------
" 2) İkinci çalışan verisi
" ------------------------------------------------------------
gs_employee-id     = 2.
gs_employee-name   = 'Ayse'.
gs_employee-salary = '32000'.

APPEND gs_employee TO gt_employee.

" ------------------------------------------------------------
" 3) Üçüncü çalışan verisi
" ------------------------------------------------------------
gs_employee-id     = 3.
gs_employee-name   = 'Mehmet'.
gs_employee-salary = '41000'.

APPEND gs_employee TO gt_employee.

" ------------------------------------------------------------
" Internal table içindeki verileri dolaşma
" ------------------------------------------------------------
LOOP AT gt_employee INTO gs_employee.

  WRITE: / 'Employee ID :', gs_employee-id,
         / 'Name        :', gs_employee-name,
         / 'Salary      :', gs_employee-salary,
         / '-----------------------------'.

ENDLOOP.