*&---------------------------------------------------------------------*
*& Report ZZ_31_CHECKBOX_AND_RADIOBUTTON
*&---------------------------------------------------------------------*
*& Purpose:
*&   Demonstrates Checkbox and Radiobutton usage in Selection Screen.
*&
*& Topics Covered:
*&   - PARAMETERS AS CHECKBOX
*&   - RADIOBUTTON GROUP
*&   - User selection logic
*&   - Conditional processing
*&---------------------------------------------------------------------*

REPORT ZZ_31_CHECKBOX_AND_RADIOBUTTON.

*---------------------------------------------------------------------*
* Structure Definition
*---------------------------------------------------------------------*
TYPES: BEGIN OF ty_employee,
         employee_id TYPE n LENGTH 8,
         name        TYPE string,
         department  TYPE c LENGTH 20,
         salary      TYPE p LENGTH 8 DECIMALS 2,
       END OF ty_employee.

*---------------------------------------------------------------------*
* Internal Table
*---------------------------------------------------------------------*
DATA gt_employee TYPE STANDARD TABLE OF ty_employee.
DATA gs_employee TYPE ty_employee.

*---------------------------------------------------------------------*
* Selection Screen
*---------------------------------------------------------------------*
PARAMETERS:
  p_active AS CHECKBOX DEFAULT 'X',

  rb_it    RADIOBUTTON GROUP grp1,
  rb_hr    RADIOBUTTON GROUP grp1,
  rb_fin   RADIOBUTTON GROUP grp1.

*---------------------------------------------------------------------*
* Sample Data
*---------------------------------------------------------------------*
INITIALIZATION.

  gt_employee = VALUE #(
    ( employee_id = '00001001' name = 'Employee A' department = 'IT'      salary = '45000' )
    ( employee_id = '00001002' name = 'Employee B' department = 'HR'      salary = '38000' )
    ( employee_id = '00001003' name = 'Employee C' department = 'FINANCE' salary = '52000' )
    ( employee_id = '00001004' name = 'Employee D' department = 'IT'      salary = '61000' )
  ).

*---------------------------------------------------------------------*
* Main Processing
*---------------------------------------------------------------------*
START-OF-SELECTION.

  IF p_active IS INITIAL.
    WRITE: / 'Report is inactive (Checkbox not selected).'.
    EXIT.
  ENDIF.

  WRITE: / 'Filtered Employee List'.
  WRITE: / sy-uline.

  LOOP AT gt_employee INTO gs_employee.

    CASE abap_true.

      WHEN rb_it.
        IF gs_employee-department <> 'IT'.
          CONTINUE.
        ENDIF.

      WHEN rb_hr.
        IF gs_employee-department <> 'HR'.
          CONTINUE.
        ENDIF.

      WHEN rb_fin.
        IF gs_employee-department <> 'FINANCE'.
          CONTINUE.
        ENDIF.

    ENDCASE.

    WRITE: / 'ID        :', gs_employee-employee_id.
    WRITE: / 'Name      :', gs_employee-name.
    WRITE: / 'Department:', gs_employee-department.
    WRITE: / 'Salary    :', gs_employee-salary.
    WRITE: / sy-uline.

  ENDLOOP.
