REPORT ZZ_15_LOOP_AT_TABLE.

*----------------------------------------------------------------------
* Program : ZZ_15_LOOP_AT_TABLE
* Konu    : LOOP AT Kullanımı
* Açıklama:
*   Bu program ABAP'ta internal table üzerinde LOOP AT kullanarak
*   verilerin nasıl dolaşıldığını göstermektedir.
*
* İçerik:
*   - Internal table oluşturma
*   - APPEND ile veri ekleme
*   - LOOP AT kullanımı
*   - Satır verilerini ekrana yazdırma
*---------------------------------------------------------------------*

*----------------------------------------------------------------------*
* Structure Tanımı
*----------------------------------------------------------------------*
TYPES: BEGIN OF ty_student,
         student_no TYPE i,
         name       TYPE string,
         department TYPE string,
         grade      TYPE p DECIMALS 2,
       END OF ty_student.

*----------------------------------------------------------------------*
* Internal Table ve Work Area Tanımı
*----------------------------------------------------------------------*
DATA: gt_students TYPE TABLE OF ty_student,
      gs_student  TYPE ty_student.

*----------------------------------------------------------------------*
* 1) Öğrenci Verisi
*----------------------------------------------------------------------*
gs_student-student_no = 1001.
gs_student-name       = 'Hafize'.
gs_student-department = 'Computer Engineering'.
gs_student-grade      = '89.50'.

APPEND gs_student TO gt_students.

*----------------------------------------------------------------------*
* 2) Öğrenci Verisi
*----------------------------------------------------------------------*
gs_student-student_no = 1002.
gs_student-name       = 'Ahmet'.
gs_student-department = 'Industrial Engineering'.
gs_student-grade      = '76.25'.

APPEND gs_student TO gt_students.

*----------------------------------------------------------------------*
* 3) Öğrenci Verisi
*----------------------------------------------------------------------*
gs_student-student_no = 1003.
gs_student-name       = 'Ayse'.
gs_student-department = 'Software Engineering'.
gs_student-grade      = '91.75'.

APPEND gs_student TO gt_students.

*----------------------------------------------------------------------*
* LOOP AT ile Internal Table İçindeki Verileri Dolaşma
*----------------------------------------------------------------------*
LOOP AT gt_students INTO gs_student.

  WRITE: / 'Student No :', gs_student-student_no,
         / 'Name       :', gs_student-name,
         / 'Department :', gs_student-department,
         / 'Grade      :', gs_student-grade,
         / '----------------------------------------'.

ENDLOOP.