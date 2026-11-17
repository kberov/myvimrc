" Настройки на ALE (раздел 6 от документа
" docs/superpowers/specs/2026-11-11-vim-ide-design.md).

" --- Стойности ---
call assert_equal(1, get(g:, 'ale_linters_explicit', 0), 'ale_linters_explicit')
call assert_equal({
      \ 'perl': ['perlsave', 'languageserver', 'perlcritic'],
      \ 'sh': ['shellcheck', 'language_server'],
      \ 'javascript': ['tsserver'],
      \ 'html': ['vscodehtml', 'htmx'],
      \ 'epl': [],
      \ 'go': [],
      \ }, get(g:, 'ale_linters', {}), 'ale_linters')
call assert_equal({'perl': ['perltidy'], 'sh': ['shfmt']},
      \ get(g:, 'ale_fixers', {}), 'ale_fixers (без go)')
call assert_equal(1, get(g:, 'ale_fix_on_save', 0), 'ale_fix_on_save')
call assert_equal('-i 4 -ci', get(g:, 'ale_sh_shfmt_options', ''), 'shfmt')
call assert_equal(1, get(g:, 'ale_set_loclist', -1), 'ale_set_loclist')
call assert_equal(0, get(g:, 'ale_set_quickfix', -1), 'ale_set_quickfix')
call assert_equal(0, get(g:, 'ale_completion_enabled', -1), 'ale_completion_enabled')
let s:ls = get(get(g:, 'ale_perl_languageserver_config', {}), 'perl', {})
call assert_equal(1, get(s:ls, 'enable', 0), 'languageserver enable')
call assert_equal('true', get(s:ls, 'perlCmd', ''), 'perlCmd – без perl -c от сървъра')
call assert_equal(expand('~/.cache/perl-lang'), get(s:ls, 'cacheDir', ''), 'cacheDir')
call assert_false(exists('g:ale_perl_perlnavigator_config'), 'няма perlnavigator')

" --- Кои проверки се пускат в буфер от даден вид ---
function! s:Names() abort
  return sort(map(copy(ale#linter#Get(&filetype)), 'v:val.name'))
endfunction
function! s:Open(name) abort
  execute 'edit' fnameescape($REPO . '/tests/fixtures/' . a:name)
endfunction

" test_ale_html_epl_only_lsp: образците – само двата езикови сървъра.
call s:Open('x.html.ep')
call assert_equal('html.epl', &filetype, 'filetype на .html.ep')
call assert_equal(['htmx', 'vscodehtml'], s:Names(), '.html.ep')

" test_ale_html
call s:Open('x.html')
call assert_equal(['htmx', 'vscodehtml'], s:Names(), '.html')

" test_ale_go_nothing: ALE не пипа Go.
call s:Open('x.go')
call assert_equal('go', &filetype, 'filetype на .go')
call assert_equal([], s:Names(), '.go')

call s:Open('x.pl')
call assert_equal(['languageserver', 'perlcritic', 'perlsave'], s:Names(), '.pl')
call s:Open('x.sh')
call assert_equal(['language_server', 'shellcheck'], s:Names(), '.sh')
call s:Open('x.js')
call assert_equal(['tsserver'], s:Names(), '.js')

call writefile(v:errors, $TEST_OUT) | qa!
