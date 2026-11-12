#!/bin/sh
# .vimrc, зареден през връзка (както ~/.vimrc след install), трябва да
# открие истинското хранилище, а не папката на връзката.
set -eu
d=$(mktemp -d)
trap 'rm -rf "$d"' EXIT
ln -s "$REPO/.vimrc" "$d/link_vimrc"
OUTF="$d/out"
export OUTF
cd "$d"
# $OUTF се разгъва от Vim, не от обвивката – затова е в единични кавички.
# shellcheck disable=SC2016
vim -N -u "$d/link_vimrc" -i NONE -es \
    -c 'call writefile([get(g:, "myvimrc_dir", "")], $OUTF)' -c 'qa!' \
    </dev/null >/dev/null 2>&1 || true
got=$(cat "$OUTF" 2>/dev/null || echo '(няма изход)')
if [ "$got" != "$REPO" ]; then
    echo "очаквах g:myvimrc_dir=$REPO, получих '$got'"
    exit 1
fi
