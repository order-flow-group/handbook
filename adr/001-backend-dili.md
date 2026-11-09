# ADR-001: Backend dili (.NET 10 vs Go)

- **Durum:** Kabul edildi
- **Tarih:** 2026-11-09
- **İlgili issue:** order-flow-group/handbook#1

## Bağlam
OrderFlow'un backend servisleri (order, inventory, payment) için bir dil seçmemiz gerekiyor.
F0'daki "yürüyen iskelet" işleri (health endpoint'leri, compose, CI şablonu, servis CLAUDE.md'si)
bu karara bağlı. `templates/CLAUDE.service.md` içindeki `{{.NET 10 | Go | Python 3.12}}` alanı
bu ADR ile doluyor. Python AI repolarında kalıyor, o yüzden bu ADR'nin kapsamı dışında.

Kısıtlar ve hedefler:
- **Deneyim:** C# biliyorum, Go'yu hiç kullanmadım.
- **Hedef iş:** Türkiye'deki e-ticaret / scale-up şirketleri (Trendyol, Hepsiburada, Getir tarzı).
- **Zaman:** Haftada 20 saatten fazla.
- **Araçlar:** Ücretsiz araçlar, VS Code. Ücretli IDE yok.
- **Asıl öğrenme konusu:** Dağıtık sistem pattern'leri (outbox, saga, idempotency, retry,
  circuit breaker). Çekirdek kodu ben yazacağım, bu yüzden dilin bu kodu "gizlememesi" önemli.
- Servis mimari kuralları: database-per-service, RabbitMQ, outbox, idempotent consumer,
  Testcontainers ile entegrasyon testi, JSON log + `correlation_id`, `/metrics`.

## Seçenekler

| Kriter | .NET 10 (C#) | Go |
| --- | --- | --- |
| Benim öğrenme süreme etkisi | Düşük, dili zaten biliyorum | Yeni dil. İlk servise kadar geçen süre F0-09'daki 2 günlük zaman kutusuyla ölçülecek |
| Türkiye e-ticaret/scale-up ilanlarındaki yaygınlık | Ölçülmedi | Ölçülmedi |
| Container image boyutu (minimal servis) | Ölçülmedi | F0-09'da Go için ölçülecek (distroless/scratch) |
| Boştaki RAM ve açılış süresi | Ölçülmedi | F0-09'da Go için ölçülecek |
| Mimari kurallar için kütüphaneler | EF Core / Npgsql, RabbitMQ.Client, Polly / `Microsoft.Extensions.Http.Resilience`, Testcontainers for .NET, OpenTelemetry | pgx / sqlc, `amqp091-go`, `gobreaker`, `testcontainers-go`, OpenTelemetry |
| OpenAPI'den kod üretimi (contract-first) | NSwag, Kiota | oapi-codegen |
| ARM desteği | Var (linux-arm64) | Var (`GOARCH=arm64` ile cross-compile) |
| Ücretsiz araçlarla çalışma | VS Code + C# Dev Kit (bireysel ve açık kaynak kullanım için ücretsiz); Rider ticari olmayan kullanım için ücretsiz | VS Code + Go eklentisi, tamamen ücretsiz |
| Destek süresi | .NET 10 LTS, Kasım 2028'e kadar | Her sürüm, iki yeni ana sürüm çıkana kadar desteklenir (yaklaşık 1 yıl); yükseltmeler genelde sorunsuz |
| Pattern'lerin görünürlüğü | Framework'ler çok şeyi saklayabilir (MassTransit outbox'ı, EF interceptor'ları) | Açık kod; outbox ve retry elle yazılır, çoğu şey görünür |

### Seçenek A: .NET 10 (C#)
**Artıları**
- Dili biliyorum. Bütün enerjim dağıtık sistem pattern'lerine gider, sözdizimine değil.
- Olgun ekosistem: DI, config, health check, OpenTelemetry ve resilience hazır geliyor.
- Uzun destek (LTS) sayesinde proje boyunca sürüm yükseltmek zorunda değilim.
- Kurumsal ve banka ilanlarında yaygın olduğunu biliyoruz. E-ticaret tarafındaki payı ölçülmedi.

**Eksileri**
- Yeni bir dil öğrenmiyorum. Proje sonunda CV'ye eklenen yeni teknoloji daha az olur.
- Hazır framework'ler pattern'i gizleyebilir. Örneğin MassTransit'in hazır outbox'ını kullanırsam
  outbox'ı öğrenmiş olmam. Bunu kuralla engellemem gerekir (outbox'ı ben yazarım).
  Ayrıca MassTransit ve MediatR gibi bazı popüler kütüphaneler son sürümlerinde ticari lisansa geçti;
  ücretsiz araç kısıtımla çakışıyor.
