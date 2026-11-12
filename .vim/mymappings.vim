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

" Find and replace in files in the current project/folder!!!
" 1. Use "Find in Files" as above
" 2. Use `cdo %s/searchPttErN/ReplaceText/gc` or let make a mapping to write
" this for us.
map <Leader>r :cfdo %s///gc<C-Left><C-Left><C-Left><C-Left>
" 3. To save the changes, do `:cdo update`
"
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
" :update записва само ако файлът е променен.
" \w работи в нормален и визуален режим. В режим на въвеждане НЕ го
" задаваме: при включена кирилица (keymap oldbgph) `\` става `ю` и
" съответствието никога не се задейства. Там ползвайте Ctrl+S (вижте по-долу).
nnoremap <silent> <leader>w :update<CR>
vnoremap <silent> <leader>w <ESC>:update<CR>

" Ctrl+S – запис във всички режими, и в GVim, и в терминала.
" Работи и при включена кирилица, защото keymap не превежда Ctrl-клавишите.
" (Преместено от .gvimrc.)
" Ако в терминала Ctrl+S „замразява“ екрана (размразява се с Ctrl+Q),
" добавете в ~/.bashrc:  [ -t 0 ] && stty -ixon
" http://stackoverflow.com/questions/3446320/in-vim-how-to-map-save-to-ctrl-s#3448551
" Нормален режим: просто записва.
nnoremap <silent> <C-S> :update<CR>
" Визуален режим: <C-C> излиза от избора, после записва.
vnoremap <silent> <C-S> <C-C>:update<CR>
" Режим на въвеждане: <C-O> изпълнява една команда и те връща обратно в
" режим на въвеждане – показалецът остава на място.
inoremap <silent> <C-S> <C-O>:update<CR>

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
inoremap <c-s-up> <ESC>:call feedkeys( line('.')==1 ? '' : 'ddkP' )<CR>
inoremap <c-s-down> <ESC>ddp

"http://vim.wikia.com/wiki/Toggle_Insert-Normal_Mode_via_ctrl-space
" from insert mode to normal mode
"inoremap ii <Esc>
"inoremap <leader>i <Esc>
"inoremap <leader>a <Esc>
"inoremap jj <Esc>
" ;; – излизане от режим на въвеждане. Работи и на кирилица, защото keymap
" оставя `;` непроменено. Вградена алтернатива: Ctrl+[ (същото като Esc).
" Махнато: inoremap \\ – на кирилица `\` става `ю` и то не се задейства.
inoremap ;; <Esc>
" from normal mode to insert mode
" Махнати: noremap ;; i  и  noremap ;a a – те закриваха `;`, която в
" нормален режим повтаря последното f/t/F/T (а `,` го повтаря назад).
" Ползвай просто i и a (или \\ и \a по-долу).
noremap <leader><leader> i
"noremap <Space><Space>  i
"" from normal mode to insert mode - after the current letter
noremap <leader>a a
" go out of insert mode to the command line
" ;: – от режим на въвеждане направо в командния ред. Работи и на кирилица.
" Махнато: inoremap \: (не работи на кирилица).
inoremap ;: <Esc>:
"" Press ii or nn when in Command mode, to go back to  insert or normal mode
""cnoremap ii <ESC> i
""cnoremap nn <ESC>
"cnoremap <Space><Space> <Esc>
" Махнати: inoremap \q и \qa (не работят на кирилица).
" От режим на въвеждане: ;; и после \q или \qa.
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
" \E и \nf – отварят Netrw (вградения файлов изследовател) отляво.
" \nf е резервен вариант без добавки: когато се зарежда
" myplugins_settings.vim, там \nf се пренасочва към :NERDTreeFind.
" Ако спрете добавките, \nf пак отваря файловете – чрез Netrw.
" Забележка: коментарът вече е на отделен ред. При :map всичко след
" командата (и `" ...`) става част от съответствието и се „натиска“.
map <Leader>E :Lexplore<CR>
map <Leader>nf :Lexplore<CR>
nmap - :Ex<CR>
" Ctrl+Space or Ctrl+@ for autocompletion
" https://stackoverflow.com/questions/7722177/how-do-i-map-ctrl-x-ctrl-o-to-ctrl-space-in-terminal-vim
inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-Space>

" Смяна на езика (латиница ↔ кирилица). Think "switch language".
" Режим на въвеждане: Ctrl+L (или вграденото Ctrl+^). Ctrl-клавишите не се
" превеждат от keymap, затова работят и в двете посоки.
" Махнато: inoremap \l – на кирилица `\` става `ю`, затова с него можехте
" да включите кирилицата, но не и да я изключите.
inoremap <C-L> <C-^>
" Нормален режим: \l влиза в режим на въвеждане след показалеца и сменя езика.
noremap <Leader>l a<C-^>

""My macros
""Clean starting, trailing and multiple spaces from a file!
"nnoremap <leader>cl  :%s/^\s\+//g<CR>:%s/\s\+$//g<CR>:%s/\s\+/ /g<CR>
"
" https://vi.stackexchange.com/questions/11609/automatically-rewrap-lines-when-writing-markdown-in-vim
" When the 'a' flag is present in 'formatoptions', text is formatted
" automatically when inserting text or deleting text.  This works nicely for
" editing text paragraphs.
" - Add the 'c' flag to only auto-format comments(already added by default).
"   Useful in source code.
" Note!!! Does not work as all this rewraps even contiguous lines in source
" code, so better simply use gwap<CR>
" set formatoptions+=a
" augroup rewrapparagraph
" autocmd!
" autocmd InsertLeave * normal gwap<CR>
" augroup END

" Save a file which needs root privileges for writing to it and I opened it as
" a normal user.
" https://linuxvox.com/blog/can-i-gain-root-permission-without-leaving-vim/
" Употреба:  :SudoW
" Пише буфера през sudo тук, в терминала, в който работите (sudo може да поиска парола).
" В GVim няма терминал за паролата, затова там работи само ако sudo не пита за нея.
" Преди беше `cnoremap ww …`, което се задействаше навсякъде в командния
" ред – включително при търсене с / (например /www).
" Името на файла се огражда с кавички (shellescape), за да работи и с интервали.
" Накрая edit! презарежда файла, за да знае Vim, че е записан – но САМО ако
" sudo е успял (v:shell_error == 0). Иначе (грешна парола, Ctrl-C, GVim без
" терминал) edit! би изтрил незаписаните промени.
command! SudoW execute 'write !sudo tee ' . shellescape(expand('%'), 1) . ' >/dev/null'
      \ | if !v:shell_error | edit! | endif
