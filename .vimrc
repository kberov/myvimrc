" Set all settings to default and be ready to apply my own settings
set all&

"compatible	behave very Vi compatible (not advisable)
set nocp	"cp

set background=dark
syntax enable

"autowrite	automatically write a file when leaving a modified buffer
"This allows us to use :make or :GoBuild or !perl -c without saving the file
set aw "noaw

"Setting this option also implies that Vim behaves like 'autowrite' has been set.
" Important!!! the following will save all files even if you quit using qa!
"set autowriteall "noawa

" Various language settings. For each of them check :help thesetting
language bg_BG.UTF-8
set langmenu=bg_BG.UTF-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp1251,cp1250,latin1

" Enable loading the plugin files for specific file types.
" If filetype detection was not switched on yet, it will be as well. This
" actually loads the file "ftplugin.vim" in 'runtimepath'. The result is that
" when a file is edited its plugin file is loaded (if there is one for the
" detected filetype). |filetype-plugin|
filetype plugin on

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

"hilight current cursor line. For cursor column see ~/.gvimrc
set cursorline

"smartindent    do clever autoindenting (local to buffer)
set si

"preserveindent Preserve kind of whitespace when changing indent. (local to buffer)
set pi "nopi

" Vim will wrap long lines at a character in 'breakat' rather than at the last
" character that fits on the screen. Unlike 'wrapmargin' and 'textwidth', this
" does not insert <EOL>s in the file, it only affects the way the file is
" displayed, not its contents.
let breakat=" -+:,.?"
set linebreak "nolinebreak

" When 'wildmenu' is on, command-line completion operates in an enhanced mode.
" On pressing 'wildchar' (usually <Tab>) to invoke completion, the possible
" matches are shown just above the command line
set wildmenu
set wildchar=<Tab> " Character you have to type to start wildcard expansion in
                   " the command-line, as specified with 'wildmode'.
" Completion mode that is used for the character specified with 'wildchar'.
set wildmode=list:longest " When more than one match, list all matches and 
                          " complete till longest common string.

" A list of file patterns.  A file that matches with one of these patterns is
" ignored when expanding |wildcards|, completing file or directory names, and
" influences the result of |expand()|, |glob()| and |globpath()| unless a flag
" is passed to disable this. 
set wildignore+=tags,.git,_build/**,blib/**,.svn,*.o,*.obj,*.pmc,*/tmp/*,*.so,*.swp
set wildignore+=*.tdy,*.bac,*.pmc
set wildignore+=bin/**,*.zip,backup/**,dump,*.tmp,*.min.js
set wildignore+=*.png,*.PNG,*.JPG,*.jpg,*.JPEG,*.jpeg,*.GIF,*.gif,*.pdf,*.PDF
set wildignore+=node_modules/**,vendor/**,coverage/**,tmp/**,rdoc/**,*.BACKUP.*
set wildignore+=*.BASE.*,*.LOCAL.*,*.REMOTE.*,.sass-cache/**

"Case insensitive search in documents. I nearly always want this!
set ignorecase
"Override the 'ignorecase' option if the search pattern contains upper case characters.
set smartcase
" While typing a search command, show where the pattern, as it was typed so far, matches.
set incsearch

"Influences the working of <BS>, <Del>, CTRL-W and CTRL-U in Insert mode.
set backspace=indent,eol,start

"Set some session options
"Cross-platform sessions
set sessionoptions+=unix,slash
set modelines=5

"" Use four spaces for indentation
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab

"set statusline=%F%m%r%h%w\ F=%{&ff}\ T=%y\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
"set spell
" default language for spellchecking. use another: setlocal spelllang=bg
set spelllang=en

"tags list of file names to search for tags (global or local to buffer)
set tags+=./.tags,./.TAGS,.tags,.TAGS,./**/tags
" See: http://vim.wikia.com/wiki/Browsing_programs_with_tags

" Don't save hidden and unloaded buffers in sessions.
set sessionoptions-=buffers
" Persist options and mappings although it can corrupt sessions.
"set sessionoptions+=options

" Search recursively for filenames!
" Now you can do :fin {partial-filename}<Tab> to quickly find and open files
" deep under the current directory.
" No CtrlP required. See also https://stackoverflow.com/questions/16082991
set path=,./**,**,* 
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

" Load bg keyboard and switch back to no keymap, so later if I need to enter
" bulgarian letters I can just press CTRL-^ to switch to INSERT(lang) as
" opposed to just INSERT
" See https://stackoverflow.com/questions/3776728/#3777557 
" See also /usr/share/vim/vim74/keymap/bulgarian-phonetic.vim 
" my keymap old-bulgarian-phonetic from ~/.vim/keymap/
set keymap=old-bulgarian-phonetic
"not switched on by default
set iminsert=0 imsearch=-1
" A cursor color for when keymaps are in use. 
highlight lCursor ctermbg=red guibg=red

"display	include "lastline" to show the last line even if it doesn't fit. include "uhex" to show unprintable characters as a hex number
set display=lastline


"alias unnamed register to the + register, which is the X Window clipboard.
"http://vim.wikia.com/wiki/Accessing_the_system_clipboard
set clipboard^=unnamedplus
"https://stackoverflow.com/questions/677986/vim-copy-selection-to-os-x-clipboard#680271
"set clipboard=unnamed

" Normally the quickfix window is at the bottom of the screen.  If there are
" vertical splits, it's at the bottom of the rightmost column of windows.  To
" make it always occupy the full width:
botright cwindow

" When on, ":autocmd", shell and write commands are not allowed in ".vimrc"
" and ".exrc" in the current directory and map commands are displayed.
set secure

" Some mappings

" If "mapleader" is not set or empty, a backslash is used instead.
" Press \+f and go to the prepared command line to modify the search pattern.
" **/*.%:e searches only in files of the same type as the current file:
" Use **/*.pm to search only in *.pm files.
map <Leader>f :noautocmd vimgrep! /*/gj **/*.%:e <Bar> cw<C-Left><C-Left><C-Left><C-Left>

"Press \+f+f to search/find in all files for the current word (the word under the
"cursor) and open the list of found occurences (quickfix)
"Example: find usages of a method in all files
map <Leader>ff :execute "noautocmd vimgrep /" . expand("<cword>") . "/gj **/*".expand("%:e") <Bar> cw<CR>

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
"Differs from 'j' when lines wrap, and when used with an operator, because it's not linewise.
map <Down> gj
map <Up>   gk
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

"Ctrl+leftarrow (or Ctrl+h) will go one window left, etc.
"See http://vim.wikia.com/wiki/Switch_between_Vim_window_splits_easily
map <silent> <C-Up> :wincmd k<CR>
map <silent> <C-Down> :wincmd j<CR>
map <silent> <C-Left> :wincmd h<CR>
map <silent> <C-Right> :wincmd l<CR>
map <silent> <C-k> :wincmd k<CR> 
map <silent> <C-j> :wincmd j<CR>
map <silent> <C-h> :wincmd h<CR>
map <silent> <C-l> :wincmd l<CR>

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
"https://stackoverflow.com/questions/7642746/#7642762
" For a list of default command mappings (shortcuts)  see /usr/share/vim/vim74/doc/index.txt
" Type  :help index
" For a list of all defined maps in vimrc and by Vim plugins type :map
"
runtime myplugins.vim 

