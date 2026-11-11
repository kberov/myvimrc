" .vimrc открива собствената си папка (g:myvimrc_dir) и слага
" <хранилище>/.vim в началото, а <хранилище>/.vim/after в края на runtimepath.
" Повторното зареждане на .vimrc не бива да дублира пътищата.
source $REPO/.vimrc
call assert_equal($REPO, get(g:, 'myvimrc_dir', ''), 'g:myvimrc_dir')
let s:rtp = split(&rtp, ',')
call assert_equal($REPO . '/.vim', s:rtp[0], 'първи в rtp')
call assert_equal($REPO . '/.vim/after', s:rtp[-1], 'последен в rtp')
call assert_equal(1, count(s:rtp, $REPO . '/.vim'), 'без дубликати на .vim')
call assert_equal(1, count(s:rtp, $REPO . '/.vim/after'), 'без дубликати на .vim/after')
call writefile(v:errors, $TEST_OUT) | qa!
