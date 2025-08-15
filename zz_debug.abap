REPORT ZZ_DEBUG
 DATA: sflight_tt Type table of sflight
 data: sflight_sc like line of sflight
 
 Select * from sflight
 into sflight_sc
 where carrid  = 'AA'.

 APPEND sflight_sc to sflight_tt.


 endselect.


 "==============================
 " ÖRNEK VERİLERLER İLE TABLO DOLDURMA
 "==============================
 " Bu bölümde, sflight tablosuna örnek veriler ekleyeceğiz.
 " Bu veriler, programın çalışması sırasında kullanılacak.
 " SE38 : SAPBC_DATA_GENERATOR 
 " BU KISIMDA SAPBC_DATA_GENERATOR PROGRAMINI KULLANARAK SFLIGHT TABLOSUNA ÖRNEK VERİLER EKLEYEBİLİRSİNİZ.
 " STANDART DATA RECORD SEÇİLİ HALİ İLE EXECUTE EDİN.
 " ÜST MENÜ  PROGRAM -> EXECUTE IN BACKGROUND  ( BU KISMA BAK AMA YUKARIDAKİ GİBİ YÜRÜTÜLÜR )

