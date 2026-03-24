/**
 * demucs_bridge.js — Max 8 node.script bridge for DEMUCS stem separation
 *
 * Max sends stateful messages:
 *   filepath <path>     — store source file
 *   model <name>        — store model name (default: htdemucs)
 *   outdir <path>       — store output dir (default: /tmp/demucs_out)
 *   separate            — run demucs with stored state
 *   separate_two <stem> — run in two-stem mode (vocals/drums/bass)
 *   cancel              — kill running process
 *
 * Max receives (outlet 0):
 *   status <text>       — progress string
 *   progress <0-100>    — percent
 *   stems <d> <b> <v> <o>  — 4 stem wav paths
 *   twostems <s> <ns>   — 2 stem wav paths
 *   error <text>        — error string
 *   done                — separation finished
 */

const Max = require("max-api");
const { spawn } = require("child_process");
const path = require("path");
const fs = require("fs");

const PYTHON = "/Library/Frameworks/Python.framework/Versions/3.13/bin/python3";

// ── Stored state ──────────────────────────────────────────────────
let state = {
  filepath: null,
  model: "htdemucs",
  outdir: "/tmp/demucs_out",
};

let activeProcess = null;

// ── Helpers ───────────────────────────────────────────────────────
function status(msg) { Max.outlet("status", msg); }
function err(msg)    { Max.outlet("error", msg); }

function detectProgress(line) {
  const pct = line.match(/(\d+)%/);
  if (pct) Max.outlet("progress", parseInt(pct[1]));
}

function findStemsInDir(dir, twoStemMode, twoStemName) {
  if (!fs.existsSync(dir)) { err("Stem dir not found: " + dir); return null; }
  const files = fs.readdirSync(dir);

  if (twoStemMode) {
    const s  = files.find(f => f.startsWith(twoStemName));
    const ns = files.find(f => f.startsWith("no_" + twoStemName));
    if (!s || !ns) { err("Two-stem files not found in: " + dir); return null; }
    return { mode: "two", stem: path.join(dir, s), nostem: path.join(dir, ns) };
  }

  const drums  = files.find(f => f.startsWith("drums"));
  const bass   = files.find(f => f.startsWith("bass"));
  const vocals = files.find(f => f.startsWith("vocals"));
  const other  = files.find(f => f.startsWith("other"));

  if (!drums || !bass || !vocals || !other) {
    err("Expected stems not found. Found: " + files.join(", "));
    return null;
  }
  return {
    mode: "four",
    drums:  path.join(dir, drums),
    bass:   path.join(dir, bass),
    vocals: path.join(dir, vocals),
    other:  path.join(dir, other),
  };
}

function findStems(twoStemMode, twoStemName) {
  const trackBase = path.basename(state.filepath, path.extname(state.filepath));
  const modelDir  = path.join(state.outdir, state.model, trackBase);

  if (fs.existsSync(modelDir)) {
    return findStemsInDir(modelDir, twoStemMode, twoStemName);
  }

  // fallback: scan for any subfolder matching trackBase
  const base = state.outdir;
  if (!fs.existsSync(base)) { err("Output dir not found: " + base); return null; }
  for (const sub of fs.readdirSync(base)) {
    const candidate = path.join(base, sub, trackBase);
    if (fs.existsSync(candidate)) return findStemsInDir(candidate, twoStemMode, twoStemName);
  }

  err("Could not find stems in: " + base);
  return null;
}

// ── Core separation ───────────────────────────────────────────────
function runDemucs(twoStemMode, twoStemName) {
  if (activeProcess) { activeProcess.kill(); activeProcess = null; }

  if (!state.filepath) { err("No file — drop an audio file first"); return; }
  if (!fs.existsSync(state.filepath)) { err("File not found: " + state.filepath); return; }

  fs.mkdirSync(state.outdir, { recursive: true });

  const args = ["-m", "demucs.separate", "-n", state.model, "-o", state.outdir, "--device", "mps"];
  if (twoStemMode) args.push("--two-stems", twoStemName);
  args.push(state.filepath);

  status("Starting DEMUCS (" + state.model + ")…");
  Max.outlet("progress", 0);

  const proc = spawn(PYTHON, args);
  activeProcess = proc;

  proc.stderr.on("data", d => {
    d.toString().split("\n").forEach(line => {
      if (line.trim()) { status(line.trim()); detectProgress(line); }
    });
  });
  proc.stdout.on("data", d => {
    d.toString().split("\n").forEach(line => { if (line.trim()) status(line.trim()); });
  });

  proc.on("close", code => {
    activeProcess = null;
    if (code !== 0) { err("DEMUCS exited with code " + code); return; }

    status("Done — loading stems…");
    Max.outlet("progress", 100);

    const result = findStems(twoStemMode, twoStemName);
    if (!result) return;

    if (result.mode === "four") {
      Max.outlet("stems", result.drums, result.bass, result.vocals, result.other);
      spawn("open", [path.dirname(result.drums)]);
    } else {
      Max.outlet("twostems", result.stem, result.nostem);
      spawn("open", [path.dirname(result.stem)]);
    }
    Max.outlet("done");
  });

  proc.on("error", e => { activeProcess = null; err("Process error: " + e.message); });
}

// ── Max message handlers ──────────────────────────────────────────
Max.addHandler("filepath", (...args) => {
  // Max may split a path with spaces into multiple args
  state.filepath = args.join(" ");
  status("File: " + state.filepath);
});

Max.addHandler("model", (m) => {
  state.model = m || "htdemucs";
});

Max.addHandler("outdir", (...args) => {
  state.outdir = args.join(" ") || "/tmp/demucs_out";
});

Max.addHandler("separate", () => {
  runDemucs(false, null);
});

Max.addHandler("separate_two", (stemName) => {
  runDemucs(true, stemName || "vocals");
});

Max.addHandler("cancel", () => {
  if (activeProcess) { activeProcess.kill(); activeProcess = null; status("Cancelled."); }
});

Max.post("demucs_bridge loaded ✓");
