#!/bin/sh
# .vimrc без vim-plug (нова машина, празен ~/.vim) стартира без грешки.
set -eu
HOME=$(mktemp -d)
export HOME
trap 'rm -rf "$HOME"' EXIT
OUTF="$HOME/msgs"
export OUTF
cd "$HOME"
# $OUTF се разгъва от Vim, не от обвивката – затова е в единични кавички.
# shellcheck disable=SC2016
vim -N -u "$REPO/.vimrc" -i NONE -es \
    -c 'call writefile(split(execute("messages"), "\n"), $OUTF)' -c 'qa!' \
    </dev/null >/dev/null 2>&1 || true
if grep -q 'E[0-9][0-9]*:' "$OUTF"; then
    echo "грешки при стартиране без vim-plug:"
    grep 'E[0-9][0-9]*:' "$OUTF" | sort -u | head -5
    exit 1
fi
