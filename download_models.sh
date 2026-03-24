#!/bin/bash
# download_models.sh — run this in Terminal, leave it open until done
set -e
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/models"
mkdir -p "$DIR"
TOKEN="$HF_TOKEN"
BASE="https://huggingface.co/Serveurperso/ACE-Step-1.5-GGUF/resolve/main"

# Expected sizes in bytes (used to detect incomplete files)
declare -A SIZES
SIZES["vae-BF16.gguf"]=353000000
SIZES["acestep-5Hz-lm-0.6B-Q8_0.gguf"]=744000000
SIZES["Qwen3-Embedding-0.6B-Q8_0.gguf"]=821000000
SIZES["acestep-v15-turbo-Q4_K_M.gguf"]=1520000000

FILES=(
  "vae-BF16.gguf"
  "acestep-5Hz-lm-0.6B-Q8_0.gguf"
  "Qwen3-Embedding-0.6B-Q8_0.gguf"
  "acestep-v15-turbo-Q4_K_M.gguf"
)

echo ""
echo "  Downloading ACE-Step models → $DIR"
echo ""

for f in "${FILES[@]}"; do
  dest="$DIR/$f"
  min_size="${SIZES[$f]}"
  actual=0
  [ -f "$dest" ] && actual=$(stat -f%z "$dest" 2>/dev/null || echo 0)

  if [ "$actual" -ge "$min_size" ] 2>/dev/null; then
    echo "  ✓ $f  ($(du -sh "$dest" | cut -f1), already complete)"
    continue
  fi

  echo "  ↓ $f ..."
  # -C - = resume, --retry 20, show progress bar
  curl -L -C - --retry 20 --retry-delay 3 \
    -H "Authorization: Bearer $TOKEN" \
    --progress-bar \
    "$BASE/$f" -o "$dest"
  echo "  ✓ $f  ($(du -sh "$dest" | cut -f1))"
done

echo ""
echo "  All models downloaded."
echo ""
echo "  Start the server:"
echo "    cd $DIR/.."
echo "    python3 app.py"
echo ""
