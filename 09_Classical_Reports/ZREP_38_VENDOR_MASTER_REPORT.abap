REPORT ZREP_38_VENDOR_MASTER_REPORT.

*---------------------------------------------------------------------*
* Program    : ZREP_38_VENDOR_MASTER_REPORT
* Title      : Vendor Master Report
* Purpose    : Demonstrates a Classical ABAP Vendor Master Report
*              using Open SQL, JOIN and internal tables.
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* This report retrieves vendor master data from LFA1 and combines
* it with address information from ADRC.
*
* The report demonstrates:
* - Open SQL
* - LFA1 vendor master data
* - ADRC address data
* - LEFT OUTER JOIN
* - Internal tables
* - SELECT field list
* - ORDER BY
* - LOOP AT
* - Classical list output
*
* Topics Covered
* 1. Vendor master data
* 2. LFA1
* 3. ADRC
* 4. LEFT OUTER JOIN
* 5. Open SQL
* 6. Internal tables
* 7. Classical list formatting
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand a classical SAP vendor master reporting scenario.
* - Retrieve vendor data using Open SQL.
* - Combine vendor and address information.
* - Understand LEFT OUTER JOIN.
* - Display vendor master data in a classical list.
*---------------------------------------------------------------------*

************************************************************************
* Types
************************************************************************

TYPES:
  BEGIN OF ty_vendor,
    lifnr TYPE lfa1-lifnr,
    name1 TYPE lfa1-name1,
    land1 TYPE lfa1-land1,
    ort01 TYPE lfa1-ort01,
    pstlz TYPE lfa1-pstlz,
    regio TYPE lfa1-regio,
    stras TYPE lfa1-stras,
    adrnr TYPE lfa1-adrnr,
    city  TYPE adrc-city1,
  END OF ty_vendor.

************************************************************************
* Data
************************************************************************

DATA:
  gt_vendor TYPE STANDARD TABLE OF ty_vendor,
  gs_vendor TYPE ty_vendor.

DATA:
  gv_record_count TYPE i.

************************************************************************
* START-OF-SELECTION
************************************************************************

START-OF-SELECTION.

  PERFORM get_vendor_data.

  IF gt_vendor IS INITIAL.

    MESSAGE 'No vendor master data found.' TYPE 'I'.

    RETURN.

  ENDIF.

  PERFORM calculate_statistics.
  PERFORM display_report.

************************************************************************
* FORM get_vendor_data
************************************************************************
* Retrieves vendor master and address data.

FORM get_vendor_data.

  SELECT
    FROM lfa1 AS vendor
    LEFT OUTER JOIN adrc AS address
      ON address~addrnumber = vendor~adrnr
    FIELDS
      vendor~lifnr,
      vendor~name1,
      vendor~land1,
      vendor~ort01,
      vendor~pstlz,
      vendor~regio,
      vendor~stras,
      vendor~adrnr,
      address~city1
    INTO TABLE @gt_vendor
    ORDER BY vendor~lifnr.

ENDFORM.

************************************************************************
* FORM calculate_statistics
************************************************************************
* Calculates the number of vendors retrieved.

FORM calculate_statistics.

  gv_record_count = lines( gt_vendor ).

ENDFORM.

************************************************************************
* FORM display_report
************************************************************************
* Displays vendor master data as a classical list.

FORM display_report.

*---------------------------------------------------------------------*
* Report Header
*---------------------------------------------------------------------*

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE: / '============================================================'.
  WRITE: / '                   VENDOR MASTER REPORT'.
  WRITE: / '============================================================'.

  FORMAT RESET.

  SKIP 1.

*---------------------------------------------------------------------*
* Report Information
*---------------------------------------------------------------------*

  WRITE: / 'Program      :', sy-repid.
  WRITE: / 'Report Date  :', sy-datum.
  WRITE: / 'Report Time  :', sy-uzeit.
  WRITE: / 'Vendors      :', gv_record_count.

  SKIP 2.

*---------------------------------------------------------------------*
* Column Header
*---------------------------------------------------------------------*

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  POSITION 1.
  WRITE: 'Vendor'.

  POSITION 15.
  WRITE: 'Vendor Name'.

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
* Vendor Data
*---------------------------------------------------------------------*

  LOOP AT gt_vendor INTO gs_vendor.

    POSITION 1.
    WRITE: / gs_vendor-lifnr.

    POSITION 15.
    WRITE: gs_vendor-name1.

    POSITION 42.
    WRITE: gs_vendor-land1.

    POSITION 52.
    WRITE: gs_vendor-city.

    POSITION 70.
    WRITE: gs_vendor-pstlz.

    POSITION 84.
    WRITE: gs_vendor-regio.

    POSITION 95.
    WRITE: gs_vendor-stras.

  ENDLOOP.

*---------------------------------------------------------------------*
* Footer
*---------------------------------------------------------------------*

  SKIP 1.

  ULINE.

  FORMAT COLOR COL_TOTAL INTENSIFIED ON.

  WRITE: / 'TOTAL VENDORS:', gv_record_count.

  FORMAT RESET.

  SKIP 2.

  FORMAT COLOR COL_POSITIVE INTENSIFIED ON.

  WRITE: / 'Vendor master report completed successfully.'.

  FORMAT RESET.

ENDFORM.
