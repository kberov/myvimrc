#!/bin/sh
# Личният речник (*.add) е в хранилището: думите от него се разпознават
# дори при празен ~/.vim (нова машина, WSL).
set -eu
REAL_HOME=$HOME
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

# „Вим“ (бълг. изписване на Vim) – от българския личен речник в хранилището.
# Без главния български речник (bg.utf-8.spl) Vim не проверява на български
# и всяка дума минава, затова слагаме връзка само към него (не и към личния
# ~/.vim/spell/bg.utf-8.add). Ако го няма – тази проверка се пропуска.
if [ -f "$REAL_HOME/.vim/spell/bg.utf-8.spl" ]; then
    mkdir -p "$HOME/.vim/spell"
    ln -s "$REAL_HOME/.vim/spell/bg.utf-8.spl" "$HOME/.vim/spell/"
    : >"$OUTF"
    # shellcheck disable=SC2016
    vim -N -u "$REPO/.vimrc" -i NONE -es \
        -c 'setlocal spell spelllang=bg' \
        -c 'call writefile([spellbadword("Вим")[0], spellbadword("Щъркелбзз")[0]], $OUTF)' \
        -c 'qa!' </dev/null >/dev/null 2>&1 || true
    if [ "$(sed -n 2p "$OUTF")" != 'Щъркелбзз' ]; then
        echo "българската проверка не работи (безсмислена дума минава)"
        exit 1
    fi
    if [ -n "$(sed -n 1p "$OUTF")" ]; then
        echo "думата Вим от личния речник не се разпознава"
        exit 1
    fi
fi
