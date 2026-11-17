# OrderFlow — handbook

> Bu dosya her Claude Code oturumunda otomatik okunur. Kalıcı bir kural öğrendiğinde buraya ekle.

## Proje
OrderFlow, Trendyol benzeri bir sipariş akışının açık kaynak demosu: mikroservisler
(order, inventory, payment), event'ler (RabbitMQ), AI agent'ları (saf Python, LangGraph,
LangChain), RAG ve MCP. Amaç öğrenmek, ölçmek ve makale yazmak. Polyrepo, GitLab'da
`order-flow-group` altında; GitHub sadece ayna.

Bu repo: **handbook** — ADR'ler, öğrenme notları, makaleler, retrolar ve Claude kit'i.
Burada uygulama kodu ve Makefile yok; sadece Markdown ve script'ler. CI (`.gitlab-ci.yml`) iki iş
çalıştırır: runner'ı doğrulayan smoke-test ve `ci-templates`'ten include edilen secret-scan.
Sözleşmeler: `order-flow-group/platform/contracts` (OpenAPI + AsyncAPI). Tek doğru kaynak orası.
Servislerin mimari kuralları: `templates/CLAUDE.service.md`. ADR veya makale yazarken onu oku.

## Geliştirici hakkında
Junior geliştiriciyim ve öğrenmek için buradayım.
- Bir kavramı açıklarken 3–5 cümleyle NEDEN'ini ve alternatifini anlat.
- ADR ve makalelerde son kararı ben veririm; sen seçenekleri ve ödünleşimleri hazırlarsın.

## Klasörler
- `adr/` — mimari kararlar (`NNN-kebab-baslik.md`, `/adr` ile)
- `notes/` — öğrendiğim kavramlar (`/explain-and-learn` ile)
- `articles/` — makale taslakları (`/write-article` ile)
- `benchmarks/` — ölçüm sonuçları
- `retro/` — faz sonu retroları (`F0.md`, `F1.md`...)
- `notes/karar-defteri.md` — decision log: her kararın nedeni, alternatifi ve bedeli (`/log-decision` ile)
- `articles/BACKLOG.md` — makale konuları; faz sonunda `/phase-retro` buradan seçer
- `templates/` — diğer repolara kopyalanan dosyalar (servis CLAUDE.md'si)
- `scripts/`, `gitlab-import/` — GitLab kurulum script'i ve issue CSV'leri
- `.claude/`, `.gitlab/` — her repoya kopyalanan skill, agent, ayar ve şablonlar
Klasör henüz yoksa ilk dosyayla birlikte oluştur.

## Yazım kuralları
- Yazılar Türkçe; teknik terimler (outbox, saga, idempotency) çevrilmez.
- Commit mesajları ve MR başlıkları İngilizce (Conventional Commits).
- Kısa paragraflar, somut örnekler. ADR'de bilinmeyen rakam için "ölçülecek" yaz ve spike issue öner;
  makalede ise rakam yoksa yazma (`/write-article` önce ölçüm ister).
- Her ADR'de en az 2 seçenek ve her seçeneğin olumsuz tarafı.

## Kayıt alışkanlığı
- Oturumda bir ayar, yöntem ya da teknoloji seçildiyse oturum sonunda `/log-decision` öner.
- Bir faz bittiğinde `/phase-retro` öner.
- Aklıma gelen makale fikirlerini `articles/BACKLOG.md`'ye 💡 olarak ekle.

## Git ve iş akışı
- Ana platform GitLab; GitLab işleri için `glab` kullan. GitHub sadece ayna: oraya push etme, PR açma.
- Branch adı: `<issue-no>-<kısa-açıklama>` (ör. `1-adr-backend-dili`).
- Commit: Conventional Commits (`docs:`, `chore:`, `feat:`).
- `main` korumalı; sadece MR ile squash merge. MR'larda pipeline'ı (smoke-test + secret-scan) yeşil olmalı.
- Issue'lar bu repoda; MR açıklamasına `Closes #N` yaz.
- Asla force push, `main`'e doğrudan push veya secret commit etme.

## Bilinen tuzaklar
Claude bir hatayı iki kez yaparsa buraya bir satır eklenir.
- Windows'ta terminal PowerShell olabilir: `grep` yerine `Select-String`, bash script'leri için Git Bash.
