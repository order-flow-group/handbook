# OrderFlow Claude Kit

VS Code'da Claude Code ile OrderFlow geliştirirken kullanılacak dosyalar. Önce `handbook`
reposuna koy, sonra her yeni repoya kopyala (`/new-repo` skill'i bunu hatırlatır).

## İçerik

```
CLAUDE.md                         ← her reponun köküne; {{...}} alanlarını doldur
CODEOWNERS
.claude/
  settings.json                   ← izinler (allow/ask/deny) + format hook'u
  hooks/format.sh                 ← her Edit/Write sonrası dosyayı formatlar (jq gerekir)
  skills/
    start-issue/SKILL.md          ← /start-issue 12   → issue oku, branch aç, plan çıkar
    new-endpoint/SKILL.md         ← /new-endpoint POST /orders → contract-first endpoint
    prepare-mr/SKILL.md           ← /prepare-mr       → kontrol, commit, MR açıklaması, glab
    adr/SKILL.md + template.md    ← /adr "konu"       → handbook/adr/NNN-*.md
    write-article/SKILL.md        ← /write-article #5 → ölçümden makale + LinkedIn postu
    explain-and-learn/SKILL.md    ← /explain-and-learn outbox → öğret, test et, not al
    new-repo/SKILL.md             ← /new-repo commerce/inventory-service
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

## Kurulum (F0-03 ve F0-04)

1. `glab auth login` → `GROUP=orderflow bash scripts/create-labels.sh`
2. handbook reposunu oluştur, bu klasörün içeriğini köküne kopyala, commit + push.
3. handbook projesinde **Issues → Import → CSV** ile `gitlab-import/issues-faz0.csv` yükle.
   Açıklamadaki `/label` ve `/milestone` satırları uygulanmadıysa label'ları board'dan toplu ekle.
   Repo'ya özel issue'ları (ör. F0-09) daha sonra **Move issue** ile ilgili repoya taşı.
4. VS Code'da repoyu aç, Claude Code panelinde `/` yaz: skill'ler listede görünmeli.
   `/agents` ile agent'ları gör.

## Günlük kullanım

```
/start-issue 9          # plan → onay → kod
"code-reviewer ile incele"
/prepare-mr             # kontrol → commit → MR
/explain-and-learn idempotency
```

## Notlar

- `settings.json` içindeki `deny` kuralları `.env` okumayı ve force push'u engeller.
  Kişisel tercihlerini `.claude/settings.local.json` dosyasına yaz (commit edilmez, .gitignore'a ekle).
- Bir skill otomatik tetiklenmiyorsa `description` alanına kullandığın kelimeleri ekle.
- Faz 8'de bu klasörü bir Claude Code plugin'ine çevirip tek komutla kurulur hale getireceğiz.
