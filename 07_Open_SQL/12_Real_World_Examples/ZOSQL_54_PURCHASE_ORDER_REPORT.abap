REPORT ZOSQL_54_PURCHASE_ORDER_REPORT.

*---------------------------------------------------------------------*
* Report  : ZOSQL_54_PURCHASE_ORDER_REPORT
* Purpose : Professional Purchase Order Report using Modern ABAP Open SQL
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. INNER JOIN
* 2. LEFT OUTER JOIN
* 3. CASE Expression
* 4. COALESCE
* 5. CONCAT_WITH_SPACE
* 6. Arithmetic Expressions
* 7. SQL Expressions
* 8. Host Variables (@)
* 9. Inline Declarations
* 10. ORDER BY
* 11. Clean ABAP
*
*---------------------------------------------------------------------*

TABLES:
  ekko,
  ekpo.

*---------------------------------------------------------------------*
* Selection Screen
*---------------------------------------------------------------------*

SELECT-OPTIONS:
  s_ebeln FOR ekko-ebeln,
  s_ekorg FOR ekko-ekorg,
  s_lifnr FOR ekko-lifnr,
  s_matnr FOR ekpo-matnr.

PARAMETERS:
  p_langu TYPE sylangu DEFAULT sy-langu.

*---------------------------------------------------------------------*
* Types
*---------------------------------------------------------------------*

TYPES:
  BEGIN OF ty_purchase_order,

    purchase_order    TYPE ekko-ebeln,
    item_number       TYPE ekpo-ebelp,

    vendor            TYPE ekko-lifnr,
    vendor_name       TYPE string,

    material          TYPE ekpo-matnr,
    material_text     TYPE makt-maktx,

    order_quantity    TYPE ekpo-menge,
    order_unit        TYPE ekpo-meins,

    net_price         TYPE ekpo-netpr,
    total_amount      TYPE ekpo-netwr,

    purchasing_org    TYPE ekko-ekorg,
    document_currency TYPE ekko-waers,

    status            TYPE char15,

  END OF ty_purchase_order.

*---------------------------------------------------------------------*
* Internal Table
*---------------------------------------------------------------------*

DATA:
  gt_purchase_order TYPE STANDARD TABLE OF ty_purchase_order
                    WITH EMPTY KEY.

*---------------------------------------------------------------------*
* Start of Selection
*---------------------------------------------------------------------*

START-OF-SELECTION.

  PERFORM get_purchase_order_data.

  IF gt_purchase_order IS INITIAL.

    WRITE:
      / 'No purchase orders found for the given selection criteria.'.

    RETURN.

  ENDIF.

  PERFORM display_report.
*---------------------------------------------------------------------*
* Form Get Purchase Order Data
*---------------------------------------------------------------------*
FORM get_purchase_order_data.

  SELECT
         ekko~ebeln                                        AS purchase_order,
         ekpo~ebelp                                        AS item_number,

         ekko~lifnr                                        AS vendor,

         CONCAT_WITH_SPACE(
             lfa1~name1,
             lfa1~name2,
             1 )                                           AS vendor_name,

         ekpo~matnr                                        AS material,

         COALESCE(
             makt~maktx,
             'No Description' )                            AS material_text,

         ekpo~menge                                        AS order_quantity,
         ekpo~meins                                        AS order_unit,

         ekpo~netpr                                        AS net_price,

         ( ekpo~menge * ekpo~netpr )                       AS total_amount,

         ekko~ekorg                                        AS purchasing_org,
         ekko~waers                                        AS document_currency,

         CASE
           WHEN ekpo~elikz = @abap_true THEN 'DELIVERED'
           WHEN ekpo~menge > 0 THEN 'OPEN'
           ELSE 'UNKNOWN'
         END                                               AS status

    FROM ekko

      INNER JOIN ekpo
        ON ekpo~ebeln = ekko~ebeln

      INNER JOIN lfa1
        ON lfa1~lifnr = ekko~lifnr

      LEFT OUTER JOIN makt
        ON makt~matnr = ekpo~matnr
       AND makt~spras = @p_langu

    WHERE ekko~ebeln IN @s_ebeln
      AND ekko~ekorg IN @s_ekorg
      AND ekko~lifnr IN @s_lifnr
      AND ekpo~matnr IN @s_matnr

    ORDER BY
      ekko~ebeln,
      ekpo~ebelp

    INTO TABLE @gt_purchase_order.

ENDFORM.
