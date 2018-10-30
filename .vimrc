" Plugins
filetype plugin indent on
syntax on

" Theme
set background=dark
colorscheme solarized
set showcmd
set wildmenu

" Indentation
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set autoindent
set smartindent
set wrap

" Line numbers
set number

" Highlight column 80
set colorcolumn=80

" Update file content automatically
set autoread

" Traverse line breaks
set whichwrap=b,s,<,>,[,]

" Save cursor position for current file
augroup resCur
  autocmd!
  autocmd BufReadPost * call setpos( ".", getpos( "'\"" ) )
augroup END

" Use the mouse
set mouse=a

" Use modelines
set modeline
