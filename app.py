import os
import json
import uuid
import threading
import subprocess
import time
import shutil
import requests as req_lib
from pathlib import Path
from flask import Flask, request, jsonify, render_template, send_file
from dotenv import load_dotenv

load_dotenv()
app = Flask(__name__)

# ── Paths ─────────────────────────────────────────────────────────────────────
BASE_DIR     = Path(__file__).parent
MODELS_DIR   = BASE_DIR / "models"
BUILD_DIR    = BASE_DIR / "acestep.cpp" / "build"
ACE_QWEN3    = BUILD_DIR / "ace-qwen3"
DIT_VAE      = BUILD_DIR / "dit-vae"
WORK_DIR     = Path("/tmp/acestep-work")
REF_DIR      = Path("/tmp/acestep-ref")
OUTPUT_DIR   = Path.home() / "Music" / "AceStep-Local"

# ── Default model filenames (override via .env) ────────────────────────────────
DEFAULT_LM   = os.getenv("LM_MODEL",  "acestep-5Hz-lm-0.6B-Q8_0.gguf")
DEFAULT_DIT  = os.getenv("DIT_MODEL", "acestep-v15-turbo-Q4_K_M.gguf")
TEXT_ENC     = "Qwen3-Embedding-0.6B-Q8_0.gguf"
VAE          = "vae-BF16.gguf"

# Available model choices (must exist in models/)
LM_OPTIONS = [
    ("0.6B Q8_0 — fast",   "acestep-5Hz-lm-0.6B-Q8_0.gguf"),
    ("1.7B Q8_0 — balanced","acestep-5Hz-lm-1.7B-Q8_0.gguf"),
    ("4B Q5_K_M — quality", "acestep-5Hz-lm-4B-Q5_K_M.gguf"),
]
DIT_OPTIONS = [
    ("turbo Q4_K_M — fastest", "acestep-v15-turbo-Q4_K_M.gguf"),
    ("turbo Q5_K_M — balanced","acestep-v15-turbo-Q5_K_M.gguf"),
    ("base  Q4_K_M",           "acestep-v15-base-Q4_K_M.gguf"),
    ("sft   Q4_K_M — steered", "acestep-v15-sft-Q4_K_M.gguf"),
]

# ── Jobs ──────────────────────────────────────────────────────────────────────
JOBS: dict[str, dict] = {}


