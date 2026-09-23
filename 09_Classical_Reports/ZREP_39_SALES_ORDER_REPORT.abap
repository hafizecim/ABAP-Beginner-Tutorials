REPORT ZREP_39_SALES_ORDER_REPORT.

*---------------------------------------------------------------------*
* Program    : ZREP_39_SALES_ORDER_REPORT
* Title      : Sales Order Report
* Purpose    : Demonstrates a Classical ABAP Sales Order Report
*              using Open SQL, JOIN and internal tables.
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This report retrieves sales order header data from VBAK and item
* data from VBAP.
*
* The report demonstrates:
* - Open SQL
* - VBAK sales order header
* - VBAP sales order item
* - INNER JOIN
* - Internal tables
* - Document and item level data
* - Date-based filtering
* - ORDER BY
* - LOOP AT
* - Classical list output
*
* Topics Covered
* 1. Sales order data
* 2. VBAK
* 3. VBAP
* 4. INNER JOIN
* 5. Open SQL
* 6. Internal tables
* 7. Document header and item relationship
* 8. Classical list formatting
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand the relationship between VBAK and VBAP.
* - Retrieve sales order data using Open SQL.
* - Combine header and item information.
* - Process transactional data with an internal table.
* - Display sales orders in a classical list.
*---------------------------------------------------------------------*

************************************************************************
* Selection Screen
************************************************************************

PARAMETERS:
  p_date TYPE vbak-erdat DEFAULT sy-datum.

************************************************************************
* Types
************************************************************************

TYPES:
  BEGIN OF ty_sales_order,
    vbeln TYPE vbak-vbeln,
    erdat TYPE vbak-erdat,
    auart TYPE vbak-auart,
    vkorg TYPE vbak-vkorg,
    kunnr TYPE vbak-kunnr,
    posnr TYPE vbap-posnr,
    matnr TYPE vbap-matnr,
    arktx TYPE vbap-arktx,
    kwmeng TYPE vbap-kwmeng,
    vrkme TYPE vbap-vrkme,
  END OF ty_sales_order.

************************************************************************
* Data
************************************************************************

DATA:
  gt_sales_order TYPE STANDARD TABLE OF ty_sales_order,
  gs_sales_order TYPE ty_sales_order.

DATA:
  gv_record_count TYPE i.

************************************************************************
* START-OF-SELECTION
************************************************************************

START-OF-SELECTION.

  PERFORM get_sales_order_data.

  IF gt_sales_order IS INITIAL.

    MESSAGE 'No sales order data found for the selected date.' TYPE 'I'.

    RETURN.

  ENDIF.

  PERFORM calculate_statistics.
  PERFORM display_report.

************************************************************************
* FORM get_sales_order_data
************************************************************************
* Retrieves sales order header and item data.

FORM get_sales_order_data.

  SELECT
    FROM vbak AS header
    INNER JOIN vbap AS item
      ON item~vbeln = header~vbeln
    FIELDS
      header~vbeln,
      header~erdat,
      header~auart,
      header~vkorg,
      header~kunnr,
      item~posnr,
      item~matnr,
      item~arktx,
      item~kwmeng,
      item~vrkme
    WHERE header~erdat = @p_date
    INTO TABLE @gt_sales_order
    ORDER BY header~vbeln,
             item~posnr.

ENDFORM.

************************************************************************
* FORM calculate_statistics
************************************************************************
* Calculates the number of sales order items retrieved.

FORM calculate_statistics.

  gv_record_count = lines( gt_sales_order ).

ENDFORM.

************************************************************************
* FORM display_report
************************************************************************
* Displays sales order data as a classical list.

FORM display_report.

*---------------------------------------------------------------------*
* Report Header
*---------------------------------------------------------------------*

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE: / '============================================================'.
  WRITE: / '                    SALES ORDER REPORT'.
  WRITE: / '============================================================'.

  FORMAT RESET.

  SKIP 1.

*---------------------------------------------------------------------*
* Report Information
*---------------------------------------------------------------------*

  WRITE: / 'Program       :', sy-repid.
  WRITE: / 'Order Date    :', p_date.
  WRITE: / 'Order Items   :', gv_record_count.
  WRITE: / 'Report Date   :', sy-datum.
  WRITE: / 'Report Time   :', sy-uzeit.

  SKIP 2.

*---------------------------------------------------------------------*
* Column Header
*---------------------------------------------------------------------*

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  POSITION 1.
  WRITE: 'Sales Order'.

  POSITION 15.
  WRITE: 'Date'.

  POSITION 27.
  WRITE: 'Type'.

  POSITION 37.
  WRITE: 'Sales Org.'.

  POSITION 50.
  WRITE: 'Customer'.

  POSITION 63.
  WRITE: 'Item'.

  POSITION 72.
  WRITE: 'Material'.

  POSITION 90.
  WRITE: 'Description'.

  POSITION 120.
  WRITE: 'Quantity'.

  POSITION 135.
  WRITE: 'UoM'.

  FORMAT RESET.

  SKIP 1.

  ULINE.

*---------------------------------------------------------------------*
* Sales Order Data
*---------------------------------------------------------------------*

  LOOP AT gt_sales_order INTO gs_sales_order.

    POSITION 1.
    WRITE: / gs_sales_order-vbeln.

    POSITION 15.
    WRITE: gs_sales_order-erdat.

    POSITION 27.
    WRITE: gs_sales_order-auart.

    POSITION 37.
    WRITE: gs_sales_order-vkorg.

    POSITION 50.
    WRITE: gs_sales_order-kunnr.

    POSITION 63.
    WRITE: gs_sales_order-posnr.

    POSITION 72.
    WRITE: gs_sales_order-matnr.

    POSITION 90.
    WRITE: gs_sales_order-arktx.

    POSITION 120.
    WRITE: gs_sales_order-kwmeng.

    POSITION 135.
    WRITE: gs_sales_order-vrkme.

  ENDLOOP.

*---------------------------------------------------------------------*
* Footer
*---------------------------------------------------------------------*

  SKIP 1.

  ULINE.

  FORMAT COLOR COL_TOTAL INTENSIFIED ON.

  WRITE: / 'TOTAL ORDER ITEMS:', gv_record_count.

  FORMAT RESET.

  SKIP 2.

  FORMAT COLOR COL_POSITIVE INTENSIFIED ON.

  WRITE: / 'Sales order report completed successfully.'.

  FORMAT RESET.

ENDFORM.
