REPORT ZZ_01_WRITE_4.

DATA:
  gt_messages TYPE TABLE OF string,
  gv_message  TYPE string.

APPEND 'Merhaba ABAP' TO gt_messages.
APPEND 'Hello ABAP'   TO gt_messages.
APPEND 'Hallo ABAP'   TO gt_messages.

LOOP AT gt_messages INTO gv_message.

  WRITE: / gv_message.

ENDLOOP.
