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
