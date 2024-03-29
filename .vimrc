" This file was generated by executing :mkvimrc on my machine Ubuntu 20.04.2
" LTS, focal on 30.06.2021 (ср)  9:16:48 EEST. For each setting type 
" `:help thesetting` to find out what it is.
"version 8.1
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
inoremap <C-U> u
map Q gq
vmap gx <Plug>NetrwBrowseXVis
nmap gx <Plug>NetrwBrowseX
vnoremap <silent> <Plug>NetrwBrowseXVis :call netrw#BrowseXVis()
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#BrowseX(expand((exists("g:netrw_gx")? g:netrw_gx : '<cfile>')),netrw#CheckIfRemote())
inoremap  u
let &cpo=s:cpo_save
unlet s:cpo_save
set backspace=indent,eol,start
set display=truncate
set fileencodings=ucs-bom,utf-8,default,latin1
set helplang=bg
set history=200
set incsearch
set langnoremap
set nolangremap
set nomodeline
set nrformats=bin,hex
set printoptions=paper:a4
set ruler
set scrolloff=5
set showcmd
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set ttimeout
set ttimeoutlen=100
set wildmenu

" Here start my (Krasi Berov's) settings.

set modeline
set wildchar=<Tab> " Character you have to type to start wildcard expansion in

" the command-line, as specified with 'wildmode'.
" Completion mode that is used for the character specified with 'wildchar'.
set wildmode=list:longest " When more than one match, list all matches and
" complete till longest common string.

" Various language settings. For each of them check :help thesetting
language bg_BG.UTF-8
set langmenu=bg_BG.UTF-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp1251,cp1250,latin1

" Enable loading the plugin files for specific file types.
" If filetype detection was not switched on yet, it will be as well. This
" actually loads the file 'ftplugin.vim' in 'runtimepath'. The result is that
" when a file is edited its plugin file is loaded (if there is one for the
" detected filetype). :help filetype-plugin
filetype plugin indent on

" insertmode use Insert mode as the default mode
set noim "im

" backupdir - list of directories to put backup files in
" Empty means that no backup file will be created ('patchmode' is impossible!).
" Writing may fail because of this.
set bdir=~/tmp,/tmp,/WINDOWS/TEMP

" directory - list of directories for the swap file
" Empty means that no swap file will be used (recovery is impossible!).
set dir=~/tmp,/tmp,/WINDOWS/TEMP

"show the line number for each line (local to window)
set nu

" title - show info in the window title
set title "notitl

"autoindent - Copy indent from current line when starting a new line
set ai
"smartindent - do clever autoindenting (local to buffer)
set si

"preserveindent Preserve kind of whitespace when changing indent. (local to buffer)
set pi "nopi

" If on, Vim will wrap long lines at a character in 'breakat' rather
" than at the last character that fits on the screen.  Unlike
" 'wrapmargin' and 'textwidth', this does not insert <EOL>s in the file,
" it only affects the way the file is displayed, not its contents.
set linebreak "nolinebreak
let breakat=" ->+:,.?"

" A list of file patterns. A file that matches with one of these patterns is
" ignored when expanding |wildcards|, completing file or directory names, and
" influences the result of |expand()|, |glob()| and |globpath()| unless a flag
" is passed to disable this. It is also used by vim[grep] to ignore files when
" seaching in them and files in 'suffixes' are searched last.
set wildignore+=tags,.git,.git/**,_build/**,*/blib/*,.svn,*.o,*.obj,*.pmc,*/tmp/*,*.so,*.swp
set wildignore+=*.tdy,*.bac,pm_to_blib,*.iml,*.sqlite
set wildignore+=bin/**,*.zip,backup/**,dump,*.tmp,*.min.js,*.min.css,*.otf,*.ttf
set wildignore+=*.png,*.PNG,*.JPG,*.jpg,*.JPEG,*.jpeg,*.GIF,*.gif,*.pdf,*.PDF
set wildignore+=node_modules/**,vendor/**,coverage/**,tmp/**,rdoc/**,*.BACKUP.*
set wildignore+=*.BASE.*,*.LOCAL.*,*.REMOTE.*,.sass-cache/**

"Case insensitive search in documents. I nearly always want this!
set ignorecase

"Override the 'ignorecase' option if the search pattern contains upper case characters.
set smartcase

" Set some session options
" Cross-platform sessions
set sessionoptions+=unix,slash,resize,curdir,folds,tabpages,winsize,terminal
" Don't save hidden and unloaded buffers in sessions.
set sessionoptions-=buffers
" Persist options and mappings although it can corrupt sessions.
set sessionoptions+=options

" Use four spaces for indentation:
set tabstop=4 " columns width used when a \t character is displayed;
set softtabstop=4 " insert that columns width \t and/or \s to simulate tab
" stops at this width;
set shiftwidth=4 " the size of an indent in columns;
set expandtab " the tab key (in insert mode) will insert \s instead of \t;
" to insert \t press CTRL-Q then TAB.

" Custom status line
" See :help statusline for details
" https://shapeshed.com/vim-statuslines/
" See https://jdhao.github.io/2019/11/03/vim_custom_statusline/
" See https://vim.fandom.com/wiki/Show_fileencoding_and_bomb_in_the_status_line
"set laststatus=2
set statusline=
set statusline+=%#PmenuSel#
set statusline+=%#CursorColumn#
"first letter of the current mode
set statusline+=\ %{toupper(mode())}
set statusline+=%#LineNr#
" space, Buffer number, space, Relative filepath, Modified?, Readonly?
" IsPREView?, keymap name
set statusline+=\ %n\ %f%m%r%W%k
" HEX character value, filetype,  
set statusline+=\ [0x%B]%y[%{&ff}]
" file encoding and byte order mask
set statusline+=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\"}
" Align items to right
set statusline+=%=
" linenumber/alllines, columnnumber or virtual columnnumber, space, percent
set statusline+=%(%l/%L:%c%V%)\ %P

" Uncomment the line below or just type the command in the commandline when
" you need to make spellchecking.
"set spell
" default language for spellchecking. use another: setlocal spelllang=bg
set spelllang=en,bg

" tags - list of file names to search for tags (global or local to buffer)
" See: http://vim.wikia.com/wiki/Browsing_programs_with_tags
set tags+=../**/tags

