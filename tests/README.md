# Тестове на конфигурацията

Автоматични проверки, които пускат Vim без прозорец и проверяват настройките.

```sh
sh tests/run              # всички тестове
sh tests/run test_rtp     # само един
```

- `test_*.vim` – Vim с `.vimrc` на хранилището (и добавките от `~/.vim/plugged`).
- `test_*_noplugins.vim` – Vim без добавки, само с `.vim` и `.vim/after` от хранилището.
- `test_*.sh` – POSIX shell тестове (провал = код ≠ 0).
- `fixtures/` – малки примерни файлове за всеки език.

Всеки `.vim` тест ползва `assert_*()` и завършва с
`call writefile(v:errors, $TEST_OUT) | qa!`.
