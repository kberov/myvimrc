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
"      и ако искаш форматиране при запис – ред в g:ale_fixers.
"      Имената на проверките: :help ale-supported-languages-and-tools
"   2. Нов файл .vim/after/ftplugin/<filetype>.vim по образеца на perl.vim:
"      еднаквите клавиши (myide#AleKeys) + проверка за инструментите
"      (myide#CheckTools).
"   3. Инструментите (сървърите) – в списъка на ./install.
"
" Полезни команди:  :ALEInfo  – какво точно е пуснато за текущия буфер.
"                   :ALEFix   – форматирай сега.

" Пускай САМО изрично изброените проверки. Без това ALE пуска всичко,
" което намери – напр. tidy/htmlhint върху шаблоните (.html.ep), които
" съдържат Perl код и биха изсипали десетки фалшиви грешки.
let g:ale_linters_explicit = 1

" Кои проверки/езикови сървъри за кой filetype.
"   perl          – `perl -c` (синтаксис) + Perl Navigator (дефиниция,
"                   описание, употреби, perlcritic).
"   sh            – shellcheck + bash-language-server.
"   javascript    – tsserver (от npm пакета typescript); работи и с
"                   обикновен JS без package.json.
"   html          – HTML сървърът на VS Code + htmx-lsp (довършване и
"                   описание на hx-* атрибутите). htmx-lsp е дефиниран в
"                   .vim/ale_linters/html/htmx.vim.
"   epl           – втората част на filetype `html.epl` (.html.ep от
"                   mojo.vim). ALE разделя html.epl на html + epl, затова
"                   шаблоните получават само двата сървъра от html.
"   go            – нищо: Go е на vim-go.
let g:ale_linters = {
      \ 'perl': ['perl', 'perlnavigator'],
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

" Perl Navigator (езиковият сървър за Perl).
"   perlcriticEnabled  – perlcritic при всяка промяна/запис.
"   perlCompileEnabled – изключено: `perl -c` го пуска ALE (проверката
"                        `perl` по-горе), иначе синтактичните грешки
"                        излизат двойно. Така `perl -c` работи и когато
"                        perlnavigator липсва.
" Профилите (.perlcriticrc, .perltidyrc) не се задават изрично: perlcritic
" и perltidy сами търсят първо в текущата папка (проекта), после в ~.
let g:ale_perl_perlnavigator_config = {
      \ 'perlnavigator': {
      \   'perlcriticEnabled': 1,
      \   'perlCompileEnabled': 0,
      \ },
      \ }
