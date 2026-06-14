REPORT ZZ_15_LOOP_AT_TABLE.

*---------------------------------------------------------------------*
* Report : ZZ_15_LOOP_AT_TABLE
* Purpose: Demonstrates LOOP AT usage with internal tables
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. Define an Internal Table
* 2. Insert Data with APPEND
* 3. LOOP AT INTO
* 4. Display Current Row Number
* 5. Calculate Total Grade
* 6. Count Processed Records
*---------------------------------------------------------------------*

"=========================================================
" 1. Define a Structure
"=========================================================
TYPES:
  BEGIN OF ty_student,
    student_no TYPE i,
    student_name TYPE string,
    department TYPE string,
    grade TYPE p LENGTH 5 DECIMALS 2,
  END OF ty_student.

"=========================================================
" 2. Define Internal Table
"=========================================================
DATA:
  lt_students TYPE STANDARD TABLE OF ty_student,
  ls_student  TYPE ty_student.

"=========================================================
" 3. Insert Data with APPEND
"=========================================================
APPEND VALUE ty_student(
  student_no   = 1001
  student_name = 'Hafize'
  department   = 'Computer Engineering'
  grade        = '89.50'
) TO lt_students.

APPEND VALUE ty_student(
  student_no   = 1002
  student_name = 'Ahmet'
  department   = 'Industrial Engineering'
  grade        = '76.25'
) TO lt_students.

APPEND VALUE ty_student(
  student_no   = 1003
  student_name = 'Ayse'
  department   = 'Software Engineering'
  grade        = '91.75'
) TO lt_students.

WRITE: / 'Total Students:',
       lines( lt_students ).

ULINE.

"=========================================================
" 4. LOOP AT INTO
"=========================================================
DATA:
  lv_total_grade TYPE p LENGTH 8 DECIMALS 2,
  lv_student_count TYPE i.

LOOP AT lt_students INTO ls_student.

  lv_student_count = lv_student_count + 1.
  lv_total_grade   = lv_total_grade + ls_student-grade.

  WRITE: / 'Row Number :', sy-tabix,
         / 'Student No :', ls_student-student_no,
         / 'Name       :', ls_student-student_name,
         / 'Department :', ls_student-department,
         / 'Grade      :', ls_student-grade.

  ULINE.

ENDLOOP.

"=========================================================
" 5. Summary Information
"=========================================================
WRITE: / 'Processed Records :', lv_student_count,
       / 'Total Grades      :', lv_total_grade.

ULINE.

"=========================================================
" End of Program
"=========================================================
WRITE: / 'Program completed successfully'.
