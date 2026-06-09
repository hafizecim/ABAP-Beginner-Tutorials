REPORT zz_10_string_processing.

*---------------------------------------------------------------------*
* Report : ZZ_10_STRING_PROCESSING
* Purpose: Demonstrates common string processing operations in ABAP
*---------------------------------------------------------------------*

"=========================================================
" Variable Declarations
"=========================================================
DATA:
  lv_first_text   TYPE string VALUE 'ABAP',
  lv_second_text  TYPE string VALUE 'Programming',
  lv_result_text  TYPE string.

"=========================================================
" CONCATENATE
"=========================================================
CONCATENATE lv_first_text
            lv_second_text
       INTO lv_result_text.

WRITE: / 'Concatenate (Without Separator):',
       / lv_result_text.

ULINE.

CONCATENATE lv_first_text
            lv_second_text
       INTO lv_result_text
       SEPARATED BY space.

WRITE: / 'Concatenate (With Space):',
       / lv_result_text.

ULINE.

CONCATENATE lv_first_text
            lv_second_text
       INTO lv_result_text
       SEPARATED BY '_'.

WRITE: / 'Concatenate (With Underscore):',
       / lv_result_text.

ULINE.

"=========================================================
" CONDENSE
"=========================================================
DATA(lv_text_with_spaces) = 'ABAP     Programming'.

CONDENSE lv_text_with_spaces NO-GAPS.

WRITE: / 'Condense (Remove All Spaces):',
       / lv_text_with_spaces.

ULINE.

"=========================================================
" STRLEN
"=========================================================
DATA(lv_text_length) = strlen( lv_second_text ).

WRITE: / 'String Length:',
       / lv_text_length.

ULINE.

"=========================================================
" REPLACE
"=========================================================
DATA(lv_replace_text) = 'ABAP Programming'.

REPLACE 'Programming'
   IN lv_replace_text
 WITH 'Development'.

WRITE: / 'Replace:',
       / lv_replace_text.

ULINE.

"=========================================================
" SEARCH
"=========================================================
DATA(lv_search_text) = 'ABAP Programming'.

DATA(lv_position) =
  search(
      val = lv_search_text
      sub = 'Programming' ).

IF lv_position > 0.

  WRITE: / 'Search Function:',
         / |Found at position { lv_position }|.

ELSE.

  WRITE: / 'Search Function:',
         / 'Text not found'.

ENDIF.

ULINE.

SEARCH lv_search_text FOR 'ing'.

WRITE: / 'Classic SEARCH:',
       / |SY-SUBRC = { sy-subrc }|,
       / |SY-FDPOS = { sy-fdpos }|.

ULINE.

SEARCH lv_search_text
   FOR 'Progm'
   ABBREVIATED.

WRITE: / 'SEARCH ABBREVIATED:',
       / |SY-SUBRC = { sy-subrc }|,
       / |SY-FDPOS = { sy-fdpos }|.

ULINE.

"=========================================================
" SHIFT
"=========================================================
DATA(lv_shift_text) = '0123450'.

SHIFT lv_shift_text BY 2 PLACES.

WRITE: / 'SHIFT BY 2:',
       / lv_shift_text.

SHIFT lv_shift_text LEFT BY 1 PLACES.

WRITE: / 'SHIFT LEFT:',
       / lv_shift_text.

SHIFT lv_shift_text RIGHT BY 1 PLACES.

WRITE: / 'SHIFT RIGHT:',
       / lv_shift_text.

SHIFT lv_shift_text UP TO '3' RIGHT CIRCULAR.

WRITE: / 'SHIFT RIGHT CIRCULAR:',
       / lv_shift_text.

SHIFT lv_shift_text LEFT DELETE LEADING '0'.

WRITE: / 'DELETE LEADING ZEROS:',
       / lv_shift_text.

SHIFT lv_shift_text RIGHT DELETE TRAILING '0'.

WRITE: / 'DELETE TRAILING ZEROS:',
       / lv_shift_text.

ULINE.

"=========================================================
" SPLIT
"=========================================================
DATA(lv_csv_text) = 'ABAP,Programming,Development'.

DATA lt_parts TYPE TABLE OF string.

SPLIT lv_csv_text
   AT ','
 INTO TABLE lt_parts.

WRITE: / 'Split Result:'.

LOOP AT lt_parts INTO DATA(lv_part).

  WRITE: / lv_part.

ENDLOOP.

ULINE.

"=========================================================
" TRANSLATE
"=========================================================
DATA(lv_translate_text) = 'ABAP Programming'.

TRANSLATE lv_translate_text TO UPPER CASE.

WRITE: / 'Upper Case:',
       / lv_translate_text.

TRANSLATE lv_translate_text TO LOWER CASE.

WRITE: / 'Lower Case:',
       / lv_translate_text.

TRANSLATE lv_translate_text USING 'aA'.

WRITE: / 'Using aA:',
       / lv_translate_text.

ULINE.

"=========================================================
" SUBSTRING
"=========================================================
DATA(lv_source_text) = 'ABAP Programming'.

DATA(lv_substring_1) = lv_source_text+5(11).
DATA(lv_substring_2) = lv_source_text+5.
DATA(lv_substring_3) = lv_source_text(4).

WRITE: / 'Substring 1:',
       / lv_substring_1.

WRITE: / 'Substring 2:',
       / lv_substring_2.

WRITE: / 'Substring 3:',
       / lv_substring_3.

ULINE.

"=========================================================
" End of Program
"=========================================================
WRITE: / 'Program completed successfully'.
