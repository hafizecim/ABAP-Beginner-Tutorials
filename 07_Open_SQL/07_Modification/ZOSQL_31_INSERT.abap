REPORT ZOSQL_31_INSERT.

*---------------------------------------------------------------------*
* Report : ZOSQL_31_INSERT
* Purpose: Demonstrates INSERT operation in ABAP Open SQL
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. INSERT Statement
* 2. Work Area
* 3. Primary Key Validation
* 4. sy-subrc
* 5. Database Commit
* 6. Error Handling
* 7. Best Practices
*---------------------------------------------------------------------*

"=========================================================
" 1. Employee Structure (Example Z Table)
"=========================================================
TABLES: zemployee.

"=========================================================
" 2. Data Declaration
"=========================================================
DATA:
  gs_employee TYPE zemployee.

"=========================================================
" 3. Fill Work Area
"=========================================================
gs_employee-emp_id     = '100001'.
gs_employee-first_name = 'Hafize'.
gs_employee-last_name  = 'Senyil'.
gs_employee-department = 'IT'.
gs_employee-salary     = '65000'.
gs_employee-currency   = 'TRY'.

"=========================================================
" 4. Insert Record
"=========================================================
INSERT zemployee
       FROM @gs_employee.

"=========================================================
" 5. Result Validation
"=========================================================
IF sy-subrc = 0.

  COMMIT WORK.

  WRITE: / 'Employee successfully inserted.'.
  WRITE: / 'Employee ID :', gs_employee-emp_id.

ELSE.

  ROLLBACK WORK.

  WRITE
