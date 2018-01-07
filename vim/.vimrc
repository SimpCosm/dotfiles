"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 一般设定
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 设定默认编码
set fenc=utf-8
set fencs=utf-8,usc-bom,euc-jp,gb18030,gbk,gb2312,cp936

" 不使用vi的键盘模式，而是使用vim自己的
set nocompatible

" history文件中需要记录的行数
set history=100

" 在处理未保存或只读文件的时候，弹出确认
set confirm

" 为特定文件类型载入相关缩进文件
filetype indent on

" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-

" 代码折叠
" set foldmethod=indent

" 语法高亮
syntax on

" 背景色
set background=dark

" 状态行颜色
highlight StatusLine guifg=SlateBlue guibg=Yellow
highlight StatusLineNC guifg=Gray guibg=White

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 文件格式
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 在状态行上显示光标所在的行号与列号
set ruler
set rulerformat=%20(%2*%<%f%=\ %m%r\ %3l\ %c\ %p%%%)

" 命令行（在状态行下）的高度，默认为1，这里是2
set cmdheight=2

" 使回格键（backspace）正常处理indent, eol, start等
set backspace=2

" 可以在buffer的任意地方使用鼠标（类似office在工作区双击鼠标定位）
set mouse=a
set selection=exclusive
set selectmode=mouse,key


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 搜索与匹配
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 高亮显示匹配的行号
set showmatch

" 匹配括号高亮的时间（单位使十分之一秒）
set matchtime=5

" 在搜索时，输入的词句逐字符高亮
set incsearch


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 文本格式与排版
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 显示行号
set nu

" 自动格式化
set formatoptions=tcrqn

" 继承前一行的的注释，特别适用于多行注释
set autoindent

" 为C程序提供自动缩进
set smartindent

" 使用C样式的缩进
set cindent

" 制表符为4
set tabstop=4

" 统一缩进为4
set softtabstop=4
set shiftwidth=4

" 不要用空格代替制表符
"set noexpandtab
set expandtab

" 不要换行
" set nowrap

" 在行和段的开始处使用制表符
set smarttab



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocommands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 只在下列文件类型被侦测到的时候显示行号，普通文本文件不显示

if has("autocmd")
   autocmd FileType xml,html,c,cs,java,perl,shell,bash,cpp,python,vim,php,ruby set number
   autocmd FileType xml,html vmap <C-o> <ESC>'<i<!--<ESC>o<ESC>'>o-->
   autocmd FileType java,c,cpp,cs vmap <C-o> <ESC>'<o/*<ESC>'>o*/
   autocmd FileType html,text,php,vim,c,java,xml,bash,shell,perl,python setlocal textwidth=100
   autocmd Filetype html,xml,xsl source $VIMRUNTIME/plugin/closetag.vim
   autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif
endif " has("autocmd")


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 自动创建作者信息
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F4> ms:call TitleDet()<cr>'s
autocmd BufNewFile *.c,*.h,*.sh exec "call TitleDet()"
function AddTitle()
	if &filetype=='sh'
		call append(0,"##############################################")
		call append(1,"#")
		call append(2,"# Author: Houmin Wei")
		call append(3,"#")
		call append(4,"# Email : weihoumin@gmail")
		call append(5,"#")
		call append(6,"# Last modified: ".strftime("%Y-%m-%d %H:%M"))
		call append(7,"#")
		call append(8,"# Filename: ".expand("%:t"))
		call append(9,"#")
		call append(10,"# Description: ")
    	call append(11,"#!/bin/bash")
	elseif &filetype=='cpp'
		call append( 0, "/*")
		call append( 1, "*  COPYRIGHT NOTICE")
		call append( 2, "*  Copyright (C) 2017 Houmin Wei. All rights reserved")
		call append( 3, "*")
		call append( 4, "*  Author              :Houmin Wei")
		call append( 5, "*  File Name           :".expand("%:p:h")."/".expand("%:t"))
		call append( 6, "*  Create Date         :".strftime("%Y-%m-%d %H:%M"))
		call append( 7, "*  Last Modified       :".strftime("%Y-%m-%d %H:%M"))
		call append( 8, "*  Description         :")
		call append( 9, "*/")
		call append(10, "")
	endif
    echohl WarningMsg | echo "Successful in adding the copyright." | echohl None
endfunction
"此处为预显示的格式
"第二部分
"更新最近修改时间和文件名
function UpdateTitle()
	normal m'
	execute '/*       Last Modified       /s@:.*$@\=strftime(":%Y-%m-%d %H:%M")@'
	normal ''
	normal mk
	execute '/*       File Name           /s@:.*$@\=":".expand("%:p:h")."\\".expand("%:t")@'
	execute "noh"
	normal 'k
	echohl WarningMsg | echo "Successful in updating the copy right." | echohl None
endfunction
"第三部分
"判断前10行代码里面，是否有Last modified这个单词（为更新时间的依据），
"如果没有的话，代表没有添加过作者信息，需要新添加；
"如果有的话，那么只需要更新即可
function TitleDet()
    let n=1
    while n < 10
        let line = getline(n)
        if line =~ '^\#\s*\S*Last\smodified:\S*.*$'
            call UpdateTitle()
            return
        endif
        let n = n + 1
    endwhile
    call AddTitle()
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle 插件管理
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype off

" 设置包括vundle和初始化相关的runtime path
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" 使用vundle管理插件版本，必须安装下面这个插件
Plugin 'VundleVim/Vundle.vim'

" 下面是自己安装的插件
Plugin 'Valloric/YouCompleteMe'
Plugin 'Raimondi/delimitMate'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'iamcco/mathjax-support-for-mkdp'
Plugin 'iamcco/markdown-preview.vim'
" 你所有的插件需要在下面这行之前
call vundle#end()
filetype plugin indent on	" 必须 加载vim自带和插件相应的语法和文件类型相关脚本


" YouCompleteMe configure
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

" NERDTree configure
:map <C-f> :NERDTree<CR>

" 状态栏相关
set t_Co=256       " Explicitly tell Vim that the terminal supports 256 colors
set laststatus=2	" 总是显示状态栏
let g:airline_powerline_fonts=1
"let g:airline#extensions#tabline#enabled=1    " enable tabline
"let g:airline#extensions#tabline#buffer_nr_show=1    " 显示buffer行号
"let g:airline_theme="solarized"
"set ambiwidth=double    " When iTerm set double-width characters, set it

" ctrlp
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|jpg|png|jpeg)$',
  \ }


" NERDTree 相关
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

" markdown相关
au BufRead,BufNewFile *.md set filetype=markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 2

" markdown 预览
let g:mkdp_path_to_chrome = "google-chrome"
" 设置 chrome 浏览器的路径（或是启动 chrome（或其他现代浏览器）的命令）

let g:mkdp_auto_start = 0
" 设置为 1 可以在打开 markdown 文件的时候自动打开浏览器预览，只在打开
" markdown 文件的时候打开一次

let g:mkdp_auto_open = 0
" 设置为 1 在编辑 markdown 的时候检查预览窗口是否已经打开，否则自动打开预
" 览窗口

let g:mkdp_auto_close = 1
" 在切换 buffer 的时候自动关闭预览窗口，设置为 0 则在切换 buffer 的时候不
" 自动关闭预览窗口

let g:mkdp_refresh_slow = 0
" 设置为 1 则只有在保存文件，或退出插入模式的时候更新预览，默认为 0，实时
" 更新预览

let g:mkdp_command_for_global = 0
" 设置为 1 则所有文件都可以使用 MarkdownPreview 进行预览，默认只有 markdown
" 文件可以使用改命令

