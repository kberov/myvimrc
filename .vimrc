"compatible	behave very Vi compatible (not advisable)
set nocp	"cp

"autowrite	automatically write a file when leaving a modified buffer
set aw "noaw

" Various language settings. For each of them check :help thesetting
language bg_BG.UTF-8
set langmenu=bg_BG.UTF-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp1251,cp1250,latin1

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
set wildignore=tags,.git,_build,blib,.svn,*.o,*.obj,*.pmc

"expandtab  expand <Tab> to spaces in Insert mode (local to buffer)
set et  "noet

"Case insensitive search in documents. I nearly always want this!
set ignorecase

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

set spell
" default language for spellchecking. use another: setlocal spelllang=bg
set spelllang=en

"tags list of file names to search for tags (global or local to buffer)
set tag+=./.tags,./.TAGS,.tags,.TAGS
   
if has("gui_running")
    set guifont=Monospace\ 14
    "runtime! mswin.vim 
    "set ch=2		" Make command line two lines high
    "remove toolbar http://vim.wikia.com/wiki/Hide_toolbar_or_menus_to_see_more_text
    set guioptions-=T  
    " Maximize gvim window.
    set lines=999 columns=999
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
set laststatus=2    "always show a status line

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
    let g:NERDTreeGlyphReadOnly='ro'
    let g:NERDTreeDirArrowExpandable = '▸'
    let g:NERDTreeDirArrowCollapsible = '▾'
    let s:dirArrows = ''
    "to open NERDTree with Ctrl+o
    map <C-n> :NERDTreeToggle<CR> 
    Plug 'scrooloose/nerdtree' " , { 'on': 'NERDTreeToggle' }
    let g:instant_markdown_autostart = 1
    "Plug 'suan/vim-instant-markdown'
	Plug 'tpope/vim-vinegar' "Press '-' to open the directory of the current file
    Plug 'tpope/vim-fugitive' "Use Git
    "Plug 'fholgado/minibufexpl.vim'
    "Plug '~/Downloads/Vim/taglist_46'
    "Plug 'majutsushi/tagbar'
    "Plug 'scrooloose/syntastic'
    Plug 'ctrlpvim/ctrlp.vim' "Pres Ctrl-p to open any file under the current directory
    "Plug 'jdonaldson/vaxe' "Haxe support
    Plug 'tomasr/molokai'  "Pretty theme"
    "Plug 'vim-airline/vim-airline' "Pretty statusbar
    "Plug 'vim-airline/vim-airline-themes'
"    AirlineTheme molokai
"    Plug 'kadimisetty/vim-simplebar'
"    Plug 'powerline/powerline'
    Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }
    "Plug 'jiangmiao/auto-pairs' "Note! Disallows entering чшщ. Todo: think how to solve 
    " TypeScript support
    " let g:typescript_compiler_binary = '/home/berov/opt/node/bin/tsc'
    " autocmd FileType typescript :set makeprg="$HOME/opt/node/bin/tsc"
    " Plug 'leafgarland/typescript-vim'
    "autocmd FileType typescript setlocal completeopt+=menu,preview
    "Plug 'Quramy/tsuquyomi'

" Add plugins to &runtimepath
call plug#end()
" commands depending on loaded plgins
" colorscheme is loaded via a plugin managed by vim-plug
colorscheme molokai "apprentice

"display	include "lastline" to show the last line even if it doesn't fit. include "uhex" to show unprintable characters as a hex number
set display=lastline

" Load bg keyboard and switch back to no keymap, so later if I need to enter
" bulgarian letters I can just press CTRL-^ to switch to INSERT(lang) as
" opposed to just INSERT See https://is.gd/AfU1df
set keymap=bulgarian-phonetic
"not switched on by default
set iminsert=0 imsearch=-1
" pandoc , markdown
command! -nargs=* RunSilent
      \ | execute ':silent !'.'<args>'
      \ | execute ':redraw!'
nmap <Leader>pc :RunSilent pandoc -o ~/tmp/vim-pandoc-out.html %<CR>
nmap <Leader>pp :RunSilent xdg-open ~/tmp/vim-pandoc-out.html<CR>
