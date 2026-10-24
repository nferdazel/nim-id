# Deploy VPS (`nim.qouver.com`)

Situs ini statis. Tidak ada container, tidak ada image, tidak ada tag `:local`/`:prev`.
Yang dipakai dari kontrak deploy: ref-guard fail-closed, `flock`, `fetch`/`reset`, swap symlink,
health check.

## Tata letak di server

```
/srv/qouver/apps/nim-id/
├── monorepo/          # clone repo (sachiel)
├── releases/<sha>/    # hasil render, 3 terbaru disimpan
├── web -> releases/<sha>   # symlink yang dibaca Caddy
├── .tools/quarto/     # Quarto CLI, tanpa root
├── logs/deploy.log
└── .deployed_rev
```

## Sekali saja (butuh root)

```bash
# 1. Direktori
sudo install -d -o sachiel -g sachiel -m 0755 \
  /srv/qouver/apps/nim-id/web \
  /srv/qouver/apps/nim-id/releases \
  /srv/qouver/apps/nim-id/logs

# 2. Label SELinux. Cek dulu apakah sudah ada aturan yang mencakup path ini.
sudo semanage fcontext -l | grep -i 'qouver/apps'
# Kalau belum ada yang cocok untuk nim-id, tambahkan; kalau sudah ada, lewati baris ini.
sudo semanage fcontext -a -t httpd_sys_content_t '/srv/qouver/apps/nim-id(/.*)?'
sudo restorecon -RF /srv/qouver/apps/nim-id
ls -Zd /srv/qouver/apps/nim-id/web   # harus httpd_sys_content_t

# 3. Blok Caddy (salin dari ops/caddy/Caddyfile.nim-id.example)
sudo cp -a /etc/caddy/Caddyfile "/etc/caddy/Caddyfile.bak-$(date +%F-%H%M)"
sudo tee -a /etc/caddy/Caddyfile < ops/caddy/Caddyfile.nim-id.example
sudo caddy validate --config /etc/caddy/Caddyfile
sudo systemctl restart caddy   # admin API dimatikan (H-5), reload mustahil

# 4. Cek
curl -sS -o /dev/null -w '%{http_code}\n' https://nim.qouver.com/
```

Tanpa langkah 2, Caddy menjawab **403/404** walaupun berkasnya ada. Tanpa langkah 3, Cloudflare
menjawab **525** karena origin belum punya vhost untuk SNI `nim.qouver.com`.

## Deploy rutin

Dipicu webhook saat push ke `main`, sama seperti aplikasi lain:

```bash
/srv/qouver/apps/nim-id/scripts/deploy-static.sh nim-id refs/heads/main
```

Skrip: ref-guard → `flock` → `git fetch`/`reset` → `tools/build-site.sh` (id + en) → rsync `public/` ke `releases/<sha>` →
swap `web` → `curl` health check → rollback symlink kalau gagal → sisakan 3 rilis.

PDF dibuat di dua tempat, dari commit yang sama:

- **VPS**, saat deploy: `deploy-static.sh` memanggil `tools/build-site.sh`, yang merender `html` dan
  `typst` sekaligus. Ini yang disajikan situs.
- **GitHub Actions**, saat tag `v*` di-push: job `buku` merender ulang lalu menerbitkan kedua PDF
  sebagai aset GitHub Release. Job itu berhenti kalau nama tag tidak sama dengan isi `VERSION`, jadi
  label rilis tidak bisa meleset.

Keduanya memakai Quarto dan Nim versi yang sama, jadi isinya identik. Rilis tidak memicu deploy:
webhook hanya mendengar `refs/heads/main`.

## Quarto di server (tanpa root)

```bash
mkdir -p /srv/qouver/apps/nim-id/.tools && cd /tmp
curl -L -o q.tgz https://github.com/quarto-dev/quarto-cli/releases/download/v1.10.19/quarto-1.10.19-linux-amd64.tar.gz
tar xzf q.tgz -C /srv/qouver/apps/nim-id/.tools
mv /srv/qouver/apps/nim-id/.tools/quarto-1.10.19 /srv/qouver/apps/nim-id/.tools/quarto
/srv/qouver/apps/nim-id/.tools/quarto/bin/quarto --version
```

## Rollback manual

```bash
cd /srv/qouver/apps/nim-id
ls -1dt releases/*/        # pilih rilis sebelumnya
ln -sfn "$(readlink -f releases/<sha-lama>)" web
curl -sS -o /dev/null -w '%{http_code}\n' https://nim.qouver.com/
```

## Webhook

- Hook `nim-id` ada di `/srv/qouver/config/webhook.json` (mode `600`, milik `sachiel`), dijalankan
  unit **user** `webhook` (`systemctl --user`), mendengarkan `127.0.0.1:9000`.
- GitHub: webhook `https://api.qouver.com/hooks/nim-id`, event **push**, HMAC-SHA256
  (`X-Hub-Signature-256`).
- Rahasia HMAC disimpan di dua sisi: `webhook.json` dan pengaturan webhook GitHub. Rotasi =
  ganti di keduanya, lalu `systemctl --user restart webhook`.
- Ref-guard di skrip hanya menerima `refs/heads/main`; event lain keluar dengan kode 0 (tidak
  dianggap gagal).
- Health check memakai **origin langsung** (`--resolve nim.qouver.com:443:127.0.0.1` + retry 5×2
  detik). Request dari VPS ke edge Cloudflare sendiri pernah gagal sesaat dan sempat memicu
  rollback palsu; CF diuji terpisah dari luar.

Jalankan manual (tanpa push):

```bash
cd /srv/qouver/apps/nim-id && ./scripts/deploy-static.sh nim-id refs/heads/main
```

Skrip menyalin versi terbarunya sendiri dari `monorepo/ops/scripts/` setelah deploy sukses, jadi
perubahan pada skrip ikut terpasang pada deploy berikutnya.
