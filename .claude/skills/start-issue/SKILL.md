---
name: start-issue
description: Var olan bir GitLab issue'su üzerinde çalışmaya başlarken kullan. Issue'yu handbook'tan glab ile okur, main'i günceller, branch açar, board'da kartı doing'e taşır, kabul kriterlerinden plan çıkarır ve onay bekler. "issue'ya başla", "#12 üzerinde çalış", "start issue" denince tetiklenir. Issue açmaz.
argument-hint: <issue-numarası>
disable-model-invocation: true
allowed-tools: Bash(glab issue view:*), Bash(glab issue update:*), Bash(git switch:*), Bash(git pull:*), Bash(git status:*), Bash(git branch:*), Read, Grep, Glob
---

# Issue'ya başla: #$ARGUMENTS

OrderFlow polyrepo: **bütün issue'lar handbook reposunda.** Hangi repoda olursan ol, issue komutlarında
`-R order-flow-group/handbook` kullan.

1. Issue'yu oku: `glab issue view $ARGUMENTS -R order-flow-group/handbook`.
   Başlık, "Ne yapılacak", "Kabul kriterleri", "Kapsam dışı", "Bağımlılıklar" ve yorumları (notları) çıkar.
   Issue'nun başlığındaki `[repo]` etiketine bak (ör. `[contracts]`); şu an o repoda değilsen DUR ve söyle.
2. Bağımlılıklar kapanmamışsa DUR ve bana söyle.
3. `git status` temiz değilse DUR ve sor.
4. Güncel main'den branch aç: `git switch main && git pull && git switch -c $ARGUMENTS-<kısa-kebab-başlık>`.
   Branch zaten varsa ona geç.
5. Board'da kartı taşı: `glab issue update $ARGUMENTS -R order-flow-group/handbook --label "status:doing" --unlabel "status:ready"`.
6. İlgili kodu ve CLAUDE.md'yi oku. Contracts değişikliği gerekiyorsa önce contracts reposunda ayrı bir iş gerektiğini söyle.
7. Kod yazmadan önce bana sor: "Bu issue'da kodu sen mi yazacaksın, ben mi?" CLAUDE.md'deki "çekirdek kodu ben yazarım"
   kuralı geçerliyse ya da ben yazacağım dersem sadece öğret ve review et.
8. Şu formatta plan yaz ve **onayımı bekle**:

```
## Plan — #<no> <başlık>
Repo ve branch: ...
Değişecek dosyalar: ...
Adımlar:
1. ... (hangi kabul kriterini karşılıyor)
Testler / doğrulama: ...
Kim yazıyor: ben / sen (dosya bazında)
Riskler / sorular: ...
Öğrenme notu: bu işte öğreneceğim kavram(lar), 2 cümle
```

9. Onaydan sonra adım adım ilerle; varsa `make lint test` çalıştır.
10. Bitince kabul kriterlerini tek tek işaretleyerek göster. Bir karar verildiyse `/log-decision`, sonra `/prepare-mr` öner.
