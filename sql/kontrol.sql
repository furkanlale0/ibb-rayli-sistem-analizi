--kac farkli hat var? sonuc: 23
select count(distinct yolcu_verisi.hat) as hat_sayisi from yolcu_verisi;

--en kucuk ve en buyuk ay sayisi? sonuc: 1 - 12
select min(yolcu_verisi.ay) as en_kucuk_ay, max(yolcu_verisi.ay) as en_buyuk_ay from yolcu_verisi;

--bos ilce sayisi? sonuc: 416
select count(*) as bos_ilce from yolcu_verisi where ilce is null;

--bos ilceli istasyonlar? sonuc: circir dogu 365, kazimkarabekir 51
select hat, istasyon, count(*) as satir_sayisi from yolcu_verisi where ilce is null group by hat, istasyon;