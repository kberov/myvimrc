#!/bin/sh
# Тестове за ./install. Всичко става във временен HOME – истинският ~ не
# се пипа. Провал = код ≠ 0 и съобщение на стандартния изход.
# `~` в съобщенията е само текст, не път – затова SC2088 е изключено.
# shellcheck disable=SC2088
set -u

fails=0
fail() {
    echo "$1: $2"
    fails=$((fails + 1))
}

# Нов празен HOME с ~/.vim/plugged (то не бива да се мести никога).
newhome() {
    HOME=$(mktemp -d)
    export HOME
    mkdir -p "$HOME/.vim/plugged/some-plugin"
}

# Пуска install; изходът – в $OUT.
run_install() {
    OUT=$(mktemp)
    "$REPO/install" >"$OUT" 2>&1
}

is_repo_link() {
    [ -L "$HOME/$1" ] && [ "$(readlink "$HOME/$1")" = "$REPO/$1" ]
}

count() {
    # Брои файловете/папките по шаблон (без грешка, ако няма такива).
    n=0
    for f in "$@"; do
        [ -e "$f" ] || [ -L "$f" ] || continue
        n=$((n + 1))
    done
    echo "$n"
}

# --- test_fresh: празен HOME → две връзки към хранилището ---
newhome
run_install || fail test_fresh "код $?"
is_repo_link .vimrc || fail test_fresh "~/.vimrc не е връзка към хранилището"
is_repo_link .gvimrc || fail test_fresh "~/.gvimrc не е връзка към хранилището"
grep -q ':PlugInstall' "$OUT" || fail test_fresh "няма напомняне за :PlugInstall"
rm -rf "$HOME"

# --- test_backup_plain: обикновен ~/.vimrc и чужда връзка ~/.gvimrc ---
newhome
echo old >"$HOME/.vimrc"
ln -s /nowhere/gvimrc "$HOME/.gvimrc"
run_install || fail test_backup_plain "код $?"
is_repo_link .vimrc || fail test_backup_plain "~/.vimrc не е връзка"
is_repo_link .gvimrc || fail test_backup_plain "~/.gvimrc не е връзка"
[ "$(count "$HOME"/.vimrc.bak.*)" -eq 1 ] || fail test_backup_plain "няма точно един ~/.vimrc.bak.*"
[ "$(cat "$HOME"/.vimrc.bak.* 2>/dev/null)" = old ] || fail test_backup_plain "загубено съдържание"
[ "$(count "$HOME"/.gvimrc.bak.*)" -eq 1 ] || fail test_backup_plain "чуждата връзка не е запазена"
rm -rf "$HOME"

# --- test_idempotent: второ пускане не прави нищо ново ---
newhome
echo x >"$HOME/.vim/mymappings.vim"
run_install
run_install || fail test_idempotent "код $?"
[ "$(count "$HOME"/.vimrc.bak.* "$HOME"/.gvimrc.bak.*)" -eq 0 ] || fail test_idempotent "нови .bak файлове"
[ "$(count "$HOME"/.vim/backup-*)" -eq 1 ] || fail test_idempotent "повече от една backup-* папка"
grep -q 'OK ~/.vimrc' "$OUT" || fail test_idempotent "няма 'OK ~/.vimrc'"
rm -rf "$HOME"

# --- test_old_copies: старите копия → ~/.vim/backup-*/ ; plugged и връзки остават ---
newhome
echo x >"$HOME/.vim/mymappings.vim"
mkdir -p "$HOME/.vim/keymap" && echo y >"$HOME/.vim/keymap/oldbgph.vim"
ln -s "$REPO/.vim/myplugins.vim" "$HOME/.vim/myplugins.vim"
run_install || fail test_old_copies "код $?"
[ ! -e "$HOME/.vim/mymappings.vim" ] || fail test_old_copies "mymappings.vim не е преместен"
[ ! -e "$HOME/.vim/keymap" ] || fail test_old_copies "keymap/ не е преместена"
[ "$(count "$HOME"/.vim/backup-*/mymappings.vim)" -eq 1 ] || fail test_old_copies "mymappings.vim не е в backup-*"
[ "$(count "$HOME"/.vim/backup-*/keymap/oldbgph.vim)" -eq 1 ] || fail test_old_copies "keymap/ не е в backup-*"
[ -d "$HOME/.vim/plugged/some-plugin" ] || fail test_old_copies "plugged/ е пипнат"
[ -L "$HOME/.vim/myplugins.vim" ] || fail test_old_copies "връзката е преместена"
rm -rf "$HOME"

# --- test_vim_dir_is_repo_link: ~/.vim → <хранилище>/.vim не се „чисти“ ---
# Работи върху копие на хранилището, за да не пипне истинските файлове.
newhome
CLONE=$(mktemp -d)
cp -R "$REPO/." "$CLONE/"
rm -rf "$HOME/.vim"
ln -s "$CLONE/.vim" "$HOME/.vim"
"$CLONE/install" >/dev/null 2>&1 || fail test_vim_dir_is_repo_link "код $?"
[ -f "$CLONE/.vim/mymappings.vim" ] || fail test_vim_dir_is_repo_link "mymappings.vim от хранилището е преместен"
[ -d "$CLONE/.vim/keymap" ] || fail test_vim_dir_is_repo_link "keymap/ от хранилището е преместена"
[ "$(count "$CLONE"/.vim/backup-*)" -eq 0 ] || fail test_vim_dir_is_repo_link "backup-* в хранилището"
rm -rf "$HOME" "$CLONE"

# --- test_spell_add_files: старите *.add в ~/.vim/spell → backup; речниците остават ---
newhome
mkdir -p "$HOME/.vim/spell"
echo dumi >"$HOME/.vim/spell/bg.utf-8.add"
echo bin >"$HOME/.vim/spell/bg.utf-8.add.spl"
echo big >"$HOME/.vim/spell/bg.utf-8.spl"
run_install || fail test_spell_add_files "код $?"
[ ! -e "$HOME/.vim/spell/bg.utf-8.add" ] || fail test_spell_add_files "bg.utf-8.add не е преместен"
[ ! -e "$HOME/.vim/spell/bg.utf-8.add.spl" ] || fail test_spell_add_files "bg.utf-8.add.spl не е преместен"
[ "$(count "$HOME"/.vim/backup-*/spell/bg.utf-8.add)" -eq 1 ] || fail test_spell_add_files "bg.utf-8.add не е в backup-*/spell/"
[ -f "$HOME/.vim/spell/bg.utf-8.spl" ] || fail test_spell_add_files "главният речник е пипнат"
rm -rf "$HOME"

# --- test_no_backup_dir_when_nothing_to_move ---
newhome
run_install
[ "$(count "$HOME"/.vim/backup-*)" -eq 0 ] || fail test_no_backup_dir "празна backup-* папка"
rm -rf "$HOME"

# --- test_missing_tools: с беден PATH изписва какво липсва и как се инсталира ---
newhome
OUT=$(mktemp)
PATH=/usr/bin:/bin "$REPO/install" >"$OUT" 2>&1 || fail test_missing_tools "код $?"
grep -q '^ЛИПСВА htmx-lsp: cargo install htmx-lsp' "$OUT" || fail test_missing_tools "няма ред за htmx-lsp"
grep -q '^ЛИПСВА tsserver: npm i -g typescript@5' "$OUT" || fail test_missing_tools "няма ред за tsserver"
rm -rf "$HOME"

[ "$fails" -eq 0 ]
