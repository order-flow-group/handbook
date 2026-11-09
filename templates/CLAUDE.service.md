# OrderFlow — {{REPO_ADI}}

> Servis repoları için CLAUDE.md şablonu. `/new-repo` bunu kopyalar ve `{{...}}` alanlarını doldurur.
> Doldurduktan sonra dosyada `{{` kalmamalı. Kalıcı bir kural öğrendiğinde buraya ekle.

## Proje
OrderFlow, Trendyol benzeri bir sipariş akışının açık kaynak demosu: mikroservisler
(order, inventory, payment), event'ler (RabbitMQ), AI agent'ları, RAG ve MCP. Amaç öğrenmek,
ölçmek ve makale yazmak. Polyrepo, GitLab'da `order-flow-group` altında; GitHub sadece ayna.

Bu repo: **{{REPO_ADI}}** — {{TEK_CÜMLE_GÖREVİ}}
Sözleşmeler: `order-flow-group/platform/contracts`, yerelde `../contracts` (OpenAPI + AsyncAPI).
Tek doğru kaynak orası.

## Geliştirici hakkında
Junior geliştiriciyim ve öğrenmek için buradayım.
- Yeni bir pattern kullandığında 3–5 cümleyle NEDEN'ini ve alternatifini açıkla.
- **Çekirdek kodu ben yazarım:** outbox tablosu + publisher, saga adımları ve telafileri,
  idempotency kontrolü (Idempotency-Key ve consumer tarafı), stok rezervasyonu.
  Bu kodlara gelince DUR: iskeleti ve testleri hazırla, çekirdeği bana bırak, sonra review et.
  Bir skill'in çağrılması bu kuralı kaldırmaz; sadece "çekirdeği sen yaz" dersem yazarsın.
- `size:L` (yaklaşık 1 günlük) işlerde kod yazmadan önce plan sun ve onayımı bekle.

## Komutlar
- `make up` / `make down` — local-dev compose
- `make test` — birim + entegrasyon testleri (Testcontainers)
- `make lint` — {{LINTER}}
- `make fmt` — {{FORMATTER}}
- `make run` — servisi lokal çalıştır
Bir değişikliği bitmiş saymadan önce `make lint test` çalıştır ve sonucu göster.

## Mimari kurallar
- Database-per-service. Başka servisin DB'sine asla bağlanma.
- Servisler arası senkron çağrı sadece contracts'taki OpenAPI ile, asenkron iletişim AsyncAPI'deki
  event'lerle. Sözleşmede olmayan alan ekleme — önce contracts'a MR.
- Event yayınlama sadece outbox ile: outbox satırı iş verisiyle aynı DB transaction'ında yazılır.
  Teslimat at-least-once, sıra garantisi yok.
- Her consumer idempotent: event id unique kısıtla, iş değişikliğiyle aynı transaction'da kaydedilir
  ("önce SELECT sonra işle" değil); ack commit'ten sonra. Sınırlı retry, sonra DLQ.
- Durum değiştiren POST'lar `Idempotency-Key` destekler; anahtar iş verisiyle aynı transaction'da
  saklanır. Zorunluluk, çakışma yanıtı ve saklama süresi contracts'ta tanımlı.
- Ağ çağrılarında (servisler arası, 3. parti, LLM) timeout + circuit breaker. Retry sadece geçici
  hatada (timeout, 5xx, 429) ve idempotent çağrıda (POST için aynı Idempotency-Key ile);
  sınırlı deneme, exponential backoff + jitter.
- Event şeması geriye uyumlu evrilir; breaking değişiklik = yeni sürüm + contracts MR.
- Health: `/health/live` (süreç ayakta), `/health/ready` (sadece kendi DB/broker'ı, diğer servisler
  değil), `/metrics`.
- Loglar JSON; HTTP isteği ya da mesaj işleyen her satırda `correlation_id` (header ve event
  envelope ile taşınır). Secret, TCKN, IBAN, telefon, e-posta, adres ve kart verisi log, trace ve
  LLM prompt'una gitmez.
- Konfigürasyon env değişkenleriyle; örnekler `.env.example`'da. `.env` asla commit edilmez.

## Kod stili
- Dil: {{.NET 10 | Go | Python 3.12}}. {{Dile özel kurallar}}
- Küçük fonksiyonlar, açık isimler, SOLID; gereksiz soyutlama yok.
- Her yeni davranışa test. Hata yolu testleri happy path kadar önemli.

## Git ve iş akışı
- Ana platform GitLab; GitLab işleri için `glab` kullan. GitHub sadece ayna: oraya push etme, PR açma.
- Branch adı: `<issue-no>-<kısa-açıklama>` (ör. `12-post-orders`).
- Commit: Conventional Commits (`feat(order): ...`, `fix:`, `chore:`, `docs:`, `test:`).
- `main` korumalı; sadece MR + yeşil pipeline + squash merge.
- MR açıklaması `Closes #N` içerir ve `.gitlab/merge_request_templates/default.md`'yi doldurur.
- Asla force push, `main`'e doğrudan push veya secret commit etme.

## Bilinen tuzaklar
Claude bir hatayı iki kez yaparsa buraya bir satır eklenir.
- henüz yok
