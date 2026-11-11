" Shell (sh) – еднаквите клавиши към ALE и проверка за инструментите.
" Файлът е в after/ftplugin: изпълнява се след ftplugin-ите на Vim и на
" добавките, затова нашите клавиши имат последната дума.
" Клавишите (gd, K, \h, gr, \rn, ]e/[e, Ctrl+клик) – виж
" .vim/autoload/myide.vim. Проверките/форматирането – .vim/ale_settings.vim.
" shfmt (-i 4 -ci) форматира при запис; shellcheck проверява.
call myide#AleKeys()
call myide#CheckTools('Shell', ['bash-language-server', 'shellcheck', 'shfmt'])
