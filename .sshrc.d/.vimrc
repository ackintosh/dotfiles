set number
set cursorline
set wrap
set incsearch
set ignorecase
set smartcase

nnoremap ; :
nnoremap : ;

set hlsearch
noremap <Esc><Esc> :nohlsearch<CR><Esc>
set laststatus=2
set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).(&bomb?':BOM':'').']['.&ff.']'}%=\ (%v,%l)/%L%8P\

autocmd FileType php        setlocal sw=4 sts=4 ts=4 et

set autoindent
set smartindent
set nobackup
set wrap
