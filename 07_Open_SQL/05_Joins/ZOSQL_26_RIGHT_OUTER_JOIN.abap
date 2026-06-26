REPORT ZOSQL_26_RIGHT_OUTER_JOIN.

*---------------------------------------------------------------------*
* Report : ZOSQL_26_RIGHT_OUTER_JOIN
* Purpose: RIGHT OUTER JOIN Concept in ABAP Open SQL
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* Topics Covered
*---------------------------------------------------------------------*
* 1. RIGHT OUTER JOIN Concept
* 2. Why RIGHT OUTER JOIN Is Not Supported
* 3. LEFT OUTER JOIN Alternative
* 4. Swapping Table Order
* 5. INNER JOIN vs LEFT OUTER JOIN vs RIGHT OUTER JOIN
* 6. SAP Best Practices
* 7. Performance Considerations
* 8. Interview Questions
*---------------------------------------------------------------------*

START-OF-SELECTION.

  PERFORM introduction.
  PERFORM sql_comparison.
  PERFORM sap_best_practice.
  PERFORM performance_notes.
  PERFORM interview_notes.

*---------------------------------------------------------------------*
*       FORM introduction
*---------------------------------------------------------------------*
FORM introduction.

  ULINE.
  WRITE: / 'RIGHT OUTER JOIN IN ABAP OPEN SQL'.
  ULINE.

  WRITE: / 'RIGHT OUTER JOIN is NOT supported in ABAP Open SQL.'.
  WRITE: / 'SAP recommends using LEFT OUTER JOIN instead.'.
  WRITE: /.

ENDFORM.

*---------------------------------------------------------------------*
*       FORM sql_comparison
*---------------------------------------------------------------------*
FORM sql_comparison.

  ULINE.
  WRITE: / 'SQL Example (Supported in Oracle / SQL Server / MySQL)'.
  ULINE.

  WRITE: / 'SELECT ...'.
  WRITE: / 'FROM SCARR'.
  WRITE: / 'RIGHT OUTER JOIN SPFLI'.
  WRITE: / 'ON SCARR~CARRID = SPFLI~CARRID'.

  WRITE: /.

  ULINE.
  WRITE: / 'Equivalent ABAP Open SQL'.
  ULINE.

  WRITE: / 'SELECT ...'.
  WRITE: / 'FROM SPFLI AS F'.
  WRITE: / 'LEFT OUTER JOIN SCARR AS C'.
  WRITE: / 'ON F~CARRID = C~CARRID'.

ENDFORM.

*---------------------------------------------------------------------*
*       FORM sap_best_practice
*---------------------------------------------------------------------*
FORM sap_best_practice.

  ULINE.

  WRITE: / 'SAP Best Practice'.

  ULINE.

  WRITE: / 'Instead of using RIGHT OUTER JOIN,'.
  WRITE: / 'reverse the table order'.
  WRITE: / 'and use LEFT OUTER JOIN.'.

  WRITE: /.

  WRITE: / 'Advantages:'.
  WRITE: / '- Database independent'.
  WRITE: / '- Better readability'.
  WRITE: / '- Recommended by SAP'.
  WRITE: / '- Supported by every ABAP release'.

ENDFORM.

*---------------------------------------------------------------------*
*       FORM performance_notes
*---------------------------------------------------------------------*
FORM performance_notes.

  ULINE.

  WRITE: / 'Performance Notes'.

  ULINE.

  WRITE: / '- Filter data using WHERE clause'.
  WRITE: / '- Select only required columns'.
  WRITE: / '- Avoid SELECT *'.
  WRITE: / '- Prefer database joins over nested SELECT'.

ENDFORM.

*---------------------------------------------------------------------*
*       FORM interview_notes
*---------------------------------------------------------------------*
FORM interview_notes.

  ULINE.

  WRITE: / 'Interview Questions'.

  ULINE.

  WRITE: / 'Q: Does ABAP support RIGHT OUTER JOIN?'.
  WRITE: / 'A: No.'.

  WRITE: /.

  WRITE: / 'Q: What is the alternative?'.
  WRITE: / 'A: Reverse table order and use LEFT OUTER JOIN.'.

  WRITE: /.

  WRITE: / 'Q: Why?'.
  WRITE: / 'A: Simpler syntax, easier optimization and database independence.'.

ENDFORM.
