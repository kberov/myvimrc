" Състоянието на Vim (история на Netrw) остава в ~/.vim, не в хранилището,
" въпреки че <хранилище>/.vim е първо в runtimepath.
call assert_equal(expand('~/.vim'), get(g:, 'netrw_home', ''), 'g:netrw_home')
call writefile(v:errors, $TEST_OUT) | qa!
