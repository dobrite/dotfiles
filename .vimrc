set nocompatible
let mapleader=","

map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

fu! SplitScroll()
  :wincmd v
  :wincmd w
  execute "normal! \<C-d>"
  :set scrollbind
  :wincmd w
  :set scrollbind
endfu

imap jk <Esc>
imap kj <Esc>
nmap <leader>sb :call SplitScroll()<CR>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" RSpec.vim mappings
map <Leader>F :call RunCurrentSpecFile()<CR>
map <Leader>N :call RunNearestSpec()<CR>
map <Leader>L :call RunLastSpec()<CR>
map <Leader>A :call RunAllSpecs()<CR>
let g:rspec_command = "!pco box zeus test {spec}"

" open/close the quickfix window
nmap <leader>x :copen<CR>
nmap <leader>xx :cclose<CR>

" ctrl-jklm changes to that split
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" and lets make these all work in insert mode too ( <C-O> makes next cmd
" happen as if in command mode )
imap <C-w> <C-O><C-w>

nmap <leader>a <Esc>:Ag<SPACE>

" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

filetype off
filetype plugin indent off
set runtimepath+=$GOROOT/misc/vim

runtime macros/matchit.vim
execute pathogen#infect()
call pathogen#helptags()

syntax on
filetype on
filetype plugin indent on

set number
set numberwidth=1

"set wildmenu       " Menu completion in command mode on <Tab>
"set wildmode=full  " <Tab> cycles between all matching choices.
"
"" Ignore these files when completing
"set wildignore+=*.o,*.obj,.git,.hg,*.pyc
"set wildignore+=eggs/**
"set wildignore+=*.egg-info/**
"set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux

" don't bell or blink
set noerrorbells
set vb t_vb=

set hidden                  " hide buffers instead of closing
set history=1000
set undolevels=1000
set pastetoggle=<F2>
set background=dark

""" Moving Around/Editing
set cursorline              " have a line indicate the cursor location
set ruler                   " show the cursor position all the time
set nostartofline           " Avoid moving cursor to BOL when jumping around
set virtualedit=block       " Let cursor move past the last char in <C-v> mode
set scrolloff=3             " Keep 3 context lines above and below the cursor
set backspace=2             " Allow backspacing over autoindent, EOL, and BOL
set showmatch               " Briefly jump to a paren once it's balanced
set linebreak               " don't wrap textin the middle of a word
"set textwidth=0             " plz?
set nowrap                  " don't wrap text
set autoindent              " always set autoindenting on
set smartindent             " use smart indent if there is no indent file
set tabstop=4               " <tab> inserts 4 spaces
set shiftwidth=4            " but an indent level is 2 spaces wide.
set softtabstop=4           " <BS> over an autoindent deletes both spaces.
"set expandtab               " Use spaces, not tabs, for autoindent/tab key.
set shiftround              " rounds indent to a multiple of shiftwidth
set matchpairs+=<:>         " show matching <> (html mainly) as well
set foldmethod=indent       " allow us to fold on indents
set foldlevel=99            " don't fold by default
set foldlevelstart=99       " don't fold by default

" don't outdent hashes
inoremap # #

"""" Reading/Writing
set noautowrite             " Never write a file unless I request it.
set noautowriteall          " NEVER.
set noautoread              " Don't automatically re-read changed files.
set modeline                " Allow vim options to be embedded in files;
set modelines=5             " they must be within the first or last 5 lines.
set ffs=unix,dos,mac        " Try recognizing dos, unix, and mac line endings.

"""" Messages, Info, Status
set ls=2                    " allways show status line
set confirm                 " Y-N-C prompt if closing with unsaved changes.
set showcmd                 " Show incomplete normal mode commands as I type.
set report=0                " : commands always print changed line count.
set shortmess+=a            " Use [+]/[RO]/[w] for modified/readonly/written.
set laststatus=2            " Always show statusline, even if only 1 window.
set statusline=[%l,%v\ %P%M]\ %f\ %r%h%w\ (%{&ff})\ %{fugitive#statusline()}

" displays tabs with :set list & displays when a line runs off-screen
set listchars=tab:>-,trail:#,precedes:<,extends:>
set list

""" Searching and Patterns
set ignorecase " Default to using case insensitive searches,
set smartcase  " unless uppercase letters are used in the regex.
set smarttab   " Handle tabs more intelligently
set hlsearch   " Highlight searches by default.
set incsearch  " Incrementally search while typing a /regex

" Git Blame
map <C-g>b :Gblame<CR>

" Paste from clipboard
map <leader>p "+p

" Quit window on <leader>q
nnoremap <leader>q :q<CR>

" close buffer and don't close split
nmap <leader>w :b#<bar>bd#<CR>

" Tabs
nnoremap <leader>t :tabnew<CR>
nnoremap <leader>c :tabclose<CR>

" hide matches on <leader>space
nnoremap <leader><space> :nohlsearch<cr>

" Remove trailing whitespace on <leader>s
nnoremap <leader>s :%s/\s\+$//<cr>:let @/=''<CR>

" NERDTREE Settings
let NERDTreeShowHidden=1 " show dotfiles
let NERDTreeIgnore = ['__pycache__', '\.pyc$', '\.swp', '.swo']

" super tab
let g:SuperTabDefaultCompletionType = "context"

" open NERDTREE
map <C-n> :NERDTreeToggle<CR>

" close vim if nerdtree is the last window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

set t_Co=16
colorscheme solarized
let g:solarized_termcolors=16

" JSHint will only do its thing when we save
let JSHintUpdateWriteOnly=1

" syntastic
let g:syntastic_javascript_checkers = ['jsxhint']

" vim-jsx
let g:jsx_pragma_required = 0

" gofmt on save
autocmd FileType go autocmd BufWritePre <buffer> Fmt
" generate ctags for go files when saving
au BufWritePost *.go silent! !ctags -R --exclude=*.js --exclude=*.coffee &
au BufRead,BufNewFile *.go set filetype=go
autocmd FileType go set nolist
autocmd FileType go set ts=4
au BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

" ctrp p custom ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn|node_modules|bower_components|env[0-9]*)$',
  \ 'file': '\v\.(exe|so|dll)$'
  \ }

let g:ctrlp_working_path_mode = 'ra'
nnoremap <silent> <leader>f :CtrlP<CR>
nnoremap <silent> <leader>b :CtrlPBuffer<CR>
nnoremap <silent> <leader>m :CtrlPMRU<CR>

" cjsx
autocmd BufNewFile,BufRead *.cjsx set filetype=coffee

" clojurescript
au BufNewFile,BufRead *.cljs set filetype=clojure

" vim-javascript
let javascript_enable_domhtmlcss = 1
let g:javascript_conceal = 1

set dir=~/.vimswap//,/var/tmp//,/tmp//,.

if exists("&colorcolumn")
    set colorcolumn=79
endif
