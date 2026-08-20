REPORT ZREP_37_CUSTOMER_MASTER_REPORT.

*---------------------------------------------------------------------*
* Program    : ZREP_37_CUSTOMER_MASTER_REPORT
* Title      : Customer Master Report
* Purpose    : Demonstrates a Classical ABAP Customer Master Report
*              using Open SQL, JOIN and internal tables.
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This report retrieves customer master data from KNA1 and combines
* it with address information from ADRC.
*
* The report demonstrates:
* - Open SQL
* - KNA1 customer master data
* - ADRC address data
* - LEFT OUTER JOIN
* - Internal tables
* - SELECT with field list
* - ORDER BY
* - LOOP AT
* - Classical list formatting
*
* Topics Covered
* 1. Customer master data
* 2. KNA1
* 3. ADRC
* 4. LEFT OUTER JOIN
* 5. Open SQL
* 6. Internal tables
* 7. Classical list output
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand a real SAP customer master reporting scenario.
* - Retrieve customer data using Open SQL.
* - Combine customer and address information.
* - Understand LEFT OUTER JOIN.
* - Display master data using classical list processing.
*---------------------------------------------------------------------*

************************************************************************
* Types
************************************************************************

TYPES:
  BEGIN OF ty_customer,
    kunnr TYPE kna1-kunnr,
    name1 TYPE kna1-name1,
    land1 TYPE kna1-land1,
    ort01 TYPE kna1-ort01,
    pstlz TYPE kna1-pstlz,
    regio TYPE kna1-regio,
    stras TYPE kna1-stras,
    adrnr TYPE kna1-adrnr,
    city  TYPE adrc-city1,
  END OF ty_customer.

************************************************************************
* Data
************************************************************************

DATA:
  gt_customer TYPE STANDARD TABLE OF ty_customer,
  gs_customer TYPE ty_customer.

DATA:
  gv_record_count TYPE i.

************************************************************************
* START-OF-SELECTION
************************************************************************

START-OF-SELECTION.

  PERFORM get_customer_data.

  IF gt_customer IS INITIAL.

    MESSAGE 'No customer master data found.' TYPE 'I'.

    RETURN.

  ENDIF.

  PERFORM calculate_statistics.
  PERFORM display_report.

************************************************************************
* FORM get_customer_data
************************************************************************
* Retrieves customer master and address data.

FORM get_customer_data.

  SELECT
    FROM kna1 AS customer
    LEFT OUTER JOIN adrc AS address
      ON address~addrnumber = customer~adrnr
    FIELDS
      customer~kunnr,
      customer~name1,
      customer~land1,
      customer~ort01,
      customer~pstlz,
      customer~regio,
      customer~stras,
      customer~adrnr,
      address~city1
    INTO TABLE @gt_customer
    ORDER BY customer~kunnr.

ENDFORM.

************************************************************************
* FORM calculate_statistics
************************************************************************
* Calculates the number of customers retrieved.

FORM calculate_statistics.

  gv_record_count = lines( gt_customer ).

ENDFORM.

************************************************************************
* FORM display_report
************************************************************************
* Displays customer master data as a classical list.

FORM display_report.

*---------------------------------------------------------------------*
* Report Header
*---------------------------------------------------------------------*

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE: / '============================================================'.
  WRITE: / '                  CUSTOMER MASTER REPORT'.
  WRITE: / '============================================================'.

  FORMAT RESET.

  SKIP 1.

*---------------------------------------------------------------------*
* Report Information
*---------------------------------------------------------------------*

  WRITE: / 'Program      :', sy-repid.
  WRITE: / 'Report Date  :', sy-datum.
  WRITE: / 'Report Time  :', sy-uzeit.
  WRITE: / 'Customers    :', gv_record_count.

  SKIP 2.

*---------------------------------------------------------------------*
* Column Header
*---------------------------------------------------------------------*

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  POSITION 1.
  WRITE: 'Customer'.

  POSITION 15.
  WRITE: 'Customer Name'.

  POSITION 42.
  WRITE: 'Country'.

  POSITION 52.
  WRITE: 'City'.

  POSITION 70.
  WRITE: 'Postal Code'.

  POSITION 84.
  WRITE: 'Region'.

  POSITION 95.
  WRITE: 'Address'.

  FORMAT RESET.

  SKIP 1.

  ULINE.

*---------------------------------------------------------------------*
* Customer Data
*---------------------------------------------------------------------*

  LOOP AT gt_customer INTO gs_customer.

    POSITION 1.
    WRITE: / gs_customer-kunnr.

    POSITION 15.
    WRITE: gs_customer-name1.

    POSITION 42.
    WRITE: gs_customer-land1.

    POSITION 52.
    WRITE: gs_customer-city.

    POSITION 70.
    WRITE: gs_customer-pstlz.

    POSITION 84.
    WRITE: gs_customer-regio.

    POSITION 95.
    WRITE: gs_customer-stras.

  ENDLOOP.

*---------------------------------------------------------------------*
* Footer
*---------------------------------------------------------------------*

  SKIP 1.

  ULINE.

  FORMAT COLOR COL_TOTAL INTENSIFIED ON.

  WRITE: / 'TOTAL CUSTOMERS:', gv_record_count.

  FORMAT RESET.

  SKIP 2.

  FORMAT COLOR COL_POSITIVE INTENSIFIED ON.

  WRITE: / 'Customer master report completed successfully.'.

  FORMAT RESET.

ENDFORM.
