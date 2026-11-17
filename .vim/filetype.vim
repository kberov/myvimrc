if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect

" automatically recognize *.mc files as HTML::Mason
autocmd BufNewFile,BufRead *.mc   set syntax=mason
" *.htm – винаги HTML. Vim иначе гадае по съдържанието и при {% %} или {# #}
" избира htmldjango. Тук .htm са образци на Go с прост двигател, чиито
" заместители са обикновен текст в HTML. (setfiletype: първото печели, а
" този файл се чете преди filetype.vim на Vim.)
autocmd BufNewFile,BufRead *.htm  setfiletype html
augroup END
