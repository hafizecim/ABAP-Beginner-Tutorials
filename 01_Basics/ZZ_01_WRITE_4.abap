*---------------------------------------------------------------------*
* Program Name : ZZ_01_WRITE_4
* Author       : Hafize
* Created Date : 25.05.2026
*
* Purpose      :
* Demonstrates the use of internal tables, APPEND statement,
* and LOOP processing in ABAP.
*
* Topics       :
* - Internal Tables
* - APPEND Statement
* - LOOP AT
* - WRITE Statement
*---------------------------------------------------------------------*

REPORT zz_01_write_4.

*---------------------------------------------------------------------*
* Data Declarations
*---------------------------------------------------------------------*

" Internal table to store multiple messages
DATA:
  gt_messages TYPE TABLE OF string,

" Work variable used during LOOP processing
  gv_message  TYPE string.

*---------------------------------------------------------------------*
* Data Population
*---------------------------------------------------------------------*

" Adding records into internal table
APPEND 'Merhaba ABAP' TO gt_messages.
APPEND 'Hello ABAP'   TO gt_messages.
APPEND 'Hallo ABAP'   TO gt_messages.

*---------------------------------------------------------------------*
* Output Section
*---------------------------------------------------------------------*

" Loop through internal table and display each record
LOOP AT gt_messages INTO gv_message.

  WRITE: / gv_message.

ENDLOOP.
