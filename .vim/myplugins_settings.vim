
"Plug 'yko/mojo.vim'
let mojo_highlight_data = 1

"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" https://github.com/fatih/vim-go-tutorial
" Quick build(\gb), test(\gt), and run(\gr)
autocmd FileType go nmap <leader>gb  <Plug>(go-build)
autocmd FileType go nmap <leader>gr  <Plug>(go-run)
autocmd FileType go nmap <leader>go  <Plug>(go-test)
"https://github.com/fatih/vim-go/wiki/Tutorial
let g:go_metalinter_autosave = 1
let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_code_completion_enabled = 1
let g:go_code_completion_icase = 1
let g:go_gopls_matcher = "fuzzy"
let g:mucomplete#enable_auto_at_startup = 1

"Plug 'idanarye/vim-dutyl'
"let g:dutyl_stdImportPaths=['/usr/include/dmd']
"call dutyl#register#tool('dcd-client', expand('$HOME/bin/dcd-client'))
"call dutyl#register#tool('dcd-server', expand('$HOME/bin/dcd-server'))
"Plug 'mileszs/ack.vim'
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

"to open NERDTree ...
"If 'mapleader' is not set or empty, a backslash is used instead.  The
"below mapping  means \O (press backslash(\) then Shift+o)
"Plug 'scrooloose/nerdtree' " , { 'on': 'NERDTreeToggle' }
map <Leader>O :NERDTreeToggle<CR>
map <Leader>nf :NERDTreeFind<CR>

let NERDTreeIgnore=['^\.git', '\~$']

"ALE
" Enable completion where available.
let g:ale_hover_to_preview = 0
let g:ale_hover_cursor = 1
let g:ale_hover_to_floating_preview = 1
let g:ale_fixers = { 'rust': ['rustfmt', 'trim_whitespace', 'remove_trailing_lines'] }
" a hack to disable gopls in ALE , because we already use vim-go
" plugin for Go
let g:ale_linters = {
            \ 'rust': ['analyzer', 'cargo'],
            "\ 'go': ['staticcheck'],
            \}
" When set to `1`, only the linters from |g:ale_linters| and |b:ale_linters|
" will be enabled. The default behavior for ALE is to enable as many linters
" as possible, unless otherwise specified.
let g:ale_linters_explicit = 1
" ignore most errors regarding failed imports
let g:ale_rust_ignore_error_codes = ['E0432', 'E0433']

let g:airline#extensions#ale#enabled = 1
set omnifunc=ale#completion#OmniFunc
nnoremap <C-LeftMouse> :ALEGoToDefinition<CR>
map <Leader>h :ALEHover<CR>

"Plug 'rust-lang/rust.vim'
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:rust_use_custom_ctags_defs = 1  " if using rust.vim
let g:tagbar_type_rust = {
  \ 'ctagsbin' : 'ctags',
  \ 'ctagstype' : 'rust',
  \ 'kinds' : [
      \ 'n:modules',
      \ 's:structures:1',
      \ 'i:interfaces',
      \ 'c:implementations',
      \ 'f:functions:1',
      \ 'g:enumerations:1',
      \ 't:type aliases:1:0',
      \ 'C:constants:1:0',
      \ 'M:macros:1',
      \ 'm:fields:1:0',
      \ 'e:enum variants:1:0',
      \ 'P:methods:1',
  \ ],
  \ 'sro': '::',
  \ 'kind2scope' : {
      \ 'n': 'module',
      \ 's': 'struct',
      \ 'i': 'interface',
      \ 'c': 'implementation',
      \ 'f': 'function',
      \ 'g': 'enum',
      \ 't': 'typedef',
      \ 'v': 'variable',
      \ 'M': 'macro',
      \ 'm': 'field',
      \ 'e': 'enumerator',
      \ 'P': 'method',
  \ },
\ }


"Plug 'preservim/tagbar'
nnoremap <silent> <Leader>t :TagbarToggle<CR>
let g:tagbar_autoclose = 1

"D
" Todo: achieve the same as in vim-go
" autocmd BufWritePre,BufRead *.d :normal gg=G
let g:tagbar_type_d = {
            \ 'ctagstype' : 'd',
            \ 'kinds'     : [
            \ 'c:classes:1:1',
            \ 'f:functions:1:1',
            \ 'T:template:1:1',
            \ 'g:enums:1:1',
            \ 'e:enumerators:0:1',
            \ 'u:unions:1:1',
            \ 's:structs:1:1',
            \ 'v:variables:1:0',
            \ 'i:interfaces:1:1',
            \ 'm:members',
            \ 'a:alias'
            \ ],
            \'sro': '.',
            \ 'kind2scope' : {
            \ 'c' : 'class',
            \ 'g' : 'enum',
            \ 's' : 'struct',
            \ 'u' : 'union',
            \ 'T' : 'template'
            \},
            \ 'scope2kind' : {
            \ 'enum'      : 'g',
            \ 'class'     : 'c',
            \ 'struct'    : 's',
            \ 'union'     : 'u',
            \ 'template'  : 'T'
            \ },
            \ 'ctagsbin' : 'dscanner',
            \ 'ctagsargs' : ['--ctags']
            \ }
