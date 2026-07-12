REPORT ZOSQL_52_VENDOR_REPORT.

*---------------------------------------------------------------------*
* Report  : ZOSQL_52_VENDOR_REPORT
* Purpose : Professional Vendor Report using Modern ABAP Open SQL
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. INNER JOIN
* 2. LEFT OUTER JOIN
* 3. CASE Expression
* 4. COALESCE
* 5. CONCAT_WITH_SPACE
* 6. Host Variables (@)
* 7. Inline Declarations
* 8. ORDER BY
* 9. Clean ABAP
*
*---------------------------------------------------------------------*

TABLES:
  lfa1,
  lfb1,
  lfm1.

*---------------------------------------------------------------------*
* Selection Screen
*---------------------------------------------------------------------*

SELECT-OPTIONS:
  s_lifnr FOR lfa1-lifnr,
  s_land1 FOR lfa1-land1,
  s_bukrs FOR lfb1-bukrs,
  s_ekorg FOR lfm1-ekorg.

PARAMETERS:
  p_langu TYPE sylangu DEFAULT sy-langu.

*---------------------------------------------------------------------*
* Types
*---------------------------------------------------------------------*

TYPES:
  BEGIN OF ty_vendor,

    vendor_number      TYPE lfa1-lifnr,
    vendor_name        TYPE string,

    city               TYPE adrc-city1,
    country            TYPE lfa1-land1,
    country_name       TYPE t005t-landx,

    company_code       TYPE lfb1-bukrs,
    purchasing_org     TYPE lfm1-ekorg,

    currency           TYPE lfb1-waers,
    account_group      TYPE lfa1-ktokk,

    status             TYPE char10,

  END OF ty_vendor.

*---------------------------------------------------------------------*
* Internal Table
*---------------------------------------------------------------------*

DATA:
  gt_vendor TYPE STANDARD TABLE OF ty_vendor WITH EMPTY KEY.

*---------------------------------------------------------------------*
* Start of Selection
*---------------------------------------------------------------------*

START-OF-SELECTION.

 