- Image boyutu ve RAM, Native AOT olmadan Go'dan büyük olabilir (ölçülmedi). EF Core'un Native AOT
  desteği sınırlı.
- VS Code deneyimi Rider veya Visual Studio kadar güçlü değil.

### Seçenek B: Go
**Artıları**
- Türk e-ticaret dünyasında görünürlüğü yüksek. Örneğin Trendyol'un açık kaynak Go projeleri ve
  mühendislik blog yazıları var. İlanlardaki gerçek oranı ölçülmedi.
- Dil küçük ve "sihir" az. Outbox, retry, idempotency gibi şeyler açıkça yazılır ve görülür. Bu,
  öğrenme hedefimle örtüşüyor.
- Tek binary üretiyor, cross-compile kolay, küçük image çıkıyor (rakam ölçülecek). Compose'da
  birçok servis aynı anda çalışacağı için kaynak kullanımı önemli.
- Bütün araçlar (go, gopls, VS Code eklentisi) ücretsiz.

**Eksileri**
- Yeni dil. Error handling, interface, goroutine/context ve paket yapısını öğrenmek F0'ı uzatır.
  Ne kadar uzatacağı ölçülecek.
- Aynı anda iki şey öğreniyorum: hem dil hem dağıtık pattern'ler. Bilişsel yük daha fazla.
  Hata yaptığımda sorunun dilden mi pattern'den mi geldiğini ayırmak zorlaşabilir.
- DI, config ve validasyon gibi şeyler için "standart" bir çatı yok, her birini kendim seçmem gerek
  (ek ADR'ler gerekebilir: router, DB erişimi sqlc mi pgx mi).
- Boilerplate fazla (`if err != nil`), bu da ilk başta yavaş hissettirir.

## Karar
**Go.** Hedefim e-ticaret/scale-up şirketleri ve haftada 20 saatten fazla zamanım var. Bu süre
yeni bir dili F0'da öğrenmeye yetecek gibi görünüyor. Go'nun açık ve az sihirli yapısı da projenin
asıl amacına, yani pattern'leri elle yazıp anlamaya uyuyor. C# bilgim kaybolmuyor, zaten CV'mde var.
Kararın güvencesi F0-09'daki zaman kutusu (bkz. Takip).

## Sonuçlar
- **Olumlu:** Yeni ve hedef ilanlarla örtüşen bir dil öğrenirim. Pattern'ler kodda açıkça görünür.
  Image'lar küçük olur, araçlar ücretsiz.
- **Olumsuz / kabul edilen riskler:** F0 yavaşlar. İlk aylarda kodum "idiomatic Go" olmayabilir;
  code-reviewer agent'ı ve `/explain-and-learn` ile telafi edilecek. Router, DB erişimi gibi
  ek seçimler için küçük ADR'ler gerekecek.
- **Geri dönüş maliyeti:** Polyrepo olduğu ve sözleşmeler contracts'ta durduğu için servis bazında
  dil değiştirmek mümkün. Değişen tek şey o servisin kodu olur. F0'da maliyet düşük (sadece
  iskelet), Faz 1'den sonra her servis için yeniden yazım demek.

## Takip
- F0-09 (order-service iskeleti) Go ile yazılacak ve 2 günlük zaman kutusu olacak; çıkmazsa ADR
  revize edilip .NET 10'a dönülür.
