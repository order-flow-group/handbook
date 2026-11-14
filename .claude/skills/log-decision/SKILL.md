---
name: log-decision
description: Projede bir karar verildiği anda (teknoloji, ayar, yöntem, yapı) karar defterine kısa bir giriş eklemek için kullan. "karar defterine ekle", "bu kararı kaydet", "neden böyle yaptık not al", "log decision" denince tetiklenir. Bir oturumda bir ayar ya da yöntem seçildiyse sonunda bunu kullanmayı öner.
argument-hint: <karar — ör. "squash + fast-forward merge">
---

# Karar kaydet: $ARGUMENTS

> `<handbook>` = handbook reposunun kökü: şu an handbook reposundaysan `.`, başka bir repodaysan `../handbook`.

Amaç: Kararın nedeni, alternatifi ve bedeli verildiği anda kayda geçsin; aylar sonra okuyan biri (geliştiricinin kendisi dahil) kararı tek cümleden anlayabilsin.

1. `<handbook>/notes/karar-defteri.md` dosyasını oku. En büyük `K-NN` numarasını bul, bir sonrakini kullan. Aynı karar zaten varsa yeni giriş açma, mevcut girişi güncelle.
2. Geliştiriciye en fazla 3 kısa soru sor (cevabı oturumdan zaten biliyorsan sorma):
   - Neden bu seçildi?
   - Hangi alternatif vardı?
   - Bunun bedeli ne?
3. Girişi dosyanın ilgili bölümüne (Platform / Git / Planlama / Teknoloji / AI) şablona göre ekle:
   ```
   ### K-NN · <karar> (<gün Ay>)
   - **Neden:**
   - **Alternatif:**
   - **Bedeli:**
   - **Özet:** "<birinci tekil şahıs, tek cümle, 30 kelimeyi geçmeyen>"
   ```
   Özet ayar ekranlarını değil, nedeni ve ödünleşimi anlatsın.
4. Karar büyükse (geri dönmesi zor, birden fazla repoyu etkiliyor) ADR yazmayı öner (`/adr`) ve girişe ADR numarasını yaz.
5. Karar bir makale konusu olabiliyorsa `<handbook>/articles/BACKLOG.md`'ye ilgili faz altında 💡 satırı ekle.
6. Geliştiriciden özeti bir kez kendi kelimeleriyle söylemesini iste; daha iyi bir ifade çıkarsa girişe işle.
Commit etme; değişiklik o anki issue'nun branch'ine girer.
