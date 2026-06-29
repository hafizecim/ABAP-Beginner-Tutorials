REPORT ZOSQL_32_UPDATE.

*---------------------------------------------------------------------*
* Report : ZOSQL_32_UPDATE
* Purpose: Demonstrates UPDATE operation in ABAP Open SQL
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. UPDATE Statement
* 2. WHERE Condition
* 3. Primary Key Update
* 4. sy-subrc Validation
* 5. COMMIT WORK
* 6. ROLLBACK WORK
* 7. Best Practices
*---------------------------------------------------------------------*

"=========================================================
" 1. Selection Parameters
"=========================================================
PARAMETERS:
  p_empid TYPE zemployee-emp_id DEFAULT '100001',
  p_sal   TYPE zemployee-salary DEFAULT '70000'.

"=========================================================
" 2. Check Existing Record
"=========================================================
SELECT SINGLE
       emp_id

  FROM zemployee

  INTO @DATA(lv_empid)

 WHERE emp_id = @p_empid.

IF sy-subrc <> 0.

  WRITE: / 'Employee does not exist.'.
  RETURN.

ENDIF.

"=========================================================
" 3. Update Employee Salary
"=========================================================
UPDATE zemployee

   SET salary = @p_sal

 WHERE emp_id = @p_empid.

"=========================================================
" 4. Validate Result
"=========================================================
IF sy-subrc = 0.

  COMMIT WORK.

  WRITE: / 'Employee updated successfully.'.
  WRITE: / 'Employee ID :', p_empid.
  WRITE: / 'New Salary  :', p_sal.

ELSE.

  ROLLBACK WORK.

  WRITE: / 'Update operation failed.'.
  WRITE: / 'SY-SUBRC :', sy-subrc.

ENDIF.

ULINE.

WRITE: / 'Program completed successfully.'.
