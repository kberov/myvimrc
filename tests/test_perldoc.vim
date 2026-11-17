" K и \h в Perl буферите викат perldoc (Perl::LanguageServer няма описание
" – hover). myide#PerlDoc е в .vim/autoload/myide.vim.

" test_perldoc_function
let s:w = winnr('$')
call assert_equal(1, myide#PerlDoc('join'), 'join')
call assert_match('perldoc://join', bufname(''), 'име на буфера')
call assert_true(search('separate strings', 'nw') > 0, 'текстът на perldoc -f join')
call assert_equal(0, &modifiable, 'само за четене')
close

" test_perldoc_module (Foo::Bar->new: <cword> е Foo::Bar, iskeyword има :)
enew | setfiletype perl | call setline(1, 'File::Spec->catfile(1)')
call assert_equal('File::Spec', expand('<cword>'), '<cword> с ::')
call assert_equal(1, myide#PerlDoc('File::Spec'), 'модул')
call assert_true(search('portably perform operations', 'nw') > 0, 'текстът за File::Spec')
" Повторно K – същият прозорец, не нов.
let s:w2 = winnr('$')
call assert_equal(1, myide#PerlDoc('join'), 'втори път')
call assert_equal(s:w2, winnr('$'), 'един прозорец за perldoc')
close

" test_perldoc_missing: кратко съобщение, без празен прозорец.
let s:w = winnr('$')
call assert_equal(0, myide#PerlDoc('where_domain_is'), 'няма описание')
call assert_equal(s:w, winnr('$'), 'без нов прозорец')
call assert_match('perldoc: няма описание за where_domain_is', execute('messages'), 'съобщението')

" test_perldoc_keys (текущият буфер е Perl от по-горе)
call assert_match('PerlDoc', maparg('K', 'n'), 'K в Perl')
call assert_match('PerlDoc', maparg('<leader>h', 'n'), '\h в Perl')
" Смяната на вида ги маха.
set filetype=text
call assert_equal('', maparg('K', 'n'), 'K след смяна на вида')

call writefile(v:errors, $TEST_OUT) | qa!
