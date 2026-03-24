# DEMUCS Stem Separator — Max 8

## Files
- `demucs_stems.maxpat` — Main patch
- `demucs_bridge.js` — Node.js subprocess bridge (called by `node.script`)

## Setup

1. **Both files must be in the same folder.** Open `demucs_stems.maxpat` in Max 8.

2. **Verify DEMUCS path** — open `demucs_bridge.js` and confirm the PYTHON constant:
   ```
   const PYTHON = "/Library/Frameworks/Python.framework/Versions/3.13/bin/python3";
   ```
   Run `which python3` in Terminal to confirm.

3. **Unlock the patch** (Cmd+E) to edit wiring.

---

## Manual wiring needed in Max (unlock and connect these)

The patch loads with most audio routing complete. You need to wire the **SEPARATE button** to `node.script`:

### A — Build the "separate" message
Add these objects near the SEPARATE button:
```
[r filepath]  [umenu model-menu outlet 1]  [textedit outdir-field outlet 0]
      |                  |                            |
   [trigger b b b]       |                            |
      |                  |                            |
[sprintf separate %s %s %s] ← connect all three as arguments
      |
[node.script demucs_bridge.js]
```

### B — Unpack stem paths on arrival
The `route stems` outlet sends: `drums.wav bass.wav vocals.wav other.wav` as a list.
Add `[unpack s s s s]` between `route` outlet 2 and the four `read $1...$4` message boxes.

### C — Two-stem mode (optional)
`route twostems` (outlet 3) sends two paths. Add `[unpack s s]` and route to any two buffers.

---

## Models
| Model | Description |
|---|---|
| `htdemucs` | Default — good quality, fast |
| `htdemucs_ft` | Fine-tuned — best quality (slower) |
| `htdemucs_6s` | 6-stem: adds piano + guitar |
| `mdx_extra` | Alternative architecture |
| `mdx_extra_q` | Quantized mdx — faster |

## Notes
- First run downloads model weights (~300MB) — may look stalled, check Terminal
- Audio is loaded into `buffer~` objects and played via `groove~` (supports looping + scrubbing)
- All stems play in sync when you hit PLAY
- Each stem has: color-coded volume slider + on/off toggle
- Output dir defaults to `/tmp/demucs_out` — change in the Output field
