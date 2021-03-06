"Gvim reads ~/.vimrc then a ~/.gvimrc file located in the same place as .vimrc.
"Setting in this file are applied only 'if has("gui_running")'
" colorscheme is loaded via a plugin managed by vim-plug
"colorscheme  peachpuff "koehler distinguished industry desert murphy slate molokai apprentice
"set cursorcolumn
set guifont=Liberation\ Mono\ 12
"set guifont=PT\ Mono:h18 "on MAC
"set linespace=5 "more vertical space between lines
"set ch=2		" Make command line two lines high

"remove toolbar http://vim.wikia.com/wiki/Hide_toolbar_or_menus_to_see_more_text
set guioptions-=T
" Make menu items that are not active grey
set guioptions+=g
" Use text-based tabs instead of graphical ones
" set go-=e
" Maximize gvim window (almost).
"set lines=99 columns=168

"http://stackoverflow.com/questions/3446320/in-vim-how-to-map-save-to-ctrl-s#3448551
" This is used even if mswin.vim below is not sourced
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

"http://vim.wikia.com/wiki/Toggle_Insert-Normal_Mode_via_ctrl-space
" Press i to enter insert mode, and ii or jj or ;; to exit.
inoremap ii <Esc>
inoremap jj <Esc>
inoremap ;; <Esc>
" Expand the syntax menu
"let do_syntax_sel_menu = 1|runtime! synmenu.vim|aunmenu &Syntax.&Show\ filetypes\ in\ menu

set mouse=a

" Copy current file name to the system clipboard now as a menu item in my
" own menu
amenu Tools.My.Copy\ File\ Name :let @+=expand('%:p')<CR>

" Uze common shotcuts available usually in Windows
" Such as Ctrl+C, Ctrl+X, Ctrl+V Ctrl+S
so $VIMRUNTIME/mswin.vim
" https://vim.fandom.com/wiki/Make_arrow_keys_work_in_visual_mode_under_Windows
set keymodel-=stopsel

