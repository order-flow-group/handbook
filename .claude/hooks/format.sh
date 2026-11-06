#!/usr/bin/env bash
# Claude bir dosyayı düzenledikten sonra çalışır (PostToolUse hook).
# stdin'den gelen JSON'dan dosya yolunu alır ve uzantıya göre formatlar.
# Hata olsa bile Claude'u durdurmaz (exit 0).

file=$(jq -r '.tool_input.file_path // empty' 2>/dev/null)
[ -z "$file" ] || [ ! -f "$file" ] && exit 0

case "$file" in
  *.cs)            command -v dotnet >/dev/null && dotnet format --include "$file" >/dev/null 2>&1 ;;
  *.go)            command -v gofmt  >/dev/null && gofmt -w "$file" ;;
  *.py)            command -v ruff   >/dev/null && ruff format -q "$file" && ruff check -q --fix "$file" ;;
  *.ts|*.tsx|*.js|*.json|*.md|*.yaml|*.yml)
                   command -v npx    >/dev/null && npx --no-install prettier --write "$file" >/dev/null 2>&1 ;;
esac
exit 0
