" Go (go) – същите клавиши като в другите езици, но към vim-go, не към
" ALE (ALE не пипа Go – вижте .vim/ale_settings.vim).
" Файлът е в after/ftplugin: изпълнява се след ftplugin-а на vim-go.
" gd, K и Ctrl+клик vim-go ги задава сам (към :GoDef и :GoDoc); тук ги
" допълваме до общия набор. \gb, \gr, \go остават от myplugins_settings.vim.
" Ако vim-go не е инсталиран, не задава нищо.
if exists(':GoDef') == 2
    " gr – всички употреби
    nnoremap <buffer> <silent> gr :GoReferrers<CR>
    " \rn – преименуване
    nnoremap <buffer> <silent> <leader>rn :GoRename<CR>
    " ]e / [e – следваща / предишна грешка (vim-go ги пише в списъка на
    " местата, location list, както ALE)
    nnoremap <buffer> <silent> ]e :lnext<CR>
    nnoremap <buffer> <silent> [e :lprevious<CR>
    " Ctrl+клик – към определението на думата, върху която щракнете
    nnoremap <buffer> <silent> <C-LeftMouse> <LeftMouse>:GoDef<CR>
    " При смяна на вида на буфера – махаме горните (вижте myide#UnmapCmd).
    call myide#AddUndo(myide#UnmapCmd(['gr', '<leader>rn', ']e', '[e',
          \ '<C-LeftMouse>']))
endif
call myide#CheckTools('Go', ['go', 'gopls'])
