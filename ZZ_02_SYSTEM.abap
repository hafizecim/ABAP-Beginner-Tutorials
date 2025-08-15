
* **SY-CPAGE** – Holds Current Page Number → **Geçerli sayfa numarasını tutar**
* **SY-DBSYS** – System DB System → **Sistem veritabanı türü**
* **SY-DYNNR** – Number of Current Screen → **Geçerli ekran numarası**
* **SY-INDEX** – Number Of Loop passes → **Döngü sayacı (kaç tur döndüğünü gösterir)**
* **SY-LANGU** – SAP Log on Language Key → **SAP oturum dili**
* **SY-LILLI** – Number Of Current List Line → **Geçerli listede seçili satır numarası**
* **SY-LINCT** – Number Of List Lines → **Listedeki toplam satır sayısı**
* **SY-LINNO** – Current Line for List Creation → **Liste oluşturmadaki geçerli satır**
* **SY-LINSZ** – Line Size of List → **Liste satır genişliği (karakter)**
* **SY-LISEL** – Selected Line For Interactive List → **Etkileşimli listede seçili satır**
* **SY-LSIND** – Number Of Secondary List → **İkincil listenin numarası**
* **SY-CPROG** – Contains Program Name → **Program adını tutar**
* **SY-MANDT** – Client Number For SAP Log On → **SAP istemci numarası**
* **SY-MSGID** – Message ID → **Mesaj kimliği**
* **SY-MSGTY** – Message Type → **Mesaj tipi (I, E, W vb.)**
* **SY-MSGNO** – Message Number → **Mesaj numarası**
* **SY-MSGV1** – Message Variable1 → **Mesaj değişkeni 1**
* **SY-MSGV2** – Message Variable2 → **Mesaj değişkeni 2**
* **SY-MSGV3** – Message Variable3 → **Mesaj değişkeni 3**
* **SY-MSGV4** – Message Variable4 → **Mesaj değişkeni 4**
* **SY-OPSYS** – Operating System → **İşletim sistemi**
* **SY-PAART** – Print Format → **Yazdırma formatı**
* **SY-CUCOL** – Cursor Position (Column) → **İmlecin sütun pozisyonu**
* **SY-DBNAM** – Logical DB for ABAP/4 Program → **ABAP programı için mantıksal veritabanı adı**
* **SY-DYNNR** – Current Screen Number → **Geçerli ekran numarası**
* **SY-REPID** – Report Name → **Rapor adı**

* **SY-PAGCT** – Page Size of List in Report Program → **Rapor programındaki liste sayfa boyutu**
* **SY-PAGNO** – Current Page in the List → **Listedeki geçerli sayfa numarası**
* **SY-PDEST** – Print Output Device → **Yazdırma çıkış cihazı**
* **SY-PFKEY** – Run time Current F key Status → **Çalışma anındaki fonksiyon tuşu durumu**
* **SY-REPID** – Report Name in ABAP → **ABAP programının (raporun) adı**
* **SY-SAPRL** – SAP Release → **SAP sürümü**
* **SY-SUBRC** – Return Value after specific ABAP Statement → **Belirli ABAP komutundan dönen değer (başarı/hata kodu)**
* **SY-SYSID** – SAP system ID → **SAP sistem kimliği**
* **SY-TABIX** – Current line of Internal Table → **İç tablodaki geçerli satır numarası**
* **SY-TCODE** – Current Transaction Code → **Geçerli işlem kodu**
* **SY-CUROW** – Cursor Position (Line) → **İmlecin satır pozisyonu**
* **SY-TIMLO** – Local Time Of User → **Kullanıcının yerel saati**
* **SY-TITLE** – Title of ABAP Program → **ABAP program başlığı**
* **SY-TMAXL** – Maximum entries in an Internal Table → **Bir iç tablodaki maksimum kayıt sayısı**
* **SY-TNAME** – Name Of Internal Table after first Access → **İlk erişimden sonra iç tablonun adı**
* **SY-UCOMM** – Interact: Command field Function entry / Function code → **Kullanıcı komut alanı (fonksiyon kodu)**
* **SY-ULINE** – Underline → **Alt çizgi (listeleme)**
* **SY-UNAME** – Session: SAP user from Log On → **Oturum açan kullanıcı adı**
* **SY-UZEIT** – System Time → **Sistem saati**
* **SY-VLINE** – Vertical Bar → **Dikey çizgi (listeleme)**
* **SY-DATLO** – Local Date for User → **Kullanıcının yerel tarihi**
* **SY-DATUM** – System Date → **Sistem tarihi**
* **SY-DATUD** – Global Date Related To UTC (GMT) → **UTC’ye göre global tarih**
* **SY-DBCNT** – Number of entries read by DB Operation → **Veritabanı işlemi ile okunan kayıt sayısı**
* **SY-DBCNTL** – Number of entries read by DB Operation in List → **Listede veritabanı işlemi ile okunan kayıt sayısı**
* **SY-DBSQL** – SQL Statement → **SQL ifadesi**
* **SY-DBVER** – Database Version → **Veritabanı sürümü**
* **SY-DBKEY** – Database Key → **Veritabanı anahtarı
* **SY-DBTAB** – Database Table Name → **Veritabanı tablosu adı**
* **SY-DBTYP** – Database Type → **Veritabanı türü**

