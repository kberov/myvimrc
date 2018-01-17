"compatible	behave very Vi compatible (not advisable)
set nocp	"cp

"autowrite	automatically write a file when leaving a modified buffer
"This allows us to use :make or :GoBuild or !perl -c without saving the file
set aw "noaw

" Various language settings. For each of them check :help thesetting
language bg_BG.UTF-8
set langmenu=bg_BG.UTF-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp1251,cp1250,latin1

set rtp+=$HOME/.vim/plugged/vim-go/syntax/
filetype plugin on
" automatically expand the filetyes submenu

"insertmode	use Insert mode as the default mode
set noim	"im

"backupdir  list of directories to put backup files in
set bdir=~/tmp,/tmp,/WINDOWS/TEMP

"directory  list of directories for the swap file
set dir=~/tmp,/tmp,/WINDOWS/TEMP

"show the line number for each line  (local to window)
set nu  
"title  show info in the window title
set title   "notitl

"hilight current cursor line and cursor column
set cursorline
set nocursorcolumn

"smartindent    do clever autoindenting (local to buffer)
set si
syntax enable

"preserveindent Preserve kind of whitespace when changing indent. (local to buffer)
set pi "nopi

" Vim will wrap long lines at a character in 'breakat' 
"rather than at the last character that fits on the screen.
let breakat=" -+:,.?"
set linebreak

