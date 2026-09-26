#!/usr/bin/env bash

set -euo pipefail

SITE="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site"
NTS_REF="main"
QUERY_FILES=(highlights.scm injections.scm folds.scm locals.scm)

declare -A GRAMMARS=(
    [go]="https://github.com/tree-sitter/tree-sitter-go 2346a3ab1bb3857b48b29d779a1ef9799a248cd7"
    [python]="https://github.com/tree-sitter/tree-sitter-python v0.25.0"
    [bash]="https://github.com/tree-sitter/tree-sitter-bash a06c2e4415e9bc0346c6b86d401879ffb44058f7"
    [nix]="https://github.com/nix-community/tree-sitter-nix a2cd7f4011c6e5830c0c9af5aa35441b3ddd5fba"
)

langs=("$@")
if [ ${#langs[@]} -eq 0 ]; then
    langs=("${!GRAMMARS[@]}")
fi

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

mkdir -p "$SITE/parser" "$SITE/queries"

for lang in "${langs[@]}"; do
    if [ -z "${GRAMMARS[$lang]:-}" ]; then
        echo "!! nieznany jezyk: $lang" >&2
        exit 1
    fi
    read -r url rev <<<"${GRAMMARS[$lang]}"

    echo ":: $lang"
    src="$tmp/$lang"
    mkdir -p "$src"
    git -C "$src" init -q
    git -C "$src" remote add origin "$url"
    git -C "$src" fetch -q --depth 1 origin "$rev"
    git -C "$src" checkout -q FETCH_HEAD

    sources=("$src/src/parser.c")
    compiler=cc
    if [ -f "$src/src/scanner.c" ]; then
        sources+=("$src/src/scanner.c")
    elif [ -f "$src/src/scanner.cc" ]; then
        sources+=("$src/src/scanner.cc")
        compiler=c++
    fi

    "$compiler" -O2 -fPIC -shared -I"$src/src" "${sources[@]}" -o "$SITE/parser/$lang.so"
    echo "   parser  -> $SITE/parser/$lang.so"

    mkdir -p "$SITE/queries/$lang"
    for q in "${QUERY_FILES[@]}"; do
        if curl -sfL \
            "https://raw.githubusercontent.com/nvim-treesitter/nvim-treesitter/$NTS_REF/runtime/queries/$lang/$q" \
            -o "$SITE/queries/$lang/$q"; then
            echo "   query   -> $lang/$q"
        else
            rm -f "$SITE/queries/$lang/$q"
        fi
    done
done

echo
echo "Done! Installed parsers for: ${langs[*]}"
