if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect

" automatically recognize *.mc files as HTML::Mason
autocmd BufNewFile,BufRead *.mc   set syntax=mason
augroup END
