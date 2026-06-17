*&---------------------------------------------------------------------*
*& Report ZZ_28_PARAMETERS_TYPES
*&---------------------------------------------------------------------*
*& Purpose:
*&   Demonstrates commonly used parameter data types in ABAP.
*&
*& Topics Covered:
*&   - Character (CHAR)
*&   - Numeric Text (NUMC)
*&   - Integer (I)
*&   - Packed Number (P)
*&   - Date (DATS)
*&   - Time (TIMS)
*&   - String
*&---------------------------------------------------------------------*

REPORT ZZ_28_PARAMETERS_TYPES.

*---------------------------------------------------------------------*
* Selection Screen
*---------------------------------------------------------------------*
PARAMETERS:
  p_empid TYPE n LENGTH 8 OBLIGATORY,
  p_name  TYPE string LOWER CASE,
  p_dept  TYPE c LENGTH 20 DEFAULT 'IT',
  p_age   TYPE i,
  p_sal   TYPE p LENGTH 8 DECIMALS 2,
  p_hdate TYPE d DEFAULT sy-datum,
  p_htime TYPE t DEFAULT sy-uzeit.

*---------------------------------------------------------------------*
* Processing
*---------------------------------------------------------------------*
START-OF-SELECTION.

  WRITE: / 'Employee Information'.
  WRITE: / sy-uline.

  WRITE: / 'Employee ID      :', p_empid.
  WRITE: / 'Employee Name    :', p_name.
  WRITE: / 'Department       :', p_dept.
  WRITE: / 'Age              :', p_age.
  WRITE: / 'Salary           :', p_sal.
  WRITE: / 'Hiring Date      :', p_hdate.
  WRITE: / 'Hiring Time      :', p_htime.

  WRITE: / sy-uline.
