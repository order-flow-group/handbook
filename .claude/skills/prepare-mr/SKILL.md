---
name: prepare-mr
description: Bir issue'nun işi bittiğinde merge request hazırlamak için kullan. Son kontrolleri yapar, Conventional Commit mesajı ve MR açıklaması üretir, onayla glab mr create çalıştırır. "MR hazırla", "merge request aç", "PR aç" denince tetiklenir.
disable-model-invocation: true
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git log:*), Bash(git add:*), Bash(git commit:*), Bash(make lint:*), Bash(make test:*), Read, Grep, Glob
---

# MR hazırla

1. Repoda `Makefile` varsa `make lint test` çalıştır; kırmızıysa DUR ve sorunu göster.
   Makefile yoksa (ör. handbook) bu adımı atla ve atladığını söyle.
2. `git diff main...HEAD` ile tüm değişikliği oku. Bulguları listele:
   - Secret, `.env`, kişisel veri (TCKN, IBAN, telefon, e-posta, adres) var mı?
   - Debug kodu, yorum satırına alınmış kod, TODO kaldı mı?
   - Sözleşme değiştiyse contracts reposu güncel mi?
   - Kod değiştiyse testler hata yollarını kapsıyor mu?
3. Kod değişikliği varsa `code-reviewer` subagent'ını çağır ve önemli bulguları özetle.
4. Branch adından issue numarasını bul (ör. `12-post-orders` → #12).
5. Conventional Commit mesajı öner: `<type>(<scope>): <özet>` + gövde + `Closes #<no>`.
6. `.gitlab/merge_request_templates/default.md` şablonunu doldurarak MR açıklaması yaz.
7. Bana göster. Onay verirsem:
   - `git push -u origin HEAD`
   - `glab mr create --title "<başlık>" --description "<doldurulmuş şablon>" --squash-before-merge --remove-source-branch --label "<issue label'ları>" --target-branch main`
   (`--fill` kullanma: açıklamayı commit mesajıyla ezer.)
8. MR linkini göster. Pipeline varsa `glab ci status` ile durumunu göster.
GitHub'da PR açma; GitHub sadece ayna.
