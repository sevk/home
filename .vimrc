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
	"显示行尾
	set encoding=utf-8
	set listchars=trail:\♥
   set lcs=tab:\ \┊
   set bdir=/tmp
endif

set nocompatible " VIM 不使用和 VI 相容的模式
filetype off                   " required!

filetype plugin on
filetype plugin indent on

"set ff=unix

" 編輯喜好設定
syntax on        " 語法上色顯示
set shiftwidth=2 " 設定縮排寬度 = 2
set tabstop=2    " tab 的字元數
set softtabstop=2
set sft          "补全提示
set expandtab   " 用 space 代替 tab
set noswf       " 交换文件 .xxx.swp

"set foldmethod=syntax "折叠模式

set ruler        " 顯示右下角設定值
set backspace=2  " 在 insert 也可用 backspace
set ic           " 設定搜尋忽略大小寫
set ru           " 第幾行第幾個字
set hlsearch     " 設定高亮度顯示搜尋結果
set incsearch    " 在關鍵字還沒完全輸入完畢前就顯示結果
set smartindent  " 設定 smartindent
set autoindent   "自动缩进
set confirm      " 操作過程有衝突時，以明確的文字來詢問
set history=90  " 保留 100 個使用過的指令
"set cursorline   " 顯示目前的游標位置
"set rnu        "行号
"set nu        "行号
set scrolloff=7  "光标前后保留10行
set clipboard=unnamedplus "使用system剪贴板

"export TERM=xterm-256color
if &t_Co >= 256 || has('gui_running')
   colo kkruby
else
   colo desert " Or some other 16-color scheme
endif

"powerline{
"* change the theme (available options: dark, light, simple, badwolf)
  let g:airline_theme='badwolf'
  set laststatus=2
"}
"set statusline=\ %4*%<\%m%<[%f\%r%h%w]%h%k\ [%{&ff},%{&fileencoding},%Y]%=\ L=%l,C=%v,%p%%\ %a\ %c

map <c-s> :w!<cr>
map z; :q <cr>
map zs :w <cr>
map zq :q <cr>
map za :wq <cr>
map zaa :wq! <cr>

