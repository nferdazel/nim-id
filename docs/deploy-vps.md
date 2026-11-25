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
├── .previous          # rilis aktif sebelumnya, dipakai rollback otomatis
├── scripts/           # salinan deploy-static.sh, diperbarui sendiri tiap deploy sukses
├── .tools/quarto/     # Quarto CLI, tanpa root
├── logs/deploy.log
└── .deployed_rev
```

## Sekali saja (butuh root)

`ops/scripts/setup-vps.sh` menjalankan langkah 1–3 di bawah dalam satu perintah. Prasyaratnya satu:
blok Caddy sudah disalin ke `/srv/qouver/apps/nim-id/Caddyfile.nim-id.block`.

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

# Blok itu memuat handle_errors (404 → /404.html), cache per jenis berkas, dan header keamanan.
# Kalau blok di server berubah, ubah cerminnya di repo pada commit yang sama.

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

Skrip: ref-guard → `flock` → `git fetch`/`reset` → tunggu check `Gate` untuk SHA itu →
`tools/build-site.sh` (id + en) → rsync `public/` ke `releases/<sha>` →
swap `web` → `curl` health check → rollback symlink kalau gagal → sisakan 3 rilis.

Webhook datang bersamaan dengan CI, jadi skrip menunggu check `Gate` pada SHA yang akan
dipasang. Hanya `success` yang dilanjutkan; CI merah, check tidak muncul, atau lewat
`NIMID_GATE_TIMEOUT` (default 1200 detik) membatalkan deploy dan situs lama tetap hidup.
Token GitHub opsional lewat `NIMID_GITHUB_TOKEN` (menaikkan rate limit API); tanpa token
pemeriksaan memakai API publik. Deploy darurat tanpa CI: `NIMID_SKIP_GATE=1`, tercatat di
`logs/deploy.log`.

PDF dibuat di dua tempat, dari commit yang sama:

- **VPS**, saat deploy: `deploy-static.sh` memanggil `tools/build-site.sh`, yang merender `html` dan
  `typst` sekaligus. Ini yang disajikan situs.
- **GitHub Actions**, saat tag `v*` di-push: job `book` merender ulang lalu menerbitkan kedua PDF
  sebagai aset GitHub Release. Job itu berhenti kalau nama tag tidak sama dengan isi `VERSION`, jadi
  label rilis tidak bisa meleset.

Keduanya memakai Quarto 1.10.19 dan dirender dari commit yang sama; verifikasi contoh dengan Nim
2.4.2 hanya berjalan di CI, tidak di VPS. Rilis tidak memicu deploy: webhook hanya mendengar
`refs/heads/main`.

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
- `main` mewajibkan check `Gate` sebelum merge (ruleset `Basic Branch Guardrail`). Admin repo
  memegang bypass untuk rilis langsung lewat `./task release --push`; deploy tetap menunggu
  `Gate` pada SHA hasil push.
- Health check menempuh **nama publik** (`https://nim.qouver.com/`, bisa ditimpa lewat
  `NIMID_HEALTH_URL`): tabel nft `inet cfedge` membuang tcp 80/443 dari sumber selain rentang
  Cloudflare, termasuk `127.0.0.1`, jadi curl ke loopback selalu timeout (kode 000) dan bukan sinyal
  yang sah. Retry 5×2 detik, kode harus 200 atau 308, lalu `index.html` kedua edisi harus memuat
  judulnya.

Jalankan perintah yang sama secara manual (tanpa push) kalau perlu deploy ulang commit yang sedang
aktif.

Skrip menyalin versi terbarunya sendiri dari `monorepo/ops/scripts/` setelah deploy sukses, jadi
perubahan pada skrip ikut terpasang pada deploy berikutnya.
