# Perl::LanguageServer вместо Perl Navigator – план за изпълнение

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Цел:** `gd`, `gr` и perlcritic за Perl чрез инструменти на Perl (Perl::LanguageServer + perlcritic на ALE), `K` чрез `perldoc`, без Node.

**Архитектура:** ALE пуска вградения си linter `languageserver` с настройка, която спира собствения `perl -c` на сървъра (`perlCmd: 'true'`) и изнася кеша му извън проекта (`cacheDir`). `perl -c` остава само при запис (`perlsave`). `K` в Perl буферите вика нова функция `myide#PerlDoc()`. Липсващ модул се открива с бърза проверка по `@INC`, без да се зарежда.

**Технологии:** Vim 9.1, ALE, vim-plug, Perl 5.44 (perlbrew), Perl::LanguageServer 2.6.2, POSIX sh.

**Замисъл:** `docs/superpowers/specs/2026-11-11-vim-ide-design.md` – раздел 6 „Perl“ (с „Изборът на езиков сървър за Perl“), раздел 5 (изключението за `K`), раздел 7 „Среда и липсващи инструменти“, раздел 8 `install`.

## Общи ограничения

- `perl -c` се пуска **само при запис** (`perlsave`); никога при отваряне или промяна.
- Нищо не се инсталира само. `install` и Vim само **изписват** какво липсва.
- Липсващ инструмент или модул не чупи Vim и не сипе грешки; едно `echomsg` на сесия за език.
- `install` и `tests/*.sh`: **само POSIX sh** (без `[[ ]]`, масиви, `local`, `echo -e`); проверка с `shellcheck -s sh` и `dash`.
- Коментарите в кода и текстовете – на български; в README и cheatsheet.md – обръщение „Вие“; думи: лад (mode), добавки (plugins), съответствия (mappings), образци (templates), довършване (completion), показалец (cursor).
- Съответствията са буферни (`<buffer>`) и се махат през `b:undo_ftplugin` (`myide#AddUndo`).
- Тестовете се пускат със `sh tests/run [име]`; `.vim` тестовете пишат `v:errors` в `$TEST_OUT`.
- **Подаването е на автора.** Всяка задача завършва с показан `git diff` за преглед, без `git commit`.

## На какво да внимава прегледът

1. **Perl::LanguageServer липсва** (работната машина): ALE не бива да пуска `perl -MPerl::LanguageServer …` и да сипе грешки при всяко отваряне – само едно съобщение от `CheckTools`. → тест в задача 3 (`myide#PerlLinters(0)`).
2. **Файл извън git проект / GVim пуснат другаде:** сървърът трябва да тръгне и `gd` да работи в самотен файл; кешът – пак в `~/.cache/perl-lang`, не до файла. → тест в задача 2 (временна папка без `.git`).
3. **`~/.cache/perl-lang` още не съществува** (нова машина): сървърът трябва сам да я създаде. → тест в задача 2 (празен `$HOME`).
4. **`K` върху дума без описание** (метод като `where_domain_is`, `$self`): кратко съобщение, без празен прозорец. → тест в задача 4.
5. **`K` върху `Foo::Bar->new`:** `iskeyword` в Perl съдържа `:`, затова думата е `Foo::Bar`; трябва да отвори описанието на модула. → тест в задача 4.

---

### Задача 1: ALE – `languageserver` + `perlcritic` вместо `perlnavigator`

**Файлове:**
- Промяна: `.vim/ale_settings.vim` (редове 26–46: коментарът за perl и `g:ale_linters`; редове 71–86: блокът за Perl Navigator)
- Тест: `tests/test_ale_settings.vim`, `tests/test_perl_onsave.vim`

**Интерфейси:**
- Създава: `g:ale_linters.perl == ['perlsave', 'languageserver', 'perlcritic']`; `g:ale_perl_languageserver_config == {'perl': {'enable': 1, 'perlCmd': 'true', 'cacheDir': expand('~/.cache/perl-lang')}}`. Махат се `g:ale_perl_perlnavigator_config` и всяко споменаване на Perl Navigator във файла.

- [ ] **Стъпка 1: Тестовете да искат новото**

