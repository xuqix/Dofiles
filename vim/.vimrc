"==============================================================================
"                          << 以下为软件默认配置 >>
"==============================================================================
set nocompatible
"source $VIMRUNTIME/vimrc_example.vim
source ~/.vim/plugin/mswin.vim    "win下C-c C-v操作
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction


"==============================================================================
"                          << 以下为用户自定义配置 >>
"==============================================================================

"------------------------------------------------------------------------------
"  < 编码配置 >
"------------------------------------------------------------------------------
"注：使用utf-8格式后，软件与程序源码、文件路径不能有中文，否则报错
set encoding=utf-8                                    "gvim内部编码
set fileencoding=utf-8                                "当前文件编码
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1     "支持打开文件的编码
"解决菜单乱码
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
"解决consle输出乱码
language messages zh_CN.utf-8

"------------------------------------------------------------------------------
"  < 界面配置 >
"------------------------------------------------------------------------------
set number                                            "显示行号
set laststatus=2                                      "开启状态栏信息
"set cmdheight=2                                       "设置命令行的高度为2，默认为1
"colorscheme Tomorrow-Night-Bright
"colorscheme Tomorrow-Night
colorscheme Tomorrow-Night-Eighties                   "设置代码颜色主题
"set cursorline                                        "突出显示当前行
"highlight CursorLine guibg=lightblue ctermbg=lightgray
set guifont=DejaVu_Sans_Mono:h10                      "设置字体:字号（字体名称空格用下划线代替）
set nowrap                                            "设置不自动换行
set shortmess=atI                                     "去掉欢迎界面
"au GUIEnter * simalt ~x                              "窗口启动时自动最大化
"winpos 100 20                                         "指定窗口出现的位置，坐标原点在屏幕左上角
"set lines=45 columns=120                              "指定窗口大小，lines为高度，columns为宽度

