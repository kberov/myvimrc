" htmx-lsp – езиков сървър за HTMX: довършване и описание (K) на hx-*
" атрибутите. ALE няма вграден, затова го дефинираме тук.
" ALE зарежда сам всички файлове от ale_linters/<filetype>/ в runtimepath,
" когато за пръв път отвори буфер от този вид – тук: html (и html.epl).
" Включва се от g:ale_linters в .vim/ale_settings.vim ('htmx').
" Инсталиране: cargo install htmx-lsp  (или готов файл от GitHub).
" Ако htmx-lsp липсва, ALE просто не го пуска.

" Коренът на проекта: папката над най-близкия .git, иначе папката на файла.
" Езиковите сървъри искат такъв корен, за да тръгнат.
function! ale_linters#html#htmx#GetProjectRoot(buffer) abort
    let l:git_path = ale#path#FindNearestDirectory(a:buffer, '.git')

    return !empty(l:git_path)
    \   ? fnamemodify(l:git_path, ':h:h')
    \   : fnamemodify(bufname(a:buffer), ':p:h')
endfunction

call ale#linter#Define('html', {
\   'name': 'htmx',
\   'lsp': 'stdio',
\   'executable': 'htmx-lsp',
\   'command': '%e',
\   'project_root': function('ale_linters#html#htmx#GetProjectRoot'),
\})
