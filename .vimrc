" cf. https://rbtnn.hateblo.jp/entry/2014/11/30/174749

filetype off

if !exists('g:vscode')
  packloadall
endif

if has('autocmd')
  autocmd!

  augroup StatusLineColor
    autocmd!
    autocmd InsertEnter * highlight StatusLine cterm=None ctermbg=5 gui=bold guibg=Magenta
    autocmd InsertLeave * highlight StatusLine cterm=None ctermbg=2 gui=bold guibg=Green
  augroup END

  augroup NERDTree
    autocmd!
    autocmd FileType nerdtree nnoremap <buffer> q <Nop>
    autocmd FileType nerdtree nnoremap <buffer> ; <C-w>w:
    autocmd FileType nerdtree nnoremap <buffer> <C-n> <Nop>
    autocmd FileType nerdtree nnoremap <buffer> <C-o> <Nop>
    autocmd FileType nerdtree nnoremap <buffer> <C-p> <Nop>
    autocmd FileType nerdtree nnoremap <buffer> <C-w>q <Nop>
  augroup END

  augroup Tex
    autocmd!
    autocmd FileType tex setlocal textwidth=80
  augroup END

  augroup Text
    autocmd!
    autocmd FileType text setlocal textwidth=80
  augroup END

  augroup Tmux
    autocmd!
    autocmd BufWritePost .tmux.conf :!tmux source %
  augroup END

  augroup Help
    autocmd!
    autocmd FileType help nnoremap <buffer> q <C-w>q
    autocmd FileType help nnoremap <buffer> H <C-t>
    autocmd FileType help nnoremap <buffer> <Backspace> <C-t>
    autocmd FileType help nnoremap <buffer> <CR> <C-]>
    autocmd FileType help nnoremap <buffer> <C-n> <Nop>
    autocmd FileType help nnoremap <buffer> <C-p> <Nop>
    autocmd FileType help setlocal textwidth=0
  augroup END

  augroup Java
    autocmd!
    autocmd FileType java setlocal completefunc=javacomplete#CompleteParamsInfo
    autocmd FileType java setlocal makeprg=ant
  augroup END

  augroup JavaScript
    autocmd!
    autocmd FileType javascript setlocal shiftwidth=2
    autocmd FileType javascript setlocal tabstop=2
  augroup END

  augroup LanguageServerProtocol
    autocmd!
    autocmd User lsp_buffer_enabled setlocal omnifunc=lsp#complete
    autocmd User lsp_buffer_enabled setlocal completefunc=lsp#complete
    autocmd User lsp_buffer_enabled setlocal signcolumn=yes
    autocmd User lsp_buffer_enabled setlocal foldmethod=expr
    autocmd User lsp_buffer_enabled setlocal foldexpr=lsp#ui#vim#folding#foldexpr()
    autocmd User lsp_buffer_enabled setlocal foldtext=lsp#ui#vim#folding#foldtext()
    autocmd User lsp_buffer_enabled nmap <buffer> K <Plug>(lsp-hover)
    autocmd User lsp_buffer_enabled nmap <buffer> <F2> <Plug>(lsp-rename)
    autocmd User lsp_buffer_enabled nmap <buffer> <F7> <Plug>(lsp-previous-diagnostic)
    autocmd User lsp_buffer_enabled nmap <buffer> <F8> <Plug>(lsp-next-diagnostic)
    autocmd User lsp_buffer_enabled nmap <buffer> <F12> <Plug>(lsp-definition)
    autocmd User lsp_buffer_enabled nmap <buffer> <S-F12> <Plug>(lsp-references)
  augroup END

  augroup PowerShell
    autocmd!
    autocmd FileType ps1 nnoremap <buffer> <F5> :QuickRun<CR>
    autocmd FileType ps1 setlocal keywordprg=PowerShell\ -ExecutionPolicy\ RemoteSigned\ -Command\ Get-Help\ -Online\ -Name
    autocmd FileType ps1 setlocal iskeyword& iskeyword+=-
  augroup END

  augroup Python
    autocmd!
    autocmd FileType python nnoremap <buffer> <F5> :QuickRun<CR>
    autocmd FileType python setlocal keywordprg=http://docs.python.jp/3.3/search.html?&check_keywords=yes&area=default&q=
  augroup END

  augroup QuickFix
    autocmd!
    autocmd FileType qf nunmap <buffer> <CR>
    autocmd FileType qf nnoremap <buffer> q <C-w>q
  augroup END

  augroup ReStructuredText
    autocmd!
    autocmd FileType rst setlocal wrap
  augroup END

  augroup Vim
    autocmd!
    autocmd BufWritePost .vimrc source %
    autocmd BufWritePost _vimrc source %
  augroup END

  augroup Binary
    autocmd!
    autocmd BufReadPost * if &binary | %!xxd -g1
    autocmd BufReadPost * set ft=xxd | endif
    autocmd BufWritePre * if &binary | %!xxd -r
    autocmd BufWritePre * endif
    autocmd BufWritePost * if &binary | %!xxd -g1
    autocmd BufWritePost * set nomod | endif
  augroup END
