# ADR-002: GitLab Runner önce lokal, Faz 7'de Oracle VM

- **Durum:** Kabul edildi
- **Tarih:** 2026-11-14
- **İlgili issue:** order-flow-group/handbook#6 (F0-06), Faz 7'de taşıma issue'su

## Bağlam
GitLab.com'un ücretsiz CI dakikaları sınırlı. Pipeline'ları kendi runner'ımızda koşturmak hem limiti kaldırıyor hem de iyi bir DevOps pratiği. Soru, runner'ın nerede çalışacağı.

## Seçenekler

| Kriter | Lokal (Monster notebook, Docker executor) | Oracle Cloud Always Free ARM VM | GitLab.com paylaşımlı runner |
| --- | --- | --- | --- |
| Başlama süresi | Bugün | Hesap + VM + ağ kurulumu | Hemen |
| Erişilebilirlik | Laptop açıkken | 7/24 | 7/24 |
| Maliyet | Yok | Yok (kota içinde) | Ücretsiz dakika sınırı |
| Öğrenme | Runner'ın çalışma mantığı, Docker executor | Linux sunucu, systemd, güvenlik | Az |
| Mimari | x86 | ARM (image'lar multi-arch olmalı) | x86 |

## Karar
İki aşamalı: Faz 0'da runner'ı lokal makinede Docker executor ile kur. Faz 7'de k3s için açılacak Oracle ARM VM'e taşı ve lokal runner'ı kaldır.

Gerekçe: Hemen başlamak ve runner'ı göz önünde, kendi makinende öğrenmek. Taşımada bir geçişi uçtan uca yaşamak: yeni makineyi kaydetmek, tag'leri değiştirmek, eski runner'ı devreden çıkarmak, x86'dan ARM'a geçerken çıkan sorunları görmek.

## Sonuçlar
- Olumlu: Bugün başlanıyor. İki yaklaşımın karşılaştırması makale malzemesi oluyor.
- Olumsuz: Laptop kapalıyken pipeline'lar bekler. Faz 7'de ek bir taşıma işi var.
- Risk: ARM'a geçişte x86'ya özel image'lar kırılabilir. Önlem: image'ları baştan multi-arch düşünmek.

## Takip
- F0-06: Lokal runner (Docker executor), `orderflow` tag'i.
- F7: Runner'ı Oracle VM'e taşı, lokal runner'ı devreden çıkar, iki ortamın pipeline sürelerini karşılaştır (makale).
