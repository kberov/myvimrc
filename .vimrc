"compatible	behave very Vi compatible (not advisable)
set nocp	"cp
language bg_BG.UTF-8
"set langmenu=lang/bg_BG.UTF-8
set encoding=utf-8
" works only for commands in normal mode an ode s not work for example for
" CTRL+w
set langmap=АA,БB,ЦC,ДD,ЕE,ФF,ГG,ХH,ИI,ЙJ,КK,ЛL,МM,НN,ОO,ПP,ЯQ,РR,СS,ТT,УU,ЖV,ВW,ѝX,ЪY,ЗZ,аa,бb,цc,дd,ефгх;efgh,ийклмно;ijklmno,пярст;pqrst,уu,жv,вw,ьx,ъз;yz
set fileencodings=ucs-bom,utf-8,cp1251,cp1250,latin1
filetype plugin on
" automatically expand the filetyes submenu

"insertmode	use Insert mode as the default mode
set noim	"im
"set keymap=bulgarian-phonetic
"backupdir  list of directories to put backup files in
set bdir=~/tmp,/tmp,/WINDOWS/TEMP
"directory  list of directories for the swap file
set dir=~/tmp,/tmp,/WINDOWS/TEMP
"number show the line number for each line  (local to window)
set nu  
"title  show info in the window title
set title   "notitl
"hilight current cursor line and cursor column
set cursorline
set nocursorcolumn

"smartindent    do clever autoindenting (local to buffer)
set si
syntax enable
colorscheme apprentice
"preserveindent Preserve kind of whitespace when changing indent    (local to buffer) set pi "nopi
"Vim will wrap long lines at a character in 'breakat' rather than at the last character that fits on the screen.
set pi "nopi
let breakat=" -+:,.?"
set linebreak
"When 'wildmenu' is on, command-line completion operates in an enhanced
"	mode.  On pressing 'wildchar' (usually <Tab>) to invoke completion,
"	the possible matches are shown just above the command line
set wildmenu
set wildchar=<Tab>
set wildmode=list:full
set wildignore=tags,.git,_build,blib,.svn,*.o,*.obj
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
"" Use two spaces for indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
"set statusline=%F%m%r%h%w\ F=%{&ff}\ T=%y\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

set spell
set spelllang=en
"tags list of file names to search for tags (global or local to buffer)
set tag+=./.tags,./.TAGS,.tags,.TAGS
   
if has("gui_running")
    set guifont=Monospace\ 16
    runtime! mswin.vim 
  "set ch=2		" Make command line two lines high
  set guioptions-=T  "remove toolbar http://vim.wikia.com/wiki/Hide_toolbar_or_menus_to_see_more_text
  " Maximize gvim window.
  set lines=999 columns=999
end

"session plugin
let g:session_autosave = 'yes'
" Don't save hidden and unloaded buffers in sessions.
set sessionoptions-=buffers
" Persist options and mappings although it can corrupt sessions.
set sessionoptions+=options
"search recursively
set path+=,**
"history: how many command lines are remembered:
set hi=1000

" now the command line history can be used by typing q: then choosing a command and pressing enter
" http://vim.wikia.com/wiki/Using_command-line_history
" See also http://vim.wikia.com/wiki/VimTip681 - Enhanced command window
" use the command editing window, try these mappings: 
nnoremap : q:i
nnoremap / q/i
nnoremap ? q?i

"When 'off', a buffer is unloaded when it is |abandon|ed.  When 'on', a buffer becomes hidden when it is |abandon|ed.
set hidden
"bomb prepend a Byte Order Mark to the file (local to buffer)
set nobomb
"foldmethod folding type: "manual", "indent", "expr", "marker" or "syntax" (local to window)
set fdm=syntax


"Manage my plugins using vim-plug https://github.com/junegunn/vim-plug
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Make sure you use single quotes
call plug#begin('~/.vim/plugged')
    " Group dependencies
    Plug 'xolox/vim-misc' | Plug 'xolox/vim-session'
    "Plug 'scrooloose/nerdtree' ", { 'on': 'NERDTreeToggle' }
    let g:instant_markdown_autostart = 0
    Plug 'suan/vim-instant-markdown'
    Plug 'tpope/vim-fugitive'
    Plug 'fholgado/minibufexpl.vim'
    "Plug '~/Downloads/Vim/taglist_46'
    Plug 'majutsushi/tagbar'
    Plug 'scrooloose/syntastic'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'jdonaldson/vaxe'
    Plug 'vim-airline/vim-airline'
    AirlineTheme {tmuxline}
    Plug 'vim-airline/vim-airline-themes'
" Add plugins to &runtimepath
call plug#end()
"set keymap=bulgarian-phonetic
