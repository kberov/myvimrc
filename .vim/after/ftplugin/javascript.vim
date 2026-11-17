" JavaScript (javascript) – еднаквите клавиши към ALE и проверка за инструментите.
" Файлът е в after/ftplugin: изпълнява се след ftplugin-ите на Vim и на
" добавките, затова нашите клавиши имат последната дума.
" Клавишите (gd, K, \h, gr, \rn, ]e/[e, Ctrl+клик) – вижте
" .vim/autoload/myide.vim. Проверките/форматирането – .vim/ale_settings.vim.
" tsserver идва от npm пакета typescript. Без форматиране и без eslint.
" ftplugin-ите на Vim за javascriptreact и др. зареждат ftplugin/javascript.vim с
" `runtime! ftplugin/javascript.vim`, а това хваща и този файл. Тук – само ако
" JavaScript наистина е сред видовете на буфера.
if index(split(&filetype, '\.'), 'javascript') < 0
    finish
endif

call myide#AleKeys()
call myide#CheckTools('JavaScript', ['tsserver'])
