#!/bin/sh
# Perl::LanguageServer така, както го пуска Vim: командата на linter-а
# perlls (.vim/ale_linters/perl/perlls.vim) и настройката
# g:ale_perl_languageserver_config.
#   test_ls_no_compile            – сървърът НЕ пуска `perl -c` при отваряне;
#   test_ls_definition            – `gd` работи и в папка без .git;
#   test_ls_cache_outside_project – кешът е в ~/.cache/perl-lang, не в проекта;
#   test_ls_control               – голият сървър (командата на вградения в
#                                   ALE `languageserver`) пуска `perl -c`
#                                   (доказва, че тестът изобщо го вижда).
# Begin.pm създава файла $LS_MARK в BEGIN блок, тоест само ако някой го
# изпълни – а `perl -c` изпълнява BEGIN.
# Ако модулът липсва: SKIP (успех).
set -eu

if ! perl -e 'exit !grep { -f "$_/Perl/LanguageServer.pm" } @INC'; then
    echo "SKIP: няма Perl::LanguageServer"
    exit 0
fi

REAL_HOME=$HOME
HOME=$(mktemp -d)
export HOME
P=$(mktemp -d) # проектът – без .git
trap 'rm -rf "$HOME" "$P"' EXIT
cp "$REPO/tests/fixtures/ls/Begin.pm" "$P/"
fail=0

# Командата на perlls – с истинския $HOME, защото ALE е в ~/.vim/plugged.
# $OUTF се разгъва от Vim, не от обвивката – затова е в единични кавички.
OUTF="$HOME/cmd.txt"
export OUTF
# shellcheck disable=SC2016
HOME=$REAL_HOME vim -N -u "$REPO/.vimrc" -i NONE -es \
    -c 'let g:l = filter(ale#linter#Get("perl"), "v:val.name ==# \"perlls\"")' \
    -c 'let g:c = get(get(g:l, 0, {}), "command", "")' \
    -c 'call writefile([substitute(g:c, "%e", "perl", "g")], $OUTF)' \
    -c 'qa!' </dev/null >/dev/null 2>&1 || true
CMD=$(cat "$OUTF" 2>/dev/null || true)
if [ -z "$CMD" ]; then
    echo "няма linter perlls (липсва ли ALE в ~/.vim/plugged?)"
    exit 1
fi

# Настройката – такава, каквато я вижда Vim с празен $HOME.
OUTF="$HOME/cfg.json"
# shellcheck disable=SC2016
vim -N -u "$REPO/.vimrc" -i NONE -es \
    -c 'call writefile([json_encode(g:ale_perl_languageserver_config)], $OUTF)' \
    -c 'qa!' </dev/null >/dev/null 2>&1 || true
CFG=$(cat "$OUTF")

# run_ls КОМАНДА – пуска сървъра срещу $P/Begin.pm; изходът – в $HOME/ls.out.
run_ls() {
    LS_MARK="$P/mark" perl "$REPO/tests/lsp_client.pl" \
        "$P" "$P/Begin.pm" "$CFG" 5 -- sh -c "exec $1" >"$HOME/ls.out" || {
        echo "сървърът не отговори на initialize: $1"
        fail=1
    }
}

run_ls "$CMD"
if [ -e "$P/mark" ]; then
    echo "test_ls_no_compile: сървърът е пуснал perl -c (има $P/mark)"
    fail=1
fi
if ! grep -qx 'DEF 1' "$HOME/ls.out"; then
    echo "test_ls_definition: очаквах 'DEF 1', получих: $(cat "$HOME/ls.out")"
    fail=1
fi
if [ -e "$P/.vscode" ]; then
    echo "test_ls_cache_outside_project: сървърът е писал в $P/.vscode"
    fail=1
fi
if [ ! -d "$HOME/.cache/perl-lang" ]; then
    echo "test_ls_cache_outside_project: няма $HOME/.cache/perl-lang"
    fail=1
fi

# Контрола: голият сървър.
rm -rf "$P/mark" "$P/.vscode"
run_ls 'perl -MPerl::LanguageServer -ePerl::LanguageServer::run'
if [ ! -e "$P/mark" ]; then
    echo "test_ls_control: и голият сървър не пуска perl -c – тестът не го вижда"
    fail=1
fi

exit "$fail"
