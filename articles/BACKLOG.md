# Makale backlog'u

Her fazın sonunda `/phase-retro` çalışır, bu listeye bakılır ve o fazdan 2–3 makale seçilir. Yeni bir konu aklına geldiği anda buraya bir satır ekle.

**Kurallar**
- Her makale bir ölçüme ya da somut bir olaya dayanır (rakam, hata, karşılaştırma).
- Bir makale tek bir soruya cevap verir. Başlık o soruyu ya da cevabı içerir.
- Hammadde: `notes/karar-defteri.md`, MR'lardaki "Öğrendiklerim" bölümleri, `retro/`, `benchmarks/`.
- Taslak: `/write-article`. Yayın: Medium, ardından LinkedIn postu.

Durum: 💡 fikir · 📝 taslak · ✅ yayında

---

## Faz 0 — Yürüyen iskelet (faz sonunda 2–3 tanesi seçilecek)

| # | Başlık önerisi | Soru | Hammadde | Durum |
| --- | --- | --- | --- | --- |
| 0.1 | AI'a yazdırdığım kit'i AI'a review ettirdim: 24 bulgu | AI ile geliştirmede kurallar nasıl repoya konur ve AI çıktısı nasıl denetlenir? | K-17, code-reviewer raporu, kit v2 MR'ı | 💡 |
| 0.2 | Tek başıma Trendyol gibi çalışmak: group, polyrepo ve handbook | Tek kişilik projede büyük şirket yapısı kurmak ne kazandırır, ne kaybettirir? | K-01…K-05 (makale #14'ün 1. bölümü) | 💡 |
| 0.3 | main'imi neden düz tuttum: squash, rebase, fast-forward | Hangi merge yöntemi ne zaman? | K-06…K-08, iki MR'ın log farkı | 💡 |
| 0.4 | Önce dizüstünde, sonra bulutta: GitLab Runner yolculuğu (1. bölüm) | Kendi runner'ını kurmak ne öğretir? | ADR-002, F0-06, ilk pipeline süreleri | 💡 |
| 0.5 | .NET bilen biri neden Go seçti? Zaman kutulu bir ADR | Teknoloji seçimi nasıl belgelenir ve riski nasıl sınırlanır? | ADR-001, F0-09 sonucu | 💡 |
| 0.6 | CRLF bir pipeline'ı nasıl bozar ve `.gitattributes` | Küçük ama gerçek bir Windows/Linux tuzağı | K-10 | 💡 (kısa LinkedIn postu) |
| 0.7 | `docker.sock`'u mount etmek: runner'a host'un anahtarını vermek | Docker executor'ın güvenlik bedeli ne, alternatifleri (rootless, Kaniko, ayrı VM) neler? | K-18, `notes/gitlab-runner.md` | 💡 (kısa LinkedIn postu) |
| 0.8 | Kullanıcısı olmayan şablon yazmayın: CI şablonlarını neden erteledim | Paylaşılan CI şablonu ne zaman yazılmalı? Önce mi, ilk kullanıcıyla mı? | K-19, F0-07 / F0-09 / F0-10 MR'ları | 💡 (kısa LinkedIn postu) |
| 0.9 | CLAUDE.md rica eder, hook zorlar: AI'a deterministik guardrail'ler | Hangi kural prompt'ta kalmalı, hangisi hook/CI ile makineye zorlatılmalı? | K-20 (Spectral `--fail-severity=warn`), ci-templates secret-scan, CLAUDE.md "Bilinen tuzaklar" | 💡 |

## Faz 1 — Sipariş happy path
| # | Başlık önerisi | Soru | Durum |
| --- | --- | --- | --- |
| 8 | Idempotency key: Redis mi Postgres unique constraint mı? | Çift sipariş nasıl önlenir? | 💡 |
| 1.1 | Go'da ilk servisim: .NET'ten gelen birinin notları | Dil geçişinde ne kolay, ne zor? | 💡 |
| 1.2 | Testcontainers ile gerçek DB'ye karşı test | Mock yerine gerçek bağımlılık neden? | 💡 |

## Faz 2 — Stok, ödeme, event'ler
| # | Başlık önerisi | Durum |
| --- | --- | --- |
| 7 | Outbox pattern ve at-least-once teslimat: kaybolan event sayısı | 💡 |
| 6 | Saga: orkestrasyon mu koreografi mi? | 💡 |
| 9 | Retry fırtınası: düz retry vs backoff + jitter + circuit breaker | 💡 |

## Faz 3 — Gateway, vitrin, yük
| # | Başlık önerisi | Durum |
| --- | --- | --- |
| 5 | Overselling'i nasıl önledim: Redis DECR vs koşullu UPDATE vs SELECT FOR UPDATE | 💡 |
| 3.1 | SSE ile canlı sipariş durumu: WebSocket'e neden gerek yok? | 💡 |

## Faz 4 — Gözlem ve analitik
| # | Başlık önerisi | Durum |
| --- | --- | --- |
| 10 | Aynı analitik sorgu: Postgres vs ClickHouse | 💡 |
| 4.1 | İlk SLO'm ve error budget'ım | 💡 |

## Faz 5 — Trafik agent'ları ve MCP
| # | Başlık önerisi | Durum |
| --- | --- | --- |
| 2 | MCP gerçekten gerekli mi? Doğrudan araç çağrısı vs MCP | 💡 |
| 13 | LLM persona trafiği vs k6 script'i | 💡 |
| 3 | API modeli vs lokal model (Ollama) | 💡 |

## Faz 6 — Müşteri agent'ı, RAG, Kalkan
| # | Başlık önerisi | Durum |
| --- | --- | --- |
| 4 | Türkçe RAG: chunk boyutu, hybrid search, reranker | 💡 |
| 11 | PII maskeleme: regex vs Presidio vs LLM | 💡 |

## Faz 7 — k3s ve GitOps
| # | Başlık önerisi | Durum |
| --- | --- | --- |
| 15 | Docker Compose'dan k3s + Argo CD'ye geçiş | 💡 |
| 0.4b | Runner yolculuğu (2. bölüm): dizüstünden Oracle ARM'a taşıma, lokal vs bulut pipeline süreleri | 💡 |

## Faz 8 — SRE agent'ı ve kapanış
| # | Başlık önerisi | Durum |
| --- | --- | --- |
| 12 | SRE agent'ı gerçekten kök nedeni bulabiliyor mu? | 💡 |
| 1 | Aynı agent'ı üç yolla yazdım: saf Python vs LangGraph vs LangChain | 💡 |
| 14 | Tek kişilik polyrepo: 4 ay sonra ne öğrendim (2. bölüm) | 💡 |
