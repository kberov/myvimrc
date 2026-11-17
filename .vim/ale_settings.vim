" Настройки на ALE (https://github.com/dense-analysis/ale).
" Зарежда се от .vimrc след myplugins_settings.vim.
" Дизайн: docs/superpowers/specs/2026-11-11-vim-ide-design.md
"
" Разделение:
"   Perl, Shell, JavaScript, HTML/HTMX – ALE.
"   Go – vim-go. ALE изобщо не работи в Go буфери (go: [] по-долу), за
"   да не се бият двата (двоен gopls, двойни грешки, двойно форматиране).
"
" КАК СЕ ДОБАВЯ НОВ ЕЗИК (Rust, C, V …):
"   1. Ред в g:ale_linters по-долу, напр.
"        \ 'rust': ['analyzer'],   (rust-analyzer)
"        \ 'c':    ['clangd'],
"        \ 'v':    ['v'],
"      и ако искате форматиране при запис – ред в g:ale_fixers.
"      Имената на проверките: :help ale-supported-languages-and-tools
"   2. Нов файл .vim/after/ftplugin/<filetype>.vim по образеца на perl.vim:
"      еднаквите клавиши (myide#AleKeys) + проверка за инструментите
"      (myide#CheckTools).
"   3. Инструментите (сървърите) – в списъка на ./install.
"
" Полезни команди:  :ALEInfo  – какво точно е пуснато за текущия буфер.
"                   :ALEFix   – форматирай сега.

" Пускай САМО изрично изброените проверки. Без това ALE пуска всичко,
" което намери – напр. tidy/htmlhint върху образците (.html.ep), които
" съдържат Perl код и биха изсипали десетки фалшиви грешки.
let g:ale_linters_explicit = 1

" Кои проверки/езикови сървъри за кой filetype.
"   perl          – perlsave: `perl -c` (синтаксис) САМО при запис – вижте
"                   .vim/ale_linters/perl/perlsave.vim (perl -c изпълнява
"                   BEGIN/use кода); + Perl::LanguageServer (определение,
"                   употреби); + perlcritic (вграденият в ALE).
"   sh            – shellcheck + bash-language-server.
"   javascript    – tsserver (от npm пакета typescript); работи и с
"                   обикновен JS без package.json.
"   html          – HTML сървърът на VS Code + htmx-lsp (довършване и
"                   описание на hx-* атрибутите). htmx-lsp е дефиниран в
"                   .vim/ale_linters/html/htmx.vim.
"   epl           – втората част на filetype `html.epl` (.html.ep от
"                   mojo.vim). ALE разделя html.epl на html + epl, затова
"                   образците получават само двата сървъра от html.
"   go            – нищо: Go е на vim-go.
let g:ale_linters = {
      \ 'perl': ['perlsave', 'languageserver', 'perlcritic'],
      \ 'sh': ['shellcheck', 'language_server'],
      \ 'javascript': ['tsserver'],
      \ 'html': ['vscodehtml', 'htmx'],
      \ 'epl': [],
      \ 'go': [],
      \ }

" Форматиране при запис – само Perl и Shell. HTML и JS форматирам сам,
" Go се форматира от vim-go (goimports).
let g:ale_fixers = {
      \ 'perl': ['perltidy'],
      \ 'sh': ['shfmt'],
      \ }
let g:ale_fix_on_save = 1

" shfmt: 4 интервала (като expandtab/shiftwidth=4 в .vimrc) и отстъпени
" клонове в case. Без това shfmt ползва табулации.
let g:ale_sh_shfmt_options = '-i 4 -ci'

" Грешките – в списъка на местата (location list, :lopen), който е свой за
" всеки прозорец. Quickfix (:copen) остава за \f (vimgrep) и \cn / \cp.
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0

" Perl::LanguageServer (езиковият сървър за Perl; linter-ът на ALE се казва
" `languageserver`). Подробно – раздел 6 на замисъла
" (docs/superpowers/specs/2026-11-11-vim-ide-design.md).
"   enable   – сървърът е включен.
"   perlCmd  – 'true' вместо perl: иначе сървърът сам пуска `perl -c` при
"              всяко отваряне и промяна (а `perl -c` изпълнява BEGIN/use
"              кода). Така `perl -c` го пуска само ALE и само при запис
"              (perlsave по-горе), и грешките не излизат двойно.
"   cacheDir – кешът на сървъра; иначе той пише в <проект>/.vscode/perl-lang.
" perlcritic не е в сървъра, а е отделна проверка на ALE (списъкът по-горе).
" Профилът на perltidy се избира за всеки буфер в .vim/after/ftplugin/perl.vim
" (проектният .perltidyrc нагоре от файла, иначе ~/.perltidyrc).
" perlcritic сам търси .perlcriticrc в текущата папка, после в ~.
let g:ale_perl_languageserver_config = {
      \ 'perl': {
      \   'enable': 1,
      \   'perlCmd': 'true',
      \   'cacheDir': expand('~/.cache/perl-lang'),
      \ },
      \ }

" Корен на проекта за bash-language-server и HTML сървъра: вградените в ALE
" правила искат .git и без него сървърът изобщо не тръгва. myide#ProjectRoot
" дава .git корена, а извън git – папката на файла.
let g:ale_root = {
      \ 'language_server': function('myide#ProjectRoot'),
      \ 'vscodehtml': function('myide#ProjectRoot'),
      \ }