"个性化状栏（增加了文件编码的显示，去掉注释即可）
set statusline=%F%m%r%h%w\ %=%{\"\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"\"}\ \|\ %l,%v\ \|\ %p%%

"显示/隐藏菜单栏、工具栏、滚动条，可用 Ctrl + F11 切换
map <silent> <c-F11> :if &guioptions =~# 'm' <Bar>
\set guioptions-=m <Bar>
\set guioptions-=T <Bar>
\set guioptions-=r <Bar>
\set guioptions-=L <Bar>
\else <Bar>
\set guioptions+=m <Bar>
\set guioptions+=T <Bar>
\set guioptions+=r <Bar>
\set guioptions+=L <Bar>
\endif<CR>

"------------------------------------------------------------------------------
"  < 编写文件时的配置 >
"------------------------------------------------------------------------------
set expandtab                                         "将tab键转换为空格
set tabstop=4                                         "设置tab键的宽度
set shiftwidth=4                                      "换行时自动缩进4个空格
set backspace=2                                       "设置退格键可用
set smarttab                                          "指定按一次backspace就删除4个空格
"set foldenable                                        "启用折叠
"set foldmethod=marker                                 "marker 折叠方式
"set foldmethod=indent                                 "indent 折叠方式
"用空格键来开关折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
"暂时使用
set mouse=a
set hlsearch
set autoindent
set smartindent
set cindent


"常规模式下输入 cs 清除行尾空格
"nmap cs :%s/\s\+$//g<cr>:noh<cr>
"常规模式下输入 cm 清除行尾 ^M 符号
"nmap cm :%s/^M$//g<cr>:noh<cr>

set ignorecase                                        "搜索模式里忽略大小写
set smartcase                                         " 如果搜索模式包含大写字符，不使用 'ignorecase' 选项，只有在输入搜索模式并且打开 'ignorecase' 选项时才会使用
"set noincsearch                                       "在输入要搜索的文字时，取消vim实时匹配

" Ctrl + K 插入模式下光标向上移动
"imap <c-k> <Up>
" Ctrl + J 插入模式下光标向下移动
"imap <c-j> <Down>
" Ctrl + H 插入模式下光标向左移动
"imap <c-h> <Left>
" Ctrl + L 插入模式下光标向右移动
"imap <c-l> <Right>

"每行超过80个的字符用下划线标示
"au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 80 . 'v.\+', -1)

"------------------------------------------------------------------------------
"  < 编译、连接、运行配置 >
"------------------------------------------------------------------------------
" F9 一键保存、连接存并运行
map <F9> :call Link_Run()<CR>
map <F9> <ESC>:call Link_Run()<CR>

" Ctrl + F9 一键保存并编译
"map <c-F9> :call Compile()<CR>
"map <c-F9> <ESC>:call Compile()<CR>

let s:LastShellReturnCode = 0
let s:Obj_Extension = '.o'
let s:Exe_Extension = '.out'

func! Compile()
    exec "update"
    if expand("%:e") == "c" || expand("%:e") == "cpp" || expand("%:e") == "cxx"
        let Sou = expand("%:p")
        let Obj = expand("%:p:r").s:Obj_Extension
        let Obj_Name = expand("%:p:t:r").s:Obj_Extension
        if !filereadable(Obj) || (filereadable(Obj) && (getftime(Obj) < getftime(Sou)))
            if expand("%:e") == "c"
                setlocal makeprg=gcc\ -std=c99\ -fexec-charset=gbk\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o
                silent make
            elseif expand("%:e") == "cpp" || expand("%:e") == "cxx"
                setlocal makeprg=g++\ -std=c++98\ -fexec-charset=gbk\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o
                silent make
            endif
            redraw!
            let s:LastShellReturnCode = v:shell_error
            if s:LastShellReturnCode != 0
                exec "cope"
                echohl WarningMsg | echo " compilation failed"
            else
                exec "cw"
                echohl WarningMsg | echo " compilation successful"
            endif
        else
            echohl WarningMsg | echo ""Obj_Name"is up to date"
        endif
    else
        echohl WarningMsg | echo "please choose the correct source file"
    endif
    setlocal makeprg=make
endfunc

func! Link_Run()
    if expand("%:e") == "c" || expand("%:e") == "cpp" || expand("%:e") == "cxx"
        let Sou = expand("%:p")
        let Obj = expand("%:p:r").s:Obj_Extension
        let Exe = expand("%:p:r").s:Exe_Extension
        call Compile()
        if s:LastShellReturnCode != 0
            let s:LastShellReturnCode = 0
            return
        endif
        if executable(Exe) && getftime(Exe) >= getftime(Obj)
            redraw!
            exec "!%<"
        else
            if expand("%:e") == "c"
                setlocal makeprg=gcc\ -o\ %<\ %<.o
                silent make
            elseif expand("%:e") == "cpp" || expand("%:e") == "cxx"
                setlocal makeprg=g++\ -o\ %<\ %<.o
                silent make
            endif
            redraw!
            let s:LastShellReturnCode = v:shell_error
            if s:LastShellReturnCode != 0
                exec "cope"
                echohl WarningMsg | echo " link failed"
                setlocal makeprg=make
                let s:LastShellReturnCode = 0
                return
            else
                exec "cw"
                echohl WarningMsg | echo " link successful"
            endif
            redraw!
            exec "!rm %<.o"      
            "exec "!./%<"       "执行文件
        endif
        redraw!
        echohl WarningMsg | echo " running finish"
    else
        echohl WarningMsg | echo "please choose the correct source file"
    endif
    setlocal makeprg=make
endfunc

"------------------------------------------------------------------------------
"  < 其它配置 >
"------------------------------------------------------------------------------
set writebackup                             "设置无写入备份
set nobackup                                "设置无备份文件
"set noswapfile                              "设置无临时文件
set vb t_vb=                                "关闭提示音


"==============================================================================
"                          << 以下为常用插件配置 >>
"==============================================================================

"------------------------------------------------------------------------------
"  < ctags 插件配置 >
"------------------------------------------------------------------------------
"对浏览代码非常的方便,可以在函数,变量之间跳转等
set tags=./tags;                            "向上级目录递归查找tags文件

"------------------------------------------------------------------------------
"  < cscope 插件配置 >
"------------------------------------------------------------------------------
"用Cscope自己的话说 - "你可以把它当做是超过频的ctags"
set cscopequickfix=s-,c-,d-,i-,t-,e-        "是设定是否使用 quickfix 窗口来显示 cscope 结果

if has("cscope")
    "使支持用 Ctrl+]  和 Ctrl+t 快捷键在代码间跳转
    set cscopetag
    "如果你想反向搜索顺序设置为1
    set csto=0
    "在当前目录中添加任何数据库
    if filereadable("cscope.out")
        cs add cscope.out
    "否则添加数据库环境中所指出的
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set cscopeverbose
    "快捷键设置
    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif

"------------------------------------------------------------------------------
"  < TagList 插件配置 >
"------------------------------------------------------------------------------
"高效地浏览源码, 其功能就像vc中的workpace 
"那里面列出了当前文件中的所有宏,全局变量, 函数名等

"常规模式下输入 tl 调用插件
nmap tl :Tlist<cr>
let Tlist_Show_One_File=1                   "只显示当前文件的tags
"let Tlist_Enable_Fold_Column=0              "使taglist插件不显示左边的折叠行
let Tlist_Exit_OnlyWindow=1                 "如果Taglist窗口是最后一个窗口则退出Vim
let Tlist_File_Fold_Auto_Close=1            "自动折叠
let Tlist_WinWidth=25                       "设置窗口宽度
"let Tlist_Use_Right_Window=1                "在右侧窗口中显示

"------------------------------------------------------------------------------
"  < Tagbar 插件配置 >
"------------------------------------------------------------------------------
"相对 TagList 能更好的支持面向对象

"常规模式下输入 tb 调用插件
nmap tb :TagbarToggle<cr>
let g:tagbar_width = 25                     "设置窗口宽度

"------------------------------------------------------------------------------
"  < WinManager 插件配置 >
"------------------------------------------------------------------------------
"管理各个窗口, 或者说整合各个窗口

"常规模式下输入 wm 调用插件
nmap wm :WMToggle<cr>
"这里可以设置为多个窗口, 如'FileExplorer|TagList'
let g:winManagerWindowLayout='FileExplorer|TagList'

let g:persistentBehaviour=0                 "只剩一个窗口时, 退出vim
let g:winManagerWidth=10                    "设置窗口宽度

"------------------------------------------------------------------------------
"  < MiniBufExplorer 插件配置 >
"------------------------------------------------------------------------------
"快速浏览和操作Buffer 
"主要用于同时打开多个文件并相与切换
"let g:miniBufExplMapWindowNavArrows = 1     "用Ctrl加方向键切换到上下左右的窗口中去
let g:miniBufExplMapWindowNavVim = 1        "用<C-k,j,h,l>切换到上下左右的窗口中去
let g:miniBufExplMapCTabSwitchBufs = 1      "功能增强 <C-Tab> 向前循环切换到每个buffer上,并在但前窗口打开
"                                                     <C-S-Tab> 向后循环切换到每个buffer上,并在但前窗口打开

"------------------------------------------------------------------------------
"  < NERD_commenter 插件配置 >
"------------------------------------------------------------------------------
"主要用于C/C++代码注释(其它的也行)
"以下为插件默认快捷键
"<Leader>ci 以每行一个 /* */ 注释选中行(选中区域所在行)，再输入则取消注释
"<Leader>cm 以一个 /* */ 注释选中行(选中区域所在行)，再输入则称重复注释
"<Leader>cc 以每行一个 /* */ 注释选中区域
"<Leader>cu 取消选中区域(行)的注释，选中区域(行)内至少有一个 /* */
"<Leader>ca 在/*...*/与//这两种注释方式中切换

"------------------------------------------------------------------------------
"  < vimtweak 插件配置 >
"------------------------------------------------------------------------------
"这里只用于窗口透明与置顶
"常规模式下 Shift + k 减小透明度，Shift + j 增加透明度，<Leader>t 窗口置顶与否切换

let g:Current_Alpha = 255
let g:Top_Most = 0
func! Alpha_add()
    let g:Current_Alpha = g:Current_Alpha + 10
	if g:Current_Alpha > 255
        let g:Current_Alpha = 255
	endif
	call libcallnr("vimtweak.dll","SetAlpha",g:Current_Alpha)
endfunc
func! Alpha_sub()
    let g:Current_Alpha = g:Current_Alpha - 10
	if g:Current_Alpha < 155
        let g:Current_Alpha = 155	
	endif
    call libcallnr("vimtweak.dll","SetAlpha",g:Current_Alpha)
endfunc
func! Top_window()
    if  g:Top_Most == 0
        call libcallnr("vimtweak.dll","EnableTopMost",1)
        let g:Top_Most = 1
    else
        call libcallnr("vimtweak.dll","EnableTopMost",0)
        let g:Top_Most = 0
    endif
endfunc
"快捷键设置
"map <s-k> :call Alpha_add()<cr>
"map <s-j> :call Alpha_sub()<cr>
"map <leader>t :call Top_window()<cr>

"------------------------------------------------------------------------------
"  < gvimfullscreen 插件配置 >
"------------------------------------------------------------------------------
"用于全屏窗口，可用 F11 切换
"全屏后再隐藏菜单栏、工具栏、滚动条效果更好
map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>

"------------------------------------------------------------------------------
"  < indent_guides 插件配置 >
"------------------------------------------------------------------------------
"用于显示对齐线
"默认键盘映射为 <leader>ig
let g:indent_guides_guide_size=1            "设置对齐线宽度为1

"------------------------------------------------------------------------------
"  < omnicppcomplete 插件配置 >
"------------------------------------------------------------------------------
"用于C/C++代码补全，这种补全主要针对命名空间、类、结构、共同体等进行补全，详细
"说明可以参考帮助或网络教程等
"使用前先执行如下 ctags 命令
"ctags -R --c++-kinds=+p --fields=+iaS --extra=+q
"我使用上面的参数生成标签后，对函数使用跳转时会出现多个选择
"所以我就将--c++-kinds=+p参数给去掉了，如果大侠有什么其它解决方法希望不要保留呀
set completeopt=menu                        "关闭预览窗口

"------------------------------------------------------------------------------
"  < snipMate 插件配置 >
"------------------------------------------------------------------------------
"用于各种代码补全，这种补全是一种对代码中的词与代码块的缩写补全，详细用法可以参
"考使用说明或网络教程等。不过有时候也会与 supertab 插件在补全时产生冲突，如果大
"侠有什么其它解决方法希望不要保留呀

"------------------------------------------------------------------------------
"  < supertab 插件配置 >
"------------------------------------------------------------------------------
"我主要用于配合 omnicppcomplete 插件，在按 Tab 键时自动补全效果更好更快

"------------------------------------------------------------------------------
"  < a.vim 插件配置 >
"------------------------------------------------------------------------------
"用于切换C/C++头文件
":A     ---切换头文件并独占整个窗口
":AV    ---切换头文件并垂直分割窗口
":AS    ---切换头文件并水平分割窗口
nnoremap <silent> <F4> :A<CR>

"------------------------------------------------------------------------------
"  < txtbrowser 插件配置 >
"------------------------------------------------------------------------------
"用于文本文件生成标签与与语法高亮（调用TagList插件生成标签，如果可以）
au BufEnter *.txt setlocal ft=txt

"------------------------------------------------------------------------------
"  < visualmark 插件配置 >
"------------------------------------------------------------------------------
"用于生成标签(按下Ctrl + F2)
"F2 正向浏览标签，Shift + F2逆向浏览标签 

"------------------------------------------------------------------------------
"  < auto-pairs 插件配置 >
"------------------------------------------------------------------------------
"用于括号与引号自动补全，不过会与函数原型提示插件echofunc冲突
"所以我就没有加入echofunc插件

"------------------------------------------------------------------------------
"  < echofunc 插件配置 >
"------------------------------------------------------------------------------
"括号补全比较鸡肋，还是用这个好了

"------------------------------------------------------------------------------
"  < 其它 >
"------------------------------------------------------------------------------
"注：上面配置中的"<Leader>"在本软件中设置为"\"键（引号里的反斜杠），如 <Leader>t 指在
"常规模式下按"\"键加"t"键，这里不是同时按，而是先按"\"键后按"t"键，间隔在一钞内


"colorscheme desert 
"set guifont=Courier_New:h10:cANSI
set guifont=Courier\ 10\ Pitch\ 12
"colorscheme blue
"colorscheme darkblue
"colorscheme delek
"colorscheme elflord
"colorscheme evening
"colorscheme koehler
"colorscheme morning
"colorscheme murphy
"colorscheme pablo
"colorscheme peachpuff
"colorscheme ron
"colorscheme shine
"colorscheme slate
"colorscheme torte
"colorscheme zellner


set ignorecase
syntax enable
syntax on
set autochdir
winpos 235 100
"-i忽略大小写
"nnoremap <silent> <F3> :grep -i<CR> 

"ctags -R --c++-kinds=+px --fields=+ialS --extra=+q
"set tags+=d:\inc_tags				"ddk库tag文件

autocmd FileType * setlocal formatoptions-=cro "取消自动注释

"启用python代码补全
filetype plugin on	"崩溃
filetype plugin indent on "打开自动缩进
"autocmd FileType python set omnifunc=pythoncomplete#Complete
imap <C-L> <C-x><C-o>
"根据文件类型选择加载的tag文件
if expand("%:e") == "py"
    set tags+=~/.vim/py_tags
    "设置supertab.vim的补全
    let g:SuperTabDefaultCompletionType="<C-X><C-O>"
    source ~/.vim/supertab.vim
elseif expand("%:e") == "c"
    set tags+=~/.vim/c_tags
elseif expand("%:e") == "cpp"
    set tags+=~/.vim/c_tags
    set tags+=~/.vim/cpp_tags
endif

"由于这个插件在编辑.py文件时有问题所以添加如下加载条件
if expand("%:e") != "py"
    source ~/.vim/snipMate.vim
endif

"pydiction 1.2 python auto complete
"filetype plugin on
"let g:pydiction_location='~/.vim/after/ftplugin/complete-dict'
"defalut g:pydiction_menu_height==15
"let g:pydiction_menu_height=8

map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> "自动生成tags文件


"关键字，注释等颜色设置
hi Comment ctermfg=darkgreen
hi PreProc ctermfg=blue
"======================================================== 
" Highlight All Function 
"======================================================== 
syn match   cFunction "\<[a-zA-Z_][a-zA-Z_0-9]*\>[^()]*)("me=e-2 
syn match   cFunction "\<[a-zA-Z_][a-zA-Z_0-9]*\>\s*("me=e-1 
hi cFunction        ctermfg=Cyan

"======================================================== 
" Highlight All Math Operator 
"======================================================== 
" C math operators 
syn match       cMathOperator     display "[-+\*%=]" 
"" C pointer operators 
syn match       cPointerOperator  display "->\|\.\|\:\:" 
" C logical   operators - boolean results 
syn match       cLogicalOperator  display "[!<>]=\=" 
syn match       cLogicalOperator  display "==" 
" C bit operators 
syn match       cBinaryOperator   display "\(&\||\|\^\|<<\|>>\)=\=" 
syn match       cBinaryOperator   display "\~" 
syn match       cBinaryOperatorError display "\~=" 
" More C logical operators - highlight in preference to binary 
syn match       cLogicalOperator  display "&&\|||" 
syn match       cLogicalOperatorError display "\(&&\|||\)=" 

" More C priority operators - highlight in preference to binary 
syn match       cpriorityperator  display "(\|)\|\[\|\]\|{\|}" 


" Math Operator 
hi cMathOperator            ctermfg=white
hi cPointerOperator         ctermfg=blue
hi cBinaryOperator          ctermfg=yellow
hi cBinaryOperatorError     ctermfg=yellow
hi cLogicalOperator         ctermfg=yellow
hi cLogicalOperatorError    ctermfg=yellow
"hi cpriorityperator	    ctermfg=blue

"inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>" 
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

"OmniCppComplete插件配置
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " 显示函数参数列表
let OmniCpp_MayCompleteDot = 1   " 输入 .  后自动补全
let OmniCpp_MayCompleteArrow = 1 " 输入 -> 后自动补全
let OmniCpp_MayCompleteScope = 1 " 输入 :: 后自动补全
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" 自动关闭补全窗口
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest
highlight   Pmenu     guibg=darkgrey  guifg=black 
highlight   PmenuSel  guibg=lightgrey guifg=black

"set tags+=~/.vim/tags


"doxygentoolkit.vim插件和快捷键配置
let g:DoxygenToolkit_authorName = "xiaok"
let g:DoxygenToolkit_licenseTag = "My license"
let g:DoxygenToolkit_compactOneLineDoc = "yes"
let g:doxygenToolkit_briefTag_funcName = "yes"
let g:DoxygenToolkit_briefTag_pre   = "@brief "
let g:DoxygenToolkit_briefTag_post  = "--- "
let g:DoxygenToolkit_paramTag_post  = ": "
"let g:DoxygenToolkit_blockHeader    = "=========================================================="
"let g:DoxygenToolkit_blockFooter    = "=========================================================="
"let g:DoxygenToolkit_blockHeader    = "---------------------------------------------------------"
"let g:DoxygenToolkit_blockFooter    = "---------------------------------------------------------"
let g:DoxygenToolkit_commentType    = "C"
"let g:DoxygenToolkit_commentType="C++"
"let g:DoxygenToolkit_briefTag_className="name"
"let g:DoxygenToolkit_returnTag="@Returns   "

map <F3>a :DoxAuthor<Enter>
map <F3>f :Dox<Enter>
map <F3>b :DoxBlock<Enter>
map <F3>c O/*  */<Left><Left><Left>


"config for vundle
set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/Vundle.vim'

" My bundles here:
"
" original repos on GitHub
"Bundle 'tpope/vim-rails.git'
Plugin 'Rykka/colorv.vim.git'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'davidhalter/jedi'

Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'plasticboy/vim-markdown'
Plugin 'scrooloose/nerdtree'
Plugin 'xuqix/h2cppx'
Plugin 'Yggdroot/indentLine'
" vim-scripts repos
"Bundle 'FuzzyFinder'
" non-GitHub repos
"Bundle 'git://git.wincent.com/command-t.git'
" Git repos on your local machine (i.e. when working on your own plugin)
"Bundle 'file:///Users/gmarik/path/to/plugin'
" ...

call vundle#end()

filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install (update) bundles
" :BundleSearch(!) foo - search (or refresh cache first) for foo
" :BundleClean(!)      - confirm (or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle commands are not allowed.


let g:indentLine_color_term = 6 "239
let g:indentLine_color_gui = '#A4E57E'
"let g:indentLine_char = '┆'   " '┆' '┊' '┆'

set tags+=~/.vim/cocos_tags

"YCM config!!!
let g:ycm_global_ycm_extra_conf = '~/.ycm_global_ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_error_symbol = '✗' "'>>'
let g:ycm_warning_symbol = '⚠' "'>*'
"let g:syntastic_always_populate_loc_list=1
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nmap <F5> :YcmDiags<CR>
"let g:syntastic_ignore_files=[".*\.py$"] "禁用py文件的语法检查
"let g:ycm_min_num_of_chars_for_completion=3

"syntastic config
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

"for ultisnip: Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

let g:h2cppx_postfix = '.cpp'
let g:h2cppx_template= 'template4'

"一些方便使用的快捷映射
"映射tt为复制一行(不包括换行符)
nmap    tt  y$

