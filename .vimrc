""!/usr/bin/env vim
"" -*- coding: utf-8 -*-
"配置文件，简洁版
 
" 檔案編碼
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr
set encoding=utf-8

highlight whitespaceEOL term=reverse ctermbg=red guibg=yellow
match whitespaceEOL /\s\+\(\%#\)\@!$/
syntax match whitespaceEOL /\s\+$/
syntax match ColorColumn /\%>87v.\+/
"set list "显示空格和行尾"
"set cpt=t "补全方式
if has("win32")
  set rtp+=G:\dev\vundle
	set termencoding=cp936
	language messages zh_CN.UTF-8
	behave mswin
	set listchars=trail:P
	set lcs=tab:\ \|
el
  set rtp+=~/.vim
	"显示行尾
	set encoding=utf-8
	set listchars=trail:\♥
   set lcs=tab:\ \┊
   set bdir=/tmp
endif

set nocompatible " VIM 不使用和 VI 相容的模式
filetype off                   " required!

if exists("g:did_load_filetypes")
   filetype off
   filetype plugin indent off
endif

syntax on
filetype plugin on
filetype plugin indent on

set ff=dos        " 换行使用dos格式

" 編輯喜好設定
"syntax on        " 語法上色顯示
set shiftwidth=2 " 設定縮排寬度 = 2
set tabstop=2    " tab 的字元數
set softtabstop=2
set sft          "补全提示
set expandtab   " 用 space 代替 tab
set noswf       " 交换文件 .xxx.swp

set foldmethod=marker "折叠模式

"set ruler        " 顯示右下角設定值
set backspace=2  " 在 insert 也可用 backspace
set ic           " 設定搜尋忽略大小寫
"set ru           " 第幾行第幾個字
set hlsearch     " 設定高亮度顯示搜尋結果
"set incsearch    " 在關鍵字還沒完全輸入完畢前就顯示結果
set smartindent  " 設定 smartindent
set autoindent   "自动缩进
"set mouse=a
set autoread     " 当文件在外部被修改时，自动重新读取
augroup checktime
   au!
   if !has("gui_running")
      "silent! necessary otherwise throws errors when using command
      "line window.
      autocmd BufEnter        * silent! checktime
      autocmd CursorHold      * silent! checktime
      autocmd CursorHoldI     * silent! checktime
      "these two _may_ slow things down. Remove if they do.
      autocmd CursorMoved     * silent! checktime
      autocmd CursorMovedI    * silent! checktime
   endif
augroup END

set confirm      " 操作過程有衝突時，以明確的文字來詢問
set history=90  " 保留 100 個使用過的指令
set cursorline   " 顯示目前的游標位置
"set rnu        "行号
set nu        "行号
set scrolloff=8  "光标前后保留10行
set clipboard=unnamedplus "使用system剪贴板

"export TERM=xterm-256color
if &t_Co >= 256 || has('gui_running')
   colo kkruby
else
   colo desert " Or some other 16-color scheme
endif

let g:airline_theme='badwolf'
set laststatus=2
set statusline=\ %4*%<\%m%<[%f\%r%h%w]%h%k\ [%{&ff},%{&fileencoding},%Y]%=\ L=%l,C=%v,%p%%\ %a\ %c

map <c-s> :w!<cr>
map zq :q <cr>
map zs :w <cr>
map zw :wq <cr>
map zza :wq! <cr>
map zaa :wq! <cr>
map zzz :Tlist <cr>

map  <f2> :call C_Make()<CR>
imap <f2> :call C_Make()<CR>
map <f9> :rake
map  <f8> :!make install<CR>
imap <f8> :!make install<CR>
"map <s-m> :!man expand("<cowrd>") <CR>
map <f3> <ESC>:bp<cr>
imap <f3> <ESC>:bp<cr>
imap <f5> def initialize 
"map <F4> :execute " grep -srnw --binary-files=without-match --exclude-dir=.git --exclude-from=exclude.list . -e " . expand("<cword>") . " " <bar> cwindow<CR>
map <F4> :execute " grep -srnw --binary-files=without-match --exclude-dir=.git . -e " . expand("<cword>") . " " <bar> cwindow<CR>
map <C-f12> "*p
imap <C-f12> <esc>"*pa

map zd :NERDTreeToggle<CR>
map <C-h> \c<space>
map z/ \c<space>
map <C-/> \c<space>
"set guicursor=i:ver100-iCursor

map <C-j> :wincmd j<cr>
map <C-k> :wincmd k<cr>
map <C-g>w :file<cr>
map <C-m-w> <esc>:w <cr>
map <C-w>c :bd <cr>
map <C-x><C-s> :w <cr>
map <C-x>s :wa <cr>
map j gj
map k gk

set tags+=../tags
set tags+=tag
set tags+=tags.base
au filetype c,cpp set tags+=/usr/include/tags

set rtp+=~/.vim/plugged
call plug#begin('~/.vim/plugged')
Plug 'vim-ruby/vim-ruby'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-scripts/c.vim'
Plug 'stjernstrom/vim-ruby-run'


" Make sure you use single quotes
"Plug 'junegunn/seoul256.vim'
Plug 'junegunn/vim-easy-align'

" Group dependencies, vim-snippets depends on ultisnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using git URL
"Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Plugin options
"Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }

" Unmanaged plugin (manually installed and updated)
"Plug '~/my-prototype-plugin'

" Add plugins to &runtimepath
call plug#end()


set nocp

" vim-scripts repos
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
    " set rtp+=/home/kk/dotfiles/vim/bundle/vundle/
    " call vundle#rc()
     " let Vundle manage Vundle
     " required!
     " My Bundles here:
     " original repos on github
     "Bundle 'tpope/vim-fugitive'
     "Bundle 'Lokaltog/vim-easymotion'
     "Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
     "Bundle 'tpope/vim-rails.git'
     " vim-scripts repos
     "Bundle 'L9'
     "Bundle 'FuzzyFinder'
     " non github repos
     "Bundle 'cespare/vim-golang'
     "Bundle 'vim-golang'
     "Bundle 'Blackrush/vim-gocode'
     "Bundle 'vim-gocode'
     "autocmd BufWritePre *.go :Fmt
     "autocmd FileType go autocmd BufWritePre <buffer> Fmt
     set showcmd

     "Bundle 'vim-ruby/vim-ruby'
     "Bundle 'nathanaelkane/vim-indent-guides'
     "Bundle 'vim-clang'
     "let g:clang_auto = 1
     "Bundle 'garbas/vim-snipmate'
    " Bundle 'Valloric/YouCompleteMe'

     "Bundle 'rking/ag.vim'
     "Bundle 'gtags.vim'
     "Bundle 'vim-scripts/textutil.vim'

" Syntax
"Bundle 'asciidoc.vim'
"Bundle 'confluencewiki.vim'
"Bundle 'html5.vim'
"Bundle 'JavaScript-syntax'
"Bundle 'mako.vim'
"Bundle 'moin.vim'
"Bundle 'xml.vim'
" Bundle 'airblade/vim-gitgutter'
" let g:gitgutter_highlight_lines = 1
"Bundle 'slim-template/vim-slim.git'

" Color
"Bundle 'desert256.vim'
"Bundle 'Impact'
"Bundle 'matrix.vim'
"Bundle 'vibrantink'
"Bundle 'vividchalk.vim'

" Indent
"Bundle 'indent/html.vim'
"Bundle 'IndentAnything'
"Bundle 'Javascript-Indentation'
"Bundle 'mako.vim--Torborg'

" Plugin
"Bundle 'AutoClose--Alves'
"Bundle 'auto_mkdir'
"Bundle 'cecutil'
"Bundle 'fcitx.vim'
"Bundle 'FencView.vim'
"Bundle 'FuzzyFinder'
"Bundle 'jsbeautify'
"Bundle 'Mark'
"Bundle 'matrix.vim'
"Bundle 'mru.vim'
"Bundle 'The-NERD-Commenter'
"Bundle 'The-NERD-tree'
"Bundle 'scrooloose/nerdtree'
" Bundle 'scrooloose/nerdcommenter'
"Bundle 'project.vim'
"Bundle 'restart.vim'
"Bundle 'taglist.vim'
Plug 'vim-scripts/taglist.vim'
"Bundle 'scrooloose/syntastic'
"Bundle 'm2ym/rsense'
"Bundle 'danchoi/ri.vim'
"Bundle 'plasticboy/vim-markdown'
"Bundle 'templates.vim'
"Bundle 'vimim.vim'
"Bundle 'ZenCoding.vim'
"Plug 'css_color.vim'
"Bundle 'hallettj/jslint.vim'
"Bundle 'vim-align'
"Bundle 'wincent/Command-T'
Plug 'bling/vim-airline'
" Bundle 'syntastic'
"execute pathogen#infect()
" call pathogen#infect()
let g:syntastic_warning_symbol = '⚠'
"let g:syntastic_always_populate_loc_list = 1

autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
              \ exe "normal g`\"" |
     \ endif

"set guifont=DejaVu\ Sans\ Mono:h14:cANSI "设置字体，h代表字体大小 
"set nobackup "不自动备份
if has('gui_running')
   set guifont=Ubuntu\ Mono\ 13
   "set guifont=kk\ 12
   "set guifont=Vera\ Sans\ YuanTi\ Mono\ 12
endif

"set lines=26 "


let g:agprg="<custom-ag-path-goes-here> -H --nocolor --nogroup --column"
"map <F4> :Ag <cword><cr>
set dy=uhex "^A^B => <xx><xx>

"进行Tlist的设置
"TlistUpdate可以更新tags
map <c-a>l :Tlist<CR>
map <f6> :Tlist<CR>

set cindent

syntax on
"filetype indent on

filetype plugin on
autocmd BufRead,BufNewFile Appraisals set filetype=ruby

