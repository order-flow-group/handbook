---
name: adr
description: Bir mimari ya da teknoloji kararı verirken Architecture Decision Record (ADR) yazmak için kullan. Seçenekleri ölçülebilir kriterlerle karşılaştırır ve handbook/adr altına numaralı dosya oluşturur. "ADR yaz", "karar kaydı", "X mi Y mi seçelim" denince tetiklenir.
argument-hint: <karar konusu — ör. "backend dili: .NET 10 vs Go">
---

# ADR: $ARGUMENTS

> `<handbook>` = handbook reposunun kökü: şu an handbook reposundaysan `.`, başka bir repodaysan `../handbook`. Klasör yoksa oluştur.

1. `<handbook>/adr/` içindeki en büyük numarayı bul, bir sonrakini kullan (`NNN-kebab-baslik.md`).
2. Karar vermeden önce bana 3–5 soru sor (deneyimim, zaman, hedef iş ilanları, kısıtlar).
3. [template.md](template.md) şablonunu doldur. Kurallar:
   - En az 2, en fazla 4 seçenek.
   - Kriterler ölçülebilir ya da gözlemlenebilir olsun (öğrenme süresi, image boyutu, ekosistem,
     Türkiye iş ilanlarındaki yaygınlık, ARM desteği...).
   - Her seçeneğin olumsuz tarafını da yaz.
   - Bilmediğin bir rakamı uydurma; "ölçülecek" yaz ve bir spike issue öner.
4. Durumu `Önerildi` olarak yaz; ben onaylayınca `Kabul edildi` yap.
