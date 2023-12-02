"Gvim reads ~/.vimrc then a ~/.gvimrc file located in the same place as .vimrc.
"Setting in this file are applied only 'if has("gui_running")'
" Start it maximized
" https://stackoverflow.com/questions/4722684/how-do-i-start-gvim-with-a-maximized-window
" Another option is to add the option -geometry on the command line.
" For example: gvim -geometry 500x500
set lines=999 columns=999

" colorscheme may be loaded via a plugin managed by vim-plug 
" (already initialized)
colorscheme darkblue "murphy base16-solarized-light dracula   base16-gruvbox-light-hard koehler desert industry 
set background=dark
" Some themes
" Dark
" murphy evening koehler desert elflord pablo blue  darkblue dracula
" base16-solarized-dark
" Light
" peachbuff default
" base16-github base16-grayscale-light base16-gruvbox-light-hard
" base16-ia-light base16-shapeshifter base16-solarized-light
" base16-summerfruit-light

" set cursorcolumn
" set cursorline
:set guifont=Noto\ Mono\ 16
"set guifont=JetBrainsMonoNL\ Nerd\ Font\ 15
"set guifont=SpaseMono\ Nerd\ Font\ Mono\ 15
"set guifont=Bukyvede\ 20
"set guifont=PT\ Mono:h18 "on MAC
"set linespace=5 "more vertical space between lines
"set ch=2		" Make command line two lines high
"https://vim.fandom.com/wiki/Configuring_the_cursor
set guicursor=a:blinkon0

"GUI
" Remove toolbar http://vim.wikia.com/wiki/Hide_toolbar_or_menus_to_see_more_text
set guioptions-=T
" Make menu items that are not active grey
set guioptions+=g
" Remove even the menu to gain one more row for editing. Comment and restart
" to get the menu back.
" set guioptions-=m
" Use dark Theme
" set guioptions+=d
" Use text-based tabs instead of graphical ones
" set go-=e


"More mappings working only in gvim!!!
"
" Ctr+S to save the document
"http://stackoverflow.com/questions/3446320/in-vim-how-to-map-save-to-ctrl-s#3448551
" This works even if mswin.vim below is not sourced
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

