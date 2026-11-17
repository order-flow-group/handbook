---
name: new-repo
description: OrderFlow polyrepo yapısına yeni bir servis ya da platform reposu eklerken kullan. Standart iskeleti (README, Makefile, servis repolarında Dockerfile, .gitlab-ci.yml, CLAUDE.md, şablonlar) oluşturur. "yeni repo", "servis iskeleti", "repo aç" denince tetiklenir.
argument-hint: <subgroup/repo-adı — ör. commerce/inventory-service>
disable-model-invocation: true
---

# Yeni repo iskeleti: $ARGUMENTS

Kaynak dosyalar handbook reposunda: `../handbook` (yerelde yoksa yolunu sor).

1. Repo türünü sor. Dosya listesi türe göre değişir:
   - **Servis:** backend servisi (ADR-001'deki dil), Python AI servisi, frontend
   - **Platform:** `contracts`, `ci-templates`, `local-dev` (yalnız YAML/IaC/şema; çalışan servis yok)
   (handbook'un kendi CLAUDE.md'sini hiçbir repoya KOPYALAMA; o sadece handbook için)
2. Her iki türde ortak dosyalar:
   - `README.md` — amaç (1 paragraf), mimarideki yeri, `make` komutları
   - `.gitignore` — türe uygun + mutlaka `.env`, `.env.local`, `.claude/settings.local.json`
   - `.editorconfig`, `LICENSE` (Apache-2.0)
   - `.gitlab-ci.yml` — sadece `include: - project: order-flow-group/platform/ci-templates` + değişkenler
   - `.claude/` ve `.gitlab/` — `../handbook/.claude` ve `../handbook/.gitlab` kopyası
3. **Servis reposuysa** ek olarak:
   - `README.md`'ye endpoint/event tablosu
   - `.gitignore` — dile uygun build çıktıları
   - `.env.example`
   - `Makefile` — `up`, `down`, `run`, `test`, `lint`, `fmt`, `build`, `docker`
   - `Dockerfile` — multi-stage, non-root, healthcheck
   - `CLAUDE.md` — `../handbook/templates/CLAUDE.service.md` kopyası, `{{...}}` alanları doldurulmuş
   - Backend servisiyse `/health/live`, `/health/ready`, `/metrics` endpoint'lerini ve testlerini ekle.
   - `local-dev/compose.yaml`'a eklenecek servis bloğunu ayrıca göster (o repo ayrı; orada ayrı MR).
4. **Platform reposuysa** ek olarak:
   - `.gitignore`'a `dist/` ekle
   - `Makefile` — yalnız reponun gerçek işleri (ör. `lint`, `validate`; local-dev için `up`, `down`)
   - `Dockerfile` ve `.env.example` OLUŞTURMA
   - `CLAUDE.md` — kısa platform CLAUDE.md'si. `../handbook/templates/CLAUDE.service.md`'den yalnız
     şu bölümleri al: Proje (`Bu repo:` satırı doldurulmuş), Geliştirici hakkında (ilk madde),
     Git ve iş akışı, Kayıt alışkanlığı, Bilinen tuzaklar. Komutlar bölümünü reponun gerçek
     komutlarıyla yaz. Mimari kurallar, Kod stili ve "çekirdek kodu ben yazarım" kuralını ALMA.
     Dosyada `{{` kalmamalı.
5. GitLab'da repo yoksa oluşturma komutunu ver ama çalıştırma:
   `glab repo create order-flow-group/$ARGUMENTS --defaultBranch main`
   ve push mirror ile protected branch ayarlarını hatırlat.
