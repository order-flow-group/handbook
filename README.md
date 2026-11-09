# OrderFlow handbook

OrderFlow projesinin el kitabı: mimari kararlar (ADR), öğrenme notları, makaleler, retrolar
ve her repoya kopyalanan Claude Code kit'i. Uygulama kodu diğer repolarda
(`order-flow-group/commerce`, `platform`, `ai`).

## İçerik

```
CLAUDE.md                         ← SADECE handbook için Claude talimatları
templates/CLAUDE.service.md       ← servis repolarına kopyalanan CLAUDE.md şablonu
CODEOWNERS                        ← Free planda belgeleme amaçlı
.claude/
  settings.json                   ← izinler (allow/ask/deny) + format hook'u
  hooks/format.sh                 ← her Edit/Write sonrası dosyayı formatlar (jq gerekir)
  skills/
    start-issue/                  ← /start-issue 12   → issue oku, branch aç, plan çıkar
    new-endpoint/                 ← /new-endpoint POST /orders → contract-first endpoint
    prepare-mr/                   ← /prepare-mr       → kontrol, commit, MR açıklaması, glab
    adr/ (+ template.md)          ← /adr "konu"       → adr/NNN-*.md
    write-article/                ← /write-article #5 → ölçümden makale + LinkedIn postu
    explain-and-learn/            ← /explain-and-learn outbox → öğret, test et, not al
    new-repo/                     ← /new-repo commerce/inventory-service
  agents/
    code-reviewer.md              ← MR öncesi inceleme (yalnızca rapor)
    test-writer.md                ← hata yolu + eşzamanlılık testleri
    security-auditor.md           ← secret, KVKK/PII, agent yetkileri
    contract-guardian.md          ← OpenAPI/AsyncAPI uyumu, breaking change
.gitlab/
  issue_templates/feature.md, bug.md, article.md
  merge_request_templates/default.md
scripts/create-labels.sh          ← group label'ları + F0–F8 milestone'ları (glab api)
gitlab-import/issues-faz0.csv     ← Faz 0'ın 12 issue'su, GitLab CSV import formatında
```

## Kontrol

- VS Code'da Claude paneline `/` yaz: `/start`, `/adr`, `/prepare` diye filtreleyince skill'ler görünmeli.
- Agent'lar: `/agents` sihirbazı kaldırıldı. Claude'a "code-reviewer subagent'ını kullanarak X'i incele"
  de; rapor gelirse agent'lar çalışıyor.

## Günlük kullanım

```
/start-issue 9          # plan → onay → iş
"code-reviewer ile incele"
/prepare-mr             # kontrol → commit → MR
/explain-and-learn idempotency
```

## Notlar

- Yeni repo açarken `/new-repo` kullan. Servis reposuna handbook'un CLAUDE.md'si değil,
  `templates/CLAUDE.service.md` kopyalanır.
- Kişisel Claude ayarları `.claude/settings.local.json` dosyasına (commit edilmez).
- Bir skill otomatik tetiklenmiyorsa `description` alanına kullandığın kelimeleri ekle.
- `main` korumalı; her değişiklik issue → branch → MR ile gelir.
