REPORT ZOSQL_31_INSERT.

*---------------------------------------------------------------------*
* Report : ZOSQL_31_INSERT
* Purpose: Demonstrates INSERT operation in ABAP Open SQL
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. INSERT Statement
* 2. Record Existence Check
* 3. Work Area
* 4. Primary Key Validation
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
ls_employee-salary     = '65000'.
ls_employee-currency   = 'USD'.

*---------------------------------------------------------------------*
* 3. Check Existing Record
*---------------------------------------------------------------------*
SELECT SINGLE
       emp_id

  FROM zemployee

  INTO @DATA(lv_emp_id)

 WHERE emp_id = @ls_employee-emp_id.

IF sy-subrc = 0.

  WRITE: / 'Employee already exists.'.
  WRITE: / 'Employee ID :', ls_employee-emp_id.

  RETURN.

ENDIF.

*---------------------------------------------------------------------*
* 4. Insert Record
*---------------------------------------------------------------------*
INSERT zemployee
  FROM @ls_employee.

*---------------------------------------------------------------------*
* 5. Validate Result
*---------------------------------------------------------------------*
IF sy-subrc = 0.

  COMMIT WORK.

  WRITE: / 'Employee inserted successfully.'.
  WRITE: / 'Rows inserted :', sy-dbcnt.

ELSE.

  ROLLBACK WORK.

  WRITE: / 'Insert operation failed.'.
  WRITE: / 'SY-SUBRC :', sy-subrc.

ENDIF.

ULINE.

*---------------------------------------------------------------------*
* 6. Display Inserted Record
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
  WRITE: / 'First Name  :', ls_employee-first_name.
  WRITE: / 'Last Name   :', ls_employee-last_name.
  WRITE: / 'Department  :', ls_employee-department.
  WRITE: / 'Salary      :', ls_employee-salary.
  WRITE: / 'Currency    :', ls_employee-currency.

ENDIF.

ULINE.

*---------------------------------------------------------------------*
* End of Program
*---------------------------------------------------------------------*
WRITE: / 'Program completed successfully.'.
