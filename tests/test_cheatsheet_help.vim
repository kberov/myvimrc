" Всяка `:help тема` в cheatsheet.md отваря съществуваща тема в помощта.
" (С всички добавки – темите на ALE, vim-go, NERDTree и т.н. са в тях.)
let s:lines = readfile($REPO . '/cheatsheet.md')
let s:topics = []
for s:l in s:lines
  let s:start = 0
  while 1
    let s:m = matchstrpos(s:l, '`:help \zs[^`]\+\ze`', s:start)
    if s:m[1] < 0
      break
    endif
    call add(s:topics, s:m[0])
    let s:start = s:m[2]
  endwhile
endfor
call assert_true(len(s:topics) > 50, 'намерени теми: ' . len(s:topics))

" „тема“ и „думи“ в обясненията са образци, не истински теми.
for s:t in filter(uniq(sort(s:topics)), 'v:val !~# "^тема" && v:val !~# "думи"')
  try
    execute 'help' s:t
    helpclose
  catch
    call add(v:errors, 'няма тема: :help ' . s:t . ' (' . v:exception . ')')
  endtry
endfor

call writefile(v:errors, $TEST_OUT) | qa!
