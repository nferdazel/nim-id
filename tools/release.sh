#!/usr/bin/env sh
# Naikkan versi otomatis dari riwayat commit, lalu commit + tag beranotasi.
#
#   ./task release            # bump level derived from commit messages
#   ./task release --patch    # force PATCH
#   ./task release --minor    # force MINOR
#   ./task release --major    # force MAJOR
#   ./task release --skip-check  # skip ./task check (not recommended)
#
# Pemetaan Conventional Commits:
#   BREAKING CHANGE / tipe!:   MAJOR
#   feat:                      MINOR
#   selain itu                PATCH
#
# Gabungan: POSIX sh + git. Tanpa dependency, tanpa menjalankan ulang CI saat tag di-push.
set -eu

root="$(cd "$(dirname "$0")/.." && pwd)"
cd "$root"

naik_paksa=""
lewati_cek=""
for a in "$@"; do
  case "$a" in
    --major | --minor | --patch) naik_paksa="${a#--}" ;;
    --skip-check) lewati_cek=1 ;;
    *)
      echo "argumen tidak dikenal: $a" >&2
      exit 2
      ;;
  esac
done

git rev-parse --git-dir >/dev/null 2>&1 || { echo "bukan repo git" >&2; exit 1; }

if [ -n "$(git status --porcelain)" ]; then
  echo "pohon kerja belum bersih. commit atau stash dulu:" >&2
  git status --short >&2
  exit 1
fi

versi_lama=$(tr -d '[:space:]' < VERSION)
tag_lama=$(git describe --tags --abbrev=0 --match 'v[0-9]*' 2>/dev/null || true)

if [ -n "$tag_lama" ]; then
  rentang="$tag_lama..HEAD"
  jumlah=$(git rev-list --count "$rentang")
else
  rentang="HEAD"
  jumlah=$(git rev-list --count HEAD)
fi

if [ "$jumlah" = 0 ]; then
  echo "tidak ada commit baru sejak ${tag_lama:-awal repo}; tidak ada yang dirilis" >&2
  exit 1
fi

subjects=$(git log "$rentang" --pretty='%s')
bodies=$(git log "$rentang" --pretty='%b')

ada_major=0
ada_minor=0
if printf '%s\n' "$subjects" | grep -Eq '^[A-Za-z]+(\([^)]*\))?!: ' || \
   printf '%s\n' "$bodies" | grep -Eq '^BREAKING[ -]CHANGE:'; then
  ada_major=1
elif printf '%s\n' "$subjects" | grep -Eq '^feat(\([^)]*\))?: '; then
  ada_minor=1
fi

if [ -n "$naik_paksa" ]; then
  naik="$naik_paksa"
elif [ "$ada_major" = 1 ]; then
  naik=major
elif [ "$ada_minor" = 1 ]; then
  naik=minor
else
  naik=patch
fi

mayor=${versi_lama%%.*}
sisa=${versi_lama#*.}
minor=${sisa%%.*}
patch=${sisa#*.}

for n in "$mayor" "$minor" "$patch"; do
  case "$n" in
    '' | *[!0-9]*)
      echo "VERSION tidak valid: '$versi_lama' (harus seperti 0.1.0)" >&2
      exit 1
      ;;
  esac
done

n_mayor=$mayor
n_minor=$minor
n_patch=$patch
case "$naik" in
  major)
    n_mayor=$((mayor + 1))
    n_minor=0
    n_patch=0
    ;;
  minor)
    n_minor=$((minor + 1))
    n_patch=0
    ;;
  patch) n_patch=$((patch + 1)) ;;
esac

versi_baru="$n_mayor.$n_minor.$n_patch"
tag_baru="v$versi_baru"

if git rev-parse -q --verify "refs/tags/$tag_baru" >/dev/null; then
  echo "tag $tag_baru sudah ada; periksa VERSION dan tag" >&2
  exit 1
fi

if [ -z "$tag_lama" ]; then
  echo "catatan: belum ada tag v*; rilis pertama sebaiknya di-tag manual (lihat docs/release.md)" >&2
fi

echo "commit sejak ${tag_lama:-awal repo}: $jumlah"
echo "naik: $naik  →  $versi_lama → $versi_baru"
printf '%s\n' "$subjects" | grep -E '^(feat|fix|docs|chore|refactor|test|style|perf)[^ ]*: |!:' | sed 's/^/  /' || true

# VERSION ditulis lebih dulu: gerbang membangun PDF, dan PDF yang dibangun harus
# sudah membawa nomor baru. Kalau gerbang gagal, VERSION tertinggal naik dan pohon
# kerja kotor, yang justru sinyal jujur untuk diperiksa.
printf '%s\n' "$versi_baru" > VERSION

if [ -z "$lewati_cek" ]; then
  echo "menjalankan gerbang ./task check ..."
  QUARTO="${QUARTO:-quarto}" sh ./task check
fi

git add VERSION
git commit -m "chore: rilis $versi_baru" >/dev/null
git tag -a "$tag_baru" -m "nim-id $versi_baru"

echo
echo "selesai: commit + tag $tag_baru dibuat (belum di-push)."
echo "push sekali jalan:  git push origin main --follow-tags"
