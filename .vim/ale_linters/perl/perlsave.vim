" perlsave – същото като вградената проверка `perl` на ALE (`perl -c`), но
" САМО при запис. `perl -c` изпълнява кода в BEGIN блоковете и `use`-ите,
" затова не бива да тръгва само защото си отворил (може и чужд) файл.
"
" ALE пуска проверките в четири случая: при отваряне, след промяна в
" нормален режим, при излизане от режим на въвеждане и при запис. Тук
" командата е празна (ALE я пропуска), освен ако:
"   – в тази сесия файлът вече е записван (b:myide_saved, задава се при
"     запис от .vim/after/ftplugin/perl.vim) – значи не при отваряне, и
"   – буферът няма незаписани промени (&modified е 0) – значи не след
"     промяна, а при запис.
" (b:changedtick не става: ALE форматира с perltidy асинхронно СЛЕД записа
" и после записва пак, което променя changedtick.)
" Включва се от g:ale_linters в .vim/ale_settings.vim ('perlsave').

function! ale_linters#perl#perlsave#GetCommand(buffer) abort
    if !getbufvar(a:buffer, 'myide_saved', 0)
    \|| getbufvar(a:buffer, '&modified')
        return ''
    endif

    " Командата и обработката на изхода – от вградената проверка perl
    " (ale_linters/perl/perl.vim в ALE; ALE я зарежда заедно с тази).
    return ale_linters#perl#perl#GetCommand(a:buffer)
endfunction

call ale#linter#Define('perl', {
\   'name': 'perlsave',
\   'executable': {b -> ale#Var(b, 'perl_perl_executable')},
\   'output_stream': 'both',
\   'command': function('ale_linters#perl#perlsave#GetCommand'),
\   'callback': 'ale_linters#perl#perl#Handle',
\})
