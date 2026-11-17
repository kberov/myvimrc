" HTML (html) – еднаквите клавиши към ALE и проверка за инструментите.
" Файлът е в after/ftplugin: изпълнява се след ftplugin-ите на Vim и на
" добавките, затова нашите клавиши имат последната дума.
" Клавишите (gd, K, \h, gr, \rn, ]e/[e, Ctrl+клик) – вижте
" .vim/autoload/myide.vim. Проверките/форматирането – .vim/ale_settings.vim.
" Изпълнява се и за образците .html.ep (filetype html.epl). Без проверки и
" форматиране на HTML – само довършване и описание (вкл. hx-* атрибутите).
" ftplugin-ите на Vim за markdown, php, eruby, xhtml, htmldjango… зареждат ftplugin/html.vim с
" `runtime! ftplugin/html.vim`, а това хваща и този файл. Тук – само ако
" HTML наистина е сред видовете на буфера (html, html.epl).
if index(split(&filetype, '\.'), 'html') < 0
    finish
endif

call myide#AleKeys()
call myide#CheckTools('HTML', ['vscode-html-language-server', 'htmx-lsp'])
