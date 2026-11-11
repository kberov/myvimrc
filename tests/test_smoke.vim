" Проверява, че тестовата рамка работи: .vimrc е зареден и vim-plug е наличен.
call assert_true(exists('g:loaded_plug'), 'vim-plug не е зареден')
call writefile(v:errors, $TEST_OUT) | qa!
