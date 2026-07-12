REPORT ZOSQL_51_CUSTOMER_REPORT.

*---------------------------------------------------------------------*
* Report  : ZOSQL_51_CUSTOMER_REPORT
* Purpose : Professional Customer Report using Modern ABAP Open SQL
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. INNER JOIN
* 2. LEFT OUTER JOIN
* 3. CASE Expression
* 4. COALESCE
* 5. String Expressions
* 6. Host Variables (@)
* 7. Inline Declarations
* 8. ORDER BY
* 9. Clean ABAP
*
*---------------------------------------------------------------------*

TABLES:
    kna1,
    knb1,
    knvv.

*---------------------------------------------------------------------*
* Selection Screen
*---------------------------------------------------------------------*

SELECT-OPTIONS:
    s_kunnr FOR kna1-kunnr,
    s_land1 FOR kna1-land1,
    s_vkorg FOR knvv-vkorg,
    s_bukrs FOR knb1-bukrs.

PARAMETERS:
    p_langu TYPE sylangu DEFAULT sy-langu.

*---------------------------------------------------------------------*
* Types
*---------------------------------------------------------------------*

TYPES:
  BEGIN OF ty_customer,

    customer_number TYPE kna1-kunnr,
    customer_name   TYPE string,

    city            TYPE adrc-city1,
    country         TYPE kna1-land1,
    country_name    TYPE t005t-landx,

    sales_org       TYPE knvv-vkorg,
    company_code    TYPE knb1-bukrs,

    currency        TYPE knb1-waers,
    account_group   TYPE kna1-ktokd,

    status          TYPE char10,

  END OF ty_customer.

*---------------------------------------------------------------------*
* Internal Table
*---------------------------------------------------------------------*

DATA:
    gt_customer TYPE STANDARD TABLE OF ty_customer WITH EMPTY KEY.

*---------------------------------------------------------------------*
* Start of Selection
*---------------------------------------------------------------------*

START-OF-SELECTION.

  PERFORM get_customer_data.

  IF gt_customer IS INITIAL.

    WRITE: / 'No customer found for the given selection criteria.'.

    RETURN.

  ENDIF.

  PERFORM display_report.
*---------------------------------------------------------------------*
* Form Get Customer Data
*---------------------------------------------------------------------*
FORM get_customer_data.

  SELECT
         kna1~kunnr                                               AS customer_number,

         CONCAT_WITH_SPACE(
             kna1~name1,
             kna1~name2,
             1 )                                                  AS customer_name,

         COALESCE(
             adrc~city1,
             'Unknown City' )                                     AS city,

         kna1~land1                                               AS country,
         t005t~landx                                              AS country_name,

         knvv~vkorg                                               AS sales_org,
         knb1~bukrs                                               AS company_code,

         knb1~waers                                               AS currency,
         kna1~ktokd                                               AS account_group,

         CASE
           WHEN kna1~loevm = @space THEN 'ACTIVE'
           ELSE 'BLOCKED'
         END                                                      AS status

    FROM kna1

      INNER JOIN knb1
        ON knb1~kunnr = kna1~kunnr

      INNER JOIN knvv
        ON knvv~kunnr = kna1~kunnr

      LEFT OUTER JOIN adrc
        ON adrc~addrnumber = kna1~adrnr

      LEFT OUTER JOIN t005t
        ON t005t~land1 = kna1~land1
       AND t005t~spras = @p_langu

    WHERE kna1~kunnr IN @s_kunnr
      AND kna1~land1 IN @s_land1
      AND knvv~vkorg IN @s_vkorg
      AND knb1~bukrs IN @s_bukrs

    ORDER BY
      kna1~kunnr,
      knvv~vkorg,
      knb1~bukrs

    INTO TABLE @gt_customer.

ENDFORM.
