#!/bin/bash
# setup.sh — ACE-Step Local: build acestep.cpp + download quantized models
# Run once. Safe to re-run (idempotent).
set -e
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR"

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; NC='\033[0m'
ok()   { echo -e "${GREEN}✓${NC} $1"; }
warn() { echo -e "${YELLOW}!${NC} $1"; }
fail() { echo -e "${RED}✗${NC} $1"; exit 1; }
step() { echo -e "\n${YELLOW}──${NC} $1"; }

echo ""
echo "  ACE-Step Local — setup"
echo "  Models: Q4_K_M DiT + 0.6B LM  (~3.3 GB)"
echo ""

# ── 0. Check dependencies ──────────────────────────────────────────────────
step "Checking dependencies"

command -v git   &>/dev/null || fail "git not found"
command -v cmake &>/dev/null || fail "cmake not found (brew install cmake)"
command -v python3 &>/dev/null || fail "python3 not found"
ok "git, cmake, python3 found"

# ── 1. Clone / update acestep.cpp ─────────────────────────────────────────
step "acestep.cpp"

if [ ! -d "acestep.cpp/.git" ]; then
  echo "  Cloning ServeurpersoCom/acestep.cpp..."
  git clone --recurse-submodules \
    https://github.com/ServeurpersoCom/acestep.cpp.git acestep.cpp
  ok "Cloned"
else
  ok "Already cloned"
fi

# ── 2. Build ───────────────────────────────────────────────────────────────
step "Building (Metal auto-detected on macOS)"

NPROC=$(sysctl -n hw.logicalcpu 2>/dev/null || echo 4)
BUILD_DIR="acestep.cpp/build"

if [ -f "$BUILD_DIR/ace-qwen3" ] && [ -f "$BUILD_DIR/dit-vae" ]; then
  ok "Binaries already built"
else
  mkdir -p "$BUILD_DIR"
  cd "$BUILD_DIR"
  # On macOS: Metal + Accelerate are auto-detected; no extra flags needed
  cmake .. -DCMAKE_BUILD_TYPE=Release -Wno-dev
  cmake --build . --config Release -j"$NPROC"
  cd "$DIR"

  [ -f "$BUILD_DIR/ace-qwen3" ] && [ -f "$BUILD_DIR/dit-vae" ] \
    && ok "Build complete" \
    || fail "Build failed — check cmake output above"
fi

# ── 3. Download models ─────────────────────────────────────────────────────
step "Downloading quantized models (Serveurperso/ACE-Step-1.5-GGUF)"

mkdir -p models

python3 - <<'PYEOF'
import sys, os
try:
    from huggingface_hub import hf_hub_download
except ImportError:
    print("Installing huggingface_hub...")
    import subprocess
    subprocess.check_call([sys.executable, "-m", "pip", "install", "huggingface_hub", "-q"])
    from huggingface_hub import hf_hub_download

REPO   = "Serveurperso/ACE-Step-1.5-GGUF"
OUTDIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), "models")

# ── Core required files (~3.3 GB total) ────────────────────────────────────
REQUIRED = [
    "Qwen3-Embedding-0.6B-Q8_0.gguf",    # text encoder  784 MB
    "vae-BF16.gguf",                       # VAE           337 MB
    "acestep-5Hz-lm-0.6B-Q8_0.gguf",      # LM (fast)     710 MB
    "acestep-v15-turbo-Q4_K_M.gguf",       # DiT (fastest) 1.45 GB
]

# ── Optional upgrades (download manually or uncomment) ─────────────────────
OPTIONAL = [
    # "acestep-5Hz-lm-1.7B-Q8_0.gguf",    # better LM     1.98 GB
    # "acestep-5Hz-lm-4B-Q5_K_M.gguf",    # best LM       3.03 GB
    # "acestep-v15-turbo-Q5_K_M.gguf",    # balanced DiT  1.70 GB
    # "acestep-v15-sft-Q4_K_M.gguf",      # SFT DiT       1.45 GB
]

def download(filename):
    dest = os.path.join(OUTDIR, filename)
    if os.path.exists(dest):
        size_mb = os.path.getsize(dest) / 1024 / 1024
        print(f"  ✓ {filename}  ({size_mb:.0f} MB, already present)")
        return
    print(f"  ↓ {filename}...")
    hf_hub_download(REPO, filename, local_dir=OUTDIR, local_dir_use_symlinks=False)
    size_mb = os.path.getsize(os.path.join(OUTDIR, filename)) / 1024 / 1024
    print(f"  ✓ {filename}  ({size_mb:.0f} MB)")

print(f"\nDownloading to: {OUTDIR}\n")
for f in REQUIRED:
    download(f)
for f in OPTIONAL:
    download(f)

print("\n  All models ready.")
PYEOF

# ── 4. Python deps ─────────────────────────────────────────────────────────
step "Python dependencies"
python3 -m pip install -q flask python-dotenv
ok "flask + python-dotenv installed"

# ── 5. Create .env if missing ──────────────────────────────────────────────
if [ ! -f ".env" ]; then
  cp .env.example .env
  ok "Created .env"
fi

# ── Done ───────────────────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}  Setup complete.${NC}"
echo ""
echo "  Start the server:"
echo "    python3 app.py"
echo ""
echo "  Then open:  http://localhost:5003"
echo ""
echo "  Optional: download a larger LM for better quality:"
echo "    cd models && huggingface-cli download Serveurperso/ACE-Step-1.5-GGUF \\"
echo "      acestep-5Hz-lm-4B-Q5_K_M.gguf --local-dir ."
echo ""
