*&---------------------------------------------------------------------*
*& Report ZZ_27_PARAMETERS_BASIC
*&---------------------------------------------------------------------*
*& Purpose:
*&   Demonstrates the basic usage of PARAMETERS in ABAP.
*&
*& Topics Covered:
*&   - PARAMETERS declaration
*&   - Default values
*&   - Mandatory fields
*&   - Lower case input
*&   - User input processing
*&---------------------------------------------------------------------*

REPORT zz_27_parameters_basic.

*---------------------------------------------------------------------*
* Selection Screen
*---------------------------------------------------------------------*
PARAMETERS:
  p_empid TYPE n LENGTH 8 OBLIGATORY,
  p_name  TYPE string LOWER CASE,
  p_dept  TYPE c LENGTH 20 DEFAULT 'IT'.

*---------------------------------------------------------------------*
* Start-of-Selection
*---------------------------------------------------------------------*
START-OF-SELECTION.

  WRITE: / 'Employee Information'.
  WRITE: / sy-uline.

  WRITE: / 'Employee ID :', p_empid.
  WRITE: / 'Employee Name:', p_name.
  WRITE: / 'Department  :', p_dept.

  WRITE: / sy-uline.
