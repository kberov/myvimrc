" Езиковите файлове в .vim/after/ftplugin/ (с всички добавки).
function! s:Open(name) abort
  execute 'edit' fnameescape($REPO . '/tests/fixtures/' . a:name)
endfunction

" Буферни съответствия в режим на въвеждане, започващи с <leader> (\).
" Не бива да има: при кирилица \ става ю.
function! s:InsertLeaderMaps() abort
  return filter(maplist(), {_, m -> m.buffer && m.mode =~# '[i!]'
        \ && m.lhs[0] ==# get(g:, 'mapleader', '\')})
endfunction

" ALE езиците: gd → ALE.
for s:f in ['x.pl', 'x.sh', 'x.js', 'x.html', 'x.html.ep']
  call s:Open(s:f)
  call assert_match('ALEGoToDefinition', maparg('gd', 'n'), s:f . ' gd')
  call assert_match('ALEFindReferences', maparg('gr', 'n'), s:f . ' gr')
  call assert_equal([], s:InsertLeaderMaps(), s:f . ' без \ в режим на въвеждане')
endfor

" Go: vim-go.
call s:Open('x.go')
call assert_match('GoDef', maparg('gd', 'n'), 'go gd')
call assert_match('GoReferrers', maparg('gr', 'n'), 'go gr')
call assert_match('GoRename', maparg('<leader>rn', 'n'), 'go \rn')
call assert_match('lnext', maparg(']e', 'n'), 'go ]e')
call assert_match('lprevious', maparg('[e', 'n'), 'go [e')
call assert_match('GoDef', maparg('<C-LeftMouse>', 'n'), 'go Ctrl+клик')
call assert_notmatch('ALE', maparg('gd', 'n'), 'go без ALE')
call assert_equal([], s:InsertLeaderMaps(), 'go без \ в режим на въвеждане')

" Смяна на вида на буфера маха нашите клавиши (b:undo_ftplugin).
" `||` в него е празна команда `:|`, която изписва текущия ред при всяко :e.
call s:Open('x.go')
call assert_notmatch('||', get(b:, 'undo_ftplugin', ''), 'go: без || в undo_ftplugin')
call s:Open('x.pl')
call assert_notmatch('||', get(b:, 'undo_ftplugin', ''), 'perl: без || в undo_ftplugin')
setfiletype text
set filetype=text
call assert_notmatch('ALEGoToDefinition', maparg('gd', 'n'), 'undo_ftplugin')

" Съобщение за липсващ инструмент (htmx-lsp още не е инсталиран тук).
if !executable('htmx-lsp')
  call assert_match('HTML: липсват .*htmx-lsp', execute('messages'), 'CheckTools HTML')
endif

call writefile(v:errors, $TEST_OUT) | qa!
