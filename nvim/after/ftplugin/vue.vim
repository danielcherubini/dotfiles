" ===============================================================
" Vue Config
" ===============================================================

:call extend(g:ale_linters, {
\   'vue': ['eslint']
\})

:call extend(g:ale_fixers, {
\    'vue': ['eslint'],
\})

augroup vue
	autocmd FileType vue syntax sync fromstart
augroup END