" When 'wildmenu' is on, command-line completion operates in an enhanced mode.
" On pressing 'wildchar' (usually <Tab>) to invoke completion, the possible
" matches are shown just above the command line
set wildmenu
set wildchar=<Tab>
set wildmode=list:full
set wildignore+=tags,.git,_build,blib,.svn,*.o,*.obj,*.pmc,*/tmp/*,*.so,*.swp
set wildignore+=bin/**,*.zip,backup/**,dump,*.tmp,*.min.js
set wildignore+=*.png,*.PNG,*.JPG,*.jpg,*.JPEG,*.jpeg,*.GIF,*.gif,*.pdf,*.PDF
set wildignore+=node_modules/**,vendor/**,coverage/**,tmp/**,rdoc/**,*.BACKUP.*
set wildignore+=*.BASE.*,*.LOCAL.*,*.REMOTE.*,.sass-cache/**
"expandtab  expand <Tab> to spaces in Insert mode (local to buffer)
set et  "noet

"Case insensitive search in documents. I nearly always want this!
set ignorecase
"Override the 'ignorecase' option if the search pattern contains upper case characters.
set smartcase

"Influences the working of <BS>, <Del>, CTRL-W and CTRL-U in Insert mode.
set backspace=indent,eol,start

"Set some session options
"Cross-platform sessions
set sessionoptions+=unix,slash
set modelines=5

"" Use four spaces for indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
"set statusline=%F%m%r%h%w\ F=%{&ff}\ T=%y\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

"set spell
" default language for spellchecking. use another: setlocal spelllang=bg
set spelllang=en

"tags list of file names to search for tags (global or local to buffer)
set tag+=./.tags,./.TAGS,.tags,.TAGS
   
if has("gui_running")
    set guifont=Monospace\ 16
    "set guifont=PT\ Mono:h18 "on MAC
    set linespace=5 "more vertical space between lines
    "runtime! mswin.vim 
    "set ch=2		" Make command line two lines high
    "remove toolbar http://vim.wikia.com/wiki/Hide_toolbar_or_menus_to_see_more_text
    set guioptions-=T  
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
end

" Don't save hidden and unloaded buffers in sessions.
set sessionoptions-=buffers
" Persist options and mappings although it can corrupt sessions.
"set sessionoptions+=options

" Search recursively for filenames!
" Now you can do :fin {partial-filename}<Tab> to quickly find and open files
" deep under the current directory.
" No CtrlP required. See also http://goo.gl/yJtGVa
set path+=.,**,* 
"history: how many command lines are remembered:
set hi=200

" Now the command line history can be used by just typing : then choosing a
" command and pressing enter
" http://vim.wikia.com/wiki/Using_command-line_history See also
" http://vim.wikia.com/wiki/VimTip681 - Enhanced command window use the
" command editing window, try these mappings: 
"nnoremap : q:i
"nnoremap / q/i
"nnoremap ? q?i

"When 'off', a buffer is unloaded when it is |abandon|ed.  When 'on', a buffer becomes hidden when it is |abandon|ed.
set hidden

"bomb prepend a Byte Order Mark to the file (local to buffer)
set nobomb

" foldmethod folding type: "manual", "indent", "expr", "marker" or "syntax" (local to window)
"set fdm=syntax

set complete-=i " Searching includes can be slow
"set laststatus=2    "always show a status line

"Manage my plugins using vim-plug https://github.com/junegunn/vim-plug
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Make sure you use single quotes
call plug#begin('~/.vim/plugged')
    " Group dependencies
    "session plugin
    let g:session_autosave = 'yes'
    let g:session_autoload = 'no'
    Plug 'xolox/vim-misc' | Plug 'xolox/vim-session'
"    let g:NERDTreeGlyphReadOnly='ro'
"    let g:NERDTreeDirArrowExpandable = '▸'
"    let g:NERDTreeDirArrowCollapsible = '▾'
"    let s:dirArrows = ''
"   to open NERDTree ...
"   If "mapleader" is not set or empty, a backslash is used instead.  The
"   below mapping  means \O (press backslash(\) then Shift+o)
    map <Leader>O :NERDTreeToggle<CR>
    Plug 'scrooloose/nerdtree' " , { 'on': 'NERDTreeToggle' }
"    let g:instant_markdown_autostart = 1
"    "Plug 'suan/vim-instant-markdown'
"	Plug 'tpope/vim-vinegar' "Press '-' to open the directory of the current file
    Plug 'tpope/vim-fugitive' "Use Git
"    "Plug 'fholgado/minibufexpl.vim'
"    "Plug '~/Downloads/Vim/taglist_46'
    Plug 'majutsushi/tagbar'
"    "Plug 'scrooloose/syntastic'
     Plug 'ctrlpvim/ctrlp.vim' "Pres Ctrl-p to open any file under the current directory
"    Plug 'jdonaldson/vaxe' "Haxe support
"    Plug 'tomasr/molokai'  "Pretty theme"
    Plug 'vim-airline/vim-airline' "Pretty statusbar
    Plug 'vim-airline/vim-airline-themes'
    let g:airline#extensions#keymap#enabled = 0
    " For the following to work, I needed to `sudo apt-get install fonts-powerline`
    " See https://github.com/powerline/fonts
    let g:airline_powerline_fonts = 1
    AirlineTheme jellybeans
"    Plug 'kadimisetty/vim-simplebar'
"    Plug 'powerline/powerline'
    Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp mason highlight-all-pragmas moose test-more try-tiny' }
    Plug 'yko/mojo.vim'
    "Highlight embedded Perl code in __DATA__ sections of your Perl files.
    let mojo_highlight_data = 1
    "Don't highlight html inside __DATA__ templates - Perl code only.
    "let mojo_disable_html = 1

"    Plug 'jiangmiao/auto-pairs' "Note! Disallows entering чшщ. Todo: think how to solve 
    " TypeScript support
"    Plug 'leafgarland/typescript-vim'
"    autocmd FileType typescript setlocal completeopt+=menu,preview
"    Plug 'HerringtonDarkholme/yats.vim'
"    Plug 'Quramy/tsuquyomi'
"    Plug 'clausreinke/typescript-tools.vim', { 'do': 'npm install' }
"    Plug 'Shougo/vimproc.vim'
    " Rust support
"    Plug 'rust-lang/rust.vim'
"    let g:rustfmt_autosave = 1
"	let g:rustfmt_options = '--ideal_width=90 fn_call_width=90 write_mode=Replace'
"    Plug 'timonv/vim-cargo'
"    Plug 'racer-rust/vim-racer' " See help for options: https://github.com/racer-rust/vim-racer
"    let g:racer_cmd = "racer"
"    let g:racer_experimental_completer = 1
    " End Rust support
    " Start Swift Support
"    Plug 'toyamarinyon/vim-swift'
    "Better JS support https://github.com/nodejs/node/wiki/Vim-Plugins
    "Enhanced JavaScript Syntax for Vim
    Plug 'jelera/vim-javascript-syntax'
    "To disable automatic checking and only check when the file is written: 
    let JSHintUpdateWriteOnly=1
    "http://jshint.com/docs/
    Plug 'wookiehangover/jshint.vim'
    Plug 'fatih/vim-go'
    Plug 'othree/html5.vim'
    Plug 'sirver/ultisnips'
    Plug 'honza/vim-snippets'
    let g:UltiSnipsUsePythonVersion = 3
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<c-b>"
    let g:UltiSnipsJumpBackwardTrigger="<c-z>"
    " If you want :UltiSnipsEdit to split your window.
    let g:UltiSnipsEditSplit="vertical"

    Plug 'Valloric/YouCompleteMe'

" Add plugins to &runtimepath
call plug#end()
" commands depending on loaded plgins
" colorscheme is loaded via a plugin managed by vim-plug
colorscheme jellybeans "distinguished industry desert murphy slate molokai apprentice

"display	include "lastline" to show the last line even if it doesn't fit. include "uhex" to show unprintable characters as a hex number
set display=lastline

" Load bg keyboard and switch back to no keymap, so later if I need to enter
" bulgarian letters I can just press CTRL-^ to switch to INSERT(lang) as
" opposed to just INSERT See https://is.gd/AfU1df
set keymap=bulgarian-phonetic
"not switched on by default
set iminsert=0 imsearch=-1

"alias unnamed register to the + register, which is the X Window clipboard.
"http://vim.wikia.com/wiki/Accessing_the_system_clipboard
set clipboard^=unnamedplus
"https://stackoverflow.com/questions/677986/vim-copy-selection-to-os-x-clipboard#680271
"set clipboard=unnamed

" pandoc , markdown
command! -nargs=* RunSilent
      \ | execute ':silent !'.'<args>'
      \ | execute ':redraw!'
nmap <Leader>pc :RunSilent pandoc -o ~/tmp/vim-pandoc-out.html %<CR>
nmap <Leader>pp :RunSilent xdg-open ~/tmp/vim-pandoc-out.html<CR>

" If "mapleader" is not set or empty, a backslash is used instead.
" Press \+f and go to the prepared command line to modify the search pattern.
" Replace **/* with **/*.%:e to search only in files of the same type:
map <Leader>f :vimgrep! /*/gj **/*.%:e <Bar> cw<C-Left><C-Left><C-Left><C-Left>

"Press \+f+f to search/find in all files for the current word (the word under the
"cursor) and open the list of found occurences (quickfix)
"Example: find usages of a method in all files
map <Leader>ff :execute "vimgrep /" . expand("<cword>") . "/gj **/*".expand("%:e") <Bar> cw<CR>

