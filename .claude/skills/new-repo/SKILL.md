---
name: new-repo
description: OrderFlow polyrepo yapısına yeni bir servis ya da platform reposu eklerken kullan. Standart iskeleti (README, Makefile, Dockerfile, .gitlab-ci.yml, CLAUDE.md, şablonlar) oluşturur. "yeni repo", "servis iskeleti", "repo aç" denince tetiklenir.
argument-hint: <subgroup/repo-adı — ör. commerce/inventory-service>
disable-model-invocation: true
---

# Yeni repo iskeleti: $ARGUMENTS

Kaynak dosyalar handbook reposunda: `../handbook` (yerelde yoksa yolunu sor).

1. Repo türünü sor: backend servisi (ADR-001'deki dil), Python AI servisi, frontend, platform (yalnız YAML/IaC).
2. Şu dosyaları oluştur (türe uygun içerikle):
   - `README.md` — amaç (1 paragraf), mimarideki yeri, endpoint/event tablosu, `make` komutları
   - `.gitignore` — dile uygun + mutlaka `.env`, `.env.local`, `.claude/settings.local.json`
   - `.editorconfig`, `.env.example`, `LICENSE` (Apache-2.0)
   - `Makefile` — `up`, `down`, `run`, `test`, `lint`, `fmt`, `build`, `docker`
   - `Dockerfile` — multi-stage, non-root, healthcheck
   - `.gitlab-ci.yml` — sadece `include: - project: order-flow-group/platform/ci-templates` + değişkenler
   - `CLAUDE.md` — `../handbook/templates/CLAUDE.service.md` kopyası, `{{...}}` alanları doldurulmuş
     (handbook'un kendi CLAUDE.md'sini KOPYALAMA; o sadece handbook için)
   - `.claude/` ve `.gitlab/` — `../handbook/.claude` ve `../handbook/.gitlab` kopyası
3. Backend servisiyse `/health/live`, `/health/ready`, `/metrics` endpoint'lerini ve testlerini ekle.
4. `local-dev/compose.yaml`'a eklenecek servis bloğunu ayrıca göster (o repo ayrı; orada ayrı MR).
5. GitLab'da repo yoksa oluşturma komutunu ver ama çalıştırma:
   `glab repo create order-flow-group/$ARGUMENTS --defaultBranch main`
   ve push mirror ile protected branch ayarlarını hatırlat.
