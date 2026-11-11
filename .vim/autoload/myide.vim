" Общи помощни функции за „единната среда“ (IDE). Викат се от езиковите
" файлове в .vim/after/ftplugin/*.vim. Файлът е в autoload/, затова Vim го
" зарежда едва при първото извикване на myide#… (не забавя стартирането).
" Дизайн: docs/superpowers/specs/2026-11-11-vim-ide-design.md, раздел 5.

" Еднаквите клавиши за всички езици, обслужвани от ALE. Задават се само за
" текущия буфер (<buffer>), затова в Go (vim-go) и в обикновените текстове
" не пречат. Само нормален режим: в режим на въвеждане <leader> (`\`) при
" кирилица става `ю` и не би работил.
"   gd          – към дефиницията       (закрива вграденото gd „локална
"                                         дефиниция“, но само тук)
"   K, \h       – описание на думата под курсора
"   gr          – всички употреби      (закрива вграденото gr, само тук)
"   \rn         – преименуване
"   ]e / [e     – следваща / предишна грешка (с превъртане в края)
"   Ctrl+клик   – към дефиницията на думата, върху която щракнеш
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
    " <LeftMouse> първо мести курсора там, където е щракнато.
    nnoremap <buffer> <silent> <C-LeftMouse> <LeftMouse>:ALEGoToDefinition<CR>
    setlocal omnifunc=ale#completion#OmniFunc
endfunction

" Кои езици вече са проверени в тази сесия на Vim (за да няма повторения).
let s:checked = {}

" Проверява дали инструментите (програмите) от tools се намират в PATH.
" Връща списък с липсващите. Първия път за даден език (lang), ако има
" липсващи, изписва ЕДНО кратко съобщение (:messages го пази), напр.
"   Perl: липсват perlnavigator, perltidy (виж install)
" Нищо не инсталира и не пипа PATH.
function! myide#CheckTools(lang, tools) abort
    let l:missing = filter(copy(a:tools), '!executable(v:val)')
    if !empty(l:missing) && !has_key(s:checked, a:lang)
        echomsg printf('%s: липсват %s (виж install)', a:lang, join(l:missing, ', '))
    endif
    let s:checked[a:lang] = 1
    return l:missing
endfunction
