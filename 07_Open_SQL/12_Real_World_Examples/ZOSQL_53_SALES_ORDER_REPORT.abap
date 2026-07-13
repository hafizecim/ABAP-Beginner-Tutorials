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
*---------------------------------------------------------------------*
* Form Get Sales Order Data
*---------------------------------------------------------------------*
FORM get_sales_order_data.

  SELECT
         vbak~vbeln                                          AS sales_order,
         vbap~posnr                                          AS item_number,

         vbak~kunnr                                          AS customer,

         CONCAT_WITH_SPACE(
             kna1~name1,
             kna1~name2,
             1 )                                             AS customer_name,

         vbap~matnr                                          AS material,

         COALESCE(
             makt~maktx,
             'No Description' )                              AS material_text,

         vbap~kwmeng                                         AS order_quantity,
         vbap~vrkme                                          AS sales_unit,

         vbap~netpr                                          AS net_price,
         vbap~netwr                                          AS total_amount,

         vbak~vkorg                                          AS sales_org,

         CASE
           WHEN vbap~kwmeng = 0 THEN 'OPEN'
           WHEN vbap~kwmeng > 0 THEN 'PROCESSED'
           ELSE 'UNKNOWN'
         END                                                 AS status

    FROM vbak

      INNER JOIN vbap
        ON vbap~vbeln = vbak~vbeln

      INNER JOIN kna1
        ON kna1~kunnr = vbak~kunnr

      LEFT OUTER JOIN makt
        ON makt~matnr = vbap~matnr
       AND makt~spras = @p_langu

    WHERE vbak~vbeln IN @s_vbeln
      AND vbak~vkorg IN @s_vkorg
      AND vbak~kunnr IN @s_kunnr
      AND vbap~matnr IN @s_matnr

    ORDER BY
      vbak~vbeln,
      vbap~posnr

    INTO TABLE @gt_sales_order.

ENDFORM.
*---------------------------------------------------------------------*
* Form Display Report
*---------------------------------------------------------------------*
FORM display_report.

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE:
    / '====================================================================================================================================',
    / 'Sales Order  Item   Customer   Customer Name               Material     Material Description      Qty     Unit   Net Value    Status',
    / '===================================================================================================================================='.

  FORMAT RESET.

  LOOP AT gt_sales_order INTO DATA(gs_sales_order).

    WRITE:
      / gs_sales_order-sales_order     UNDER 'Sales Order',
        gs_sales_order-item_number     UNDER 'Item',
        gs_sales_order-customer        UNDER 'Customer',
        gs_sales_order-customer_name   UNDER 'Customer Name',
        gs_sales_order-material        UNDER 'Material',
        gs_sales_order-material_text   UNDER 'Material Description',
        gs_sales_order-order_quantity  UNDER 'Qty',
        gs_sales_order-sales_unit      UNDER 'Unit',
        gs_sales_order-total_amount    UNDER 'Net Value',
        gs_sales_order-status          UNDER 'Status'.

  ENDLOOP.

  ULINE.

  WRITE:
    / 'Total Sales Order Items :',
      lines( gt_sales_order ).

ENDFORM.
