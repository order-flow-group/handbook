---
name: new-repo
description: OrderFlow polyrepo yapısına yeni bir servis ya da platform reposu eklerken kullan. Standart iskeleti (README, Makefile, Dockerfile, .gitlab-ci.yml, CLAUDE.md, şablonlar) oluşturur. "yeni repo", "servis iskeleti", "repo aç" denince tetiklenir.
argument-hint: <subgroup/repo-adı — ör. commerce/inventory-service>
disable-model-invocation: true
---

# Yeni repo iskeleti: $ARGUMENTS

1. Repo türünü sor: backend servisi (ADR-001'deki dil), Python AI servisi, frontend, platform (yalnız YAML/IaC).
2. Şu dosyaları oluştur (türe uygun içerikle):
   - `README.md` — amaç (1 paragraf), mimarideki yeri, endpoint/event tablosu, `make` komutları
   - `.gitignore`, `.editorconfig`, `.env.example`, `LICENSE` (Apache-2.0)
   - `Makefile` — `up`, `down`, `run`, `test`, `lint`, `fmt`, `build`, `docker`
   - `Dockerfile` — multi-stage, non-root, healthcheck
   - `.gitlab-ci.yml` — sadece `include: - project: orderflow/platform/ci-templates` + değişkenler
   - `CLAUDE.md` — handbook'taki şablondan, `{{...}}` alanları doldurulmuş
   - `.claude/` — handbook'tan kopya (settings.json, skills, agents, hooks)
   - `.gitlab/issue_templates/` ve `.gitlab/merge_request_templates/` — handbook'tan kopya
   - `CODEOWNERS` — `* @<gitlab-kullanıcı-adın>`
3. Backend servisiyse `/health/live`, `/health/ready`, `/metrics` endpoint'lerini ve testlerini ekle.
4. `local-dev/compose.yaml`'a eklenecek servis bloğunu ayrıca göster (o repo ayrı olduğu için orada ayrı MR).
5. GitLab'da repoyu oluşturmak için komutları ver ama çalıştırma:
   `glab repo create orderflow/$ARGUMENTS --private=false --defaultBranch main`
   ve push mirror ile protected branch ayarlarını hatırlat.
