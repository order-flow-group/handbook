---
name: prepare-mr
description: Bir issue'nun işi bittiğinde merge request hazırlamak için kullan. Son kontrolleri yapar, Conventional Commit mesajı ve MR açıklaması üretir, onayla glab mr create çalıştırır. "MR hazırla", "merge request aç", "PR aç" denince tetiklenir.
disable-model-invocation: true
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git log:*), Bash(git add:*), Bash(git commit:*), Bash(make lint:*), Bash(make test:*), Read, Grep
---

# MR hazırla

1. `make lint test` çalıştır. Kırmızıysa DUR, sorunu göster.
2. `git diff main...HEAD` ile tüm değişikliği oku. Şunları kontrol et ve bulguları listele:
   - Secret, `.env`, kişisel veri (TCKN/IBAN/telefon) var mı?
   - Debug kodu, yorum satırına alınmış kod, TODO kaldı mı?
   - Sözleşme değiştiyse contracts reposu güncel mi?
   - Testler hata yollarını kapsıyor mu?
3. Gerekirse `code-reviewer` subagent'ını çağır ve önemli bulguları özetle.
4. Branch adından issue numarasını bul (ör. `12-post-orders` → #12).
5. Conventional Commit mesajı öner: `<type>(<scope>): <özet>` + gövde + `Closes #<no>`.
6. `.gitlab/merge_request_templates/default.md` şablonunu doldurarak MR açıklaması yaz.
7. Bana göster. Onay verirsem:
   `git push -u origin HEAD` ve
   `glab mr create --fill --squash-before-merge --remove-source-branch --title "<başlık>" --description "<açıklama>" --label "<issue label'ları>"`
8. MR linkini ve pipeline durumunu (`glab ci status`) göster.
