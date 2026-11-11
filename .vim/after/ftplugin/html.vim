" HTML (html) – еднаквите клавиши към ALE и проверка за инструментите.
" Файлът е в after/ftplugin: изпълнява се след ftplugin-ите на Vim и на
" добавките, затова нашите клавиши имат последната дума.
" Клавишите (gd, K, \h, gr, \rn, ]e/[e, Ctrl+клик) – виж
" .vim/autoload/myide.vim. Проверките/форматирането – .vim/ale_settings.vim.
" Изпълнява се и за шаблоните .html.ep (filetype html.epl). Без проверки и
" форматиране на HTML – само довършване и описание (вкл. hx-* атрибутите).
call myide#AleKeys()
call myide#CheckTools('HTML', ['vscode-html-language-server', 'htmx-lsp'])
