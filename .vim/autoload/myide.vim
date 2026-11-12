" Общи помощни функции за „единната среда“ (IDE). Викат се от езиковите
" файлове в .vim/after/ftplugin/*.vim. Файлът е в autoload/, затова Vim го
" зарежда едва при първото извикване на myide#… (не забавя стартирането).
" Дизайн: docs/superpowers/specs/2026-11-11-vim-ide-design.md, раздел 5.

" Еднаквите клавиши за всички езици, обслужвани от ALE. Задават се само за
" текущия буфер (<buffer>), затова в Go (vim-go) и в обикновените текстове
" не пречат. Само нормален режим: в режим на въвеждане <leader> (`\`) при
" кирилица става `ю` и не би работил.
"   gd          – към определението  (закрива вграденото gd „локално
"                                    определение“, но само тук)
"   K, \h       – описание на думата под показалеца
"   gr          – всички употреби      (закрива вграденото gr, само тук)
"   \rn         – преименуване
"   ]e / [e     – следваща / предишна грешка (с превъртане в края)
"   Ctrl+клик   – към определението на думата, върху която щракнете
" Освен това omnifunc идва от ALE, така че Ctrl+Space (<C-x><C-o>) и
" vim-mucomplete предлагат думите от езиковия сървър.
" Ако ALE не е инсталиран (Vim без добавки), не прави нищо.
function! myide#AleKeys() abort
    if exists(':ALEGoToDefinition') != 2
        return
    endif
    nnoremap <buffer> <silent> gd :ALEGoToDefinition<CR>
    nnoremap <buffer> <silent> K :ALEHover<CR>
    nnoremap <buffer> <silent> <leader>h :ALEHover<CR>
    nnoremap <buffer> <silent> gr :ALEFindReferences<CR>
    nnoremap <buffer> <silent> <leader>rn :ALERename<CR>
    nmap <buffer> <silent> ]e <Plug>(ale_next_wrap)
    nmap <buffer> <silent> [e <Plug>(ale_previous_wrap)
    " <LeftMouse> първо мести показалеца там, където е щракнато.
    nnoremap <buffer> <silent> <C-LeftMouse> <LeftMouse>:ALEGoToDefinition<CR>
    setlocal omnifunc=ale#completion#OmniFunc
    " Ако видът на буфера се смени (:set ft=…), Vim изпълнява
    " b:undo_ftplugin – там казваме как да се махне всичко горе.
    call myide#AddUndo(myide#UnmapCmd(['gd', 'K', '<leader>h', 'gr',
          \ '<leader>rn', ']e', '[e', '<C-LeftMouse>']) . '|setlocal omnifunc<')
endfunction

" Команда, която маха буферните съответствия keys в нормален режим.
" ВНИМАНИЕ: преди `|` не бива да има интервал – при :unmap интервалът става
" част от клавиша („gd “ вместо „gd“) и Vim дава E31: No such mapping.
function! myide#UnmapCmd(keys) abort
    " `|` само МЕЖДУ командите: `||` би бил празна команда `:|`, която
    " изписва текущия ред при всяко :e.
    return join(map(copy(a:keys), '"silent! nunmap <buffer> " . v:val'), '|')
endfunction

" Добавя команди към b:undo_ftplugin, без да изтрива написаното там от
" ftplugin-ите на Vim и на добавките.
function! myide#AddUndo(cmd) abort
    let l:old = get(b:, 'undo_ftplugin', '')
    let b:undo_ftplugin = empty(l:old) ? a:cmd : l:old . ' | ' . a:cmd
endfunction

" Кои езици вече са проверени в тази сесия на Vim (за да няма повторения).
let s:checked = {}

" Проверява дали инструментите (програмите) от tools се намират в PATH.
" Връща списък с липсващите. Първия път за даден език (lang), ако има
" липсващи, изписва ЕДНО кратко съобщение (:messages го пази), напр.
"   Perl: липсват perlnavigator, perltidy (вижте install)
" Нищо не инсталира и не пипа PATH.
function! myide#CheckTools(lang, tools) abort
    let l:missing = filter(copy(a:tools), '!executable(v:val)')
    if !empty(l:missing) && !has_key(s:checked, a:lang)
        echomsg printf('%s: липсват %s (вижте install)', a:lang, join(l:missing, ', '))
    endif
    let s:checked[a:lang] = 1
    return l:missing
endfunction

" Търси name (файл или папка) нагоре от папката dir до /. Връща пълния
" път до намереното или ''. Нарочно НЕ ползва findfile()/finddir(): те
" спазват 'wildignore', а в .vimrc то съдържа */tmp/*, bin/** и т.н., така
" че проект в такава папка би останал „невидим“.
function! myide#FindUpFrom(dir, name) abort
    let l:dir = fnamemodify(a:dir, ':p')
    while 1
        let l:dir = substitute(l:dir, '/\+$', '', '')
        let l:candidate = l:dir . '/' . a:name
        if filereadable(l:candidate) || isdirectory(l:candidate)
            return l:candidate
        endif
        let l:parent = fnamemodify(empty(l:dir) ? '/' : l:dir, ':h')
        if empty(l:dir) || l:parent ==# l:dir
            return ''
        endif
        let l:dir = l:parent
    endwhile
endfunction

" Същото, от папката на текущия буфер (напр. .perltidyrc, .editorconfig).
function! myide#FindUp(name) abort
    return myide#FindUpFrom(expand('%:p:h'), a:name)
endfunction

" Корен на проекта за езиковите сървъри: папката над най-близкия .git,
" а извън git проект – папката на файла. Без това ALE не пуска сървърите
" за Shell и HTML върху самостоятелни файлове (напр. ~/bin/скрипт.sh).
" Ползва се от g:ale_root в .vim/ale_settings.vim.
function! myide#ProjectRoot(buffer) abort
    let l:dir = fnamemodify(bufname(a:buffer), ':p:h')
    let l:git = myide#FindUpFrom(l:dir, '.git')
    return empty(l:git) ? l:dir : fnamemodify(l:git, ':h')
endfunction
