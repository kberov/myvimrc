" Perl (perl) – еднаквите клавиши към ALE и проверка за инструментите.
" Файлът е в after/ftplugin: изпълнява се след ftplugin-ите на Vim и на
" добавките, затова нашите клавиши имат последната дума.
" Клавишите (gd, K, \h, gr, \rn, ]e/[e, Ctrl+клик) – виж
" .vim/autoload/myide.vim. Проверките/форматирането – .vim/ale_settings.vim.
" perltidy форматира при запис; perlcritic проверява чрез Perl Navigator.
call myide#AleKeys()
call myide#CheckTools('Perl', ['perl', 'perlnavigator', 'perltidy', 'perlcritic'])

" perltidy при запис: профилът на проекта (най-близкият .perltidyrc нагоре
" от файла), иначе ~/.perltidyrc. ALE пуска perltidy върху временно копие
" от текущата папка на Vim, затова perltidy сам не би намерил проекта, ако
" GVim е пуснат другаде.
let s:rc = myide#FindUp('.perltidyrc')
if empty(s:rc) && filereadable(expand('~/.perltidyrc'))
    let s:rc = expand('~/.perltidyrc')
endif
let b:ale_perl_perltidy_options = empty(s:rc) ? '' : '-pro=' . shellescape(s:rc)
call myide#AddUndo('unlet! b:ale_perl_perltidy_options')

" perl -c само при запис (виж .vim/ale_linters/perl/perlsave.vim): отбелязваме,
" че в тази сесия файлът е записван. BufWritePre, а не BufWritePost: ALE
" проверява при запис веднага, в своя BufWritePost, т.е. преди нашия.
augroup myide_perl_save
    autocmd! * <buffer>
    autocmd BufWritePre <buffer> let b:myide_saved = 1
augroup END
call myide#AddUndo('silent! autocmd! myide_perl_save * <buffer>|unlet! b:myide_saved')
