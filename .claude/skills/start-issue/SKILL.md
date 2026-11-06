---
name: start-issue
description: Bir GitLab issue'su üzerinde çalışmaya başlarken kullan. Issue'yu glab ile okur, branch açar, kabul kriterlerinden plan çıkarır ve onay bekler. "issue'ya başla", "#12 üzerinde çalış", "start issue" denince tetiklenir.
argument-hint: <issue-numarası>
disable-model-invocation: true
allowed-tools: Bash(glab issue view:*), Bash(git switch:*), Bash(git status:*), Read, Grep, Glob
---

# Issue'ya başla: #$ARGUMENTS

1. `glab issue view $ARGUMENTS` ile issue'yu oku. Başlık, "Ne yapılacak", "Kabul kriterleri",
   "Kapsam dışı" ve "Bağımlılıklar" bölümlerini çıkar.
2. Bağımlılıklar kapanmamışsa DUR ve bana söyle.
3. `git status` temiz değilse DUR ve sor.
4. `main`'den branch aç: `git switch main && git pull && git switch -c $ARGUMENTS-<kısa-kebab-başlık>`.
5. İlgili kodu oku (CLAUDE.md'deki mimari kurallar dahil). Contracts değişikliği gerekiyor mu kontrol et;
   gerekiyorsa önce contracts reposunda ayrı bir issue/MR gerektiğini söyle.
6. Şu formatta plan yaz ve **onayımı bekle**, kod yazma:

```
## Plan — #<no> <başlık>
Değişecek dosyalar: ...
Adımlar:
1. ... (hangi kabul kriterini karşılıyor)
Testler: ... (happy path + en az bir hata yolu)
Riskler / sorular: ...
Öğrenme notu: bu işte öğreneceğim kavram(lar) ve 2 cümle açıklama
```

7. Onaydan sonra adım adım uygula; her adımdan sonra `make lint test` çalıştır.
8. Bitince kabul kriterlerini tek tek işaretleyerek karşılandığını göster ve `/prepare-mr` öner.
