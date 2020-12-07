" ===============================================================
" Go Config
" ===============================================================

set nowrap nolinebreak list

" :call extend(g:ale_linters, {
"     \'go': ['golint', 'go vet'], })

:call extend(g:ale_fixers, {
\    'go': ['gofmt', 'goimports']
\})

" vim-go
let g:go_fmt_command = 'goimports'
let g:go_autodetect_gopath = 1
let g:go_list_type = 'quickfix'

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1

let g:go_gocode_unimported_packages = 1

let g:go_doc_popup_window = 1


" build_go_files is a custom function that builds or compiles the test file.
" It calls :GoBuild if its a Go file, or :GoTestCompile if it's a test file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

let g:go_highlight_debug = 1

let g:go_debug_windows = {
	\ 'vars':       'leftabove 90vnew',
	\ 'goroutines': 'botright 10new',
	\ 'out':        'botright 5new',
\}

let g:go_debug_mappings = {
	\ '(go-debug-breakpoint)': {'key': 'b', 'arguments': '<nowait>'},
	\ '(go-debug-continue)': {'key': 'c', 'arguments': '<nowait>'},
	\ '(go-debug-stop)': {'key': 'q'},
	\ '(go-debug-next)': {'key': 'n', 'arguments': '<nowait>'},
	\ '(go-debug-step)': {'key': 's'},
\}
