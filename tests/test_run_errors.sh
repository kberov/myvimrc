#!/bin/sh
# tests/run брои за провал и грешка на Vim (E117 и пр.), не само v:errors.
# Иначе ред като `call assert_equal(1, NoSuchFunc())` прекъсва, преди
# assert_* да запише нещо в v:errors, и тестът минава фалшиво.
set -eu
T=$(mktemp -d)
trap 'rm -rf "$T"' EXIT
mkdir "$T/tests"
cp "$REPO/tests/run" "$T/tests/"
cat >"$T/tests/test_e117_noplugins.vim" <<'VIM'
call assert_equal(1, NoSuchFuncXyz())
call writefile(v:errors, $TEST_OUT) | qa!
VIM
if sh "$T/tests/run" >"$T/out" 2>&1; then
    echo "tests/run прие тест с E117 за успешен:"
    cat "$T/out"
    exit 1
fi
grep -q 'E117: Unknown function: NoSuchFuncXyz' "$T/out" || {
    echo "tests/run не показа грешката E117:"
    cat "$T/out"
    exit 1
}