" Search recursively for filenames!
" Now you can do :fin {partial-filename}<Tab> to quickly find and open files
" deep under the current directory.
" No CtrlP required. See also https://stackoverflow.com/questions/16082991
" This is a list of directories which will be searched when using the
" |gf|, [f, ]f, ^Wf, |:find|, |:sfind|, |:tabfind| and other commands,
" provided that the file being searched for has a relative path (not
" starting with "/", "./" or "../").  The directories in the 'path'
" option may be relative or absolute.
set path=*,**

"bomb - prepend a Byte Order Mark to the file (local to buffer)
set nobomb

set complete-=i " do not scan included files for completions because it slows
" down autocompletion with large codebases
set complete-=t " Do not scan tags. Use i_CTRL-X_CTRL-O].
set showfulltag " show both the tag name and a tidied-up form of the search
" pattern (if there is one) as possible matches.
"set completeopt=menu,popup
" As-you-type autocomplete
"set completeopt=menu,menuone,popup,noselect
set completeopt=menu,menuone,popup,noselect,noinsert

" Load bg keyboard and switch back to no keymap, so later if I need to enter
" bulgarian letters I can just press CTRL-^ to switch to INSERT(lang) as
" opposed to just INSERT
" See https://stackoverflow.com/questions/3776728/#3777557
" See also /usr/share/vim/vim74/keymap/bulgarian-phonetic.vim
" my keymap old-bulgarian-phonetic from ~/.vim/keymap/
" One can change the switching coombination inoremap <c-l> <c-^>
set keymap=oldbgph
" The following are needed when the keymap above is in use. iminsert
" specifies whether :lmap or an Input Method (IM) is to be used in Insert
" mode. imsearch specifies whether :lmap or an Input Method (IM) is to be
" used when entering a search pattern.
set iminsert=0 imsearch=-1
" A cursor color for when keymaps are in use.
highlight lCursor ctermbg=red guibg=red

"display include "lastline" to show the last line even if it doesn't fit. include "uhex" to show unprintable characters as a hex number
set display=lastline

"Alias unnamed register to the + register, which is the X Window clipboard.
" This allow you to use directly the system clipboard in vim. Yank then paste
" in another application and vice versa
"http://vim.wikia.com/wiki/Accessing_the_system_clipboard
set clipboard^=unnamedplus
"https://stackoverflow.com/questions/677986/vim-copy-selection-to-os-x-clipboard#680271

" https://andrew.stwrt.ca/posts/project-specific-vimrc/
" Enable usage of .exrc or .vimrc per project
set exrc

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
" For a list of default command mappings (shortcuts) see /usr/share/vim/vim74/doc/index.txt
" Type :help index


"https://vimhelp.appspot.com/term.txt.html#xterm-bracketed-paste
"https://unix.stackexchange.com/questions/196098/copy-paste-in-xfce4-terminal-adds-0-and-1
set t_BE=

" Write the contents of the file, if it has been modified...
" Like 'autowrite', but also used for commands ":edit", ":enew", ":quit",
" :qall", ":exit", ":xit", ":recover" and closing the Vim window.
set autowriteall

colorscheme darkblue

"https://vim.fandom.com/wiki/To_switch_back_to_normal_mode_automatically_after_inaction
" !!!Automatically leave insert mode after 'updatetime' milliseconds of
" inaction. I do not have to press constantly ESC ANYMORE... EVER
" au CursorHoldI * stopinsert
" If you find that this event fires too quickly, you can adjust 'updatetime'
" to suit your needs, but you might want to consider doing so only when you
" enter insert mode:
" set 'updatetime' to 2600 miliseconds when in insert mode
" au InsertEnter * let updaterestore=&updatetime | set updatetime=4600
" au InsertLeave * let &updatetime=updaterestore

"set mousemodel=popup

runtime mymappings.vim
runtime myplugins.vim
runtime myplugins_settings.vim

" vim: set ft=vim :
