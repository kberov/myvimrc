" Без ALE и vim-go: езиковите файлове не гърмят и не задават клавиши.
for s:f in ['x.pl', 'x.go', 'x.html.ep']
  let v:errmsg = ''
  execute 'edit' fnameescape($REPO . '/tests/fixtures/' . s:f)
  call assert_equal('', v:errmsg, s:f . ' без грешки')
  call assert_equal('', maparg('gd', 'n'), s:f . ' без gd')
endfor
call writefile(v:errors, $TEST_OUT) | qa!
