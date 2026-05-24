# Build & Preview Commands

# Notes:
# - Run these from the project root (where your .tex files live).
# - Replace `resume2.0.tex` with whichever top-level .tex file you want to compile (e.g. `combined-toggleable.tex`).

## Recommended (latexmk) — best for full builds + automatic runs
```powershell
# Build PDF with pdfLaTeX (recommended if you use pdflatex)
latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode -synctex=1" -file-line-error resume2.0.tex

# Build PDF with XeLaTeX (if you need system fonts / unicode support)
latexmk -pdf -xelatex -synctex=1 resume2.0.tex

# Clean generated auxiliary files (keeps the PDF)
latexmk -c

# Clean ALL generated files including the PDF
latexmk -CA
```

## Single-pass commands (when you want manual control)
```powershell
# Single pdflatex run
pdflatex -interaction=nonstopmode -synctex=1 resume2.0.tex

# Run bibliography tools if needed (example: biber)
# biber resume2.0

# Run pdflatex again if references/citations changed
pdflatex -interaction=nonstopmode -synctex=1 resume2.0.tex
```

## Preview / Open PDF (Windows)
```powershell
# Open with default PDF viewer
start resume2.0.pdf

# If you use SumatraPDF for continuous preview (install SumatraPDF first):
"C:\Program Files\SumatraPDF\SumatraPDF.exe" -reuse-instance resume2.0.pdf
```

## VS Code (LaTeX Workshop)
- Build: use the LaTeX Workshop build command (default: `Ctrl+Alt+B`)
- View: use the LaTeX Workshop view command or click the "View PDF" icon

## Quick tips
- If you switch main file, update the filename at the top of this file.
- If you get errors, run the latexmk command and inspect the `.log` for details.