endif

chdir ~

cnoremap <C-a> <C-b>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>
nnoremap <Space> :CtrlP<CR>
nnoremap Y y$
nnoremap : ;
nnoremap ; :
nnoremap <S-Tab> gT
nnoremap <Tab> gt
nnoremap <C-b> :CtrlPBuffer<CR>
nnoremap <C-f> :CtrlPCurWD<CR>
nnoremap <C-o> <Nop>
nnoremap <C-n> :bn<CR>
nnoremap <C-p> :bp<CR>
if exists(':update') == 2
  nnoremap <CR> :update<CR>
else
  " Use :w for Vim-like applications without the support of :update
  nnoremap <CR> :w<CR>
endif

if exists('+ambiwidth')
  set ambiwidth=double
endif
if exists('+autochdir')
  set autochdir
endif
set autoread
if !&compatible
  set backspace=indent,eol,start
endif
set nobackup
set cindent
set cinoptions=(s
if has('nvim')
  set clipboard=unnamed
else
  set clipboard=autoselect,unnamed
endif
set cmdheight=1
set completeopt=longest,menuone,preview
set cpoptions& cpoptions+=$
if exists('+cursorline')
  set cursorline
endif
set directory-=.
set expandtab
set encoding=utf-8
set formatoptions+=mM
set fileencodings=ucs-bom,utf-8,euc-jp,iso-2022-jp,cp932,utf-16,utf-16le
set fileformats=dos,unix,mac
set hidden
set hlsearch
set noimcmdline
set ignorecase
set iminsert=0
set imsearch=0
set incsearch
set laststatus=2
set lazyredraw
set list
set mouse=
set nrformats-=octal
set number
if exists('+packpath')
  set packpath+=$HOME\.vim
endif
if exists('+relativenumber')
  set relativenumber
endif
set shiftwidth=4
set showcmd
set showmatch
set smartcase
set splitbelow
set statusline=\ %n
set statusline+=%{&ro?'#':&mod?'*':&ma?':':'='}
set statusline+=\ %f
set statusline+=%=%<
set statusline+=\ %l,%c\ /\ %L\ (%3p%%)
set statusline+=\ [
set statusline+=%{substitute(&fenc!=''?&fenc:&enc!=''?&enc:'?','[a-z]','\\u\\0','g')}
set statusline+=%{&bomb?'BOM':'N'}:
set statusline+=%{substitute(&ff!=''?&ff:'?','[a-z]','\\u\\0','g')}:
set statusline+=%Y]\ 
if exists('*SkkGetModeStr')
  set statusline+=%{SkkGetModeStr()}\ 
endif
set tabstop=4
if has('win32')
  set termencoding=CP932
else
  set termencoding=UTF-8
endif
if exists('+setguicolors')
  set termguicolors
endif
set textwidth=0
set notitle
set nowrap
set whichwrap=b,s,<,>,~,[,]
set wildmenu
set nowritebackup

scriptencoding utf-8
colorscheme elflord
syntax enable

highlight ChangedDefaultHl cterm=bold ctermbg=4 ctermfg=white gui=bold guibg=red guifg=white
highlight DiffAdd cterm=bold ctermbg=4 guibg=DarkBlue
highlight LineNr ctermfg=2 ctermbg=4 guifg=Silver guibg=DarkBlue
highlight NonText cterm=NONE ctermfg=darkgray ctermbg=NONE gui=NONE guifg=#666666 guibg=NONE
highlight Search cterm=reverse
highlight StatusLine cterm=None ctermbg=2 gui=bold guibg=Green

let g:buftabs_only_basename = 1
let g:buftabs_in_statusline = 1
let g:buftabs_marker_start = '%2* '
let g:buftabs_marker_end = ' %0*'
let g:buftabs_separator = ':'
let g:buftabs_separator_mod = '*'
let g:camelcasemotion_key = '<leader>'
let g:hardtime_allow_different_key = 1
let g:hardtime_default_on = 1
let g:hardtime_showmsg = 1
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_settings = {
\   'pyls-all': {
\     'workspace_config': {
\       'pyls': {
\         'configurationSources': ['flake8']
\       }
\     }
\   },
\}

let g:NERDTreeShowHidden = 1
let g:nerdtree_tabs_autofind = 0 " Automatically find and select currently opened file in NERDTree
let g:nerdtree_tabs_open_on_console_startup = 0 " Open NERDTree on console vim startup
let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = '--max-line-length=120'
let g:quickrun_config = {'*': {'split': '5'}}

" Enable 'termguicolors' for some non-xterm terminals accepting the same sequence with xterm.
" See also the Vim help for xterm-true-color.
let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"

filetype plugin indent on

" vim:sw=2:ts=2:
