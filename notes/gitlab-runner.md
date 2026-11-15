# GitLab Runner

Kurulum: 15 Kasım 2026, Monster notebook (Windows + Docker Desktop). Karar: ADR-002 (Faz 7'de Oracle VM'e taşınacak).

| Ayar | Değer |
| --- | --- |
| Kapsam | Group runner (order-flow-group) |
| Executor | Docker, varsayılan image alpine:latest |
| Tag | orderflow (tag'siz job'ları da çalıştırır) |
| Açıklama | monster-notebook |
| Ayar dosyası | Docker volume `gitlab-runner-config` → /etc/gitlab-runner/config.toml |

## Kurulum (PowerShell)

```powershell
docker volume create gitlab-runner-config
docker run -d --name gitlab-runner --restart always -v /var/run/docker.sock:/var/run/docker.sock -v gitlab-runner-config:/etc/gitlab-runner gitlab/gitlab-runner:latest
docker exec -it gitlab-runner gitlab-runner register --non-interactive --url https://gitlab.com --token <TOKEN> --executor docker --docker-image alpine:latest --description monster-notebook
```

Token: order-flow-group → Build → Runners → New group runner. Repoya ya da herhangi bir dosyaya yazılmaz.

## Günlük komutlar

```powershell
docker exec gitlab-runner gitlab-runner verify   # GitLab'a bağlı mı
docker logs -f gitlab-runner                     # job loglarını izle
docker restart gitlab-runner                     # yeniden başlat
```

## Sınır

Laptop kapalıyken ya da uykudayken pipeline'lar "pending" bekler.
Docker Desktop, oturum açılınca kendiliğinden başlayacak şekilde ayarlı (Settings → General → "Start Docker Desktop when you sign in"); runner da `--restart always` ile onunla birlikte kalkar.