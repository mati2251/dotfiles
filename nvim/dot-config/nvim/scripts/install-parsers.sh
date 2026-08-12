#!/usr/bin/env bash
# Instaluje parsery treesittera i ich zapytania bez nvim-treesitter jako pluginu.
#
# Parsery ida do $XDG_DATA_HOME/nvim/site/parser/<lang>.so, zapytania do
# .../site/queries/<lang>/. Oba katalogi sa na 'runtimepath', wiec Neovim
# znajduje je sam (:h treesitter-parsers).
#
# Wersje gramatyk sa przypiete do tych samych commitow, ktorych uzywa
# nvim-treesitter - dzieki temu zapytania pasuja do drzewa skladniowego.
# Odswiezenie wersji: lua/nvim-treesitter/parsers.lua na gałęzi main.
#
# Uzycie: ./install-parsers.sh [lang...]   (bez argumentow: wszystkie)

set -euo pipefail

SITE="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site"
NTS_REF="main"
QUERY_FILES=(highlights.scm injections.scm folds.scm locals.scm)

# lang -> "url revision"
declare -A GRAMMARS=(
    [go]="https://github.com/tree-sitter/tree-sitter-go 2346a3ab1bb3857b48b29d779a1ef9799a248cd7"
    [python]="https://github.com/tree-sitter/tree-sitter-python v0.25.0"
    [bash]="https://github.com/tree-sitter/tree-sitter-bash a06c2e4415e9bc0346c6b86d401879ffb44058f7"
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

    # gramatyki maja wygenerowany src/parser.c w repo, tree-sitter CLI nie jest
    # potrzebny. Czesc ma dodatkowy zewnetrzny skaner (C lub C++).
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
echo "Gotowe. Sprawdz w Neovimie: :checkhealth vim.treesitter"