REPORT ZZ_02_SYSTEM.

DATA: lt_vars TYPE TABLE OF string,
      lv_line TYPE string.

APPEND 'SY-CPAGE  - Geçerli sayfa numarası' TO lt_vars.
APPEND 'SY-DBSYS  - Sistem veritabanı türü' TO lt_vars.
APPEND 'SY-DYNNR  - Geçerli ekran numarası' TO lt_vars.
APPEND 'SY-INDEX  - Döngü sayacı' TO lt_vars.
APPEND 'SY-LANGU  - SAP oturum dili' TO lt_vars.
APPEND 'SY-LILLI  - Geçerli listedeki satır numarası' TO lt_vars.
APPEND 'SY-LINCT  - Listedeki toplam satır sayısı' TO lt_vars.
APPEND 'SY-LINNO  - Liste oluşturmadaki geçerli satır' TO lt_vars.
APPEND 'SY-LINSZ  - Liste satır genişliği' TO lt_vars.
APPEND 'SY-LISEL  - Etkileşimli listede seçili satır' TO lt_vars.
APPEND 'SY-LSIND  - İkincil listenin numarası' TO lt_vars.
APPEND 'SY-CPROG  - Program adı' TO lt_vars.
APPEND 'SY-MANDT  - SAP istemci numarası' TO lt_vars.
APPEND 'SY-MSGID  - Mesaj kimliği' TO lt_vars.
APPEND 'SY-MSGTY  - Mesaj tipi' TO lt_vars.
APPEND 'SY-MSGNO  - Mesaj numarası' TO lt_vars.
APPEND 'SY-MSGV1  - Mesaj değişkeni 1' TO lt_vars.
APPEND 'SY-MSGV2  - Mesaj değişkeni 2' TO lt_vars.
APPEND 'SY-MSGV3  - Mesaj değişkeni 3' TO lt_vars.
APPEND 'SY-MSGV4  - Mesaj değişkeni 4' TO lt_vars.
APPEND 'SY-OPSYS  - İşletim sistemi' TO lt_vars.
APPEND 'SY-PAART  - Yazdırma formatı' TO lt_vars.
APPEND 'SY-CUCOL  - İmlecin sütun pozisyonu' TO lt_vars.
APPEND 'SY-DBNAM  - Mantıksal veritabanı adı' TO lt_vars.
APPEND 'SY-PAGCT  - Liste sayfa boyutu' TO lt_vars.
APPEND 'SY-PAGNO  - Listedeki geçerli sayfa numarası' TO lt_vars.
APPEND 'SY-PDEST  - Yazdırma cihazı' TO lt_vars.
APPEND 'SY-PFKEY  - Fonksiyon tuşu durumu' TO lt_vars.
APPEND 'SY-REPID  - Program (rapor) adı' TO lt_vars.
APPEND 'SY-SAPRL  - SAP sürümü' TO lt_vars.
APPEND 'SY-SUBRC  - Dönen değer (0=başarılı)' TO lt_vars.
APPEND 'SY-SYSID  - SAP sistem kimliği' TO lt_vars.
APPEND 'SY-TABIX  - İç tablodaki geçerli satır' TO lt_vars.
APPEND 'SY-TCODE  - İşlem kodu' TO lt_vars.
APPEND 'SY-CUROW  - İmlecin satır pozisyonu' TO lt_vars.
APPEND 'SY-TIMLO  - Yerel saat' TO lt_vars.
APPEND 'SY-TITLE  - Program başlığı' TO lt_vars.
APPEND 'SY-TMAXL  - İç tablo maksimum satır sayısı' TO lt_vars.
APPEND 'SY-TNAME  - İç tablonun adı' TO lt_vars.
APPEND 'SY-UCOMM  - Komut alanı' TO lt_vars.
APPEND 'SY-ULINE  - Alt çizgi' TO lt_vars.
APPEND 'SY-UNAME  - Kullanıcı adı' TO lt_vars.
APPEND 'SY-UZEIT  - Sistem saati' TO lt_vars.
APPEND 'SY-VLINE  - Dikey çizgi' TO lt_vars.
APPEND 'SY-DATLO  - Yerel tarih' TO lt_vars.
APPEND 'SY-DATUM  - Sistem tarihi' TO lt_vars.
APPEND 'SY-DATUD  - UTC global tarih' TO lt_vars.
APPEND 'SY-DBCNT  - DB’den okunan kayıt sayısı' TO lt_vars.

* Başlık kırmızı (COLOR 6)
WRITE: / '=== SAP Sistem Değişkenleri (SY-Fields) ===' COLOR 6.
ULINE.

* Listeyi renkli yazdırma
LOOP AT lt_vars INTO lv_line.
  * SY-... kısmını kırmızı, açıklamasını sarı yazdır
  WRITE: / lv_line(10) COLOR 6,  "SY-XXXXX kısmı
           lv_line+10   COLOR 3. "Açıklama kısmı
ENDLOOP.
