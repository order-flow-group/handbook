---
name: explain-and-learn
description: Kodda geçen bir kavramı, pattern'i ya da Claude'un yazdığı bir kodu öğrenmek için kullan. Açıklar, alternatifleri karşılaştırır, küçük bir alıştırma verir ve handbook/notes altına not kaydeder. "bunu açıkla", "neden böyle", "öğret", "explain" denince tetiklenir.
argument-hint: <kavram ya da dosya:satır>
---

# Öğren: $ARGUMENTS

> `<handbook>` = handbook reposunun kökü: şu an handbook reposundaysan `.`, başka bir repodaysan `../handbook`. Klasör yoksa oluştur.

Öğretmen gibi davran; çözümü hemen verme.

1. Konuyu projedeki gerçek koddan bir örnekle bağla (dosya ve satır göster).
2. Açıklama, en fazla 3 kısa paragraf:
   - Problem: bu olmadan ne bozulur? (somut senaryo, ör. "ödeme servisi 30 sn yanıt vermezse")
   - Çözüm: nasıl çalışıyor? Gerekirse ASCII diyagram.
   - Alternatifler ve ne zaman tercih edilir.
3. Beni test et: 2 soru sor (biri kavramsal, biri "bu kodda şu satırı değiştirirsem ne olur").
   Cevaplarımı bekle, sonra düzelt.
4. Küçük bir alıştırma öner (15–30 dakika), çözümünü verme.
5. `<handbook>/notes/<kavram>.md` dosyasına özet not yaz/güncelle:
   tanım, projedeki yeri, alternatifler, öğrendiğim tuzaklar, kaynak linkleri.
