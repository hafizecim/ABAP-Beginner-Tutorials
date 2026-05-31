REPORT ZZ_05_VARIABLE_NAMING_CONVENTIONS.

"=========================================================
" Global Variables
"=========================================================
DATA gv_carrid  TYPE sflight-carrid.

DATA gt_sflight TYPE TABLE OF sflight.

DATA gs_sflight TYPE sflight.

"=========================================================
" Parameters
"=========================================================
PARAMETERS p_carrid TYPE sflight-carrid.

SELECT-OPTIONS s_carrid FOR gv_carrid.

"=========================================================
" Constants
"=========================================================
CONSTANTS gc_pi TYPE p VALUE '3.14'.

"=========================================================
" Local Class
"=========================================================
CLASS lcl_flight DEFINITION.

  PUBLIC SECTION.

    METHODS get_flight_data.

ENDCLASS.

CLASS lcl_flight IMPLEMENTATION.

  METHOD get_flight_data.

    DATA lv_fldate TYPE sflight-fldate.

    SELECT SINGLE carrid
                  connid
                  fldate
                  price
      FROM sflight
      INTO @gs_sflight
      WHERE carrid = @p_carrid.

    IF sy-subrc = 0.

      WRITE: / |Carrier ID : { gs_sflight-carrid }|,
             / |Connection : { gs_sflight-connid }|,
             / |Flight Date: { gs_sflight-fldate }|,
             / |Price      : { gs_sflight-price }|.

    ELSE.

      WRITE: / 'No data found'.

    ENDIF.

  ENDMETHOD.

ENDCLASS.

"=========================================================
" Start of Selection
"=========================================================
START-OF-SELECTION.

  DATA(lo_flight) = NEW lcl_flight( ).

  lo_flight->get_flight_data( ).
