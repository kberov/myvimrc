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
" Manage my plugins using vim-plug https://github.com/junegunn/vim-plug
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Make sure you use single quotes
call plug#begin('~/.vim/plugged')
    " Group dependencies
    "session plugin
    let g:session_autosave = 'yes'
    let g:session_autoload = 'no'
    Plug 'xolox/vim-misc' | Plug 'xolox/vim-session'
"   to open NERDTree ...
"   If 'mapleader' is not set or empty, a backslash is used instead.  The
"   below mapping  means \O (press backslash(\) then Shift+o)
    Plug 'scrooloose/nerdtree' " , { 'on': 'NERDTreeToggle' }
    map <Leader>O :NERDTreeToggle<CR>
    map <Leader>nf :NERDTreeFind<CR>
    let NERDTreeIgnore=['^\.git', '\~$']
"    let g:instant_markdown_autostart = 1
"    "Plug 'suan/vim-instant-markdown'
"	Plug 'tpope/vim-vinegar' "Press '-' to open the directory of the current file
    Plug 'tpope/vim-fugitive' "Use Git
" Show current branch in status line
set statusline=%f%m%r\ %y[%{&ff}]\ %{fugitive#statusline()}%=%-14.(%l:%c%V%)\ %P
"    "Plug 'fholgado/minibufexpl.vim'
"    "Plug '~/Downloads/Vim/taglist_46'
    Plug 'majutsushi/tagbar'
    "Tagbar window will automatically close when you jump to a tag.
    let g:tagbar_autoclose = 1
    nnoremap <silent> <Leader>t :TagbarToggle<CR>
    "Plug 'scrooloose/syntastic'
    Plug 'ctrlpvim/ctrlp.vim' "Pres Ctrl-p to open any file under the current directory
    Plug 'yssl/QFEnter' " Open items from Vim's quickfix or location list wherever you wish.
    " If you're a CtrlP user, for instance, you might like these for familiarity:
    let g:qfenter_keymap = {}
    let g:qfenter_keymap.vopen = ['<C-v>']
    let g:qfenter_keymap.hopen = ['<C-CR>', '<C-s>', '<C-x>']
    let g:qfenter_keymap.topen = ['<C-t>']
"    Plug 'jdonaldson/vaxe' "Haxe support
"    Plug 'kadimisetty/vim-simplebar'
    Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp mason highlight-all-pragmas moose test-more try-tiny' }
    Plug 'yko/mojo.vim'
    "Highlight embedded Perl code in __DATA__ sections of your Perl files.
    let mojo_highlight_data = 1
    "Don't highlight html inside __DATA__ templates - Perl code only.
    "let mojo_disable_html = 1

    " TypeScript support
    Plug 'leafgarland/typescript-vim'
    autocmd FileType typescript setlocal completeopt+=menu,preview
    Plug 'HerringtonDarkholme/yats.vim'
    "Plug 'Quramy/tsuquyomi'
    Plug 'clausreinke/typescript-tools.vim', { 'do': 'npm install' }
    " Plug 'Shougo/vimproc.vim'

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
    Plug 'pangloss/vim-javascript'
    " React JSX support
    Plug 'mxw/vim-jsx'
    let g:jsx_ext_required = 0 " Allow JSX in normal JS files

    "Plug 'fatih/vim-go'
    " vim-go requires Vim 7.4.2009 or Neovim 0.3.1, but you're using an older version.
    "let g:go_version_warning = 0
    Plug 'othree/html5.vim'
    "Plug 'sirver/ultisnips'
    "Plug 'honza/vim-snippets'
    "let g:UltiSnipsUsePythonVersion = 3
    "let g:UltiSnipsExpandTrigger="<tab>"
    "let g:UltiSnipsJumpForwardTrigger="<c-b>"
    "let g:UltiSnipsJumpBackwardTrigger="<c-z>"
    " If you want :UltiSnipsEdit to split your window.
    "let g:UltiSnipsEditSplit="vertical"

    "Plug '~/.vim/plugged/dbext_2600'
    "Plug 'Valloric/YouCompleteMe'
" Colorschemes:
    Plug 'nightsense/vimspectr'
    Plug 'altercation/vim-colors-solarized'
    Plug 'fcpg/vim-farout'
    Plug 'kadekillary/Turtles'
    Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'chriskempson/base16-vim'
    Plug 'JarrodCTaylor/spartan'
    " https://superuser.com/questions/921920
    " Display trailing spaces in vim
    Plug 'vim-scripts/ShowTrailingWhitespace'
" Add plugins to &runtimepath
call plug#end()
" commands depending on loaded plgins
" colorscheme solarized  "jellybeans distinguished industry desert murphy slate molokai apprentice
" To load a random dark theme during the night, random light theme during the day:
if has("gui_running")
    if strftime("%H") < 7 || strftime("%H") >= 19
      set background=dark
      let themes = [
        \ 'vimspectrgrey-dark',
        \ 'blue', 'darkblue', 'desert', 'distinguished',
        \ 'heman', 'elflord', 'evening', 'jellybeans', 'koehler', 'murphy',
        \ 'pablo', 'ron', 'slate', 'solarized', 'torte', 'farout',
        \ 'spartan', 'thermopylae', 'dracula', 'base16-3024', 'base16-apathy',
        \ 'base16-ashes', 'base16-atelier-dune', 'base16-atelier-heath'
        \ ]
    else
      set background=light
      let themes = [
        \ 'vimspectrgrey-light',
        \ 'default', 'delek', 'morning', 'peachpuff', 'shine', 'solarized',
        \ 'zellner', 'base16-atelier-dune-light', 'base16-cupertino',
        \ 'base16-atelier-heath-light'
        \ ]
    endif
    exe 'colorscheme '.themes[localtime() % len(themes)]
endif
":help ShowTrailingWhitespace CONFIGURATION
highlight ShowTrailingWhitespace ctermbg=Red guibg=Red

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
" Settings to support extended patterns for perl in ctags in tagbar
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
        \ 'm:private_subroutines:0:0',
        \ 't:old_private_subroutines:0:0',
        \ 'd:POD:1:0'
    \ ],
	\ 'ctagsbin'  : 'perl_ctags_for_tagbar'
\ }

