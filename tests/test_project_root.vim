" Проектни настройки и корен на проекта за файлове извън/в проекти.
let s:tmp = fnamemodify(tempname(), ':p')

" perltidy: ползва .perltidyrc на проекта, където и да е пуснат Vim.
call mkdir(s:tmp . '/proj/lib', 'p')
call writefile(['-i=2'], s:tmp . '/proj/.perltidyrc')
execute 'edit' fnameescape(s:tmp . '/proj/lib/Foo.pm')
call assert_equal('-pro=' . shellescape(s:tmp . '/proj/.perltidyrc'),
      \ get(b:, 'ale_perl_perltidy_options', ''), 'perltidy с проектния профил')

" Без проектен .perltidyrc: изрично ~/.perltidyrc (ако го има).
call mkdir(s:tmp . '/loose', 'p')
execute 'edit' fnameescape(s:tmp . '/loose/x.pl')
let s:home_rc = expand('~/.perltidyrc')
call assert_equal(filereadable(s:home_rc) ? '-pro=' . shellescape(s:home_rc) : '',
      \ get(b:, 'ale_perl_perltidy_options', ''), 'perltidy без проект')

" shfmt: при .editorconfig в проекта – без наши флагове (shfmt го чете сам).
call writefile(['root = true'], s:tmp . '/proj/.editorconfig')
execute 'edit' fnameescape(s:tmp . '/proj/run.sh')
call assert_equal('', get(b:, 'ale_sh_shfmt_options', 'НЕЗАДАДЕНО'), 'shfmt с .editorconfig')
execute 'edit' fnameescape(s:tmp . '/loose/y.sh')
call assert_equal('НЕЗАДАДЕНО', get(b:, 'ale_sh_shfmt_options', 'НЕЗАДАДЕНО'), 'shfmt без .editorconfig')

" Езиковите сървъри за Shell и HTML тръгват и извън git проект:
" коренът е папката на файла.
function! s:Root(ft, name) abort
  let l:l = filter(ale#linter#Get(a:ft), 'v:val.name ==# a:name')
  return ale#lsp_linter#FindProjectRoot(bufnr(''), l:l[0])
endfunction
execute 'edit' fnameescape(s:tmp . '/loose/y.sh')
call assert_equal(s:tmp . '/loose', s:Root('sh', 'language_server'), 'корен sh')
execute 'edit' fnameescape(s:tmp . '/loose/z.html')
call assert_equal(s:tmp . '/loose', s:Root('html', 'vscodehtml'), 'корен html')

call writefile(v:errors, $TEST_OUT) | qa!
