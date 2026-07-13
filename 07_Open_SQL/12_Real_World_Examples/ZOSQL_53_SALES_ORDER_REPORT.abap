REPORT ZOSQL_53_SALES_ORDER_REPORT.

*---------------------------------------------------------------------*
* Report  : ZOSQL_53_SALES_ORDER_REPORT
* Purpose : Professional Sales Order Report using Modern ABAP Open SQL
*---------------------------------------------------------------------*
*
* Topics Covered
* 1. INNER JOIN
* 2. LEFT OUTER JOIN
* 3. CASE Expression
* 4. COALESCE
* 5. Arithmetic Expressions
* 6. CONCAT_WITH_SPACE
* 7. Host Variables (@)
* 8. Inline Declarations
* 9. ORDER BY
* 10. Clean ABAP
*
*---------------------------------------------------------------------*

TABLES:
  vbak,
  vbap.

*---------------------------------------------------------------------*
* Selection Screen
*---------------------------------------------------------------------*

SELECT-OPTIONS:
  s_vbeln FOR vbak-vbeln,
  s_vkorg FOR vbak-vkorg,
  s_kunnr FOR vbak-kunnr,
  s_matnr FOR vbap-matnr.

PARAMETERS:
  p_langu TYPE sylangu DEFAULT sy-langu.

*---------------------------------------------------------------------*
* Types
*---------------------------------------------------------------------*

TYPES:
  BEGIN OF ty_sales_order,

    sales_order      TYPE vbak-vbeln,
    item_number      TYPE vbap-posnr,

    customer         TYPE vbak-kunnr,
    customer_name    TYPE string,

    material         TYPE vbap-matnr,
    material_text    TYPE makt-maktx,

    order_quantity   TYPE vbap-kwmeng,
    sales_unit       TYPE vbap-vrkme,

    net_price        TYPE vbap-netpr,
    total_amount     TYPE vbap-netwr,

    sales_org        TYPE vbak-vkorg,

    status           TYPE char15,

  END OF ty_sales_order.

*---------------------------------------------------------------------*
* Internal Table
*---------------------------------------------------------------------*

DATA:
  gt_sales_order TYPE STANDARD TABLE OF ty_sales_order
                 WITH EMPTY KEY.

*---------------------------------------------------------------------*
* Start of Selection
*---------------------------------------------------------------------*

START-OF-SELECTION.

  PERFORM get_sales_order_data.

  IF gt_sales_order IS INITIAL.

    WRITE:
      / 'No sales orders found for the given selection criteria.'.

    RETURN.

  ENDIF.

  PERFORM display_report.
