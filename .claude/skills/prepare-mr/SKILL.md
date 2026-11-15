---
name: prepare-mr
description: Bir issue'nun işi bittiğinde merge request hazırlamak için kullan. Son kontrolleri yapar, Conventional Commit mesajı ve MR açıklaması üretir, board'da kartı review'a taşır ve push/MR komutlarını verir. "MR hazırla", "merge request aç", "PR aç" denince tetiklenir.
disable-model-invocation: true
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git log:*), Bash(git add:*), Bash(git commit:*), Bash(make lint:*), Bash(make test:*), Bash(glab issue update:*), Bash(glab issue view:*), Read, Grep, Glob
---

# MR hazırla

OrderFlow polyrepo: **bütün issue'lar handbook reposunda** (`order-flow-group/handbook`).

1. Repoda `Makefile` varsa `make lint test` çalıştır; kırmızıysa DUR. Makefile yoksa bu adımı atla ve söyle.
2. `git diff main...HEAD` ile tüm değişikliği oku. Bulguları listele:
   - Secret, `.env`, kişisel veri (TCKN, IBAN, telefon, e-posta, adres) var mı?
   - Debug kodu, yorum satırına alınmış kod, TODO kaldı mı?
   - Sözleşme değiştiyse contracts reposu güncel mi?
   - Kod değiştiyse testler hata yollarını kapsıyor mu?
3. Kod değişikliği varsa `code-reviewer` subagent'ını çağır ve önemli bulguları özetle.
4. Branch adından issue numarasını bul (ör. `12-post-orders` → 12).
5. Issue referansını belirle:
   - Bu repo handbook ise: `Closes #<no>`
   - Başka bir repoysa: `Closes order-flow-group/handbook#<no>`
   - İş issue'nun sadece bir parçasıysa `Closes` yerine `Refs` kullan ve bunu bana söyle.
6. Conventional Commit mesajı öner (İngilizce): `<type>(<scope>): <özet>` + gövde + issue referansı.
7. `.gitlab/merge_request_templates/default.md` şablonunu doldurarak MR açıklaması yaz.
8. Bana göster. Onay verirsem commit'i at (`git add` + `git commit`). Push'u sen yapma; bana şu komutları ver:
   - `git push -u origin HEAD`
   - `glab mr create --title "<başlık>" --description "<açıklama>" --squash-before-merge --remove-source-branch --target-branch main --assignee @me --yes`
9. Kartı review'a taşı: `glab issue update <no> -R order-flow-group/handbook --label "status:review" --unlabel "status:doing"`.
10. Hatırlat: "Pipeline yeşil olunca merge et (ya da MR'da Set to auto-merge). Sonra `git switch main && git pull`,
    branch'i sil ve `glab issue update <no> -R order-flow-group/handbook --unlabel status:review`."
GitHub'da PR açma; GitHub sadece ayna.
