#!/bin/bash
# バックアップ先ディレクトリ
backup_dir="$HOME/.chezmoi_backups"
mkdir -p "$backup_dir"

# バックアップ処理
for file in "$@"; do
  if [ -f "$file" ]; then
    cp "$file" "$backup_dir/$(basename "$file").$(date +%Y%m%d%H%M%S).bak"
  fi
done

