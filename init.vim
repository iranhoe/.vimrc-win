syntax on
filetype plugin indent on

let mapleader = ','
set number
set tabstop=4		" Number of spaces tab is counted for.
set shiftwidth=4	" Number of spaces to use to autoindent
set path+=.,,src/**
set foldmethod=indent
set clipboard=unnamed " Copy into system (*) register.
"set wildmenu				   " Enalbe enhanced tab autocomplete
" set wildmode=list:longest,full " Complete till longes string

" PRovides tab-completion for all file-related task


" colorscheme murphy " Change a colorscheme

" silent! helptags ALL " Load help files for all plugins




" ------------------------------------------------------------------------
" functions
" ------------------------------------------------------------------------
function! Smart_TabComplete()
  let line = getline('.')                         " current line

  let substr = strpart(line, -1, col('.')+1)      " from the start of the current
                                                  " line to one character right
                                                  " of the cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  if (!has_period && !has_slash)
	  return "\<C-X>\<C-P>"                         " existing text matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  else
    return "\<C-X>\<C-O>"                         " plugin matching
  endif
endfunction

" ---------------------------------
"  MAPPINGS
"  --------------------------------
" Pluging mappings
noremap <leader>n :NERDTreeToggle<cr>
inoremap <tab> <c-r>=Smart_TabComplete()<CR>

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:OmniSharp_selector_ui = 'fzf'
let g:OmniSharp_selector_findusages = 'fzf'

" Escape alternative 

imap jj <Esc>
" Move insert mode
inoremap <A-k> <C-o>k
inoremap <A-j> <C-o>j
inoremap <A-h> <C-o>h
inoremap <A-l> <C-o>l
" Swamp lines
nnoremap <A-K> :m .-2<CR>==
nnoremap <A-J> :m .+1<CR>==
vnoremap <A-J> :m '>+1<CR>gv=gv
vnoremap <A-K> :m '<-2<CR>gv=gv
inoremap <A-J> <Esc>:m .=1<CR>==gi
inoremap <A-K> <Esc>:m .-2<CR>==gi
" disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" ------------------------------------------
"  C# Code Folding
" ------------------------------------------

au FileType cs set omnifunc=syntaxcomplete#Complete
au FileType cs set foldmethod=marker
au FileType cs set foldmarker={,}
au FileType cs set foldtext=subtitute(getline(v:foldstart),'{.*','{...}',)
au FileType cs set foldlevelstart=2

" --------------------------------------------------------------------------
"  PLUGINS
" --------------------------------------------------------------------------
call plug#begin(stdpath('data') . '/plugged')

" On-demand loading
" Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
   Plug 'preservim/nerdtree'
   Plug 'https://tpope.io/vim/unimpaired.git'
   Plug 'https://github.com/tpope/vim-vinegar.git'
   Plug 'tpope/vim-fugitive'
   Plug 'chrisbra/Colorizer'
"   Plug 'https://github.com/ctrlpvim/ctrlp.vim.git'
   Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
   Plug 'junegunn/fzf.vim'
   Plug 'OmniSharp/omnisharp-vim'

call plug#end()

