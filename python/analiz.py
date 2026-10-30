import pandas as pd

df = pd.read_csv("data/2025_rayli_sistem.csv")

# print(df.shape)
# print(df.columns)
# print(df.head())

# Her hattin toplam yolculugu
# SQL: select line, sum(passage_cnt) from tablo group by line;
hat_toplam = df.groupby("line")["passage_cnt"].sum()
#print(hat_toplam)

# En kalabalik 5 hat
# SQL: ... order by toplam desc limit 5;
en_kalabalik = hat_toplam.sort_values(ascending=False).head(5)
#print(en_kalabalik)

# Her ayin toplam yolculugu
# SQL: select transaction_month, sum(passage_cnt) from tablo group by transaction_month;
ay_toplam = df.groupby("transaction_month")["passage_cnt"].sum()
#print(ay_toplam)

# 1) Her hattin kac farkli istasyonu var?
# nunique = farkli deger sayisi (SQL: count(distinct station_name))
istasyon_sayisi = df.groupby("line")["station_name"].nunique()

# 2) Ikisini de tabloya cevir (merge tablo ister)
# reset_index = "line" yan bilgi olmaktan cikip normal bir sutun olur
yolculuk_tablo = hat_toplam.reset_index()
istasyon_tablo = istasyon_sayisi.reset_index()

# 3) Birlestir
# SQL: ... join istasyon_tablo on yolculuk_tablo.line = istasyon_tablo.line
birlesik = pd.merge(yolculuk_tablo, istasyon_tablo, on="line")

# 4) Yeni sutun: istasyon basina yolculuk
birlesik["istasyon_basina"] = birlesik["passage_cnt"] // birlesik["station_name"]

# Istasyon bilgisi olmayan hatlari cikar (0'a bolme -> inf)
birlesik = birlesik[birlesik["station_name"] > 0]
# 5) Buyukten kucuge sirala, ilk 5
print(birlesik.sort_values("istasyon_basina", ascending=False).head(5))