В `tests/test_ale_settings.vim`:
```vim
" в очаквания речник g:ale_linters:
      \ 'perl': ['perlsave', 'languageserver', 'perlcritic'],
" вместо трите реда за s:pn:
let s:ls = get(get(g:, 'ale_perl_languageserver_config', {}), 'perl', {})
call assert_equal(1, get(s:ls, 'enable', 0), 'languageserver enable')
call assert_equal('true', get(s:ls, 'perlCmd', ''), 'perlCmd – без perl -c от сървъра')
call assert_equal(expand('~/.cache/perl-lang'), get(s:ls, 'cacheDir', ''), 'cacheDir')
call assert_false(exists('g:ale_perl_perlnavigator_config'), 'няма perlnavigator')
" за x.pl:
call assert_equal(['languageserver', 'perlcritic', 'perlsave'], s:Names(), '.pl')
```
В `tests/test_perl_onsave.vim`: `['languageserver', 'perlcritic', 'perlsave']` вместо `['perlnavigator', 'perlsave']`.

- [ ] **Стъпка 2: Да падат**

Run: `sh tests/run test_ale_settings; sh tests/run test_perl_onsave`
Expected: FAIL и за двата (`ale_linters`, `.pl`, `perl проверки`).

- [ ] **Стъпка 3: Промяната в `.vim/ale_settings.vim`**

Стойностите от „Интерфейси“. Коментарът над `g:ale_perl_languageserver_config` обяснява накратко трите ключа (защо `perlCmd` е `true` – сървърът иначе пуска `perl -c` при всяко отваряне и промяна; защо `cacheDir` – иначе пише в `<проект>/.vscode/perl-lang`) и препраща към раздел 6 на замисъла. Коментарят за `perl` в списъка с проверки: perlsave + Perl::LanguageServer (определение, употреби) + perlcritic.

- [ ] **Стъпка 4: Да минават**

Run: `sh tests/run`
Expected: `15/15 успешни`

- [ ] **Стъпка 5: `git diff` за преглед от автора**

---

### Задача 2: Сървърът наистина не пуска `perl -c` и не пише в проекта

Проверка срещу истинския Perl::LanguageServer, с настройката, взета от Vim. Клиентът е на Perl (принципът на автора).

**Файлове:**
- Създаване: `tests/lsp_client.pl` – малък LSP клиент през stdio (само ядрото на Perl: `IPC::Open3`, `JSON::PP`, `IO::Select`)
- Създаване: `tests/test_perl_ls.sh`
- Създаване: `tests/fixtures/ls/Begin.pm` – `package Begin; BEGIN { open my $f, '>', $ENV{LS_MARK} } sub hello { 1 } sub world { hello() } 1;`

**Интерфейси:**
- Използва: `g:ale_perl_languageserver_config` от задача 1.
- `tests/lsp_client.pl КОРЕН ФАЙЛ НАСТРОЙКА_JSON ЧАКАНЕ_СЕК -- КОМАНДА…`: изпраща `initialize` (rootUri = КОРЕН), `initialized`, `workspace/didChangeConfiguration` (`settings` = НАСТРОЙКА_JSON), `textDocument/didOpen` (ФАЙЛ), чака ЧАКАНЕ_СЕК, после `textDocument/definition` върху `hello` в `world`. Изписва на stdout един ред `DEF <ред>` (1-базиран) или `DEF none`; изход 0, ако сървърът е отговорил на `initialize`, иначе 1.

- [ ] **Стъпка 1: Тестът**

`tests/test_perl_ls.sh`:
- Ако `perl -e 'exit !grep { -f "$_/Perl/LanguageServer.pm" } @INC'` дава ≠ 0: `echo "SKIP: няма Perl::LanguageServer"; exit 0`.
- `HOME` и проектът – нови временни папки (`mktemp -d`), проектът **без** `.git`; копира `Begin.pm` там.
- Настройката: `vim -N -u "$REPO/.vimrc" -i NONE -es -c 'call writefile([json_encode(g:ale_perl_languageserver_config)], $OUTF)' -c 'qa!'`.
- `test_ls_no_compile`: `LS_MARK=$P/mark perl tests/lsp_client.pl "$P" "$P/Begin.pm" "$CFG" 5 -- perl -MPerl::LanguageServer -ePerl::LanguageServer::run` → **няма** `$P/mark`.
- `test_ls_definition`: изходът съдържа `DEF 1` (`hello` е на ред 1 в `Begin.pm`).
- `test_ls_cache_outside_project`: няма `$P/.vscode`; има `$HOME/.cache/perl-lang` (папка, която преди не е съществувала).
- `test_ls_control`: същото, но с `perlCmd` махнато от настройката → **има** `$P/mark`. (Доказва, че тестът изобщо може да види `perl -c`.)

- [ ] **Стъпка 2: Да пада**

Run: `sh tests/run test_perl_ls`
Expected: FAIL (`tests/lsp_client.pl` още го няма). Ако Perl::LanguageServer не е инсталиран в perlbrew, пуснете с `PERL5LIB=<временна инсталация>/lib/perl5:$PERL5LIB` (`cpanm -L /tmp/… Perl::LanguageServer`), за да не е SKIP.

