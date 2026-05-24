REPORT ZZ_17_MODIFY_DELETE_TABLE.

*----------------------------------------------------------------------
* Program : ZZ_17_MODIFY_DELETE_TABLE
* Konu    : MODIFY ve DELETE Kullanımı
* Açıklama:
*   Bu program ABAP'ta internal table üzerinde veri güncelleme
*   ve silme işlemlerini göstermektedir.
*
* İçerik:
*   - Internal table oluşturma
*   - APPEND ile veri ekleme
*   - MODIFY kullanımı
*   - DELETE kullanımı
*   - LOOP AT ile sonuçları görüntüleme
*---------------------------------------------------------------------*

*----------------------------------------------------------------------*
* Structure Tanımı
*----------------------------------------------------------------------*
TYPES: BEGIN OF ty_product,
         product_id TYPE i,
         product_name TYPE string,
         category TYPE string,
         price TYPE p DECIMALS 2,
       END OF ty_product.

*----------------------------------------------------------------------*
* Internal Table ve Work Area Tanımı
*----------------------------------------------------------------------*
DATA: gt_products TYPE TABLE OF ty_product,
      gs_product  TYPE ty_product.

*----------------------------------------------------------------------*
* 1) Ürün Verisi
*----------------------------------------------------------------------*
gs_product-product_id   = 1.
gs_product-product_name = 'Laptop'.
gs_product-category     = 'Technology'.
gs_product-price        = '45000'.

APPEND gs_product TO gt_products.

*----------------------------------------------------------------------*
* 2) Ürün Verisi
*----------------------------------------------------------------------*
gs_product-product_id   = 2.
gs_product-product_name = 'Phone'.
gs_product-category     = 'Technology'.
gs_product-price        = '30000'.

APPEND gs_product TO gt_products.

*----------------------------------------------------------------------*
* 3) Ürün Verisi
*----------------------------------------------------------------------*
gs_product-product_id   = 3.
gs_product-product_name = 'Chair'.
gs_product-category     = 'Furniture'.
gs_product-price        = '5000'.

APPEND gs_product TO gt_products.

*----------------------------------------------------------------------*
* MODIFY Kullanımı
* product_id = 2 olan kaydı güncelleme
*----------------------------------------------------------------------*
READ TABLE gt_products
INTO gs_product
WITH KEY product_id = 2.

IF sy-subrc = 0.

  gs_product-price = '35000'.

  MODIFY gt_products FROM gs_product INDEX sy-tabix.

  WRITE: / 'Product Updated Successfully!'.

ELSE.

  WRITE: / 'Product Not Found!'.

ENDIF.

WRITE: / '--------------------------------
