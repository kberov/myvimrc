" Общите функции в .vim/autoload/myide.vim.

" test_checktools_missing: връща липсващите и съобщава точно веднъж.
call assert_equal(['no-such-tool-xyz'],
      \ myide#CheckTools('T', ['sh', 'no-such-tool-xyz']), 'CheckTools липсващ')
call myide#CheckTools('T', ['sh', 'no-such-tool-xyz'])
let s:msgs = split(execute('messages'), "\n")
let s:readme = fnamemodify(g:myvimrc_dir . '/README.md', ':~')
call assert_equal(1, count(s:msgs,
      \ 'T: липсват no-such-tool-xyz (как се инсталират – вижте ' . s:readme . ')'),
      \ 'съобщението веднъж')

" test_checktools_all_present: нищо не липсва – нищо не се изписва.
call assert_equal([], myide#CheckTools('U', ['sh']), 'CheckTools всичко е налице')
call assert_equal(0, len(filter(split(execute('messages'), "\n"), 'v:val =~# "^U:"')),
      \ 'без съобщение за U')

" test_alekeys: буферни клавиши към ALE + omnifunc.
enew
setfiletype perl
call myide#AleKeys()
call assert_match('ALEGoToDefinition', maparg('gd', 'n'), 'gd')
call assert_match('ALEHover', maparg('K', 'n'), 'K')
call assert_match('ALEHover', maparg('<leader>h', 'n'), '\h')
call assert_match('ALEFindReferences', maparg('gr', 'n'), 'gr')
call assert_match('ALERename', maparg('<leader>rn', 'n'), '\rn')
call assert_match('ale_next_wrap', maparg(']e', 'n'), ']e')
call assert_match('ale_previous_wrap', maparg('[e', 'n'), '[e')
call assert_match('ALEGoToDefinition', maparg('<C-LeftMouse>', 'n'), 'Ctrl+клик')
call assert_equal(1, get(maparg('gd', 'n', 0, 1), 'buffer', 0), 'gd е буферно')
call assert_equal('ale#completion#OmniFunc', &l:omnifunc, 'omnifunc')

" Само в този буфер: в нов буфер няма gd към ALE.
enew
call assert_notmatch('ALEGoToDefinition', maparg('gd', 'n'), 'gd в друг буфер')

" test_has_perl_module: бърза проверка по @INC, без да се зарежда модулът.
call assert_equal(1, myide#HasPerlModule('File::Spec'), 'File::Spec е в ядрото')
call assert_equal(0, myide#HasPerlModule('No::Such::ModXyz'), 'липсващ модул')

" test_checktools_module: елемент с :: е Perl модул, другите – програми.
call assert_equal(['No::Such::ModXyz'],
      \ myide#CheckTools('M', ['sh', 'File::Spec', 'No::Such::ModXyz']), 'CheckTools модул')

" test_perl_linters: без Perl::LanguageServer ALE не пуска perlls (иначе
" би сипал грешки при всяко отваряне); съобщението е от CheckTools.
call assert_equal(['perlsave', 'perlls', 'perlcritic'], myide#PerlLinters(1), 'със сървър')
call assert_equal(['perlsave', 'perlcritic'], myide#PerlLinters(0), 'без сървър')

call writefile(v:errors, $TEST_OUT) | qa!
