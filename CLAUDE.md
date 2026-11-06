# OrderFlow — handbook

> Bu dosya her Claude Code oturumunda otomatik okunur. Kısa ve doğru tut.
> Kalıcı bir kural öğrendiğinde buraya ekle.

## Proje
OrderFlow, Trendyol benzeri bir sipariş akışının açık kaynak demosu: mikroservisler
(order, inventory, payment), event'ler (RabbitMQ), AI agent'ları (saf Python, LangGraph,
LangChain), RAG ve MCP. Amaç öğrenmek, ölçmek ve makale yazmak. Polyrepo, GitLab'da
`order-flow-group` group'u altında; GitHub sadece ayna.

Bu repo: **handbook** — ADR'ler, öğrenme notları, makaleler, retrolar ve Claude kit'i.
Burada uygulama kodu yok; sadece Markdown ve script'ler.
Sözleşmeler: `order-flow-group/platform/contracts` (OpenAPI + AsyncAPI). Tek doğru kaynak orası.

## Geliştirici hakkında
Junior geliştiriciyim ve öğrenmek için buradayım. Bu yüzden:
- Yeni bir pattern (saga, outbox, idempotency, circuit breaker) kullandığında 3–5 cümleyle
  NEDEN'ini ve alternatifini açıkla.
- Saga, outbox ve idempotency çekirdeğini ben yazarım; sen review et, hataları göster,
  istemedikçe tamamını yazma.
- Kod yazmadan önce L boyutlu işlerde plan sun ve onayımı bekle.

## Klasörler
- `adr/` — mimari kararlar (`NNN-kebab-baslik.md`, `/adr` skill'i ile)
- `notes/` — öğrendiğim kavramlar (`/explain-and-learn` ile)
- `articles/` — makale taslakları (`/write-article` ile)
- `benchmarks/` — ölçüm sonuçları
- `retro/` — faz sonu retroları (`F0.md`, `F1.md`...)
- `scripts/` — GitLab label/milestone script'i
- `.claude/` — diğer repolara kopyalanan skill, agent ve ayarlar

## Mimari kurallar
- Database-per-service. Başka servisin DB'sine asla bağlanma.
- Servisler arası senkron çağrı sadece `contracts` içindeki OpenAPI ile; asenkron iletişim
  AsyncAPI'deki event'lerle. Sözleşmede olmayan alan ekleme — önce contracts'a MR.
- Event yayınlama sadece outbox üzerinden (doğrudan publish yok).
- Her consumer idempotent olmalı (event id ile tekrar kontrolü).
- POST endpoint'leri `Idempotency-Key` header'ını destekler.
- Dış çağrılarda timeout + retry (exponential backoff + jitter) + circuit breaker.
- Health: `/health/live` (süreç ayakta), `/health/ready` (bağımlılıklar hazır), `/metrics`.
- Loglar JSON, her satırda `correlation_id`. Secret, TCKN, IBAN, telefon loglanmaz.
- Konfigürasyon env değişkenleriyle; örnekler `.env.example`'da. `.env` asla commit edilmez.

## Yazım kuralları
- Yazılar Türkçe; teknik terimler (outbox, saga, idempotency) çevrilmez.
- Kısa paragraflar, somut örnekler, mümkünse rakam. Rakam uydurma; bilinmiyorsa "ölçülecek" yaz.
- Her ADR'de en az 2 seçenek ve her seçeneğin olumsuz tarafı.

## Git ve iş akışı
- Branch adı: `<issue-no>-<kısa-açıklama>` (ör. `12-post-orders`).
- Commit: Conventional Commits (`feat(order): ...`, `fix:`, `chore:`, `docs:`, `test:`).
- `main` korumalı; sadece MR + yeşil pipeline + squash merge.
- MR açıklaması `Closes #N` içerir ve `.gitlab/merge_request_templates/default.md`'yi doldurur.
- **Asla** `git push --force`, `main`'e doğrudan push veya secret commit etme.

## Bilinen tuzaklar
<!-- Claude bir hatayı iki kez yaparsa buraya bir satır ekle. -->
- henüz yok
