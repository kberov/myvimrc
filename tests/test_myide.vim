" Общите функции в .vim/autoload/myide.vim.

" test_checktools_missing: връща липсващите и съобщава точно веднъж.
call assert_equal(['no-such-tool-xyz'],
      \ myide#CheckTools('T', ['sh', 'no-such-tool-xyz']), 'CheckTools липсващ')
call myide#CheckTools('T', ['sh', 'no-such-tool-xyz'])
let s:msgs = split(execute('messages'), "\n")
call assert_equal(1, count(s:msgs, 'T: липсват no-such-tool-xyz (вижте install)'),
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

call writefile(v:errors, $TEST_OUT) | qa!
