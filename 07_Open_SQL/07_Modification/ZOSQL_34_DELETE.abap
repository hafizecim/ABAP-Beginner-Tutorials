REPORT ZOSQL_34_DELETE.

*---------------------------------------------------------------------*
* Report : ZOSQL_34_DELETE
* Purpose: Demonstrates DELETE operation in ABAP Open SQL
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. DELETE Statement
* 2. WHERE Condition (Critical Safety Rule)
* 3. Primary Key Deletion
* 4. Record Existence Check
* 5. sy-subrc
* 6. sy-dbcnt
* 7. COMMIT WORK
* 8. ROLLBACK WORK
* 9. Best Practices
*
*---------------------------------------------------------------------*

TABLES: zemployee.

*---------------------------------------------------------------------*
* 1. Selection Parameters
*---------------------------------------------------------------------*
PARAMETERS:
  p_empid TYPE zemployee-emp_id DEFAULT '100001'.

*---------------------------------------------------------------------*
* 2. Data Declaration
*---------------------------------------------------------------------*
DATA:
  lv_emp_id TYPE zemployee-emp_id.

*---------------------------------------------------------------------*
* 3. Check Record Before Delete (Safety Step)
*---------------------------------------------------------------------*
SELECT SINGLE emp_id
  FROM zemployee
  INTO @lv_emp_id
 WHERE emp_id = @p_empid.

IF sy-subrc <> 0.

  WRITE: / 'Employee not found. Nothing to delete.'.
  RETURN.

ENDIF.

*---------------------------------------------------------------------*
* 4. DELETE Operation
*---------------------------------------------------------------------*
DELETE FROM zemployee
 WHERE emp_id = @p_empid.

*---------------------------------------------------------------------*
* 5. Validate Result
*---------------------------------------------------------------------*
IF sy-subrc = 0.

  COMMIT WORK.

  WRITE: / 'Employee deleted successfully.'.
  WRITE: / 'Employee ID :', p_empid.
  WRITE: / 'Rows deleted :', sy-dbcnt.

ELSE.

  ROLLBACK WORK.

  WRITE: / 'Delete operation failed.'.
  WRITE: / 'SY-SUBRC :', sy-subrc.

ENDIF.

ULINE.

*---------------------------------------------------------------------*
* 6. Verify Deletion
*---------------------------------------------------------------------*
SELECT SINGLE emp_id
  FROM zemployee
  INTO @lv_emp_id
 WHERE emp_id = @p_empid.

IF sy-subrc <> 0.
  WRITE: / 'Verification: Record successfully removed from database.'.
ELSE.
  WRITE: / 'Warning: Record still exists in database.'.
ENDIF.

ULINE.

*---------------------------------------------------------------------*
* End of Program
*---------------------------------------------------------------------*
WRITE: / 'Program completed successfully.'.
