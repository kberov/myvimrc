" perlls – Perl::LanguageServer (CPAN), но БЕЗ собствения му `perl -c`.
"
" Сървърът пуска `perl -c` при всяко отваряне и всяка промяна на файла, а
" `perl -c` изпълнява кода в BEGIN блоковете и `use`-ите. Тук той трябва да
" тръгва само при запис (perlsave). Настройка, която да го спре, сървърът
" няма: `perl.perlCmd` е настройка на разширението за VS Code (с нея то пуска
" самия сървър), а сървърът не я чете.
"
" Сървърът пуска проверката със свойството perlcmd на своя Workspace, а
" стойността му по подразбиране е `$^X`, взета при зареждане на модула
" (Perl/LanguageServer/Workspace.pm: `default => $^X`; другаде $^X не се
" ползва). Затова задаваме `$^X = "true"` в BEGIN – преди `use` – и сървърът
" пуска `true -c …`, което нищо не изпълнява и нищо не съобщава. Кодът на
" модула не се пипа. (Дебъгерът на сървъра също би ползвал perlcmd, но във
" Vim не го ползваме.)
"
" Останалото е като вградения в ALE linter `languageserver`
" (ale_linters/perl/languageserver.vim): същата настройка
" g:ale_perl_languageserver_config, същият корен на проекта. Вграденият езиков
" сървър не става, защото командата му е неизменна и там
" -MPerl::LanguageServer зарежда модула преди всеки наш BEGIN.
" Проверява се от tests/test_perl_ls.sh (с истинския сървър).
" Включва се от g:ale_linters в .vim/ale_settings.vim ('perlls').

call ale#Set('perl_perl_executable', 'perl')
call ale#Set('perl_languageserver_config', {})

" Без workspace/didChangeConfiguration сървърът не тръгва – затова поне
" {'perl': {'enable': 1}} (както във вградения linter).
function! ale_linters#perl#perlls#GetConfig(buffer) abort
    let l:config = ale#Var(a:buffer, 'perl_languageserver_config')

    return empty(l:config) ? {'perl': {'enable': 1}} : l:config
endfunction

call ale#linter#Define('perl', {
\   'name': 'perlls',
\   'lsp': 'stdio',
\   'executable': {b -> ale#Var(b, 'perl_perl_executable')},
\   'command': '%e -e '
\       . ale#Escape('BEGIN { $^X = "true" } use Perl::LanguageServer; Perl::LanguageServer::run'),
\   'lsp_config': {b -> ale_linters#perl#perlls#GetConfig(b)},
\   'project_root': function('ale#handlers#perl#GetProjectRoot'),
\})
