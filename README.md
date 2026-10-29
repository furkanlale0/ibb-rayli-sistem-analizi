# İBB Raylı Sistem Yolcu Analizi

İstanbul raylı sistemlerinin (metro, tramvay, teleferik, füniküler, Marmaray) 2025 yılı
istasyon bazlı yolcu verisini PostgreSQL'e yükleyip SQL ile analiz ettiğim proje.

## Veri
- **Kaynak:** [İBB Açık Veri Portalı - Raylı Sistemler İstasyon Bazlı Yolcu ve Yolculuk Sayıları](https://data.ibb.gov.tr/en/dataset/rayli-sistemler-istasyon-bazli-yolcu-ve-yolculuk-sayilari/resource/604776d6-e99f-469c-bf25-25ccadc5e89b)
- **Kapsam:** 2025 yılı, Ocak–Aralık
- **Boyut:** 135.783 satır, 23 hat
- Her satır = bir istasyonun bir günü
- **Yolculuk:** o gün yapılan geçiş sayısı, **yolcu:** o gün gelen farklı kişi sayısı

## Kurulum
1. CSV'yi İBB portalından indirip `data/` klasörüne koy
2. `sql/kurulum.sql` dosyasındaki adımları sırayla uygula

## Dosyalar
| Dosya | Ne yapıyor |
|---|---|
| `sql/kurulum.sql` | Veritabanı, tablo ve veri yükleme adımları |
| `sql/kontrol.sql` | Yüklemeden sonra veri sağlık kontrolleri |

## Veri kalitesi notları
- **Satır sonu sorunu:** Başlık satırı Windows usulü (`\r\n`), veri satırları Linux usulü (`\n`) bitiyordu. `\copy` hata verdi, `sed` ile düzeltildi.
- **Bozuk koordinatlar:** Boylam/enlem değerleri `289.335.555.555.556` gibi geliyor (olması gereken ~28.93). Şimdilik `text` olarak yüklendi, analizde düzeltilecek.
- **Boş ilçeler:** 416 satırda ilçe boş. Hepsi M7 hattından: Çırçır Doğu (365 gün, yani hiç girilmemiş) ve Kazımkarabekir (51 gün).

## Araçlar
PostgreSQL 16, WSL2 (Ubuntu 24.04), DBeaver, Git