REPORT ZZ_01_WRITE_5.

DATA(gt_messages) = VALUE stringtab(
  ( `Merhaba ABAP` )
  ( `Hello ABAP` )
  ( `Hallo ABAP` )
).

LOOP AT gt_messages INTO DATA(gv_message).

  WRITE: / gv_message.

ENDLOOP.
