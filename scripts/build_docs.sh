#!/usr/bin/env bash
set -euo pipefail

echo "Building docs…"
mkdir -p build

for f in sample/templates/*.tex; do
  if grep -q '\\documentclass' "$f"; then
    echo "  → compiling $(basename "$f")"
    # -halt-on-error turns most LaTeX problems into a clean exit status
    pdflatex -interaction=nonstopmode -halt-on-error \
             -output-directory build "$f" >/dev/null 2>&1 \
      || echo "    ⚠️  LaTeX errors in $(basename "$f") – skipped"
  else
    echo "  → skipping $(basename "$f") (no \\documentclass)"
  fi
done

cp sample/guides/*.md build/ 2>/dev/null || true
echo "Docs ready in ./build"