"Go
let g:tagbar_type_go = {
	        \ 'ctagstype' : 'go',
	        \ 'kinds'     : [
		    \ 'p:package',
		    \ 'i:imports:1',
		    \ 'c:constants',
		    \ 'v:variables',
		    \ 't:types',
		    \ 'n:interfaces',
		    \ 'w:fields',
		    \ 'e:embedded',
		    \ 'm:methods',
		    \ 'r:constructor',
		    \ 'f:functions'
	        \ ],
	        \ 'sro' : '.',
	        \ 'kind2scope' : {
		    \ 't' : 'ctype',
		    \ 'n' : 'ntype'
	        \ },
	        \ 'scope2kind' : {
		    \ 'ctype' : 't',
		    \ 'ntype' : 'n'
	        \ },
	        \ 'ctagsbin'  : 'gotags',
	        \ 'ctagsargs' : '-sort -silent'
            \ }
"Perl
let g:tagbar_type_perl = {
            \ 'ctagstype' : 'perl',
            \ 'kinds'     : [
            \ 'p:package:0:0',
            \ 'w:roles:0:0',
            \ 'e:extends:0:0',
            \ 'u:uses:0:0',
            \ 'r:requires:0:0',
            \ 'o:ours:0:0',
            \ 'a:properties:0:0',
            \ 'b:aliases:0:0',
            \ 'h:helpers:0:0',
            \ 's:subs:0:0',
            \ 'm:private_subs:0:0',
            \ 't:old_private_subs:0:0',
            \ 'd:POD:1:0'
            \ ],
            \ 'sort' : 0
            \ }
"YAML
let g:tagbar_type_yaml = {
            \ 'ctagstype' : 'yaml',
            \ 'kinds' : [
            \ 'a:anchors',
            \ 's:section',
            \ 'e:entry'
            \ ],
            \ 'sro' : '.',
            \ 'scope2kind': {
            \ 'section': 's',
            \ 'entry': 'e'
            \ },
            \ 'kind2scope': {
            \ 's': 'section',
            \ 'e': 'entry'
            \ },
            \ 'sort' : 0
            \ }

let g:tagbar_type_v = {
            \ 'ctagstype' : 'v',
            \ 'kinds'     : [
            \   's:structs:0:1',
            \   'm:methods:0:1',
            \   'f:functions:0:1'
            \ ],
            \ 'sort' : 0
            \}

let g:tagbar_type_js = {
\ 'ctagstype': 'js',
\ 'kinds': [
\ 'A:arrays',
\ 'P:properties',
\ 'T:tags',
\ 'O:objects',
\ 'G:generator functions',
\ 'F:functions',
\ 'C:constructors/classes',
\ 'M:methods',
\ 'V:variables',
\ 'I:imports',
\ 'E:exports',
\ 'S:styled components'
\ ]}

" vim-markdown-preview
" https://github.com/JamshedVesuna/vim-markdown-preview
" let vim_markdown_preview_toggle=3
" let vim_markdown_preview_hotkey='<C-m>'
" let vim_markdown_preview_use_xdg_open=1
" let vim_markdown_preview_perl=1
" for Universal ctags:
" https://github.com/preservim/tagbar/wiki#markdown
let g:tagbar_type_markdown = {
\ 'ctagstype'	: 'markdown',
\ 'kinds'		: [
  \ 'c:chapter:0:1',
  \ 's:section:0:1',
  \ 'S:subsection:0:1',
  \ 't:subsubsection:0:1',
  \ 'T:l4subsection:0:1',
  \ 'u:l5subsection:0:1',
\ ],
\ 'sro'			: '""',
\ 'kind2scope'	: {
  \ 'c' : 'chapter',
  \ 's' : 'section',
  \ 'S' : 'subsection',
  \ 't' : 'subsubsection',
  \ 'T' : 'l4subsection',
\ },
\ 'scope2kind'	: {
  \ 'chapter' : 'c',
  \ 'section' : 's',
  \ 'subsection' : 'S',
  \ 'subsubsection' : 't',
  \ 'l4subsection' : 'T',
\ },
\ }

"Vlang
let g:v_autofmt_bufwritepre = 1
