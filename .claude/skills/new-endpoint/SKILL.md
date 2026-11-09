---
name: new-endpoint
description: OrderFlow servislerine yeni bir HTTP endpoint eklerken kullan (contract-first). Önce OpenAPI sözleşmesini, sonra handler, validasyon, persistence, test ve dokümanı sırayla yazar. "endpoint ekle", "POST /x yaz", "yeni API" isteklerinde tetiklenir.
argument-hint: "<METHOD> <path> — ör. POST /orders"
---

# Yeni endpoint: $ARGUMENTS

Sıra önemlidir; atlama.

1. **Sözleşme.** `contracts/openapi/<servis>.yaml` içinde endpoint tanımlı mı? Değilse önce
   sözleşme taslağını yaz ve bana göster (request/response şeması, hata kodları, örnekler).
   Hata gövdesi her zaman RFC 9457 problem+json.
2. **Tasarım kontrolü.** Şunları cevapla:
   - Idempotent mi? POST ise `Idempotency-Key` desteği gerekli mi?
   - Hangi doğrulamalar? (boş, aralık, format)
   - Event üretiyor mu? Üretiyorsa outbox'a yazılacak, AsyncAPI'de tanımlı mı?
   - Sayfalama/filtre gerekiyor mu?
3. **Test önce.** Kabul kriterlerini karşılayan testleri yaz: 1 happy path, en az 2 hata yolu
   (400 validasyon, 404/409). Entegrasyon testi Testcontainers ile gerçek Postgres kullanır.
4. **Uygulama.** Handler → servis/uygulama katmanı → repository. İş kuralı handler'da olmaz.
   Endpoint çekirdek koda dokunuyorsa (Idempotency-Key kontrolü, outbox yazımı, saga adımı, stok
   rezervasyonu) DUR: CLAUDE.md'deki "çekirdek kodu ben yazarım" kuralı geçerli. İskeleti ve testleri
   bırak, çekirdeği geliştiriciye yazdır, sonra review et.
5. **Gözlemlenebilirlik.** Log (correlation_id), metrik (istek sayısı, süre histogramı), trace span.
6. **Doğrula.** `make lint test`; servisi çalıştırıp `curl` ile örnek istek at, çıktıyı göster.
7. **Doküman.** README'deki endpoint tablosunu ve `.http` örnek dosyasını güncelle.

Bitince: değişen dosyaların listesi + bir paragraf "bu endpoint'te neyi neden böyle yaptık".
