REPORT ZOSQL_33_MODIFY.

*---------------------------------------------------------------------*
* Report : ZOSQL_33_MODIFY
* Purpose: Demonstrates MODIFY statement in ABAP Open SQL
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. MODIFY Statement
* 2. UPSERT (Insert or Update)
* 3. Primary Key Handling
* 4. Work Area
* 5. sy-subrc
* 6. sy-dbcnt
* 7. COMMIT WORK
* 8. ROLLBACK WORK
* 9. Best Practices
*
*---------------------------------------------------------------------*

TABLES: zemployee.

*---------------------------------------------------------------------*
* 1. Data Declaration
*---------------------------------------------------------------------*
DATA:
  ls_employee TYPE zemployee.

*---------------------------------------------------------------------*
* 2. Prepare Employee Data
*---------------------------------------------------------------------*
ls_employee-emp_id     = '100001'.
ls_employee-first_name = 'John'.
ls_employee-last_name  = 'Smith'.
ls_employee-department = 'IT'.
ls_employee-salary     = '75000'.
ls_employee-currency   = 'USD'.

*---------------------------------------------------------------------*
* 3. MODIFY Database Record
*---------------------------------------------------------------------*
MODIFY zemployee
  FROM @ls_employee.

*---------------------------------------------------------------------*
* 4. Check Database Result
*---------------------------------------------------------------------*
IF sy-subrc = 0.

  COMMIT WORK.

  WRITE: / 'Database operation completed successfully.'.

  IF sy-dbcnt = 1.
    WRITE: / 'Rows affected :', sy-dbcnt.
  ENDIF.

ELSE.

  ROLLBACK WORK.

  WRITE: / 'Database operation failed.'.
  WRITE: / 'SY-SUBRC :', sy-subrc.

ENDIF.

ULINE.

*---------------------------------------------------------------------*
* 5. Read Record After MODIFY
*---------------------------------------------------------------------*
SELECT SINGLE
       emp_id,
       first_name,
       last_name,
       department,
       salary,
       currency

  FROM zemployee

  INTO CORRESPONDING FIELDS OF @ls_employee

 WHERE emp_id = @ls_employee-emp_id.

IF sy-subrc = 0.

  WRITE: / 'Employee Information'.

  ULINE.

  WRITE: / 'Employee ID :', ls_employee-emp_id.
  WRITE: / 'First Name :', ls_employee-first_name.
  WRITE: / 'Last Name  :', ls_employee-last_name.
  WRITE: / 'Department :', ls_employee-department.
  WRITE: / 'Salary     :', ls_employee-salary.
  WRITE: / 'Currency   :', ls_employee-currency.

ELSE.

  WRITE: / 'Employee could not be retrieved.'.

ENDIF.

ULINE.

*---------------------------------------------------------------------*
* End of Program
*---------------------------------------------------------------------*
WRITE: / 'Program completed successfully.'.
