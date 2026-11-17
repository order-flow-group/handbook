# Karar defteri (decision log)

Projede verilen her kararın nedeni, alternatifi ve bedeli burada. Ayrıntısı olan kararların ADR'si `adr/` altında.

Yeni karar, verildiği anda `/log-decision` ile eklenir. Geri dönmesi zor ya da birden fazla repoyu etkileyen kararlar ayrıca ADR olarak yazılır.

Format: **Karar** · Neden · Alternatif · Bedeli · Özet (tek cümle)

---

## Platform ve repo yapısı

### K-01 · GitLab ana platform, GitHub sadece ayna (6 Kas 2026)
- **Neden:** Hedef şirketlerden Trendyol GitLab kullanıyor. Group/subgroup, issue, board, CI, container registry tek yerde. GitHub ise işe alımcıların baktığı vitrin.
- **Alternatif:** Her şeyi GitHub'da yapmak (Actions, Projects).
- **Bedeli:** İki platform; mirror token'ının süresini takip etmek gerekiyor.
- **Özet:** "Asıl iş GitLab'da, çünkü hedeflediğim ekiplerin kullandığı araç; GitHub'a push mirror ile otomatik aynalıyorum, orası vitrin."

### K-02 · Polyrepo + contracts reposu (6 Kas)
- **Neden:** Her servis bağımsız deploy edilir, Trendyol gibi büyük mikroservis şirketlerinin çalışma şekli bu. Servisler arası sözleşmeler (OpenAPI, AsyncAPI) tek bir `contracts` reposunda; tek doğru kaynak.
- **Alternatif:** Monorepo (tek repoda her şey; atomik değişiklik kolay).
- **Bedeli:** Sözleşmeleri senkron tutmak, çok repo yönetmek. contracts bunu hafifletiyor.
- **Özet:** "Bağımsız deploy için polyrepo seçtim; polyrepo'nun asıl riski servislerin birbirinden kopması, onu contracts reposuyla ve contract testleriyle yönetiyorum."

### K-03 · Group → subgroup yapısı: platform / commerce / ai (6 Kas)
- **Neden:** Sahiplik alanlarını ayırmak. Label, milestone ve board group seviyesinde tanımlanınca bütün repolarda ortak çalışıyor. Yetkiler de alan bazında verilebiliyor.
- **Alternatif:** Tek group altında düz repo listesi.
- **Bedeli:** Yol adları uzuyor (`order-flow-group/platform/contracts`).
- **Özet:** "Repoları ekip sahipliği gibi alanlara böldüm; planlama nesneleri group seviyesinde olduğu için 16 repoyu tek board'dan yönetiyorum."