# ── Generation pipeline ───────────────────────────────────────────────────────
def _run_generation(job_id: str, params: dict):
    job     = JOBS[job_id]
    workdir = WORK_DIR / job_id
    workdir.mkdir(parents=True, exist_ok=True)

    lm_file  = MODELS_DIR / params.get("lm_model",  DEFAULT_LM)
    dit_file = MODELS_DIR / params.get("dit_model",  DEFAULT_DIT)
    te_file  = MODELS_DIR / TEXT_ENC
    vae_file = MODELS_DIR / VAE

    for label, path in [("LM", lm_file), ("DiT", dit_file),
                        ("text-encoder", te_file), ("VAE", vae_file)]:
        if not path.exists():
            job["status"]  = "error"
            job["message"] = f"{label} model not found: {path.name} — run setup.sh first"
            return

    if not ACE_QWEN3.exists() or not DIT_VAE.exists():
        job["status"]  = "error"
        job["message"] = "Binaries not built — run setup.sh first"
        return

    try:
        # ── 1. Write request.json ─────────────────────────────────────────────
        req = {
            "caption":          params["prompt"],
            "lyrics":           params.get("lyrics", ""),
            "duration":         float(params.get("duration", 30)),
            "bpm":              int(params.get("bpm", 0)),
            "seed":             int(params.get("seed", -1)),
            "lm_cfg_scale":     float(params.get("lm_cfg_scale", 2.0)),
            "lm_temperature":   float(params.get("lm_temperature", 0.85)),
            "inference_steps":  int(params.get("inference_steps", 8)),
            "guidance_scale":   float(params.get("guidance_scale", 0.0)),
            "shift":            float(params.get("shift", 3.0)),
        }
        if params.get("key"):
            req["keyscale"] = params["key"]
        if params.get("negative_prompt"):
            req["lm_negative_prompt"] = params["negative_prompt"]
        if params.get("ref_audio_path"):
            ref_p = Path(params["ref_audio_path"])
            if ref_p.exists():
                req["ref_audio_path"]  = str(ref_p)
                req["audio_cfg_scale"] = float(params.get("audio_cfg_scale", 0.5))

        req_path = workdir / "request.json"
        req_path.write_text(json.dumps(req, indent=2))
        job["started_at"] = time.time()

        # ── 2. ace-qwen3: generate audio codes ───────────────────────────────
        job["status"]   = "lm"
        job["message"]  = f"LM generating audio codes ({lm_file.name})…"
        job["progress"] = 20

        r1 = subprocess.run(
            [str(ACE_QWEN3), "--request", "request.json", "--model", str(lm_file)],
            cwd=str(workdir),
            capture_output=True,
            timeout=300,
        )
        if r1.returncode != 0:
            raise RuntimeError(f"ace-qwen3 failed:\n{r1.stderr.decode(errors='replace')[-800:]}")

        req0 = workdir / "request0.json"
        if not req0.exists():
            raise RuntimeError("ace-qwen3 produced no request0.json — check model path")

        # ── 3. dit-vae: synthesize audio ─────────────────────────────────────
        job["status"]   = "dit"
        job["message"]  = f"DiT synthesizing ({dit_file.name})…"
        job["progress"] = 55

        r2 = subprocess.run(
            [str(DIT_VAE),
             "--request",      "request0.json",
             "--text-encoder", str(te_file),
             "--dit",          str(dit_file),
             "--vae",          str(vae_file),
             "--wav"],
            cwd=str(workdir),
            capture_output=True,
            timeout=900,
        )
        if r2.returncode != 0:
            raise RuntimeError(f"dit-vae failed:\n{r2.stderr.decode(errors='replace')[-800:]}")

        # ── 4. Locate output ──────────────────────────────────────────────────
        candidates = sorted(workdir.glob("*.wav")) + sorted(workdir.glob("*.mp3"))
        audio_out  = next((f for f in candidates if "request0" not in f.name.lower()), None)
        if not audio_out:
            # fallback: any wav
            audio_out = next(iter(candidates), None)
        if not audio_out:
            raise RuntimeError("No audio output found after dit-vae")

        OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
        suffix = audio_out.suffix
        dest   = OUTPUT_DIR / f"{job_id}{suffix}"
        audio_out.rename(dest)

        elapsed = round(time.time() - job["started_at"])
        job.update({
            "status":    "done",
            "message":   f"Done in {elapsed}s",
            "progress":  100,
            "file":      str(dest),
            "audio_url": f"/api/audio/{job_id}",
            "prompt":    params["prompt"],
            "duration":  params.get("duration", 30),
        })

    except subprocess.TimeoutExpired:
        job["status"]  = "error"
        job["message"] = "Timed out — try shorter duration or smaller model"
    except Exception as e:
        job["status"]  = "error"
        job["message"] = str(e)[:600]


# ── Routes ────────────────────────────────────────────────────────────────────
@app.route("/")
def index():
    return render_template("index.html",
                           lm_options=LM_OPTIONS,
                           dit_options=DIT_OPTIONS,
                           default_lm=DEFAULT_LM,
                           default_dit=DEFAULT_DIT)


@app.route("/api/generate", methods=["POST"])
def generate():
    data = request.get_json(silent=True) or {}
    if not data.get("prompt"):
        return jsonify({"error": "prompt required"}), 400

    job_id = str(uuid.uuid4())[:8]
    JOBS[job_id] = {
        "status":   "queued",
        "message":  "Queued…",
        "progress": 5,
        "file":     None,
        "audio_url": None,
    }

    t = threading.Thread(target=_run_generation, args=(job_id, data), daemon=True)
    t.start()
    return jsonify({"job_id": job_id})


@app.route("/api/status/<job_id>")
def status(job_id):
    job = JOBS.get(job_id)
    if not job:
        return jsonify({"error": "unknown job"}), 404
    return jsonify(job)


@app.route("/api/audio/<job_id>")
def audio(job_id):
    job = JOBS.get(job_id)
    if not job or not job.get("file"):
        return jsonify({"error": "not ready"}), 404
    path = Path(job["file"])
    if not path.exists():
        return jsonify({"error": "file gone"}), 404
    dl = request.args.get("download") == "1"
    return send_file(path, as_attachment=dl,
                     download_name=path.name if dl else None)


