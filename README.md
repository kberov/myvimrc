# myvimrc

Личните настройки на Красимир Беров за Vim и GVim.

## Описание

Тези настройки превръщат Vim в **единна среда за разработка** (IDE) за
няколко езика:

| Език | Какво дава | Чрез |
|---|---|---|
| Perl (и Mojolicious) | към определението, описание, употреби, perlcritic; perltidy при запис; `perl -c` само при запис | [ALE](https://github.com/dense-analysis/ale) + Perl Navigator |
| Shell | shellcheck, езиков сървър; shfmt (`-i 4 -ci`) при запис | ALE |
| JavaScript | към определението, описание, употреби | ALE + tsserver |
| HTML, HTMX, шаблони (`.html.ep`, fasttemplate) | довършване и описание на етикети и `hx-*` атрибути, без проверки и без форматиране | ALE + HTML сървъра на VS Code + htmx-lsp |
| Go | всичко на vim-go (GoDef, GoReferrers, GoCallers, GoRename, GoMetaLinter…) | [vim-go](https://github.com/fatih/vim-go) |

Във всички тези езици **клавишите са едни и същи**. Действат само в
нормален лад[^lad]:

| Клавиш | Действие |
|---|---|
| `gd`, Ctrl+клик | към определението |
| `K`, `\h` | описание на думата под показалеца |
| `gr` | всички употреби на думата под показалеца |
| `\rn` | преименуване |
| `]e` / `[e` | следваща / предишна грешка |
| Ctrl+S | запис (във всички ладове, и в терминала) |
| Ctrl+L | смяна латиница ↔ кирилица в лад за въвеждане |

Други особености:

- **Кирилица.** Кирилицата се пише чрез Vim (`keymap=oldbgph`, разширена
  фонетична подредба със старобългарски букви), а не чрез клавиатурната
  подредба на работната уредба. Затова съответствията в нормален лад
  работят винаги.
  В лад за въвеждане няма съответствия с `\`, защото на кирилица `\`
  става `ю`.
- **Слоеве.** Основните файлове (`.vimrc`, `.vim/mymappings.vim`)
  работят и без добавки (plugins). Вградените решения имат предимство:
  Netrw (`\nf`, `\E`), vimgrep (`\f`).
- **Липсващ инструмент не чупи Vim.** При първото отваряне на файл от даден
  език излиза едно кратко съобщение какво липсва.
- **Личният правописен речник** (`zg`) е в хранилището (`.vim/spell/*.add`)
  и пътува с настройките.

Ежедневните команди и клавиши, които си струва да се помнят, са в
[бележките за ползването](cheatsheet.md).

Подробно: дизайн в `docs/superpowers/specs/2026-11-11-vim-ide-design.md`,
план в `docs/superpowers/plans/2026-11-11-vim-ide.md`.

## Добавки

Добавките (plugins) са изброени в `.vim/myplugins.vim` и се управляват с
[vim-plug](https://github.com/junegunn/vim-plug). Без vim-plug файлът спира
още в началото и Vim работи само с вградените си възможности. Настройките
на добавките са в `.vim/myplugins_settings.vim` и `.vim/ale_settings.vim`.

Списъкът е към 14 ноември 2026 г.

| Добавка | За какво |
|---|---|
| **Изглед** | |
| [dracula](https://github.com/dracula/vim), [everforest](https://github.com/sainnhe/everforest), [gruvbox-material](https://github.com/sainnhe/gruvbox-material), [edge](https://github.com/sainnhe/edge) | цветови теми (`:colorscheme …`); по подразбиране е вградената `elflord` |
| [vim-airline](https://github.com/vim-airline/vim-airline) | по-богат ред за състоянието в дъното на прозореца |
| [vim-devicons](https://github.com/ryanoasis/vim-devicons) | значки според вида на файла (в NERDTree, airline); иска шрифт Nerd Font |
| [vim_current_word](https://github.com/dominikduda/vim_current_word) | осветява думата под показалеца и всичките ѝ появи |
| **Езици** | |
| [ALE](https://github.com/dense-analysis/ale) | проверки, форматиране и езикови сървъри за Perl, Shell, JS и HTML/HTMX (`gd`, `K`, `gr`, `\rn`) |
| [vim-go](https://github.com/fatih/vim-go) | всичко за Go: определения, употреби, преименуване, build, test |
| [mojo.vim](https://github.com/yko/mojo.vim) | осветяване на вградения Perl в шаблоните на Mojolicious (`.html.ep`) |
| [html5.vim](https://github.com/othree/html5.vim) | осветяване, отстъпи и довършване за HTML5 и вграден SVG |
| [rust.vim](https://github.com/rust-lang/rust.vim) | поддръжка на Rust |
| [v-vim](https://github.com/ollykel/v-vim) | поддръжка на езика V |
| **Работа** | |
| [vim-mucomplete](https://github.com/lifepillar/vim-mucomplete) | довършването изскача само, докато пишете (чрез вграденото довършване на Vim) |
| [NERDTree](https://github.com/preservim/nerdtree) | дърво на файловете отляво (`\O`) |
| [CtrlP](https://github.com/ctrlpvim/ctrlp.vim) | търсене на файл по част от името (Ctrl+P) |
| [Tagbar](https://github.com/preservim/tagbar) | съдържание на файла: функции, методи, променливи (`\t`); иска ctags |
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | Git от самия Vim (`:Git`) |
| [claude-code.vim](https://github.com/keitheis/claude-code.vim) | пуска Claude Code в прозорец на Vim и презарежда файловете, които той промени |

## Лиценз

Copyright (c) Красимир Беров.

Свободно за ползване, промяна и разпространение при условията на
**Artistic License 2.0**, същия лиценз като при Perl. Пълният текст е във
файла [`LICENSE`](LICENSE).

Произход на `LICENSE`: точно копие, байт по байт, на
`/usr/share/common-licenses/Artistic-2.0` от Debian пакета `base-files`
13.8+deb13u7 (sha256
`5c29658b80a9cbb016dfe238ece8b86b5e63761355df8b872126d35bebce4303`). Този
текст съвпада дума по дума с оригинала на The Perl Foundation:
<https://www.perlfoundation.org/artistic-license-20.html>.

## Отказ от отговорност

Това са **лични настройки**, споделени както са, **без каквато и да е
гаранция** (вижте и раздел 14 на лиценза). Съставителят не носи отговорност,
ако нещо се счупи, загуби или промени поведението на вашия Vim, на файловете ви
или на работната ви уредба. Ползвате ги на своя отговорност.

По-точно трябва да знаете, че:

- **Файловете се променят сами при запис.** perltidy пренарежда целия
  Perl файл, а shfmt целия Shell скрипт. Ако проектът има собствен
  `.perltidyrc` или `.editorconfig`, се ползват те.
- **`perl -c` изпълнява кода в `BEGIN` блоковете и `use`-прагмите** на файла.
  Тук се пуска само при запис, но все пак не записвайте чужд код, на който
  не вярвате.
- Когато променяте файлове на някой от поддържаните програмни езици (Perl,
  Shell, JavaScript, HTML, Go), **вградените клавишни съответствия `gd` и
  `gr`** вършат друго. Във всички други файлове те действат както винаги.

  | Клавиш | Във Vim по принцип | В програмните езици с тези настройки |
  |---|---|---|
  | `gd` | към **местното обявяване** на думата в текущата функция (`:help gd`) | към **определението** чрез езиковия сървър, и в други файлове |
  | `gr` | **заместване на един знак** като `r`, но без да разбутва табулациите (`:help gr`) | **всички употреби** на думата |
- **`install` пипа домашната ви папка:** `~/.vimrc`, `~/.gvimrc` и
  `~/.vim`. Нищо не трие, а мести старото в резервни копия (вижте
  [Връщане на старите настройки](#връщане-на-старите-настройки)).
  Все пак **първо си направете запасно копие**.

## Предпоставки

### Задължителни

| Какво | Проверка | Ако липсва (Debian/Ubuntu/WSL) |
|---|---|---|
| Vim 9.1 или по-нов (GVim по желание) | `vim --version \| head -1` | `sudo apt install vim-gtk3` (или `vim`) |
| git | `git --version` | `sudo apt install git` |
| curl (за vim-plug) | `curl --version` | `sudo apt install curl` |
| [vim-plug](https://github.com/junegunn/vim-plug) | `ls ~/.vim/autoload/plug.vim` | `curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim` |

Работи под Linux (проверено с Debian 13 и с Ubuntu под WSL). Скриптът
`install` е чист POSIX `sh`.

### По желание: инструментите за езиците

Всеки инструмент е нужен само за своя език. Ако липсва, Vim работи, само
без съответната възможност. `./install` изписва точно кои липсват.

| Език | Програма | Как се инсталира |
|---|---|---|
| Perl | `perl` | обикновено е налице; или чрез [perlbrew](https://perlbrew.pl/) |
| Perl | `perlnavigator` | `npm i -g perlnavigator-server` |
| Perl | `perltidy`, `perlcritic` | `cpanm Perl::Tidy Perl::Critic` |
| Shell | `shellcheck`, `shfmt` | `sudo apt install shellcheck shfmt` |
| Shell | `bash-language-server` | `npm i -g bash-language-server` |
| JavaScript | `tsserver` | `npm i -g typescript@5` (TypeScript 7 вече няма `tsserver`) |
| HTML | `vscode-html-language-server` | `npm i -g vscode-langservers-extracted` |
| HTMX | `htmx-lsp` | `cargo install htmx-lsp` (нужен е [Rust](https://rustup.rs/)) |
| Go | `go`, `gopls` | [go.dev/dl](https://go.dev/dl/), после `go install golang.org/x/tools/gopls@latest` |

Програмите от `npm` изискват [Node.js](https://nodejs.org/). Важно е
всичко да е в `PATH`. **GVim пускайте от терминал** (`gvim файл`), за да
наследи `PATH` и `PERL5LIB` от обвивката (shell).

## Установяване

### 1. Пробвайте, без да променяте нищо в собствената си уредба.

```sh
git clone --depth 1 https://github.com/kberov/myvimrc.git ~/opt/dev/myvimrc
cd ~/opt/dev/myvimrc
gvim -u .vimrc -U .gvimrc     # или: vim -u .vimrc
```

Така вашите `~/.vimrc` и `~/.vim` не се пипат. В този Vim пуснете
`:PlugInstall`, за да се свалят добавките в `~/.vim/plugged`.

### 2. Направете запасно копие на своите настройки

```sh
cp -a ~/.vimrc ~/.vimrc.mine 2>/dev/null
cp -a ~/.gvimrc ~/.gvimrc.mine 2>/dev/null
cp -a ~/.vim ~/.vim.mine 2>/dev/null
```

### 3. Пуснете `install`

Можете първо да видите какво ще направи, с временна домашна папка:

```sh
H=$(mktemp -d); HOME=$H ./install; ls -la $H $H/.vim; rm -rf $H
```

После наистина:

```sh
./install
```

Ето какво прави:

1. `~/.vimrc` и `~/.gvimrc` стават **връзки** към файловете в
   хранилището. Ако там вече има файл, той се преименува на
   `~/.vimrc.bak.<дата-час>`.
2. Старите копия на файловете от хранилището в `~/.vim` (`mymappings.vim`,
   `keymap/`, `spell/*.add` …) се местят в `~/.vim/backup-<дата-час>/`.
   `~/.vim/plugged`, `sessions`, главните речници и т.н. не се пипат.
3. Изписва `ЛИПСВА <програма>: <команда>` за всяка липсваща програма.
   **Нищо не инсталира и не ползва sudo.**

Може да се пуска многократно. Втория път само казва `OK`.

### 4. Довършете

```sh
vim +PlugInstall +qa       # добавките (ALE, vim-go …)
vim +GoUpdateBinaries +qa  # ако ползвате Go
```

Отворете файл, например `gvim нещо.pl`, и напишете `:ALEInfo`. Там се вижда
какво точно работи за този файл.

### Връщане на старите настройки

Ако новите настройки не ви вършат работа:

```sh
# 1. махнете връзките
rm ~/.vimrc ~/.gvimrc
# 2. върнете своите файлове (от install или от стъпка 2)
mv ~/.vimrc.bak.<дата-час> ~/.vimrc       # или: mv ~/.vimrc.mine ~/.vimrc
mv ~/.gvimrc.bak.<дата-час> ~/.gvimrc
# 3. върнете старите копия в ~/.vim
cp -a ~/.vim/backup-<дата-час>/. ~/.vim/
```

Ако сте направили пълно копие (стъпка 2): `rm -rf ~/.vim && mv ~/.vim.mine ~/.vim`.

Добавките, свалени в `~/.vim/plugged`, не пречат. Ако не ги искате, махнете
папките им оттам.

## Устройство

```
.vimrc                  основните настройки; открива хранилището и го слага в runtimepath
.gvimrc                 само за GVim (шрифт, цветове)
install                 връзки + списък с липсващите инструменти
cheatsheet.md           бележки за ползването: ежедневните команди и клавиши
.vim/mymappings.vim     общите съответствия (работят и без добавки)
.vim/myplugins.vim      списъкът с добавки (vim-plug)
.vim/myplugins_settings.vim  настройки на добавките (vim-go, NERDTree, Tagbar …)
.vim/ale_settings.vim   всичко за ALE + „как се добавя нов език“
.vim/ale_linters/       собствени проверки за ALE (htmx-lsp, perl -c при запис)
.vim/autoload/myide.vim еднаквите клавиши и проверката за инструменти
.vim/after/ftplugin/    по един файл за всеки език
.vim/keymap/            фонетичната подредба с кирилица и старобългарски букви
.vim/spell/             личният правописен речник
tests/                  автоматичните проверки: sh tests/run
docs/                   дизайн и план
```

**Нов език** (например Rust, C, V): вижте бележката в началото на
`.vim/ale_settings.vim`.

## Проверки

```sh
sh tests/run            # всички
sh tests/run test_rtp   # една
```

Проверките пускат Vim без прозорец. Вашия `~` го пипат само за четене, а
всичко, което пише, става във временни папки.

[^lad]: **Лад** е нашият превод на *mode* (обикн. „режим“). Защо – вижте
    бележката под линия в [Бележки за Vim](cheatsheet.md#езикът-на-vim).
