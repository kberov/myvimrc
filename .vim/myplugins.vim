" This file is sourced by ~/.vimrc
"
" Netrw settings; See https://shapeshed.com/vim-netrw/
let g:netrw_banner = 0 " remove the mostly useless banner
let g:netrw_liststyle = 3 " tree view
" The following always opens the new file in the previous window, which                                                                                       
" happens to be annoying when you want to open the file in the same window.
" So for now we use "P" when we wont to open it in the previous window
let g:netrw_browse_split = 0 "4 - open in previous window like NERDTree
let g:netrw_winsize = 20 " % -  in percentage 
let g:netrw_list_hide = &wildignore "ignore the same files as wildignore
"    augroup ProjectDrawer "launch it right after you’ve entered Vim
"      autocmd!
"      autocmd VimEnter * :Vexplore
"    augroup END
map <Leader>E :Lexplore<CR>  " Split left and explore
nmap - :Ex<CR>

" Using Plugins. I tend to reduce Plugins usage by learning more of the VIM
" features
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
"   If 'mapleader' is not set or empty, a backslash is used instead.  The
"   below mapping  means \O (press backslash(\) then Shift+o)
    Plug 'scrooloose/nerdtree' " , { 'on': 'NERDTreeToggle' }
    map <Leader>O :NERDTreeToggle<CR>
    map <Leader>nf :NERDTreeFind<CR>
"    let g:instant_markdown_autostart = 1
"    "Plug 'suan/vim-instant-markdown'
"	Plug 'tpope/vim-vinegar' "Press '-' to open the directory of the current file
    Plug 'tpope/vim-fugitive' "Use Git
"    "Plug 'fholgado/minibufexpl.vim'
"    "Plug '~/Downloads/Vim/taglist_46'
    Plug 'majutsushi/tagbar'
    "Tagbar window will automatically close when you jump to a tag.
    let g:tagbar_autoclose = 1
    nnoremap <silent> <Leader>t :TagbarToggle<CR>
    Plug 'altercation/vim-colors-solarized'
    "Plug 'scrooloose/syntastic'
     Plug 'ctrlpvim/ctrlp.vim' "Pres Ctrl-p to open any file under the current directory
"    Plug 'jdonaldson/vaxe' "Haxe support
"    Plug 'tomasr/molokai'  "Pretty theme"
"    Plug 'vim-airline/vim-airline' "Pretty statusbar
"    Plug 'vim-airline/vim-airline-themes'
    "let g:airline#extensions#keymap#enabled = 0
    " For the following to work, I needed to `sudo apt-get install fonts-powerline`
    " See https://github.com/powerline/fonts
    "let g:airline_powerline_fonts = 1
    "let g:airline_theme='jellybeans'
"    Plug 'kadimisetty/vim-simplebar'
    "Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp mason highlight-all-pragmas moose test-more try-tiny' }
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
    " Plug 'jelera/vim-javascript-syntax'
    "To disable automatic checking and only check when the file is written: 
    "let JSHintUpdateWriteOnly=1
    "http://jshint.com/docs/
    "Plug 'wookiehangover/jshint.vim'
    "Plug 'fatih/vim-go'
    Plug 'othree/html5.vim'
    "Plug 'sirver/ultisnips'
    "Plug 'honza/vim-snippets'
    "let g:UltiSnipsUsePythonVersion = 3
    "let g:UltiSnipsExpandTrigger="<tab>"
    "let g:UltiSnipsJumpForwardTrigger="<c-b>"
    "let g:UltiSnipsJumpBackwardTrigger="<c-z>"
    " If you want :UltiSnipsEdit to split your window.
    "let g:UltiSnipsEditSplit="vertical"

    "Plug 'Valloric/YouCompleteMe'

" Add plugins to &runtimepath
call plug#end()
" commands depending on loaded plgins
colorscheme solarized  "jellybeans distinguished industry desert murphy slate molokai apprentice
" pandoc , markdown
command! -nargs=* RunSilent
      \ | execute ':silent !'.'<args>'
      \ | execute ':redraw!'
nmap <Leader>pc :RunSilent pandoc -o ~/tmp/vim-pandoc-out.html %<CR>
nmap <Leader>pp :RunSilent xdg-open ~/tmp/vim-pandoc-out.html<CR>

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



" Settings for the Taglist plugin
"let Tlist_Close_On_Select = 1
"let Tlist_Show_One_File = 1
"let Tlist_Compact_Format = 1
"let Tlist_Sort_Type = "name"
"let Tlist_Use_Right_Window = 1
"nnoremap <silent> <Leader>t :TlistToggle<CR>
"

let g:tagbar_type_perl = {
    \ 'ctagstype' : 'perl',
    \ 'kinds'     : [
        \ 'p:package:0:0',
        \ 'w:roles:0:0',
        \ 'e:extends:0:0',
        \ 'u:uses:0:0',
        \ 'r:requires:0:0',
        \ 'o:ours:0:0',
        \ 'a:properties:0:0',
        \ 'b:aliases:0:0',
        \ 'h:helpers:0:0',
        \ 's:subroutines:0:0',
        \ 'd:POD:1:0'
    \ ]
\ }

