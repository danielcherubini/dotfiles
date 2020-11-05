" ===============================================================
" General Options
" ===============================================================

set ttyfast
set ttimeout
set ttimeoutlen=50
set nobackup
set nowritebackup
set noswapfile
set backspace=indent,eol,start
set showcmd
set wildmenu
set wildmode=longest:full,full
set hidden
set nowrap
set cursorline
set nopaste


syntax on
colorscheme dracula
if $COLORTERM == 'truecolor'
	set termguicolors
endif
set number
filetype plugin on
set ttyfast
if !has('nvim')
	set ttymouse=xterm2
else
	set mouse=a
endif

set autoindent

" Enable to copy to clipboard for operations like yank, delete, change and put
" http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
if has('unnamedplus')
	set clipboard^=unnamed
	set clipboard+=unnamedplus
end

" COC.vim SETUP
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

let g:CSApprox_loaded = 1
let g:indentLine_enabled = 1
let g:indentLine_faster = 1

" ===============================================================
" Sesson Managment
" ===============================================================
let g:session_directory = '~/.config/nvim/session'
let g:session_autoload = 'no'
let g:session_autosave = 'no'
let g:session_command_aliases = 1
set completeopt-=preview

augroup fzf_preview
  autocmd!
  autocmd User fzf_preview#initialized call s:fzf_preview_settings()
augroup END

function! s:fzf_preview_settings() abort
	let g:fzf_preview_fzf_color_option = 'fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f,info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7'
	let g:fzf_preview_grep_preview_cmd = 'COLORTERM=truecolor '
	let g:fzf_preview_command = 'COLORTERM=truecolor bat --theme=Dracula --color=always --style=grid {-1}'
	let g:fzf_preview_filelist_command = "rg --files --hidden --follow"
	let g:fzf_preview_filelist_postprocess_command = 'xargs exa --color=always'
endfunction