- [ ] **Стъпка 3: `tests/lsp_client.pl`**

Заглавия `Content-Length`, четене с таймаут през `IO::Select`; отговаря с `null` на заявки от сървъра; накрая `shutdown` и `kill`. Позицията на `hello` в `world` се търси по текст, не се пише на ръка.

- [ ] **Стъпка 4: Да минава**

Run: `sh tests/run test_perl_ls` (с Perl::LanguageServer) → PASS; `sh tests/run` → всичко минава (`16/16`).
`shellcheck -s sh tests/test_perl_ls.sh` → чисто.

- [ ] **Стъпка 5: `git diff` за преглед от автора**

---

### Задача 3: Липсващ Perl модул – проверка и без сървър в ALE

**Файлове:**
- Промяна: `.vim/autoload/myide.vim` (`myide#CheckTools`, нови `myide#HasPerlModule`, `myide#PerlLinters`)
- Промяна: `.vim/after/ftplugin/perl.vim` (ред 6 – коментарът; ред 8 – списъкът; `b:ale_linters`)
- Тест: `tests/test_myide.vim`

**Интерфейси:**
- `myide#HasPerlModule(name: String) -> Number` (1/0). Бърза проверка: `perl -e 'exit !grep { -f "$_/<път>.pm" } @INC'` (`::` → `/`), **не** `-M` (зарежда Moose и Coro: ~0,3 с). Резултатът се пази в `s:` за сесията.
- `myide#CheckTools(lang, tools)`: елемент с `::` се проверява с `myide#HasPerlModule`, останалите – с `executable()`. Всичко друго е както досега.
- `myide#PerlLinters(has_ls: Number) -> List`: `['perlsave', 'languageserver', 'perlcritic']` или без `'languageserver'`.
- В `after/ftplugin/perl.vim`: `CheckTools('Perl', ['perl', 'Perl::LanguageServer', 'perltidy', 'perlcritic'])`; `let b:ale_linters = myide#PerlLinters(myide#HasPerlModule('Perl::LanguageServer'))` + `AddUndo('unlet! b:ale_linters')`.

- [ ] **Стъпка 1: Тестовете**

В `tests/test_myide.vim`:
```vim
" test_has_perl_module
call assert_equal(1, myide#HasPerlModule('File::Spec'), 'File::Spec е в ядрото')
call assert_equal(0, myide#HasPerlModule('No::Such::ModXyz'), 'липсващ модул')
" test_checktools_module
call assert_equal(['No::Such::ModXyz'],
      \ myide#CheckTools('M', ['sh', 'File::Spec', 'No::Such::ModXyz']), 'CheckTools модул')
" test_perl_linters
call assert_equal(['perlsave', 'languageserver', 'perlcritic'], myide#PerlLinters(1), 'със сървър')
call assert_equal(['perlsave', 'perlcritic'], myide#PerlLinters(0), 'без сървър')
```

- [ ] **Стъпка 2: Да падат**

Run: `sh tests/run test_myide` → FAIL (`E117: Unknown function`).

- [ ] **Стъпка 3: Функциите и `after/ftplugin/perl.vim`**

- [ ] **Стъпка 4: Да минават**

Run: `sh tests/run` → всичко минава.

- [ ] **Стъпка 5: `git diff` за преглед от автора**

---

### Задача 4: `K` и `\h` в Perl → `perldoc`

**Файлове:**
- Промяна: `.vim/autoload/myide.vim` (нова `myide#PerlDoc`)
- Промяна: `.vim/after/ftplugin/perl.vim` (след `myide#AleKeys()`)
- Промяна: `cheatsheet.md` (таблицата „С добавки“, ред с `K`; нов ред за `gf`)
- Тест: нов `tests/test_perldoc.vim`

**Интерфейси:**
- `myide#PerlDoc(word: String) -> Number`: ако `word` съдържа `::` – `perldoc -otext -T <word>`, иначе `perldoc -otext -T -f <word>`. При успех (код 0 и непразен изход) показва текста в един и същ прозорец-драскалка (`buftype=nofile`, `bufhidden=wipe`, `noswapfile`, име `perldoc://<word>`, `nomodifiable`), отгоре на текущия, и връща 1. Иначе `echomsg 'perldoc: няма описание за <word>'` и връща 0, без нов прозорец.
- В `after/ftplugin/perl.vim`: `nnoremap <buffer> <silent> K :call myide#PerlDoc(expand('<cword>'))<CR>` и същото за `<leader>h`. Махането вече го прави `AleKeys` (`K`, `<leader>h` са в списъка ѝ).

- [ ] **Стъпка 1: Тестът**

