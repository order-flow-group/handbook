---
name: write-article
description: OrderFlow'daki bir deney ya da benchmark'tan Medium/LinkedIn makalesi taslağı çıkarmak için kullan. Rakam yoksa yazmaz; önce ölçümü ister. "makale yaz", "blog taslağı", "LinkedIn postu" denince tetiklenir.
argument-hint: <makale numarası ya da konu — ör. "#5 overselling">
---

# Makale taslağı: $ARGUMENTS

> `<handbook>` = handbook reposunun kökü: şu an handbook reposundaysan `.`, başka bir repodaysan `../handbook`. Klasör yoksa oluştur.

Kural: Her makale bir ölçüme dayanır. Rakam olmadan taslak yazma.

1. `<handbook>/benchmarks/` ve ilgili reponun `bench/` klasöründe sonuçları ara.
   Yoksa DUR ve şunu öner: hangi senaryo, hangi araç (k6, eval runner), hangi metrikler,
   kaç tekrar. Ölçüm planını issue metni olarak yaz.
2. Varsa şu iskeletle `<handbook>/articles/NN-kebab-baslik.md` taslağı oluştur:
   - **Başlık:** soru ya da sonuç içeren, rakamlı (ör. "3 yöntemle overselling: p99'u 4 kat düşüren tercih")
   - **Kanca (2–3 cümle):** gerçek dünya problemi (Trendyol kampanya günü vb.)
   - **Kurulum:** mimari, donanım, versiyonlar, veri boyutu — tekrarlanabilir olsun
   - **Seçenekler:** her biri için kısa kod parçası (en fazla 15 satır)
   - **Sonuçlar:** tablo + bir grafik önerisi; rakamlar sonuç dosyasından birebir
   - **Yorum:** neden böyle çıktı, hangi durumda hangisi
   - **Sınırlar:** ölçümün zayıf yanları
   - **Kod:** GitHub aynası linki
3. Ayrıca 1300 karakteri geçmeyen bir LinkedIn postu yaz: ilk satır kanca, 3 madde bulgu,
   1 soru ile bitir. Emoji kullanma, en fazla 3 hashtag.
4. Rakamları uydurma; her rakamın hangi dosyadan geldiğini taslakta yorum olarak belirt.
