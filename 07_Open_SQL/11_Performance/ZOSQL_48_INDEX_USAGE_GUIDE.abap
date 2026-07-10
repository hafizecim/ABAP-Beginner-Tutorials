REPORT ZOSQL_48_INDEX_USAGE_GUIDE.

*---------------------------------------------------------------------*
* Report  : ZOSQL_48_INDEX_USAGE_GUIDE
* Author  : ABAP Beginner Tutorials
* Purpose : Demonstrate Index-Friendly Open SQL Statements
*---------------------------------------------------------------------*
*
* Topics Covered
*
* 1. Primary Key Search
* 2. Leading Index Search
* 3. Composite Index Search
* 4. Equality and Range Conditions
* 5. ORDER BY PRIMARY KEY
* 6. SELECT SINGLE
* 7. UP TO 1 ROWS
* 8. Select Required Columns
* 9. Non-Indexed Search
*10. Performance Recommendations
*
*---------------------------------------------------------------------*

************************************************************************
* Type Definitions
************************************************************************

TYPES:
  BEGIN OF ty_scarr,
    carrid   TYPE scarr-carrid,
    carrname TYPE scarr-carrname,
    currcode TYPE scarr-currcode,
    url      TYPE scarr-url,
  END OF ty_scarr.

TYPES:
  BEGIN OF ty_sflight,
    carrid   TYPE sflight-carrid,
    connid   TYPE sflight-connid,
    fldate   TYPE sflight-fldate,
    price    TYPE sflight-price,
    currency TYPE sflight-currency,
    seatsocc TYPE sflight-seatsocc,
  END OF ty_sflight.

************************************************************************
* Data Definitions
************************************************************************

DATA:
  gs_scarr    TYPE ty_scarr,
  gt_scarr    TYPE STANDARD TABLE OF ty_scarr WITH EMPTY KEY,

  gs_flight   TYPE ty_sflight,
  gt_flight   TYPE STANDARD TABLE OF ty_sflight WITH EMPTY KEY.

************************************************************************
* Start of Selection
************************************************************************

START-OF-SELECTION.

************************************************************************
* Example 1
* Search Using Primary Key
************************************************************************

ULINE.
WRITE: / 'Example 1 : Search Using Primary Key'.
ULINE.

CLEAR gs_scarr.

SELECT SINGLE
       carrid,
       carrname,
       currcode,
       url
  FROM scarr
  WHERE carrid = 'LH'
  INTO @gs_scarr.

IF sy-subrc = 0.

  WRITE: /
    'Carrier :', gs_scarr-carrid,
    gs_scarr-carrname.

ELSE.

  WRITE / 'No data found.'.

ENDIF.

SKIP.

************************************************************************
* Example 2
* Search Using Leading Index Field
************************************************************************

ULINE.
WRITE: / 'Example 2 : Leading Index Field'.
ULINE.

CLEAR gt_flight.

SELECT
       carrid,
       connid,
       fldate,
       price,
       currency,
       seatsocc
  FROM sflight
  WHERE carrid = 'LH'
  INTO TABLE @gt_flight.

WRITE:
/ 'Number of Records :', lines( gt_flight ).

LOOP AT gt_flight INTO gs_flight.

  WRITE:
  / gs_flight-carrid,
    gs_flight-connid,
    gs_flight-fldate,
    gs_flight-price,
    gs_flight-currency.

ENDLOOP.

SKIP.

************************************************************************
* Example 3
* Search Using Composite Key
************************************************************************

ULINE.
WRITE: / 'Example 3 : Composite Key Search'.
ULINE.

CLEAR gt_flight.

SELECT
       carrid,
       connid,
       fldate,
       price,
       currency,
       seatsocc
  FROM sflight
  WHERE carrid = 'LH'
    AND connid = '0400'
  INTO TABLE @gt_flight.

WRITE:
/ 'Number of Records :', lines( gt_flight ).

LOOP AT gt_flight INTO gs_flight.

  WRITE:
  / gs_flight-carrid,
    gs_flight-connid,
    gs_flight-fldate,
    gs_flight-price.

ENDLOOP.

SKIP.

************************************************************************
* Example 4
* Equality Before Range
************************************************************************

ULINE.
WRITE: / 'Example 4 : Equality and Range Condition'.
ULINE.

CLEAR gt_flight.

SELECT
       carrid,
       connid,
       fldate,
       price,
       currency,
       seatsocc
  FROM sflight
  WHERE carrid = 'LH'
    AND fldate >= @sy-datum
  INTO TABLE @gt_flight.

WRITE:
/ 'Future Flights :', lines( gt_flight ).

LOOP AT gt_flight INTO gs_flight.

  WRITE:
  / gs_flight-carrid,
    gs_flight-connid,
    gs_flight-fldate,
    gs_flight-price.

ENDLOOP.

SKIP.