`tests/test_perldoc.vim`:
```vim
" test_perldoc_function
let s:w = winnr('$')
call assert_equal(1, myide#PerlDoc('join'), 'join')
call assert_match('perldoc://join', bufname(''), 'име на буфера')
call assert_true(search('separate strings', 'nw') > 0, 'текстът на perldoc -f join')
close
" test_perldoc_module (Foo::Bar->new: <cword> е Foo::Bar)
enew | setfiletype perl | call setline(1, 'File::Spec->catfile(1)')
call assert_equal('File::Spec', expand('<cword>'), '<cword> с ::')
call assert_equal(1, myide#PerlDoc('File::Spec'), 'модул')
close
" test_perldoc_missing
call assert_equal(0, myide#PerlDoc('where_domain_is'), 'няма описание')
call assert_equal(s:w, winnr('$'), 'без нов прозорец')
" test_perldoc_keys
call assert_match('PerlDoc', maparg('K', 'n'), 'K в Perl')
call assert_match('PerlDoc', maparg('<leader>h', 'n'), '\h в Perl')
call writefile(v:errors, $TEST_OUT) | qa!
```

- [ ] **Стъпка 2: Да пада**

Run: `sh tests/run test_perldoc` → FAIL.

- [ ] **Стъпка 3: `myide#PerlDoc` и клавишите**

- [ ] **Стъпка 4: `cheatsheet.md`**

В таблицата „С добавки“: в реда за `K`, `\h` – „в Perl: `perldoc`“ и `:help K` до `:help :ALEHover`. Нов ред: `gf` | Perl | към файла на модула под показалеца (`use Foo::Bar`) | `:help gf`. В абзаца под таблицата: perlcritic проверява при промяна, а `perl -c` – само при запис.

- [ ] **Стъпка 5: Да минават**

Run: `sh tests/run` → всичко минава (вкл. `test_cheatsheet_help` за новия `:help gf`).

- [ ] **Стъпка 6: `git diff` за преглед от автора**

---

### Задача 5: `install`, README, последни следи от Perl Navigator

**Файлове:**
- Промяна: `install` (`hint()` и цикълът в т. 3)
- Промяна: `README.md` (ред 12 – колоната „чрез“; таблицата с инструментите, ред 149)
- Тест: `tests/test_install.sh` (`test_missing_tools`)

**Интерфейси:**
- `install` проверява модула Perl::LanguageServer отделно от цикъла с `command -v` (с бързата проверка по `@INC` от задача 3, през `perl`, ако го има) и изписва `ЛИПСВА Perl::LanguageServer: cpanm Perl::LanguageServer`. `perlnavigator` изчезва от `hint()` и от цикъла.

- [ ] **Стъпка 1: Тестът**

В `test_missing_tools` (там `PATH=/usr/bin:/bin`; добавете и `PERL5LIB=` за предвидимост):
```sh
grep -q '^ЛИПСВА Perl::LanguageServer: cpanm Perl::LanguageServer' "$OUT" || fail test_missing_tools "няма ред за Perl::LanguageServer"
! grep -q 'perlnavigator' "$OUT" || fail test_missing_tools "още споменава perlnavigator"
```

- [ ] **Стъпка 2: Да пада**

Run: `sh tests/run test_install` → FAIL.

- [ ] **Стъпка 3: `install` и README**

README ред 12: „ALE + Perl::LanguageServer“ и в описанието: „към определението, употреби, perlcritic; описание чрез perldoc; …“. Таблицата: `Perl | Perl::LanguageServer (модул) | cpanm Perl::LanguageServer` вместо реда за `perlnavigator`.

- [ ] **Стъпка 4: Да минава и да няма следи**

Run: `sh tests/run` → всичко минава; `shellcheck -s sh install && dash -n install` → чисто.
Run: `git grep -n -i navigator -- . ':!docs/superpowers/plans/2026-11-11-vim-ide.md' ':!docs/superpowers/specs/'` → празно (старият план и замисълът остават като история).

- [ ] **Стъпка 5: `git diff` за преглед от автора**

---

### След плана (авторът)

1. `cpanm Perl::LanguageServer` в perlbrew perl-5.44.0.
2. `sh tests/run test_perl_ls` – вече не SKIP, а PASS.
3. Във Vim, в `Slovo/lib/Slovo/Model/Stranici.pm`: `gd` и `gr` върху `where_domain_is` (ред 70), `K` върху `Mojo::Base`, `gf` върху `Slovo::Model::Celini`; `:ALEInfo` показва `languageserver`, `perlcritic`, `perlsave`.
4. Продължаване с останалите инструменти по `./install`.