@app.route("/api/models")
def list_models():
    """Report which model files are actually present."""
    def present(name):
        return (MODELS_DIR / name).exists()

    return jsonify({
        "lm_options":  [{"label": l, "file": f, "ready": present(f)}
                        for l, f in LM_OPTIONS],
        "dit_options": [{"label": l, "file": f, "ready": present(f)}
                        for l, f in DIT_OPTIONS],
        "text_encoder_ready": present(TEXT_ENC),
        "vae_ready":          present(VAE),
        "binaries_ready": ACE_QWEN3.exists() and DIT_VAE.exists(),
    })


@app.route("/api/cancel/<job_id>", methods=["POST"])
def cancel(job_id):
    job = JOBS.get(job_id)
    if job and job["status"] not in ("done", "error"):
        job["status"]  = "error"
        job["message"] = "Cancelled"
    return jsonify({"ok": True})


@app.route("/api/upload_ref", methods=["POST"])
def upload_ref():
    """Accept a reference audio file for style transfer, return its server-side path."""
    f = request.files.get("file")
    if not f:
        return jsonify({"error": "no file"}), 400
    REF_DIR.mkdir(parents=True, exist_ok=True)
    suffix = Path(f.filename).suffix or ".wav"
    dest   = REF_DIR / f"{uuid.uuid4().hex[:8]}{suffix}"
    f.save(str(dest))
    return jsonify({"path": str(dest)})


@app.route("/api/compose", methods=["POST"])
def compose():
    """Proxy to Anthropic API — generates style prompt + lyrics from a plain-language idea."""
    data    = request.get_json(silent=True) or {}
    idea    = data.get("idea", "").strip()
    api_key = data.get("api_key", "").strip()

    if not idea:
        return jsonify({"error": "idea is required"}), 400
    if not api_key:
        return jsonify({"error": "Anthropic API key required"}), 400

    system = (
        "You are a music composition assistant. Given the user's song idea, "
        "output ONLY valid JSON (no markdown fences, no explanation) in this exact format:\n"
        '{"style":"comma-separated style/genre/mood/instrument tags for a music generator",'
        '"lyrics":"full song lyrics with section markers like [verse] [chorus] [bridge]"}\n\n'
        "Style: be specific — genre, subgenre, mood, instruments, vocal style, tempo feel, production texture.\n"
        "Lyrics: complete, poetic, matching the idea's emotional tone, with proper song structure. "
        "Write at least two verses, one chorus, and a bridge. Keep each section 4–8 lines."
    )

    try:
        resp = req_lib.post(
            "https://api.anthropic.com/v1/messages",
            headers={
                "x-api-key": api_key,
                "anthropic-version": "2023-06-01",
                "content-type": "application/json",
            },
            json={
                "model": "claude-3-5-haiku-20241022",
                "max_tokens": 1800,
                "system": system,
                "messages": [{"role": "user", "content": idea}],
            },
            timeout=40,
        )

        if resp.status_code != 200:
            return jsonify({"error": f"Anthropic API {resp.status_code}: {resp.text[:300]}"}), 502

        raw = resp.json()["content"][0]["text"].strip()

        # Strip markdown code fences if Claude wrapped it anyway
        if raw.startswith("```"):
            raw = raw.split("```")[1]
            if raw.startswith("json"):
                raw = raw[4:]
            raw = raw.strip().rstrip("`").strip()

        parsed = json.loads(raw)
        return jsonify({"style": parsed.get("style", ""), "lyrics": parsed.get("lyrics", "")})

    except json.JSONDecodeError:
        return jsonify({"error": f"Couldn't parse Claude's response: {raw[:200]}"}), 502
    except req_lib.exceptions.Timeout:
        return jsonify({"error": "Anthropic API timed out — try again"}), 504
    except Exception as e:
        return jsonify({"error": str(e)[:400]}), 500


if __name__ == "__main__":
    WORK_DIR.mkdir(parents=True, exist_ok=True)
    REF_DIR.mkdir(parents=True, exist_ok=True)
    port = int(os.getenv("PORT", 5003))
    print(f"\n  ACE-Step Local  →  http://localhost:{port}\n")
    app.run(host="0.0.0.0", port=port, debug=False)
