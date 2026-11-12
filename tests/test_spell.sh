#!/bin/sh
# Личният речник (*.add) е в хранилището: думите от него се разпознават
# дори при празен ~/.vim (нова машина, WSL).
set -eu
HOME=$(mktemp -d)
export HOME
trap 'rm -rf "$HOME"' EXIT
OUTF="$HOME/out"
export OUTF
cd "$HOME"
# $OUTF се разгъва от Vim, не от обвивката – затова е в единични кавички.
# shellcheck disable=SC2016
vim -N -u "$REPO/.vimrc" -i NONE -es \
    -c 'setlocal spell spelllang=en' \
    -c 'call writefile([spellbadword("Mojolicious")[0]], $OUTF)' -c 'qa!' \
    </dev/null >/dev/null 2>&1 || true
got=$(cat "$OUTF" 2>/dev/null || echo '(няма изход)')
if [ -n "$got" ]; then
    echo "„Mojolicious“ от личния речник не се разпознава: '$got'"
    exit 1
fi
