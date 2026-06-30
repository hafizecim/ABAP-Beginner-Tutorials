REPORT ZOSQL_32_UPDATE.

*---------------------------------------------------------------------*
* Report : ZOSQL_32_UPDATE
* Purpose: Demonstrates UPDATE operation in ABAP Open SQL
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. UPDATE Statement
* 2. WHERE Condition
* 3. Primary Key Validation
* 4. sy-subrc
* 5. sy-dbcnt
* 6. COMMIT WORK
* 7. ROLLBACK WORK
* 8. Read Updated Record
* 9. Best Practices
*
*---------------------------------------------------------------------*

TABLES: zemployee.

*---------------------------------------------------------------------*
* 1. Selection Parameters
*---------------------------------------------------------------------*
PARAMETERS:
  p_empid TYPE zemployee-emp_id DEFAULT '100001',
  p_salary TYPE zemployee-salary DEFAULT '70000'.

*---------------------------------------------------------------------*
* 2. Data Declaration
*---------------------------------------------------------------------*
DATA:
  ls_employee TYPE zemployee.

*---------------------------------------------------------------------*
* 3. Check Employee Existence
*---------------------------------------------------------------------*
SELECT SINGLE
       emp_id

  FROM zemployee

  INTO @DATA(lv_emp_id)

 WHERE emp_id = @p_empid.

IF sy-subrc <> 0.

  WRITE: / 'Employee not found.'.
  RETURN.

ENDIF.

*---------------------------------------------------------------------*
* 4. Update Employee Salary
*---------------------------------------------------------------------*
UPDATE zemployee

   SET salary = @p_salary

 WHERE emp_id = @p_empid.

*---------------------------------------------------------------------*
* 5. Validate Database Result
*---------------------------------------------------------------------*
IF sy-subrc = 0.

  COMMIT WORK.

  WRITE: / 'Employee updated successfully.'.
  WRITE: / 'Rows updated :', sy-dbcnt.

ELSE.

  ROLLBACK WORK.

  WRITE: / 'Update operation failed.'.
  WRITE: / 'SY-SUBRC :', sy-subrc.

  RETURN.

ENDIF.

ULINE.

*---------------------------------------------------------------------*
* 6. Read Updated Record
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

 WHERE emp_id = @p_empid.

IF sy-subrc = 0.

  WRITE: / 'Updated Employee Information'.

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
