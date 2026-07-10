REPORT ZOSQL_49_PACKAGE_SIZE.

*---------------------------------------------------------------------*
* Report  : ZOSQL_49_PACKAGE_SIZE
* Purpose : Demonstrates PACKAGE SIZE in Open SQL
*---------------------------------------------------------------------*
*
* Topics Covered
*
* 1. Read All Records
* 2. PACKAGE SIZE 10
* 3. PACKAGE SIZE 50
* 4. Process Each Package
*
*---------------------------------------------------------------------*

************************************************************************
* Type Definitions
************************************************************************

TYPES:
  BEGIN OF ty_flight,
    carrid   TYPE sflight-carrid,
    connid   TYPE sflight-connid,
    fldate   TYPE sflight-fldate,
    price    TYPE sflight-price,
    currency TYPE sflight-currency,
  END OF ty_flight.

************************************************************************
* Data Definitions
************************************************************************

DATA:
  gs_flight TYPE ty_flight,
  gt_flight TYPE STANDARD TABLE OF ty_flight WITH EMPTY KEY.

DATA:
  gv_package_no TYPE i,
  gv_total_rows TYPE i.

************************************************************************
* Start of Selection
************************************************************************

START-OF-SELECTION.

************************************************************************
* Example 1
* Read All Records At Once
************************************************************************

ULINE.
WRITE: / 'Example 1 : Read All Records'.
ULINE.

CLEAR gt_flight.

SELECT
       carrid,
       connid,
       fldate,
       price,
       currency
  FROM sflight
  INTO TABLE @gt_flight.

WRITE:
/ 'Total Records :', lines( gt_flight ).

SKIP.

************************************************************************
* Example 2
* PACKAGE SIZE 10
************************************************************************

ULINE.
WRITE: / 'Example 2 : PACKAGE SIZE 10'.
ULINE.

CLEAR:
  gv_package_no,
  gv_total_rows.

SELECT
       carrid,
       connid,
       fldate,
       price,
       currency
  FROM sflight
  INTO TABLE @gt_flight
  PACKAGE SIZE 10.

  gv_package_no = gv_package_no + 1.
  gv_total_rows = gv_total_rows + lines( gt_flight ).

  WRITE:
  / 'Package :', gv_package_no,
    'Rows :', lines( gt_flight ).

  LOOP AT gt_flight INTO gs_flight.

    WRITE:
    / gs_flight-carrid,
      gs_flight-connid,
      gs_flight-fldate.

  ENDLOOP.

  SKIP.

ENDSELECT.

WRITE:
/
'Total Rows Read :', gv_total_rows.

SKIP.

************************************************************************
* Example 3
* PACKAGE SIZE 50
************************************************************************

ULINE.
WRITE: / 'Example 3 : PACKAGE SIZE 50'.
ULINE.

CLEAR:
  gv_package_no,
  gv_total_rows.

SELECT
       carrid,
       connid,
       fldate,
       price,
       currency
  FROM sflight
  INTO TABLE @gt_flight
  PACKAGE SIZE 50.

  gv_package_no = gv_package_no + 1.
  gv_total_rows = gv_total_rows + lines( gt_flight ).

  WRITE:
  / 'Package :', gv_package_no,
    'Rows :', lines( gt_flight ).

ENDSELECT.

WRITE:
/
'Total Rows Read :', gv_total_rows.

SKIP.

************************************************************************
* Example 4
* Process Every Package
************************************************************************

ULINE.
WRITE: / 'Example 4 : Process Every Package'.
ULINE.

CLEAR:
  gv_package_no,
  gv_total_rows.

SELECT
       carrid,
       connid,
       fldate,
       price,
       currency
  FROM sflight
  INTO TABLE @gt_flight
  PACKAGE SIZE 20.

  gv_package_no = gv_package_no + 1.

  WRITE:
  / 'Processing Package', gv_package_no.

  LOOP AT gt_flight INTO gs_flight.

    gv_total_rows = gv_total_rows + 1.

  ENDLOOP.

ENDSELECT.

WRITE:
/
'Processed Rows :', gv_total_rows.

SKIP.

************************************************************************
* Example 5
* PACKAGE SIZE with WHERE Condition
************************************************************************

ULINE.
WRITE: / 'Example 5 : PACKAGE SIZE with WHERE'.
ULINE.

CLEAR:
  gv_package_no,
  gv_total_rows.

SELECT
       carrid,
       connid,
       fldate,
       price,
       currency
  FROM sflight
  WHERE carrid = 'LH'
  INTO TABLE @gt_flight
  PACKAGE SIZE 15.

  gv_package_no = gv_package_no + 1.
  gv_total_rows = gv_total_rows + lines( gt_flight ).

  WRITE:
  / 'Package :', gv_package_no,
    'Rows :', lines( gt_flight ).

  LOOP AT gt_flight INTO gs_flight.

    WRITE:
    / gs_flight-carrid,
      gs_flight-connid,
      gs_flight-fldate,
      gs_flight-price.

  ENDLOOP.

  SKIP.

ENDSELECT.

WRITE:
/ 'Total Rows Read :', gv_total_rows.

SKIP.

************************************************************************
* Example 6
* PACKAGE SIZE with ORDER BY
************************************************************************

ULINE.
WRITE: / 'Example 6 : PACKAGE SIZE with ORDER BY'.
ULINE.

CLEAR:
  gv_package_no,
  gv_total_rows.

SELECT
       carrid,
       connid,
       fldate,
       price,
       currency
  FROM sflight
  WHERE carrid = 'AA'
  ORDER BY PRIMARY KEY
  INTO TABLE @gt_flight
  PACKAGE SIZE 5.

  gv_package_no = gv_package_no + 1.
  gv_total_rows = gv_total_rows + lines( gt_flight ).

  WRITE:
  / 'Package :', gv_package_no,
    'Rows :', lines( gt_flight ).

ENDSELECT.

WRITE:
/ 'Total Rows Read :', gv_total_rows.

SKIP.

************************************************************************
* Example 7
* Count Processed Packages
************************************************************************

ULINE.
WRITE: / 'Example 7 : Count Packages'.
ULINE.

CLEAR:
  gv_package_no,
  gv_total_rows.

SELECT
       carrid,
       connid,
       fldate,
       price,
       currency
  FROM sflight
  INTO TABLE @gt_flight
  PACKAGE SIZE 25.

  gv_package_no = gv_package_no + 1.
  gv_total_rows = gv_total_rows + lines( gt_flight ).

ENDSELECT.

WRITE:
/ 'Packages Processed :', gv_package_no,
/ 'Total Records      :', gv_total_rows.

SKIP.

************************************************************************
* Example 8
* Memory-Efficient Package Processing
************************************************************************

ULINE.
WRITE: / 'Example 8 : Memory-Efficient Processing'.
ULINE.

CLEAR:
  gv_package_no,
  gv_total_rows.

SELECT
       carrid,
       connid,
       fldate,
       price,
       currency
  FROM sflight
  INTO TABLE @gt_flight
  PACKAGE SIZE 20.

  gv_package_no = gv_package_no + 1.

  LOOP AT gt_flight INTO gs_flight.

    gv_total_rows = gv_total_rows + 1.

*   Place business logic here.
*   Example:
*   - Validation
*   - Calculation
*   - Data transformation
*   - File generation
*   - API call
*   - BAPI processing

  ENDLOOP.

* Release package memory before fetching the next package.

  CLEAR gt_flight.

ENDSELECT.

WRITE:
/ 'Packages Processed :', gv_package_no,
/ 'Total Records      :', gv_total_rows.

SKIP.
