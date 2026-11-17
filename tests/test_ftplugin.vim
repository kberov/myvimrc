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

"" test_ftplugin_not_via_runtime: ftplugin-ите на Vim за markdown, php,
" javascriptreact… зареждат ftplugin/html.vim или javascript.vim с
" `runtime!`, а това хваща и нашите after/ftplugin файлове. Там – нищо наше.
" Преди всеки HTML буфер: CheckTools съобщава само веднъж на сесия.
for [s:f, s:ft] in [['x.md', 'markdown'], ['x.jsx', 'javascriptreact']]
  call s:Open(s:f)
  call assert_equal(s:ft, &filetype, s:f . ' filetype')
  call assert_notmatch('ALE', maparg('gd', 'n'), s:f . ' gd – не към ALE')
endfor
call assert_notmatch('HTML: липсват', execute('messages'), '.md – без съобщение за HTML')
call assert_notmatch('JavaScript: липсват', execute('messages'), '.jsx – без съобщение за JS')

" test_ftplugin_htm: .htm е HTML, дори Vim да познае htmldjango по {% %}
" (образците на Go с прост двигател – заместителите са обикновен текст).
call s:Open('x.htm')
call assert_equal('html', &filetype, '.htm filetype')

" ALE езиците: gd → ALE.
for s:f in ['x.pl', 'x.sh', 'x.js', 'x.html', 'x.html.ep', 'x.htm']
  call s:Open(s:f)
  call assert_match('ALEGoToDefinition', maparg('gd', 'n'), s:f . ' gd')
  call assert_match('ALEFindReferences', maparg('gr', 'n'), s:f . ' gr')
  call assert_equal([], s:InsertLeaderMaps(), s:f . ' без \ в режим на въвеждане')
endfor

"" test_perl_buffer_linters: в Perl буфер проверките зависят от това дали
" Perl::LanguageServer е инсталиран.
call s:Open('x.pl')
call assert_equal(myide#PerlLinters(myide#HasPerlModule('Perl::LanguageServer')),
      \ get(b:, 'ale_linters', 'няма'), 'perl b:ale_linters')

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

" test_perl_undo_save_mark: смяната на вида маха и отметката за запис на
" perl.vim, и автокомандата ѝ (за perlsave).
call s:Open('x.pl')
let b:myide_saved = 1
set filetype=text
call assert_false(exists('b:myide_saved'), 'perl undo: b:myide_saved')
call assert_false(exists('#myide_perl_save#BufWritePre#<buffer>'),
      \ 'perl undo: автокомандата BufWritePre')

" Съобщение за липсващ инструмент (htmx-lsp още не е инсталиран тук).
if !executable('htmx-lsp')
  call assert_match('HTML: липсват .*htmx-lsp', execute('messages'), 'CheckTools HTML')
endif

call writefile(v:errors, $TEST_OUT) | qa!
