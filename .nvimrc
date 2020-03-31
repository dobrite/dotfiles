call plug#begin('~/.config/nvim/plugged')
  Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'airblade/vim-gitgutter'
  Plug 'altercation/vim-colors-solarized'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'janko-m/vim-test'
  Plug 'jremmen/vim-ripgrep'
  Plug 'kchmck/vim-coffee-script'
  Plug 'keith/swift.vim'
  Plug 'neomake/neomake'
  Plug 'pangloss/vim-javascript'
  Plug 'MaxMEllon/vim-jsx-pretty'
  Plug 'pest-parser/pest.vim'
  Plug 'rust-lang/rust.vim'
  Plug 'sbdchd/neoformat'
  Plug 'scrooloose/nerdtree'
  Plug 'slim-template/vim-slim'
  Plug 'stephpy/vim-yaml'
  Plug 'tell-k/vim-browsereload-mac'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rails', { 'commit': 'f8f5c6c544de7d9ebff7283142593e1733ffae89' } " for syntax hl
  Plug 'tpope/vim-rhubarb'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'vim-ruby/vim-ruby'
call plug#end()

colorscheme solarized
set background=dark

let g:airline_theme='solarized'

" italics
highlight Comment cterm=italic
" end italics

let mapleader=","

" open/close the quickfix window
nmap <leader>x :copen<CR>
nmap <leader>xx :cclose<CR>

" close buffer and don't close split
nmap <leader>w :b#<bar>bd#<CR>

" hide matches on <leader>space
nnoremap <leader><space> :nohlsearch<cr>

" navigation ctrl-jklm changes to that split
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h
imap <C-w> <C-O><C-w>
" end navigation

" line numbers
set number
set numberwidth=1
" end line numbers

" whitespace
set list " show whitespace
set listchars=tab:>-,trail:#,precedes:<,extends:> " formatting for shown whitespace
" end whitespace

" line wrapping
set nowrap " turn off line wrapping
set linebreak " don't wrap text in the middle of a word
" end line wrapping

set confirm " Y/N/C prompt
set hidden  " hide buffers instead of closing (keeps changes rather than forceing prompt)

" reading/writing
set noautowrite    " Never write a file unless I request it.
set noautowriteall " NEVER.
set noautoread     " Don't automatically re-read changed files.
" end reading/writing

" searching and patterns
set ignorecase " Default to using case insensitive searches,
set smartcase  " unless uppercase letters are used in the regex.
set hlsearch   " Highlight searches by default.
set incsearch  " Incrementally search while typing a /regex
" end searching and patterns

" folding
set foldmethod=indent " allow us to fold on indents
set foldlevel=99      " don't fold by default
set foldlevelstart=99 " don't fold by default
" end folding

" netrw (file/directory navigation)
let g:netrw_liststyle = 3
" end netrw

" vim-javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1
" end vim-javascript

" vim-jsx
let g:jsx_ext_required = 0 " also highlight .js files
" end vim-jsx

" vim-test
nmap <silent> <leader>N :TestNearest<CR>
nmap <silent> <leader>F :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>L :TestLast<CR>
nmap <silent> <leader>A :TestSuite<CR>
nmap <silent> <leader>g :TestVisit<CR>
let test#strategy = "neovim"
let test#ruby#use_spring_binstub = 1
let g:test#preserve_screen = 1
" end vim-test

" ctrlp
nnoremap <silent> <leader>f :CtrlP<CR>
nnoremap <silent> <leader>b :CtrlPBuffer<CR>
nnoremap <silent> <leader>m :CtrlPMRU<CR>
nnoremap <silent> <leader>. :CtrlPTag<CR>
" end ctrlp

" fugitive (git)
map <C-g>b :Gblame<CR>
map <C-g>s :Gstatus<CR>
map <C-g>a :Gadd<CR>
map <C-g>c :Gcommit<CR>
map <C-g>l :Glog<CR>
map <C-g>h :Gbrowse<CR>
map <C-g>r :Gread<CR>
map <C-g>w :Gwrite<CR>
map <C-g>s :Gpush<CR>
map <C-g>u :Gpull<CR>
map <C-g>f :Gfetch<CR>
" end fugitive

" neomake (linting - e.g. rubocop)
let g:neomake_javascript_enabled_makers = ['eslint']
call neomake#configure#automake('w')
"let g:ale_ruby_rubocop_executable = 'bundle exec'
"let g:ale_ruby_rubocop_options = '--config=.rubocop.yml'
" end neomake

" neoformat - prettier
autocmd BufWritePre *.js Neoformat
autocmd BufWritePre *.jsx Neoformat
autocmd FileType javascript set formatprg=./node_modules/prettier/bin-prettier.js\ --stdin\ --single-quote\ --no-semi\ --trailing-comma\ es5\ --parser\ babel
let g:neoformat_try_formatprg = 1
"let g:neoformat_only_msg_on_error = 1
" end neoformat - prettier

" ripgrep
nmap <leader>a <Esc>:Rg<SPACE>
let g:rg_command = "rg --vimgrep --sort-files"
if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
endif
" end ripgrep

" NERDtree
" close vim if NERDtree is last window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1 " show dotfiles
" end NERDtree

" deoplete
let g:deoplete#enable_at_startup = 1
" end deoplete

" vim-browserload-mac
nnoremap <silent> <leader>r :ChromeReload<CR>
let g:returnApp = "iTerm"
" end vim browsereload-mac

" rustfmt
let g:rustfmt_autosave = 1
let g:rustfmt_fail_silently = 0
" end rustfmt

" RLS
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ }
let g:LanguageClient_autoStart = 1
autocmd BufReadPost *.rs setlocal filetype=rust
" end RLS

packloadall
silent! helptags ALL