map <m-c> <ESC>:colo kkruby<ESC>
map  <f2> :call C_Make()<CR>
imap <f2> :call C_Make()<CR>
map <f9> :rake
map  <f8> :!make install<CR>
imap <f8> :!make install<CR>
map <f3> <ESC>:bp<cr>
imap <f3> <ESC>:bp<cr>
imap <f5> def initialize(
"map <F4> :execute " grep -srnw --binary-files=without-match --exclude-dir=.git --exclude-from=exclude.list . -e " . expand("<cword>") . " " <bar> cwindow<CR>
map <F4> :execute " grep -srnw --binary-files=without-match --exclude-dir=.git . -e " . expand("<cword>") . " " <bar> cwindow<CR>
map <C-f12> "*p
imap <C-f12> <esc>"*pa

map <C-d> :NERDTreeToggle<CR>
"map <C-h> \c<space>
map <C-h> ,c<space>
map <C-/> ,c<space>
map <C-h> \c<space>
map <C-3> \c<space>
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
au filetype c,cpp set tags+=/usr/include/tags

set nocp

" vim-scripts repos
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
     set rtp+=/home/kk/dotfiles/vim/bundle/vundle/
     call vundle#rc()

     " let Vundle manage Vundle
     " required! 

     " My Bundles here:
     "
     " original repos on github
     "Bundle 'tpope/vim-fugitive'
     "Bundle 'Lokaltog/vim-easymotion'
     "Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
     "Bundle 'tpope/vim-rails.git'
     " vim-scripts repos
     "Bundle 'L9'
     "Bundle 'FuzzyFinder'
     " non github repos
     "Bundle 'git://git.wincent.com/command-t.git'
     
     Bundle 'Shougo/neocomplcache.vim'
     Bundle 'vim-ruby/vim-ruby'
     Bundle 'nathanaelkane/vim-indent-guides'
     Bundle 'rking/ag.vim'
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
"Bundle 'The-NERD-tree'
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
Bundle 'The-NERD-Commenter'
"Bundle 'project.vim'
"Bundle 'restart.vim'
Bundle 'taglist.vim'
Bundle 'c.vim'
"Bundle 'm2ym/rsense'
Bundle 'danchoi/ri.vim'
Bundle 'plasticboy/vim-markdown'
"Bundle 'templates.vim'
"Bundle 'vimim.vim'
"Bundle 'ZenCoding.vim'
"Bundle 'css_color.vim'
"Bundle 'hallettj/jslint.vim'
"Bundle 'vim-align'
"Bundle 'wincent/Command-T'
"Bundle 'git://github.com/Lokaltog/vim-powerline.git'
Bundle 'bling/vim-airline'

"selected search
noremap gss "zy:!w3m "http://www.google.com.hk/search?q=<c-r>=substitute(@z,' ','%20','g')<cr>"<return>
"cword search
noremap gsw ":!w3m "http://www.google.com.hk/search?q=<cword>"<return>
noremap gsc ":!chromium-browser "http://www.google.com.hk/search?q=<cword>"<return>
noremap gsf ":!firefox "http://www.google.com.hk/search?q=<cword>"<return>

autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
              \ exe "normal g`\"" |
     \ endif

"set guifont=DejaVu\ Sans\ Mono:h14:cANSI "设置字体，h代表字体大小 
"set nobackup "不自动备份
if has('gui_running')
   "set guifont=Monospace\ 12
   set guifont=kk\ 11
   "set guifont=Vera\ Sans\ YuanTi\ Mono\ 12
endif

"set lines=26 "

let g:indent_guides_auto_colors = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#111111 ctermbg=232
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#222222 ctermbg=233
"let g:loaded_indent_guides = 1
let g:indent_guides_autocmds_enabled = 1
au filetype rb,c,cpp,haskell,makefile,vim IndentGuidesEnable

let g:agprg="<custom-ag-path-goes-here> -H --nocolor --nogroup --column"
"map <F4> :Ag <cword><cr>
set dy=uhex "^A^B => <xx><xx>

"进行Tlist的设置
"TlistUpdate可以更新tags
map <c-a>l :Tlist<CR>
map <mod1-l> :Tlist<CR>
map <m-9> :Tlist<CR>
map <\x40-9> :Tlist<CR>
let Tlist_Ctags_Cmd='ctags' "因为我们放在环境变量里，所以可以直接执行
"let Tlist_Use_Right_Window=1 "让窗口显示在右边，0的话就是显示在左边
"let Tlist_Show_One_File=0 "让taglist可以同时展示多个文件的函数列表，如果想只有1个，设置为1
let Tlist_File_Fold_Auto_Close=1 "非当前文件，函数列表折叠隐藏
let Tlist_Exit_OnlyWindow=1 "当taglist是最后一个分割窗口时，自动推出vim
let Tlist_Process_File_Always=0 "是否一直处理tags.1:处理;0:不处理。不是一直实时更新tags，因为没有必要
"let Tlist_Inc_Winwidth=0

set completeopt=menuone,menu,longest,preview
let g:SuperTabRetainCompletionType = 2
"let g:SuperTabDefaultCompletionType = <C-X><C-O> 
let g:acp_enableAtStartup = 0
let g:AutoComplPop_MappingDriven = 0
let g:acp_ignorecaseOption = 1
let g:acp_completeOption = '.,w,b,k'
" """""""""""""""""""""""""""""configuration for neocomplcache""""""""""""""""""""""""""""
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 1
" set the max list in the popup menu. increase the speed
let g:neocomplcache_max_list=16
" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
  let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
let g:neocomplcache_auto_completion_start_length=1
" ignore letter case
let g:neocomplcache_enable_ignore_case=1
" """""""""""""""""""""""""""""configuration for neocomplcache""""""""""""""""""""""""""""
" """"""""""""""""""""""""""auto complete () "" """"""""""""""""""""""""""""""""""""""""
":inoremap ( ()<ESC>i
":inoremap ) <c-r>=ClosePair(')')<CR>
":inoremap { {}<ESC>i
":inoremap } <c-r>=ClosePair('}')<CR>
":inoremap [ []<ESC>i
":inoremap ] <c-r>=ClosePair(']')<CR>
":inoremap < <><ESC>i
":inoremap > <c-r>=ClosePair('>')<CR>
function ClosePair(char)
if getline('.')[col('.') - 1] == a:char
  return "\<Right>"
else
  return a:char
endif
endf
" """"""""""""""""""""""""""auto complete () "" """"""""""""""""""""""""""""""""""""""""
set cindent

" markdown viewer
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_initial_foldlevel=1

