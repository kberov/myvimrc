
" Using Plugins. I tend to reduce Plugins usage by learning more of the VIM
" features
" Manage my plugins using vim-plug https://github.com/junegunn/vim-plug
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Make sure you use single quotes
call plug#begin('~/.vim/plugged')

" Colorschemes:
    Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'sainnhe/everforest'
    Plug 'sainnhe/gruvbox-material'
    Plug 'sainnhe/edge'
    "Plug 'chriskempson/base16-vim'
    " Error during updates
    "Plug 'nightsense/vimspectr'
    Plug 'vim-airline/vim-airline'
" Languages
    " Mojolicous(Perl)
    Plug 'yko/mojo.vim'
    " Plug 'vim-scripts/dbext.vim'
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    Plug 'othree/html5.vim'    
    "Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
    "Plug 'zah/nim.vim'
    Plug 'ollykel/v-vim'
    Plug 'rust-lang/rust.vim'
    " Plug 'JamshedVesuna/vim-markdown-preview'
    " ALE – проверки, форматиране и езикови сървъри за Perl, Shell,
    " JavaScript и HTML/HTMX. Go остава на vim-go (ALE не го пипа).
    " Останалите настройки са в .vim/ale_settings.vim.
    " Тази настройка трябва да е ПРЕДИ зареждането на ALE: собственото
    " довършване на ALE е изключено – довършването остава на vim-mucomplete,
    " а ALE само му подава думите чрез omnifunc (виж autoload/myide.vim).
    let g:ale_completion_enabled = 0
    Plug 'dense-analysis/ale'
    "Plug 'udalov/kotlin-vim'
    "Plug '~/opt/chapel-1.27.0/highlight/vim'
    "Plug 'cheap-glitch/vim-v'
    " Plug 'ziglang/zig.vim'
    "Plug 'arrufat/vala.vim'
    " D
    "Plug 'idanarye/vim-dutyl'
    "Search/Navigate
    " help Ack (I now use my mapping \f)
    " Plug 'mileszs/ack.vim'
    Plug 'tpope/vim-fugitive' "Use Git

    Plug 'scrooloose/nerdtree' " , { 'on': 'NERDTreeToggle' }
    "Pres Ctrl-p to open any file under the current directory
    Plug 'ctrlpvim/ctrlp.vim'
    "Highlighting word under cursor and all of its occurrences.
    Plug 'dominikduda/vim_current_word'
    "Tagbar: a class outline viewer for Vim
    Plug 'preservim/tagbar'
    "It will (re)generate tag files as you work while staying completely out
    "of your way. commented out for big projects like lazarus
    " Plug 'ludovicchabant/vim-gutentags'
    "Icons
    Plug 'ryanoasis/vim-devicons'
    " auto complete menu popups immediately
    Plug 'lifepillar/vim-mucomplete'
    " AI
    Plug 'keitheis/claude-code.vim'
" Initialize plugin system
call plug#end()
