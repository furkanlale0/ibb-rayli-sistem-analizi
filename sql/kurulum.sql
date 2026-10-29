-- ibb rayli sistem yolcu analizi - kurulum adimlari
-- veri: ibb acik veri portali, 2025 rayli sistemler istasyon bazli yolcu sayilari

-- 1) veritabanini olustur (terminalde):
-- createdb ibb

-- 2) csv'deki satir sonu sorununu duzelt (terminalde):
-- baslik satiri windows usulu (\r\n), veri satirlari linux usulu (\n) bitiyordu
-- sed -i 's/\r$//' data/2025_rayli_sistem.csv

-- 3) tabloyu olustur
-- not: sutun sirasi csv ile ayni olmali, \copy isme degil siraya bakar
-- not: boylam ve enlem bozuk geldigi icin (ornek: 289.335.555.555.556) simdilik text
create table yolcu_verisi (
    id integer,
    yil integer,
    ay integer,
    gun integer,
    hat text,
    istasyon text,
    istasyon_kodu text,
    ilce text,
    boylam text,
    enlem text,
    yolculuk integer,
    yolcu integer
);

-- 4) csv'yi tabloya yukle (psql icinde, proje klasorunden):
-- \copy yolcu_verisi from 'data/2025_rayli_sistem.csv' csv header
-- sonuc: copy 135783