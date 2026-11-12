" Shell (sh) – еднаквите клавиши към ALE и проверка за инструментите.
" Файлът е в after/ftplugin: изпълнява се след ftplugin-ите на Vim и на
" добавките, затова нашите клавиши имат последната дума.
" Клавишите (gd, K, \h, gr, \rn, ]e/[e, Ctrl+клик) – вижте
" .vim/autoload/myide.vim. Проверките/форматирането – .vim/ale_settings.vim.
" shfmt (-i 4 -ci) форматира при запис; shellcheck проверява.
call myide#AleKeys()
call myide#CheckTools('Shell', ['bash-language-server', 'shellcheck', 'shfmt'])

" Ако проектът има .editorconfig, shfmt го чете сам – но само когато не
" му подаваме наши флагове (-i 4 -ci от ale_settings.vim). Тогава махаме
" флаговете за този буфер, за да важи стилът на проекта.
if !empty(myide#FindUp('.editorconfig'))
    let b:ale_sh_shfmt_options = ''
    call myide#AddUndo('unlet! b:ale_sh_shfmt_options')
endif
