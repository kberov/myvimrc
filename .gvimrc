"Gvim reads ~/.vimrc then a ~/.gvimrc file located in the same place as vimrc.
"Setting in this file are applied only 'if has("gui_running")'
" colorscheme is loaded via a plugin managed by vim-plug
"colorscheme  peachpuff "koehler distinguished industry desert murphy slate molokai apprentice
"set cursorcolumn
set guifont=Ubuntu\ Mono\ 16,Monospace\ 15,Courier\ New\ 15
"set guifont=PT\ Mono:h18 "on MAC
set linespace=5 "more vertical space between lines
"runtime! mswin.vim 
"set ch=2		" Make command line two lines high
"remove toolbar http://vim.wikia.com/wiki/Hide_toolbar_or_menus_to_see_more_text
set guioptions-=T
" Make omenu items that are not active grey
set guioptions +=g  
" Maximize gvim window.
set lines=999 columns=999
"http://stackoverflow.com/questions/3446320/in-vim-how-to-map-save-to-ctrl-s#3448551
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>
"http://vim.wikia.com/wiki/Toggle_Insert-Normal_Mode_via_ctrl-space
" Press i to enter insert mode, and ii to exit.
inoremap ii <Esc>
" Switch between insert and normal mode using Ctrl+left arrow
inoremap <C-L> &insertmode ? <C-L> : <Esc>
" Expand the syntax menu
"let do_syntax_sel_menu = 1|runtime! synmenu.vim|aunmenu &Syntax.&Show\ filetypes\ in\ menu
set mouse=a

" Copy current file name to the system clipboard now as a menu item in my own
" menu
:amenu Tools.My.Copy\ File\ Name :let @+=expand('%:p')<CR>
"
