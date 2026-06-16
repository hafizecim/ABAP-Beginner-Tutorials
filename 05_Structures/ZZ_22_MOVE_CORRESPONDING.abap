*&---------------------------------------------------------------------*
*& Report ZZ_22_MOVE_CORRESPONDING
*&---------------------------------------------------------------------*
*& Purpose:
*&   Demonstrates MOVE-CORRESPONDING usage in ABAP.
*&
*& Topics Covered:
*&   - Field mapping between structures
*&   - Same-named fields transfer
*&   - Partial structure copy behavior
*&---------------------------------------------------------------------*

REPORT ZZ_22_MOVE_CORRESPONDING.

*---------------------------------------------------------------------*
* Source Structure
*---------------------------------------------------------------------*
TYPES: BEGIN OF ty_source,
         id        TYPE i,
         name      TYPE string,
         department TYPE string,
         salary    TYPE p LENGTH 8 DECIMALS 2,
       END OF ty_source.

*---------------------------------------------------------------------*
* Target Structure (Different Layout)
*---------------------------------------------------------------------*
TYPES: BEGIN OF ty_target,
         id        TYPE i,
         name      TYPE string,
         city      TYPE string,
         salary    TYPE p LENGTH 8 DECIMALS 2,
       END OF ty_target.

*---------------------------------------------------------------------*
* Data Declarations
*---------------------------------------------------------------------*
DATA gs_source TYPE ty_source.
DATA gs_target TYPE ty_target.

*---------------------------------------------------------------------*
* Fill Source Structure
*---------------------------------------------------------------------*
gs_source-id         = 1001.
gs_source-name       = 'Demo User'.
gs_source-department = 'IT'.
gs_source-salary     = '50000.00'.

*---------------------------------------------------------------------*
* MOVE-CORRESPONDING
*---------------------------------------------------------------------*
MOVE-CORRESPONDING gs_source TO gs_target.

*---------------------------------------------------------------------*
* Output
*---------------------------------------------------------------------*
WRITE: / 'Source Structure'.
WRITE: / 'ID:', gs_source-id.
WRITE: / 'Name:', gs_source-name.
WRITE: / 'Department:', gs_source-department.
WRITE: / 'Salary:', gs_source-salary.

WRITE: / sy-uline.

WRITE: / 'Target Structure (After MOVE-CORRESPONDING)'.
WRITE: / 'ID:', gs_target-id.
WRITE: / 'Name:', gs_target-name.
WRITE: / 'City:', gs_target-city.
WRITE: / 'Salary:', gs_target-salary.
