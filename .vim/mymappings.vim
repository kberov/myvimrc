" Some mappings
"
" Now the command line history can be used by just typing : then choosing a
" command and pressing enter
" http://vim.wikia.com/wiki/Using_command-line_history See also
" http://vim.wikia.com/wiki/VimTip681 - Enhanced command window use the
" command editing window, try these mappings:
"nnoremap : q:i
"nnoremap / q/i
"nnoremap ? q?i

" If "mapleader" is not set or empty, a backslash is used instead.
" you want to (make it easier to (make it easier to (edit text)))
" http://learnvimscriptthehardway.stevelosh.com/chapters/07.html
nnoremap <leader>ev :split $MYVIMRC<cr>

" Find in files!
" Press \+f and go to the prepared command line to modify the search pattern.
" The cursor is positioned conveniently between the search delimiters // like
" this /|/.
" **/*.%:e searches only in files of the same type as the current file:
" Use **/*.pm to search only in *.pm files.
" Use % to find occurennces in the current file only
map <Leader>f :noautocmd vimgrep! //j **/*.* <Bar> cw<C-Left><C-Left><C-Left><C-Left><Right>

"" Press \ff to search/find in all files of the same type for the current
"" word (the word under the cursor) and open the list of found occurences
"" (quickfix). Example: find usages of a method in all files!!!
"map <Leader>ff :execute "noautocmd vimgrep /" . expand("<cword>") . "/gj **/*".expand("%:e") <Bar> cw<CR><C-w>J

"copy current file name to the system clipboard 'cfp' stands for
"" 'current filename (full) path' - the full path
"map <Leader>cfp :let @+=expand('%:p')<CR>
"" only the file name - tail
"map <Leader>cft :let @+=expand('%:t')<CR>
" the relative path from the root of the project (current folder)
map <Leader>cf :let @+=expand('%')<CR>

" Navigating among opened files (buffers)
" Switch to alternate file
map <C-Tab> :bnext<cr>
map <C-S-Tab> :bprevious<cr>
"nmap b] :bnext<cr>
"nmap ]b :bnext<cr>
"nmap b[ :bprevious<cr>
"nmap [b :bprevious<cr>
"map <Leader>b :b
"
""Differs from 'j' when lines wrap, and when used with an operator, because it's not linewise.
map <Down> gj
map <Up> gk
"
" Some shortcuts to make it easier to jump between errors in quickfix list
map <leader>cn :cnext<CR>
map <leader>cp :cprevious<CR>
"Delete and not Cut - replacing text multiple times
"https://stackoverflow.com/questions/11993851
"Delete in normal mode.
nnoremap <leader>d "_d
"Delete in visual mode
vnoremap <leader>d "_d
"Replace in visual mode
vnoremap <leader>p "_dP
"
" Update/Save the file
nnoremap <silent> <leader>w :update<CR>
vnoremap <silent> <leader>w <ESC>:update<CR>
inoremap <silent> <leader>w <ESC>:update<CR>a

" To quickly switch/jump to windows
" Ctrl+leftarrow (or Ctrl+h) will go one window left, etc.
" See http://vim.wikia.com/wiki/Switch_between_Vim_window_splits_easily
map <silent> <C-Up> :wincmd k<CR>
map <silent> <C-Down> :wincmd j<CR>
map <silent> <C-Left> :wincmd h<CR>
map <silent> <C-Right> :wincmd l<CR>
map <silent> <C-k> :wincmd k<CR>
map <silent> <C-j> :wincmd j<CR>
map <silent> <C-h> :wincmd h<CR>
map <silent> <C-l> :wincmd l<CR>

" To move/swap windows see :help window-moving
" CTRL-W r Rotate windows downwards/rightwards.
" CTRL-W x Exchange current window with next one.
" The following commands can be used to change the window layout.
" CTRL-W K Move the current window to be at the very top, using the full
" width of the screen.
" CTRL-W J Move the current window to be at the very bottom, using the
" full width of the screen.
" CTRL-W H Move the current window to be at the far left, using the
" full height of the screen.
" CTRL-W L Move the current window to be at the far right, using the full
" height of the screen.
" CTRL-W T Move the current window to a new tab page. This fails if
" there is only one window in the current tab page.
" CTRL-W s CTRL-W T Split the current window and move the upper split to a new
" tab.
" See also :help CTRL-W for a full list of window commands.

" Open a new tab with the directory of the current file
" See https://stackoverflow.com/questions/5596548
" nnoremap t :tabnew %:h<cr>
"
" Move up and down in autocomplete with j and k
":inoremap <expr> j pumvisible() ? '<C-n>' : 'j'
":inoremap <expr> k pumvisible() ? '<C-p>' : 'k'

"Move entire line up and down https://stackoverflow.com/questions/741814
noremap <c-s-up> :call feedkeys( line('.')==1 ? '' : 'ddkP' )<CR>
noremap <c-s-down> ddp

"http://vim.wikia.com/wiki/Toggle_Insert-Normal_Mode_via_ctrl-space
" from insert mode to normal mode
"inoremap ii <Esc>
"inoremap <leader>i <Esc>
"inoremap <leader>a <Esc>
"inoremap jj <Esc>
inoremap ;; <Esc>
inoremap <leader><leader> <Esc>
" from normal mode to insert mode
noremap ;; i
noremap <leader><leader> i
"noremap <Space><Space>  i
"" from normal mode to insert mode - after the current letter
noremap ;a a
noremap <leader>a a
" go out of insert mode to the command line
inoremap ;: <Esc>:
inoremap <leader>: <Esc>:
"" Press ii or nn when in Command mode, to go back to  insert or normal mode
""cnoremap ii <ESC> i
""cnoremap nn <ESC>
"cnoremap <Space><Space> <Esc>
" exit - close current window while in insert mode
inoremap <leader>q <Esc> :q<CR>
" exit - close all windows while in insert mode
inoremap <leader>qa <Esc> :qa<CR>
" exit - close current window while in normal mode
noremap <leader>q :q<CR>
"" exit - close all windows while in normal mode
noremap <leader>qa :qa<CR>

" Core plugins
" Netrw settings; See https://shapeshed.com/vim-netrw/
let g:netrw_banner = 0 " remove the mostly useless banner
let g:netrw_liststyle = 3 " tree view
" The following always opens the new file in the previous window, which
" happens to be annoying when you want to open the file in the same window.
" So for now we use "P" when we want to open it in the previous window
let g:netrw_browse_split = 0 "4 - open in previous window like NERDTree
let g:netrw_winsize = 20 " % -  in percentage
let g:netrw_list_hide = &wildignore "ignore the same files as wildignore
"    augroup ProjectDrawer "launch it right after you’ve entered Vim
"      autocmd!
"      autocmd VimEnter * :Vexplore
"    augroup END
map <Leader>E :Lexplore<CR>  " Split left and explore
map <Leader>nf :Lexplore<CR>  " Split left and explore
nmap - :Ex<CR>
" Ctrl+Space or Ctrl+@ for autocompletion
" https://stackoverflow.com/questions/7722177/how-do-i-map-ctrl-x-ctrl-o-to-ctrl-space-in-terminal-vim
inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-Space>

" switch keymap: Ctrl+l
inoremap <Leader>l <C-^>
noremap <Leader>l a<C-^>

""My macros
""Clean starting, trailing and multiple spaces from a file!
"nnoremap <leader>cl  :%s/^\s\+//g<CR>:%s/\s\+$//g<CR>:%s/\s\+/ /g<CR>
"
