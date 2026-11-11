" Perl (perl) – еднаквите клавиши към ALE и проверка за инструментите.
" Файлът е в after/ftplugin: изпълнява се след ftplugin-ите на Vim и на
" добавките, затова нашите клавиши имат последната дума.
" Клавишите (gd, K, \h, gr, \rn, ]e/[e, Ctrl+клик) – виж
" .vim/autoload/myide.vim. Проверките/форматирането – .vim/ale_settings.vim.
" perltidy форматира при запис; perlcritic проверява чрез Perl Navigator.
call myide#AleKeys()
call myide#CheckTools('Perl', ['perl', 'perlnavigator', 'perltidy', 'perlcritic'])