### K-04 · handbook reposu (6 Kas)
- **Neden:** Kod dışındaki her şeyin (kararlar, notlar, makaleler, retrolar, Claude kit'i) versiyonlanmış tek evi. GitLab'ın kendi şirket el kitabı fikri. Kod repolarında bu bilgi kaybolur; wiki'de ise review'dan geçmez.
- **Alternatif:** GitLab Wiki, Notion, kod repolarının README'leri.
- **Bedeli:** Bir repo daha; dokümanı güncel tutma disiplini.
- **Özet:** "Mühendislik kararlarını kodla aynı süreçten geçirmek için handbook reposu açtım; ADR'ler ve kurallar MR ile değişiyor, yani her kararın tarihi ve review'u var."

### K-05 · GitHub organization + fine-grained token (13 Kas)
- **Neden:** 16 repoyu tek adreste toplamak; kişisel profili dağıtmamak. Token en az yetki ilkesiyle: sadece bu organization, sadece Contents read/write, süreli.
- **Alternatif:** Kişisel hesaba aynalamak; klasik (classic) token.
- **Bedeli:** Token süresi dolunca mirror durur; hatırlatma gerekiyor.
- **Özet:** "Mirror token'ını tek organization'a ve tek izne sınırladım; sızarsa kişisel repolarıma ya da başka bir şeye erişemez."

## Git ve iş akışı

### K-06 · Issue → branch → MR → merge, kısa ömürlü branch (trunk-based) (7 Kas)
- **Neden:** Her değişiklik bir issue'ya bağlı ve review'dan geçiyor. Branch 1–2 günden uzun yaşamıyor, bu yüzden çakışma olmuyor.
- **Alternatif:** GitFlow (develop, release, hotfix branch'leri).
- **Bedeli:** Disiplin: küçük issue'lar, sık merge.
- **Özet:** "Trunk-based çalıştım: her issue kısa ömürlü bir branch, MR ile main'e giriyor; GitFlow sürümlü ürünler için anlamlı, sürekli deploy edilen servisler için ağır."

### K-07 · Squash + fast-forward merge (10 Kas)
- **Neden:** main'deki her commit = bir MR = bir issue. Geçmiş düz bir liste; bir özelliği geri almak tek `git revert`, hatanın hangi MR'dan geldiğini bulmak `git bisect` ile kolay. Branch'teki "typo", "wip" commit'leri main'i kirletmiyor.
- **Alternatif:** Merge commit (varsayılan), squash'sız rebase.
- **Bedeli:** Branch içindeki ara adımlar main'de görünmüyor; main ilerlemişse önce rebase gerekiyor (otomatik rebase açık).
- **Özet:** "Squash ile her MR main'de tek commit oluyor, fast-forward ile merge commit oluşmuyor; sonuç her satırı bir issue'ya bağlı düz bir geçmiş, revert ve bisect çok kolay."

### K-08 · main korumalı (7 Kas)
- **Neden:** Kimse (ben dahil) main'e doğrudan push edemiyor; her değişiklik MR'dan ve review'dan geçiyor.
- **Alternatif:** Tek kişilik projede korumasız main.
- **Bedeli:** Küçük bir düzeltme için bile MR açmak.
- **Özet:** "Tek başıma çalışsam da main'i korudum; alışkanlık ekip ortamına aynen taşınsın diye."

### K-09 · Conventional Commits, İngilizce (9 Kas)
- **Neden:** `feat:`, `fix:`, `docs:` öneki commit'in türünü söylüyor; ileride changelog ve sürüm numarası otomatik üretilebilir (semantic-release). İngilizce, çünkü repolar herkese açık bir vitrin.
- **Alternatif:** Serbest commit mesajı.
- **Özet:** "Conventional Commits kullandım; mesaj formatı makineyle okunabilir olduğu için changelog'u otomatikleştirebiliyorum."

### K-10 · `.gitattributes` ile LF satır sonu (9 Kas)
- **Neden:** Windows'ta git satır sonlarını CRLF'e çeviriyor. Container'lar ve CI Linux'ta çalışıyor; CRLF'li bir `.sh` script'i orada bozuluyor.
- **Alternatif:** Herkesin kendi `core.autocrlf` ayarına güvenmek.
- **Özet:** "Satır sonu kuralını kişisel ayara değil repoya koydum, `.gitattributes` ile; böylece Windows'ta yazılan script Linux container'da da çalışıyor."

### K-11 · Code review: kendim + code-reviewer agent'ı + gerektiğinde insan (10 Kas)
- **Neden:** Review hatayı main'e girmeden yakalar. Agent kuralları ve dağıtık sistem hatalarını kontrol ediyor; tasarım soruları için insan gerekiyor.
- **Özet:** "Her MR'ı Changes sekmesinde kendim okuyorum, kod repolarında bir review agent'ı da çalışıyor; kritik tasarımlarda insan review'u istiyorum."

### K-12 · Her makinede ayrı SSH anahtarı (7 Kas)
- **Neden:** Bir bilgisayar kaybolursa sadece onun anahtarını iptal edersin. Private key asla kopyalanmaz.
- **Özet:** "Anahtar başına bir cihaz; iptal kolay, private key hiçbir yere taşınmıyor."

## Planlama

### K-13 · Fazlar = milestone, issue boyutu en fazla 1 gün, dikey dilim (6 Kas)
- **Neden:** Küçük issue = küçük MR = iyi review. Dikey dilimde her issue uçtan uca çalışan bir şey üretiyor.
- **Alternatif:** Katman katman ilerlemek ("önce tüm DB katmanı").
- **Özet:** "İşleri katman değil dikey dilim olarak böldüm; her issue bir günde biten, gösterilebilir bir sonuç."

### K-14 · Faz 0 = walking skeleton, iş mantığı yok (6 Kas)
- **Neden:** En riskli bilinmeyenler (repo, CI, runner, compose) kod yokken çözülüyor. Faz 1'de sadece iş mantığına odaklanılıyor.
- **Özet:** "Önce boş ama uçtan uca çalışan bir iskelet kurdum; altyapı sorunlarını iş mantığıyla karıştırmamak için."

### K-19 · CI şablonu, onu kullanan bir repo varken yazılır; `go.yml` F0-09'a, `docker.yml` F0-10'a ertelendi (15 Kas)
- **Neden:** Kullanan bir repo yokken yazılan şablon test edilemiyor; yeşil olduğu bilinmiyor, sadece tahmin ediliyor. `go.yml` (lint, test, build) için gerçek bir Go modülü, `docker.yml` için gerçek bir Dockerfile gerekiyor; ikisi de F0-09 ve F0-10'da doğuyor. F0-07'de bugün kullanılabilen `base.yml` ve `secret-scan.yml` yazıldı. Handbook bunları hemen `include` ile kullandı ve pipeline'ı yeşil oldu.
- **Alternatif:** F0-07'nin ilk planı: bütün job şablonlarını (`lint`, `test`, `build`, `docker-build`, `secret-scan`) baştan, kullanan repo olmadan yazmak.
- **Bedeli:** F0-07 kabul kriterlerinin bir kısmı (`lint`, `test`, `build`, `docker-build`) karşılanmadan kapanıyor; issue'ya bunun not edilmesi gerekiyor. F0-09 ve F0-10'un kapsamı büyüyor; iş artık iki repoya yayılıyor (ci-templates + order-service), yani iki MR. Zaman kutulu F0-09'un (ADR-001) 2 günlük süresi bu ek işten etkilenebilir.
- **Özet:** "Şablonu, onu kullanan ilk repoyla birlikte yazdım; test edilmemiş bir şablon tahmindir, bedeli F0-09 ve F0-10'a eklenen iş."

## Teknoloji

### K-15 · Backend dili Go (ADR-001, 10 Kas)
- **Neden:** Hedef e-ticaret ekiplerinde yaygın; az "sihirli" olduğu için outbox, saga gibi pattern'leri elle yazarken görüyorum.
- **Alternatif:** .NET 10 (zaten biliyorum).
- **Bedeli:** Hem dili hem pattern'leri aynı anda öğrenmek. Güvence: F0-09 iskeleti 2 günde çıkmazsa .NET'e dönülür.
- **Özet:** ".NET biliyordum ama Go seçtim; dili öğrenme riskini 2 günlük bir zaman kutusuyla sınırladım ve bunu ADR'ye yazdım."

### K-16 · GitLab Runner önce lokal, Faz 7'de Oracle VM (ADR-002, 14 Kas)
- **Neden:** Şimdi hızlı başlamak ve runner'ın nasıl çalıştığını kendi makinende görmek. Faz 7'de buluta taşıyarak bir geçişi uçtan uca yaşamak ve iki yaklaşımı karşılaştırmak.
- **Alternatif:** Doğrudan Oracle VM; GitLab.com'un paylaşımlı runner'ları.
- **Bedeli:** Laptop kapalıyken CI çalışmaz; taşıma ek bir iş.
- **Özet:** "Runner'ı önce lokalde Docker executor'la kurdum, sonra Oracle'daki VM'e taşıdım; lokal ile bulutun farkını, kaydı değiştirmeyi ve iki ortamı yönetmeyi yaşadım."

### K-18 · Group runner, Docker executor, `orderflow` tag'i (ADR-002'nin uygulaması, 15 Kas)
- **Neden:** *Kendi runner'ım:* GitLab.com'un paylaşımlı runner'larında ücretsiz CI dakikası sınırlı. Kendi makinemdeki runner bu sınıra takılmıyor. *Group runner:* Tek kayıtla `order-flow-group` altındaki bütün repolar aynı runner'ı kullanıyor, her repoya ayrı runner kaydetmek gerekmiyor. *Docker executor:* Her job temiz ve izole bir container'da çalışıyor. Job'un image'ını (`alpine`, `golang`) `.gitlab-ci.yml` belirliyor, makineye araç kurmak gerekmiyor. *Tag:* Job'lar `tags: [orderflow]` ile bu runner'ı açıkça seçiyor. Faz 7'de Oracle VM'e geçerken tag'i yeni runner'a vermek yetiyor. Tag'siz job'lar da çalışıyor, böylece tag'i unutan bir job "pending"de takılı kalmıyor.
- **Alternatif:** Her repoya ayrı project runner. Shell executor (komutlar doğrudan host'ta çalışır, hızlı ama izole değil). Tag kullanmamak.
- **Bedeli:** Bütün repolar tek runner'ı paylaşıyor. `concurrent` varsayılan olarak 1 olduğu için job'lar sırayla bekliyor; gerçek bekleme süresi ölçülecek. `docker.sock` mount edildiği için runner container'ı host'ta root yetkisine sahip. Tek kişilik projede bunu kabul ediyorum. Job'lara socket ayrıca açılırsa (ör. `docker build` için) job'lar da bu yetkiyi alır; F0-10'da buna dikkat edilecek. İlk job'larda image çekme süresi de ekleniyor. Runner laptopta çalıştığı için laptop kapalıyken pipeline "pending" bekliyor. "Pipelines must succeed" açık olduğu için o sırada MR'lar merge edilemiyor. Bu kısıt Faz 7'de runner Oracle VM'e taşınınca kalkacak.
- **Özet:** "Dakika sınırına takılmamak için laptopuma group seviyesinde bir runner kurdum; her job ayrı bir Docker container'ında çalışıyor, bedeli laptop kapalıyken bekleyen pipeline'lar ve host'ta root yetkili bir runner."

### K-20 · Sözleşme lint'i Spectral, `--fail-severity=warn` (F0-08, 17 Kas)
- **Neden:** *Spectral:* OpenAPI ve AsyncAPI'yi tek araçla lint ediyor; `contracts` reposunda ikisi de olacak. Kurallar `.spectral.yaml`'da duruyor ve genişletilebiliyor. *`--fail-severity=warn`:* Spectral varsayılan olarak sadece `error` bulgularında pipeline'ı kırar; bu ayarla uyarılar da kırıyor, böylece sözleşme baştan temiz kalıyor. Uygulama: `contracts` reposu + ci-templates `spec-lint.yml`.
- **Alternatif:** Redocly CLI (OpenAPI'de güçlü, AsyncAPI desteği zayıf). Sadece şema doğrulayan bir validator (yapıyı kontrol eder, stil ve tutarlılık kurallarını değil).
- **Bedeli:** Küçük stil uyarıları da MR'ı durduruyor. Kapatılacak ya da seviyesi düşürülecek kurallar `.spectral.yaml`'da tek tek yönetiliyor.
- **Özet:** "Sözleşmeleri tek araçla kontrol etmek için Spectral seçtim ve uyarıları da hata saydım; böylece sözleşme baştan temiz kalıyor, her istisnayı bilerek açıyorum."

## AI ile geliştirme

### K-17 · Claude Code'u CLAUDE.md, skill ve agent'larla donatmak (6–9 Kas)
- **Neden:** Kuralları her oturumda yeniden anlatmamak; aynı kuralların 16 repoda geçerli olması; tekrar eden işleri (issue'ya başlama, MR hazırlama, ADR) standart hale getirmek.
- **Klasik süreçten farkı:** Klasik ekipte bu bilgi onboarding dokümanında, wiki'de, linter ayarında durur ve sadece insanlar okur. Burada aynı bilgi hem insanın hem AI'ın okuduğu dosyalarda; kurallar "uygulanan dokümantasyon" oluyor.
- **Bedeli:** Kit'in kendisi de review gerektiriyor (v1'de 24 bulgu çıktı).
- **Özet:** "AI asistanına kuralları her seferinde anlatmak yerine repoya koydum: CLAUDE.md proje kuralları, skill'ler tekrar eden iş akışları, agent'lar review gibi ayrı bağlam isteyen işler; kit'in kendisini de review'dan geçirdim."

---

## Yeni karar şablonu

### K-XX · <karar> (<tarih>)
- **Neden:**
- **Alternatif:**
- **Bedeli:**
- **Özet:**
