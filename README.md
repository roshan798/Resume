# Resume Builder

A collection of LaTeX resume templates with automated build scripts.

## Project Structure

```
.
├── src/                        # Source LaTeX files
│   ├── resume2.0.tex
│   ├── combined-toggleable.tex
│   ├── backend-focused.tex
│   ├── frontend-focused.tex
│   ├── fullstack-focused.tex
│   ├── resume_faangpath.tex
│   └── resume.cls            # Resume class file
│
├── pdf/                        # Final PDFs (git-ignored)
│   ├── backend-focused.pdf
│   ├── combined-toggleable.pdf
│   └── ...
│
├── build/                      # Build artifacts (git-ignored)
│   ├── *.aux, *.log, *.fls, etc.
│
├── scripts/                    # Build automation scripts
│   ├── build.ps1             # PowerShell script (Windows)
│   ├── build.sh              # Bash script (Linux/Mac/WSL)
│   └── organize.sh           # Organization helper
│
├── commands.md                # Quick reference for manual commands
├── .gitignore
└── README.md

```

## Quick Start

### Windows (PowerShell)

```powershell
# Build default resume (resume2.0)
.\scripts\build.ps1

# Build and view PDF
.\scripts\build.ps1 -View

# Build a specific resume
.\scripts\build.ps1 -ResumeName combined-toggleable -View

# Clean build artifacts
.\scripts\build.ps1 -Clean
```

### Linux / Mac / WSL (Bash)

```bash
# Make script executable (first time only)
chmod +x scripts/build.sh

# Build default resume
./scripts/build.sh

# Build and view PDF
./scripts/build.sh resume2.0 --view

# Build a specific resume
./scripts/build.sh combined-toggleable --view

# Clean build artifacts
./scripts/build.sh --clean
```

## Setup

### Prerequisites

- **LaTeX distribution** (required to build PDFs)
  - Windows: [MiKTeX](https://miktex.org/) or [TeX Live](https://www.tug.org/texlive/)
  - Mac: [MacTeX](https://www.tug.org/mactex/)
  - Linux: `sudo apt install texlive-full` (Ubuntu/Debian) or equivalent

- **latexmk** (included with most LaTeX distributions)
  - If missing, install via your package manager or LaTeX distro

### Optional

- **PDF Viewer** (for `--view` flag)
  - Windows: Built-in (uses default viewer)
  - Linux/Mac: `xdg-open` or `open` (usually pre-installed)

## Usage

### Build Options

| Command | Effect |
|---------|--------|
| `build.ps1` | Build resume2.0 → `build/resume2.0.pdf` |
| `build.ps1 -ResumeName combined-toggleable` | Build specific variant |
| `build.ps1 -View` | Build and open PDF |
| `build.ps1 -Clean` | Remove all artifacts (not PDFs) |
| `build.sh resume_name --view` | Bash equivalent |
| `build.sh --clean` | Bash clean |

### Available Resumes

- `resume2.0` — Default resume
- `combined-toggleable` — Combined frontend/backend
- `backend-focused` — Backend-specific
- `frontend-focused` — Frontend-specific
- `fullstack-focused` — Full-stack focused
- `resume_faangpath` — FAANG path variant

## Manual Build (if scripts fail)

See [commands.md](commands.md) for manual `pdflatex` and `latexmk` commands.

## Troubleshooting

### Build fails with "command not found: latexmk"
- **Windows:** Install MiKTeX or TeX Live with `latexmk` included
- **Linux:** `sudo apt install latexmk` or install full TeX Live
- **Mac:** `sudo tlmgr install latexmk` (if using MacTeX)

### PDF not created in build/
- Check `build/*.log` files for errors
- Run manually with verbose output: `pdflatex -interaction=nonstopmode resume2.0.tex`

### Permission denied on bash script
- Run: `chmod +x scripts/build.sh`

## Next Steps

1. Move your `.tex` files to `src/` (except `resume.cls` which stays there too)
2. Update file references in scripts if you rename resumes
3. Add to `.gitignore` any custom files you don't want tracked
4. Commit the `scripts/` and `README.md` to version control

---

**Quick Reference:** `commands.md` has manual build commands if you prefer direct `latexmk` or `pdflatex` calls.
