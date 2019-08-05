" ===============================================================
" Javascript Config
" ===============================================================
:call extend(g:ale_linters, {
\   'javascript': ['eslint']
\})

:call extend(g:ale_fixers, {
\    'javascript': ['eslint'],
\    'scss': ['prettier'],
\    'html': ['prettier']
\})

let g:javascript_plugin_jsdoc = 1
