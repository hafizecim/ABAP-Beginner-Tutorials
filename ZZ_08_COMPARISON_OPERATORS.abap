REPORT ZZ_08_COMPARISON_OPERATORS.

DATA: opr1 type i value 13,
      opr2 type i value 8.


*---------------------------------------------------------------------
* Comparison Operators / Karşılaştırma Operatörleri
*---------------------------------------------------------------------

if opr1 = opr2. " eq ( equal) )
  WRITE:  'OPR1 is equal OPR2'.   
  ULINE.
endif.

if opr1 <> opr2. " ne (  not equal) )
  WRITE:  'OPR1 is not equal OPR2'.   
  ULINE.
endif.

if opr1 < opr2. " lt (less than) )
    WRITE:  'OPR1 is less than OPR2'.
  ULINE.
endif.

if opr1 > opr2. " gt (greater than) )
    WRITE:  'OPR1 is greater than OPR2'.
  ULINE.
endif.

if opr1 <= opr2. " le (less than or equal to) )
    WRITE:  'OPR1 is less than or equal to OPR2'.
  ULINE.
endif.

if opr1 >= opr2. " ge (greater than or equal to) )
    WRITE:  'OPR1 is greater than or equal to OPR2'.
  ULINE.
endif.



*---------------------------------------------------------------------
* Logical Operators / Mantıksal Operatörler
*---------------------------------------------------------------------

if opr1 = 13 and opr2 = 8. " and (logical AND) )
  WRITE:  'OPR1 is equal to 13 and OPR2 is equal to 8'.
  ULINE.
endif.

if opr1 = 13 or opr2 = 8. " or (logical OR) )
  WRITE:  'OPR1 is equal to 13 or OPR2 is equal to 8'.
  ULINE.
endif.

if not opr1 = 13. " not (logical NOT) )
  WRITE:  'OPR1 is not equal to 13'.
  ULINE.
endif.

if opr1 = 13 and not opr2 = 8. " and with not (logical AND with NOT) )
  WRITE:  'OPR1 is equal to 13 and OPR2 is not equal to 8'.
  ULINE.
endif.

if opr1 = 13 or not opr2 = 8. " or with not (logical OR with NOT) )
  WRITE:  'OPR1 is equal to 13 or OPR2 is not equal to 8'.
  ULINE.
endif.

if opr1 = 13 and opr2 = 8 or opr1 > 10. " complex condition with AND and OR )
  WRITE:  'OPR1 is equal to 13 and OPR2 is equal to 8 or OPR1 is greater than 10'.
  ULINE.
endif.

if opr1 = 13 and (opr2 = 8 or opr2 < 10). " complex condition with parentheses )
  WRITE:  'OPR1 is equal to 13 and OPR2 is either equal to 8 or less than 10'.
  ULINE.
endif.

if opr1 = 13 and (opr2 = 8 or opr2 < 10) and not opr1 > 20. " complex condition with parentheses and NOT )
  WRITE:  'OPR1 is equal to 13, OPR2 is either equal to 8 or less than 10, and OPR1 is not greater than 20'.
  ULINE.
endif.
