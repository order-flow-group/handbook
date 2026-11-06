#!/usr/bin/env bash
# OrderFlow group label'larını ve milestone'larını oluşturur.
# Gereksinim: glab auth login yapılmış olmalı.
# Kullanım: GROUP=orderflow bash scripts/create-labels.sh
set -euo pipefail
GROUP="${GROUP:-orderflow}"
G=$(printf '%s' "$GROUP" | sed 's#/#%2F#g')

label() { # ad renk açıklama
  glab api -X POST "groups/$G/labels" -f name="$1" -f color="$2" -f description="$3" >/dev/null \
    && echo "✓ $1" || echo "• $1 (zaten var olabilir)"
}

label "type:feature" "#1f75cb" "Yeni davranış"
label "type:bug"     "#dc143c" "Hata"
label "type:chore"   "#808080" "Altyapı, bakım"
label "type:docs"    "#6699cc" "Doküman"
label "type:spike"   "#9400d3" "Araştırma, zaman kutulu"
label "type:article" "#ff8c00" "Makale ve ölçüm"
label "size:S" "#c2e0c6" "<= 2 saat"
label "size:M" "#7fbf7f" "<= 4 saat"
label "size:L" "#2e8b57" "<= 1 gün"
for a in order inventory payment web platform ai obs; do label "area:$a" "#36454f" "$a alanı"; done
label "status:ready"   "#d4edda" "Başlanabilir (Definition of Ready)"
label "status:doing"   "#fff3cd" "Üzerinde çalışılıyor"
label "status:review"  "#cce5ff" "MR açık"
label "status:blocked" "#f8d7da" "Bağımlılık bekliyor"
label "prio:high" "#b22222" "Önce bu"
label "prio:low"  "#d3d3d3" "Vakit olursa"
label "learn:claude" "#d97757" "Claude ekosistemi öğrenme"
label "learn:k8s"    "#326ce5" "Kubernetes öğrenme"
label "learn:agents" "#8a2be2" "Agent/RAG/MCP öğrenme"

# Milestone'lar (haftada ~25 saat varsayımı; tarihleri kendine göre kaydır)
ms() { glab api -X POST "groups/$G/milestones" -f title="$1" -f start_date="$2" -f due_date="$3" -f description="$4" >/dev/null \
  && echo "✓ $1" || echo "• $1 (zaten var olabilir)"; }
ms "F0 Yürüyen iskelet"        2026-11-09 2026-11-18 "Repo, CI, runner, /health"
ms "F1 Sipariş happy path"     2026-11-19 2026-12-02 "Order API, idempotency"
ms "F2 Stok, ödeme, event'ler" 2026-12-03 2026-12-16 "Outbox, saga, DLQ, CB"
ms "F3 Gateway, vitrin, yük"   2026-12-17 2026-12-30 "Traefik, Next.js, k6, overselling"
ms "F4 Gözlem ve analitik"     2026-12-31 2027-01-08 "OTel, Grafana, SLO, ClickHouse"
ms "F5 Trafik agent'ları, MCP" 2027-01-09 2027-01-22 "Saf Python agent, FastMCP"
ms "F6 Müşteri agent'ı, RAG"   2027-01-23 2027-02-05 "LangGraph, pgvector, Kalkan, evals"
ms "F7 k3s ve GitOps"          2027-02-06 2027-02-19 "OpenTofu, k3s, Helm, Argo CD"
ms "F8 SRE agent ve kapanış"   2027-02-20 2027-03-05 "SRE agent, Claude CI, makaleler"
