---
name: phase-retro
description: Bir faz (milestone) bittiğinde retro yazmak, öğrenilenleri toplamak ve o fazdan çıkacak 2–3 makaleyi seçmek için kullan. "faz bitti", "retro yaz", "faz değerlendirmesi", "phase retro" denince tetiklenir.
argument-hint: <faz — ör. F0>
disable-model-invocation: true
allowed-tools: Bash(glab issue list:*), Bash(glab mr list:*), Bash(git log:*), Read, Grep, Glob, Edit, Write
---

# Faz retrosu: $ARGUMENTS

> `<handbook>` = handbook reposunun kökü (handbook içindeysen `.`).

1. **Veriyi topla**
   - `glab issue list --milestone "<faz başlığı>" --all` ile kapanan ve açık issue'lar.
   - `glab mr list --merged` ile bu fazın MR'ları; açıklamalarındaki "Öğrendiklerim" bölümlerini oku.
   - `<handbook>/notes/karar-defteri.md` içinde bu fazın tarihlerine düşen kararlar.
   - Faz için tahmin edilen süre (yol haritası) ile gerçek süre: geliştiriciye sor.
2. **Retro yaz:** `<handbook>/retro/$ARGUMENTS.md`
   - Ne çıktı (issue listesi, linkler)
   - Rakamlar: issue sayısı, MR sayısı, tahmin vs gerçek saat, karşılaşılan hata sayısı
   - İyi giden 3 şey, zorlayan 3 şey
   - Bu fazda verilen kararlar (K-NN listesi)
   - Bir sonraki faza taşınan iş ve değişen plan
3. **Kararları gözden geçir:** Bu fazın kararlarından 5 tanesini seç ve geliştiriciden her birinin nedenini kendi cümleleriyle anlatmasını iste. Özeti eksik ya da belirsiz kalan girişleri birlikte netleştir.
4. **Makale seçimi:** `<handbook>/articles/BACKLOG.md`'deki bu faza ait 💡 konuları değerlendir. Elinde ölçüm ya da somut olay olan 2–3 tanesini öner (başlık + tek cümlelik soru + hammadde). Geliştirici seçince durumlarını 📝 yap ve `/write-article` ile ilkinin taslağına başla.
5. **Doküman senkronu hatırlatması:** Geliştiriciye şunu söyle: "claude.ai'daki OrderFlow projesine dön ve '<faz> bitti, dokümanları güncelle' de." Yol haritası, çalışma günlüğü ve mimari animasyonu orada güncelleniyor.

Commit etme; retro kendi issue'sunun branch'ine girer.
