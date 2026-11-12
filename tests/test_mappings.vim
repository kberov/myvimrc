" Общи съответствия и команди от .vimrc / mymappings.vim.

" gx (отвори адреса под курсора) сочи към нещо, което съществува.
let s:rhs = maparg('gx', 'n')
call assert_notequal('', s:rhs, 'gx е зададено')
let s:plug = matchstr(s:rhs, '<Plug>\S\+')
if !empty(s:plug)
  call assert_notequal('', maparg(s:plug, 'n'), 'gx → ' . s:plug . ' съществува')
endif

" :SudoW с фалшив sudo в PATH.
let s:d = fnamemodify(tempname(), ':p')
call mkdir(s:d)
let s:oldpath = $PATH
let $PATH = s:d . ':' . $PATH

" Неуспешен sudo (грешна парола, Ctrl-C): промените остават в буфера.
call writefile(['#!/bin/sh', 'cat >/dev/null', 'exit 1'], s:d . '/sudo')
call setfperm(s:d . '/sudo', 'rwxr-xr-x')
execute 'edit' fnameescape(s:d . '/f.txt')
call setline(1, 'original')
write
call setline(1, 'precious')
silent! SudoW
call assert_equal('precious', getline(1), 'SudoW при провал пази промените')
call assert_true(&modified, 'SudoW при провал: буферът остава променен')

" Успешен sudo: файлът е записан и буферът е презареден.
call writefile(['#!/bin/sh', 'exec "$@"'], s:d . '/sudo')
silent! SudoW
call assert_equal(['precious'], readfile(s:d . '/f.txt'), 'SudoW записва')
call assert_false(&modified, 'SudoW при успех: незапроменен')

let $PATH = s:oldpath
call writefile(v:errors, $TEST_OUT) | qa!
