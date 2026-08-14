REPORT ZREP_27_FORMATTING_WITH_FORMAT.

*---------------------------------------------------------------------*
* Program    : ZREP_27_FORMATTING_WITH_FORMAT
* Title      : Formatting with FORMAT
* Purpose    : Demonstrates the FORMAT statement and its formatting
*              options in a Classical ABAP list report.
*---------------------------------------------------------------------*
* Description
*---------------------------------------------------------------------*
* The FORMAT statement controls the visual and interactive properties
* of classical ABAP list output.
*
* This report demonstrates:
* - COLOR
* - INTENSIFIED
* - HOTSPOT
* - INPUT
* - INVERSE
* - RESET
*
* Topics Covered
* 1. FORMAT statement
* 2. Color formatting
* 3. Intensified output
* 4. Hotspot formatting
* 5. Input-style formatting
* 6. Inverse formatting
* 7. Format reset
*---------------------------------------------------------------------*
* Learning Objectives
*---------------------------------------------------------------------*
* - Understand the purpose of FORMAT.
* - Apply different list formatting attributes.
* - Combine formatting attributes.
* - Reset formatting safely.
*---------------------------------------------------------------------*

************************************************************************
* START-OF-SELECTION
************************************************************************

START-OF-SELECTION.

*---------------------------------------------------------------------*
* Report Header
*---------------------------------------------------------------------*

  FORMAT COLOR COL_HEADING INTENSIFIED ON.

  WRITE: / '============================================================'.
  WRITE: / '                  FORMAT DEMONSTRATION'.
  WRITE: / '============================================================'.

  FORMAT RESET.

  SKIP 2.

*---------------------------------------------------------------------*
* NORMAL FORMAT
*---------------------------------------------------------------------*

  WRITE: / '1. NORMAL OUTPUT'.
  ULINE.

  WRITE: / 'This line uses the default list formatting.'.

  SKIP 2.

*---------------------------------------------------------------------*
* COLOR
*---------------------------------------------------------------------*

  WRITE: / '2. COLOR'.
  ULINE.

  FORMAT COLOR COL_POSITIVE.

  WRITE: / 'This line uses the positive color.'.

  FORMAT RESET.

  FORMAT COLOR COL_NEGATIVE.

  WRITE: / 'This line uses the negative color.'.

  FORMAT RESET.

  SKIP 2.

*---------------------------------------------------------------------*
* INTENSIFIED
*---------------------------------------------------------------------*

  WRITE: / '3. INTENSIFIED'.
  ULINE.

  FORMAT INTENSIFIED ON.

  WRITE: / 'This line is displayed with intensified formatting.'.

  FORMAT RESET.

  FORMAT INTENSIFIED OFF.

  WRITE: / 'This line uses non-intensified formatting.'.

  FORMAT RESET.

  SKIP 2.

*---------------------------------------------------------------------*
* HOTSPOT
*---------------------------------------------------------------------*

  WRITE: / '4. HOTSPOT'.
  ULINE.

  FORMAT HOTSPOT ON.

  WRITE: / 'CLICKABLE HOTSPOT'.

  FORMAT HOTSPOT OFF.

  FORMAT RESET.

  WRITE: / 'This text is not a hotspot.'.

  SKIP 2.

*---------------------------------------------------------------------*
* INPUT
*---------------------------------------------------------------------*

  WRITE: / '5. INPUT'.
  ULINE.

  FORMAT INPUT ON.

  WRITE: / 'INPUT STYLE OUTPUT'.

  FORMAT INPUT OFF.

  FORMAT RESET.

  WRITE: / 'Normal style output'.

  SKIP 2.

*---------------------------------------------------------------------*
* INVERSE
*---------------------------------------------------------------------*

  WRITE: / '6. INVERSE'.
  ULINE.

  FORMAT INVERSE ON.

  WRITE: / 'INVERSE DISPLAY'.

  FORMAT INVERSE OFF.

  FORMAT RESET.

  WRITE: / 'Normal display'.

  SKIP 2.

*---------------------------------------------------------------------*
* COMBINED FORMAT
*---------------------------------------------------------------------*

  WRITE: / '7. COMBINED FORMAT'.
  ULINE.

  FORMAT:
    COLOR COL_HEADING,
    INTENSIFIED ON,
    HOTSPOT ON.

  WRITE: / 'COLORED + INTENSIFIED + HOTSPOT'.

  FORMAT RESET.

  SKIP 2.

*---------------------------------------------------------------------*
* FORMAT RESET
*---------------------------------------------------------------------*

  WRITE: / '8. FORMAT RESET'.
  ULINE.

  FORMAT COLOR COL_NEGATIVE INTENSIFIED ON.

  WRITE: / 'This line has special formatting.'.

  FORMAT RESET.

  WRITE: / 'Formatting has now been reset.'.

  SKIP 2.

*---------------------------------------------------------------------*
* Final Output
*---------------------------------------------------------------------*

  FORMAT COLOR COL_POSITIVE INTENSIFIED ON.

  WRITE: / 'FORMAT demonstration completed successfully.'.

  FORMAT RESET.
