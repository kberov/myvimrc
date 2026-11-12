" perl -c (изпълнява BEGIN/use кода!) се пуска само при запис: проверката
" perlsave дава празна команда (ALE я пропуска), освен ако буферът е току-що
" записан и след това непроменен.
let s:d = fnamemodify(tempname(), ':p')
call mkdir(s:d)
call writefile(readfile($REPO . '/tests/fixtures/x.pl'), s:d . '/a.pl')
execute 'edit' fnameescape(s:d . '/a.pl')
let s:names = map(copy(ale#linter#Get('perl')), 'v:val.name')
call assert_equal(['perlnavigator', 'perlsave'], sort(s:names), 'perl проверки')
call assert_equal('', ale_linters#perl#perlsave#GetCommand(bufnr('')), 'при отваряне – нищо')
write
call assert_match('-c', ale_linters#perl#perlsave#GetCommand(bufnr('')), 'след запис – perl -c')
" ALE форматира (чрез perltidy) асинхронно СЛЕД записа и сам записва пак – това
" променя b:changedtick, но буферът пак е записан (без незаписани промени).
call setline(1, 'use strict; # форматирано')
noautocmd write
call assert_match('-c', ale_linters#perl#perlsave#GetCommand(bufnr('')), 'след форматиране и запис')
call setline(1, 'use strict; # променено')
call assert_equal('', ale_linters#perl#perlsave#GetCommand(bufnr('')), 'след промяна – нищо')
call writefile(v:errors, $TEST_OUT) | qa!
