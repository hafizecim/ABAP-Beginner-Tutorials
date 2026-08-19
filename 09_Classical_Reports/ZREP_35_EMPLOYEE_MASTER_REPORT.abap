REPORT ZREP_35_EMPLOYEE_MASTER_REPORT.

*---------------------------------------------------------------------*
* Program    : ZREP_35_EMPLOYEE_MASTER_REPORT
* Title      : Employee Master Report
* Purpose    : Demonstrates a classical employee master data report
*              using Open SQL and an internal table.
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This report retrieves employee master data from PA0001 and displays
* the organizational assignment of employees in a classical list.
*
* The report demonstrates:
* - Open SQL
* - PA0001 employee data
* - Internal tables
* - SELECT with WHERE conditions
* - Sorting
* - LOOP AT
* - Classical list formatting
* - Record counting
* - Report statistics
*
* Topics Covered
* 1. Employee master data
* 2. Open SQL
* 3. PA0001
* 4. Internal tables
* 5. SELECT
* 6. WHERE
* 7. ORDER BY
* 8. LOOP AT
* 9. Classical list output
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand a real SAP master-data reporting scenario.
* - Retrieve employee organizational data with Open SQL.
* - Store database results in an internal table.
* - Display employee information using classical list processing.
* - Separate database access from presentation logic.
*---------------------------------------------------------------------*

************************************************************************
* Types
************************************************************************

TYPES:
  BEGIN OF ty_employee,
    pernr TYPE pa0001-pernr,
    ename TYPE pa0001-ename,
    bukrs TYPE pa0001-bukrs,
    werks TYPE pa0001-werks,
    btrtl TYPE pa0001-btrtl,
    persg TYPE pa0001-persg,
    persk TYPE pa0001-persk,
    plans TYPE pa0001-plans,
  END OF ty_employee.

************************************************************************
* Data
************************************************************************

DATA:
  gt_employee TYPE STANDARD TABLE OF ty_employee,
  gs_employee TYPE ty_employee.

DATA:
  gv_record_count TYPE i.

************************************************************************
* START-OF-SELECTION
************************************************************************

START-OF-SELECTION.

  PERFORM get_employee_data.

  IF gt_employee IS INITIAL.

    MESSAGE 'No employee master data found.' TYPE 'I'.

    RETURN.

  ENDIF.

  PERFORM calculate_statistics.
  PERFORM display_report.

************************************************************************
* FORM get_employee_data
************************************************************************
* Retrieves current employee organizational assignment data.

FORM get_employee_data.

  SELECT
    FROM pa0001
    FIELDS
      pernr,
      ename,
      bukrs,
      werks,
      btrtl,
      persg,
      persk,
      plans
    WHERE begda <= @sy-datum
      AND endda >= @sy-datum
    INTO TABLE @gt_employee
    ORDER BY bukrs,
             werks,
             pernr.

ENDFORM.

************************************************************************
* FORM calculate_statistics
************************************************************************
* Calculates the number of employees retrieved.

FORM calculate_statistics.

  gv_record_count = lines( gt_employee ).

ENDFORM.

************************************************************************
* FORM display_report
************************************************************************
* Displays employee master data as a classical list.

FORM display_report.

*---------------------------------------------------------------------*
* Report Header
*---------------------------------------------------------------------*

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE: / '============================================================'.
  WRITE: / '                 EMPLOYEE MASTER REPORT'.
  WRITE: / '============================================================'.

  FORMAT RESET.

  SKIP 1.

*---------------------------------------------------------------------*
* Report Information
*---------------------------------------------------------------------*

  WRITE: / 'Program      :', sy-repid.
  WRITE: / 'Report Date  :', sy-datum.
  WRITE: / 'Report Time  :', sy-uzeit.
  WRITE: / 'Employees    :', gv_record_count.

  SKIP 2.

*---------------------------------------------------------------------*
* Column Header
*---------------------------------------------------------------------*

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  POSITION 1.
  WRITE: 'Personnel'.

  POSITION 13.
  WRITE: 'Employee Name'.

  POSITION 35.
  WRITE: 'Company'.

  POSITION 45.
  WRITE: 'Plant'.

  POSITION 55.
  WRITE: 'Personnel Area'.

  POSITION 70.
  WRITE: 'Group'.

  POSITION 80.
  WRITE: 'Subgroup'.

  POSITION 92.
  WRITE: 'Position'.

  FORMAT RESET.

  SKIP 1.

  ULINE.

*---------------------------------------------------------------------*
* Employee Data
*---------------------------------------------------------------------*

  LOOP AT gt_employee INTO gs_employee.

    POSITION 1.
    WRITE: / gs_employee-pernr.

    POSITION 13.
    WRITE: gs_employee-ename.

    POSITION 35.
    WRITE: gs_employee-bukrs.

    POSITION 45.
    WRITE: gs_employee-werks.

    POSITION 55.
    WRITE: gs_employee-btrtl.

    POSITION 70.
    WRITE: gs_employee-persg.

    POSITION 80.
    WRITE: gs_employee-persk.

    POSITION 92.
    WRITE: gs_employee-plans.

  ENDLOOP.

*---------------------------------------------------------------------*
* Footer
*---------------------------------------------------------------------*

  SKIP 1.

  ULINE.

  FORMAT COLOR COL_TOTAL INTENSIFIED ON.

  WRITE: / 'TOTAL EMPLOYEES:', gv_record_count.

  FORMAT RESET.

  SKIP 2.

  FORMAT COLOR COL_POSITIVE INTENSIFIED ON.

  WRITE: / 'Employee master report completed successfully.'.

  FORMAT RESET.

ENDFORM.