"copy current file name to the system clipboard
"cf stands for "current filename"
map <Leader>cf :let @+=expand('%:p')<CR>

"Navigating among opened files (buffers)
" Switch to alternate file
map <C-Tab> :bnext<cr>
map <C-S-Tab> :bprevious<cr>
nmap b] :bnext<cr>
nmap b[ :bprevious<cr>
nmap [b :bprevious<cr>
nmap ]b :bnext<cr>
map <Leader>b :b  

"some shortcuts to make it easier to jump between errors in quickfix list
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
"Delete and not Cut - replacing text multiple times
"https://stackoverflow.com/questions/11993851
"Delete in normal mode.
nnoremap <leader>d "_d
"Delete in visual mode
vnoremap <leader>d "_d
"Replace in visual mode
vnoremap <leader>p "_dP

"https://github.com/fatih/vim-go-tutorial#quick-setup
"all lists will be of type quickfix:
let g:go_list_type = "quickfix"
let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }

"Ctrl+leftarrow will go one window left, etc.
"See http://vim.wikia.com/wiki/Switch_between_Vim_window_splits_easily
map <silent> <C-Up> :wincmd k<CR>
map <silent> <C-Down> :wincmd j<CR>
map <silent> <C-Left> :wincmd h<CR>
map <silent> <C-Right> :wincmd l<CR>

"Move entire line up and down https://stackoverflow.com/questions/741814
noremap <c-s-up> :call feedkeys( line('.')==1 ? '' : 'ddkP' )<CR>
noremap <c-s-down> ddp

" Comment/uncomment regions of lines
" https://stackoverflow.com/questions/1676632/
" Commenting with #:
" 1. visually select the text rows (using V as usual)
" 2. :norm i#
" Uncommenting #:
" 1. visually select the text as before (or type gv to re-select the previous selection)
" 2. :norm x
" This deletes the first character of each line. If I had used a 2-char comment such as //
" then I'd simply do :norm xx to delete both chars. 
"
 
