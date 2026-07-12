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

 *---------------------------------------------------------------------*
* Form Get Vendor Data
*---------------------------------------------------------------------*
FORM get_vendor_data.

  SELECT
         lfa1~lifnr                                                AS vendor_number,

         CONCAT_WITH_SPACE(
             lfa1~name1,
             lfa1~name2,
             1 )                                                   AS vendor_name,

         COALESCE(
             adrc~city1,
             'Unknown City' )                                      AS city,

         lfa1~land1                                                AS country,
         t005t~landx                                               AS country_name,

         lfb1~bukrs                                                AS company_code,
         lfm1~ekorg                                                AS purchasing_org,

         lfb1~waers                                                AS currency,
         lfa1~ktokk                                                AS account_group,

         CASE
           WHEN lfa1~loevm = @space THEN 'ACTIVE'
           ELSE 'BLOCKED'
         END                                                       AS status

    FROM lfa1

      INNER JOIN lfb1
        ON lfb1~lifnr = lfa1~lifnr

      INNER JOIN lfm1
        ON lfm1~lifnr = lfa1~lifnr

      LEFT OUTER JOIN adrc
        ON adrc~addrnumber = lfa1~adrnr

      LEFT OUTER JOIN t005t
        ON t005t~land1 = lfa1~land1
       AND t005t~spras = @p_langu

    WHERE lfa1~lifnr IN @s_lifnr
      AND lfa1~land1 IN @s_land1
      AND lfb1~bukrs IN @s_bukrs
      AND lfm1~ekorg IN @s_ekorg

    ORDER BY
      lfa1~lifnr,
      lfb1~bukrs,
      lfm1~ekorg

    INTO TABLE @gt_vendor.

ENDFORM.
*---------------------------------------------------------------------*
* Form Display Report
*---------------------------------------------------------------------*
FORM display_report.

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE:
    / '==============================================================================================================================',
    / 'Vendor     Vendor Name                   City              Country        Company  Purch.Org Currency Account Grp Status',
    / '=============================================================================================================================='.

  FORMAT RESET.

  LOOP AT gt_vendor INTO DATA(gs_vendor).

    WRITE:
      / gs_vendor-vendor_number    UNDER 'Vendor',
        gs_vendor-vendor_name      UNDER 'Vendor Name',
        gs_vendor-city             UNDER 'City',
        gs_vendor-country_name     UNDER 'Country',
        gs_vendor-company_code     UNDER 'Company',
        gs_vendor-purchasing_org   UNDER 'Purch.Org',
        gs_vendor-currency         UNDER 'Currency',
        gs_vendor-account_group    UNDER 'Account Grp',
        gs_vendor-status           UNDER 'Status'.

  ENDLOOP.

  ULINE.

  WRITE:
    / 'Total Vendors :', lines( gt_vendor ).

ENDFORM.
