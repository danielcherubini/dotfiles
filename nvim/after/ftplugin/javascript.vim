" ===============================================================
" Javascript Config
" ===============================================================
:call extend(g:ale_linters, {
\   'javascript': ['tsserver', 'tslint'],
\   'typescript': ['tsserver', 'tslint'],
\})

:call extend(g:ale_fixers, {
\    'javascript': ['tslint'],
\    'typescript': ['tslint'],
\    'scss': ['prettier'],
\    'html': ['prettier']
\})

let g:ale_typescript_tslint_use_global = 0
let g:ale_typescript_tslint_config_path = ''
let g:javascript_plugin_jsdoc = 1
