REPORT ZZ_06_ABAP_SHORTCUT.

*---------------------------------------------------------------------
* Report: ZZ_06_ABAP_SHORTCUT
* Açıklama: ABAP Editör Kısayolları ve Debug Örnekleri
*---------------------------------------------------------------------

DATA: lv_integer TYPE i. 

*---------------------------------------------------------------------
* ABAP Editör Kısayolları
*---------------------------------------------------------------------
" CTRL+D        : İmleçteki satırı altına çoğaltır
" CTRL+<        : Seçili satırı yorum satırına dönüştürür
" CTRL+SHIFT+<  : Yorum satırını tekrar aktif hale getirir
" CTRL+F2       : Syntax (yazım) hatalarını kontrol eder
" CTRL+F8       : Programı çalıştırır
" CTRL+SPACE    : Değişken veya komut yazarken otomatik tamamlama
" F1            : Seçili ABAP komutu için yardım ekranını açar
" CTRL+F        : Arama yapar
" CTRL+H        : Arama ve değiştirme işlemi yapar
" CTRL+Z        : Geri al (undo)
" CTRL+Y        : Geri alınanı tekrar uygular (redo)
" CTRL+SHIFT+F  : Kod formatlama (auto-format)
" CTRL+SHIFT+I  : Satırı girintiler (indent)
" CTRL+SHIFT+U  : Satırı girintiden çıkar (outdent)
" CTRL+SHIFT+S  : Programı kaydeder
" CTRL+SHIFT+N  : Yeni ABAP programı oluşturur
" CTRL+SHIFT+O  : Açık programları listeler

*---------------------------------------------------------------------
* ABAP Debug Kısayolları
*---------------------------------------------------------------------
" F5 (Step Into)  : Method/fonksiyon içine girer, satır satır ilerler
" F6 (Step Over)  : Fonksiyon/metoda girmez, çağrıyı tek satır çalıştırır
" F7 (Step Out)   : Mevcut method/fonksiyondan çıkar, çağıran koda döner
" F8 (Continue)   : Breakpoint’ten programın devam etmesini sağlar
" F9 (Run to Cursor) : İmlecin bulunduğu satıra kadar kodu çalıştırır
" F3 (Exit)       : Programdan çıkış yapar