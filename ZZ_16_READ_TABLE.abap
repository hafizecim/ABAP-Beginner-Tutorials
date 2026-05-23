REPORT ZZ_16_READ_TABLE.

*----------------------------------------------------------------------
* Program : ZZ_16_READ_TABLE
* Konu    : READ TABLE Kullanımı
* Açıklama:
*   Bu program ABAP'ta READ TABLE komutunun kullanımını göstermektedir.
*
* İçerik:
*   - Internal table oluşturma
*   - APPEND ile veri ekleme
*   - READ TABLE kullanımı
*   - sy-subrc kontrolü
*---------------------------------------------------------------------*

*----------------------------------------------------------------------*
* Structure Tanımı
*----------------------------------------------------------------------*
TYPES: BEGIN OF ty_employee,
         employee_id TYPE i,
         name        TYPE string,
         department  TYPE string,
         salary      TYPE p DECIMALS 2,
       END OF ty_employee.

*----------------------------------------------------------------------*
* Internal Table ve Work Area Tanımı
*----------------------------------------------------------------------*
DATA: gt_employee TYPE TABLE OF ty_employee,
      gs_employee TYPE ty_employee.

*----------------------------------------------------------------------*
* 1) Çalışan Verisi
*----------------------------------------------------------------------*
gs_employee-employee_id = 1.
gs_employee-name        = 'Hafize'.
gs_employee-department  = 'SAP ABAP'.
gs_employee-salary      = '45000'.

APPEND gs_employee TO gt_employee.

*----------------------------------------------------------------------*
* 2) Çalışan Verisi
*----------------------------------------------------------------------*
gs_employee-employee_id = 2.
gs_employee-name        = 'Ahmet'.
gs_employee-department  = 'SAP FI'.
gs_employee-salary      = '52000'.

APPEND gs_employee TO gt_employee.

*----------------------------------------------------------------------*
* 3) Çalışan Verisi
*----------------------------------------------------------------------*
gs_employee-employee_id = 3.
gs_employee-name        = 'Ayse'.
gs_employee-department  = 'SAP SD'.
gs_employee-salary      = '48000'.

APPEND gs_employee TO gt_employee.

*----------------------------------------------------------------------*
* READ TABLE Kullanımı
* employee_id = 2 olan kaydı bulma
*----------------------------------------------------------------------*
READ TABLE gt_employee
INTO gs_employee
WITH KEY employee_id = 2.

*----------------------------------------------------------------------*
* sy-subrc Kontrolü
*----------------------------------------------------------------------*
IF sy-subrc = 0.

  WRITE: / 'Employee Found!',
         / 'ID         :', gs_employee-employee_id,
         / 'Name       :', gs_employee-name,
         / 'Department :', gs_employee-department,
         / 'Salary     :', gs_employee-salary.

ELSE.

  WRITE: / 'Employee Not Found!'.

ENDIF.
