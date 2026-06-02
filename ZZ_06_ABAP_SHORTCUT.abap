REPORT zz_06_abap_shortcut.

*---------------------------------------------------------------------
* Report : ZZ_06_ABAP_SHORTCUT
* Purpose: ABAP Editor Shortcuts + Debug Practice
*---------------------------------------------------------------------

"=========================================================
" Variables
"=========================================================
DATA lv_integer TYPE i VALUE 10.
DATA lv_result  TYPE i.

DATA lt_numbers TYPE TABLE OF i.

"=========================================================
" ABAP Editor Shortcuts
"=========================================================
" CTRL + D         -> Duplicate current line
" CTRL + <         -> Comment selected line
" CTRL + SHIFT + < -> Uncomment selected line
" CTRL + F2        -> Syntax check
" CTRL + F8        -> Execute program
" CTRL + SPACE     -> Auto-completion
" F1               -> ABAP keyword help
" CTRL + F         -> Search
" CTRL + H         -> Find & replace
" CTRL + Z         -> Undo
" CTRL + Y         -> Redo
" CTRL + SHIFT + F -> Auto format
" CTRL + SHIFT + I -> Indent
" CTRL + SHIFT + U -> Outdent

"=========================================================
" Debug Shortcuts
"=========================================================
" F5 -> Step Into
" F6 -> Step Over
" F7 -> Step Out
" F8 -> Continue
" F9 -> Run to Cursor
" F3 -> Exit Debugger

"=========================================================
" Simple Debug Example
"=========================================================
WRITE: / 'Program Started'.

lv_result = lv_integer * 5.

WRITE: / |Result = { lv_result }|.

" Breakpoint Example
BREAK-POINT.

"=========================================================
" Internal Table Example
"=========================================================
APPEND 10 TO lt_numbers.
APPEND 20 TO lt_numbers.
APPEND 30 TO lt_numbers.

LOOP AT lt_numbers INTO DATA(lv_number).

  BREAK-POINT.

  WRITE: / |Current Number = { lv_number }|.

ENDLOOP.

WRITE: / 'Program Finished'.
