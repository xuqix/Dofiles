"==============================================================================
"                          << ����Ϊ���Ĭ������ >>
"==============================================================================
set nocompatible
"source $VIMRUNTIME/vimrc_example.vim
source ~/.vim/plugin/mswin.vim    "win��C-c C-v����
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
"                          << ����Ϊ�û��Զ������� >>
"==============================================================================

"------------------------------------------------------------------------------
"  < �������� >
"------------------------------------------------------------------------------
"ע��ʹ��utf-8��ʽ����������Դ�롢�ļ�·�����������ģ����򱨴�
set encoding=utf-8                                    "gvim�ڲ�����
set fileencoding=utf-8                                "��ǰ�ļ�����
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1     "֧�ִ��ļ��ı���
"����˵�����
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
"���consle�������
language messages zh_CN.utf-8

"------------------------------------------------------------------------------
"  < �������� >
"------------------------------------------------------------------------------
set number                                            "��ʾ�к�
set laststatus=2                                      "����״̬����Ϣ
"set cmdheight=2                                       "���������еĸ߶�Ϊ2��Ĭ��Ϊ1
"colorscheme Tomorrow-Night-Bright
"colorscheme Tomorrow-Night
colorscheme Tomorrow-Night-Eighties                   "���ô�����ɫ����
"set cursorline                                        "ͻ����ʾ��ǰ��
"highlight CursorLine guibg=lightblue ctermbg=lightgray
set guifont=DejaVu_Sans_Mono:h10                      "��������:�ֺţ��������ƿո����»��ߴ��棩
set nowrap                                            "���ò��Զ�����
set shortmess=atI                                     "ȥ����ӭ����
"au GUIEnter * simalt ~x                              "��������ʱ�Զ����
"winpos 100 20                                         "ָ�����ڳ��ֵ�λ�ã�����ԭ������Ļ���Ͻ�
"set lines=45 columns=120                              "ָ�����ڴ�С��linesΪ�߶ȣ�columnsΪ���

"���Ի�״�����������ļ��������ʾ��ȥ��ע�ͼ��ɣ�
set statusline=%F%m%r%h%w\ %=%{\"\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"\"}\ \|\ %l,%v\ \|\ %p%%

"��ʾ/���ز˵������������������������� Ctrl + F11 �л�
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
"  < ��д�ļ�ʱ������ >
"------------------------------------------------------------------------------
set expandtab                                         "��tab��ת��Ϊ�ո�
set tabstop=4                                         "����tab���Ŀ��
set shiftwidth=4                                      "����ʱ�Զ�����4���ո�
set backspace=2                                       "�����˸������
set smarttab                                          "ָ����һ��backspace��ɾ��4���ո�
"set foldenable                                        "�����۵�
"set foldmethod=marker                                 "marker �۵���ʽ
"set foldmethod=indent                                 "indent �۵���ʽ
"�ÿո���������۵�
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
"��ʱʹ��
set mouse=a
set hlsearch
set autoindent
set smartindent
set cindent


"����ģʽ������ cs �����β�ո�
"nmap cs :%s/\s\+$//g<cr>:noh<cr>
"����ģʽ������ cm �����β ^M ����
"nmap cm :%s/^M$//g<cr>:noh<cr>

set ignorecase                                        "����ģʽ����Դ�Сд
set smartcase                                         " �������ģʽ������д�ַ�����ʹ�� 'ignorecase' ѡ�ֻ������������ģʽ���Ҵ� 'ignorecase' ѡ��ʱ�Ż�ʹ��
"set noincsearch                                       "������Ҫ����������ʱ��ȡ��vimʵʱƥ��

" Ctrl + K ����ģʽ�¹�������ƶ�
"imap <c-k> <Up>
" Ctrl + J ����ģʽ�¹�������ƶ�
"imap <c-j> <Down>
" Ctrl + H ����ģʽ�¹�������ƶ�
"imap <c-h> <Left>
" Ctrl + L ����ģʽ�¹�������ƶ�
"imap <c-l> <Right>

"ÿ�г���80�����ַ����»��߱�ʾ
"au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 80 . 'v.\+', -1)

"------------------------------------------------------------------------------
"  < ���롢���ӡ��������� >
"------------------------------------------------------------------------------
" F9 һ�����桢���Ӵ沢����
map <F9> :call Link_Run()<CR>
map <F9> <ESC>:call Link_Run()<CR>

" Ctrl + F9 һ�����沢����
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
            "exec "!./%<"       "ִ���ļ�
        endif
        redraw!
        echohl WarningMsg | echo " running finish"
    else
        echohl WarningMsg | echo "please choose the correct source file"
    endif
    setlocal makeprg=make
endfunc

"------------------------------------------------------------------------------
"  < �������� >
"------------------------------------------------------------------------------
set writebackup                             "������д�뱸��
set nobackup                                "�����ޱ����ļ�
"set noswapfile                              "��������ʱ�ļ�
set vb t_vb=                                "�ر���ʾ��


"==============================================================================
"                          << ����Ϊ���ò������ >>
"==============================================================================

"------------------------------------------------------------------------------
"  < ctags ������� >
"------------------------------------------------------------------------------
"���������ǳ��ķ���,�����ں���,����֮����ת��
set tags=./tags;                            "���ϼ�Ŀ¼�ݹ����tags�ļ�

"------------------------------------------------------------------------------
"  < cscope ������� >
"------------------------------------------------------------------------------
"��Cscope�Լ��Ļ�˵ - "����԰��������ǳ���Ƶ��ctags"
set cscopequickfix=s-,c-,d-,i-,t-,e-        "���趨�Ƿ�ʹ�� quickfix ��������ʾ cscope ���

if has("cscope")
    "ʹ֧���� Ctrl+]  �� Ctrl+t ��ݼ��ڴ������ת
    set cscopetag
    "������뷴������˳������Ϊ1
    set csto=0
    "�ڵ�ǰĿ¼������κ����ݿ�
    if filereadable("cscope.out")
        cs add cscope.out
    "����������ݿ⻷������ָ����
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set cscopeverbose
    "��ݼ�����
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
"  < TagList ������� >
"------------------------------------------------------------------------------
"��Ч�����Դ��, �书�ܾ���vc�е�workpace 
"�������г��˵�ǰ�ļ��е����к�,ȫ�ֱ���, ��������

"����ģʽ������ tl ���ò��
nmap tl :Tlist<cr>
let Tlist_Show_One_File=1                   "ֻ��ʾ��ǰ�ļ���tags
"let Tlist_Enable_Fold_Column=0              "ʹtaglist�������ʾ��ߵ��۵���
let Tlist_Exit_OnlyWindow=1                 "���Taglist���������һ���������˳�Vim
let Tlist_File_Fold_Auto_Close=1            "�Զ��۵�
let Tlist_WinWidth=25                       "���ô��ڿ��
"let Tlist_Use_Right_Window=1                "���Ҳര������ʾ

"------------------------------------------------------------------------------
"  < Tagbar ������� >
"------------------------------------------------------------------------------
"��� TagList �ܸ��õ�֧���������

"����ģʽ������ tb ���ò��
nmap tb :TagbarToggle<cr>
let g:tagbar_width = 25                     "���ô��ڿ��

"------------------------------------------------------------------------------
"  < WinManager ������� >
"------------------------------------------------------------------------------
"�����������, ����˵���ϸ�������

"����ģʽ������ wm ���ò��
nmap wm :WMToggle<cr>
"�����������Ϊ�������, ��'FileExplorer|TagList'
let g:winManagerWindowLayout='FileExplorer|TagList'

let g:persistentBehaviour=0                 "ֻʣһ������ʱ, �˳�vim
let g:winManagerWidth=10                    "���ô��ڿ��

"------------------------------------------------------------------------------
"  < MiniBufExplorer ������� >
"------------------------------------------------------------------------------
"��������Ͳ���Buffer 
"��Ҫ����ͬʱ�򿪶���ļ��������л�
"let g:miniBufExplMapWindowNavArrows = 1     "��Ctrl�ӷ�����л����������ҵĴ�����ȥ
let g:miniBufExplMapWindowNavVim = 1        "��<C-k,j,h,l>�л����������ҵĴ�����ȥ
let g:miniBufExplMapCTabSwitchBufs = 1      "������ǿ <C-Tab> ��ǰѭ���л���ÿ��buffer��,���ڵ�ǰ���ڴ�
"                                                     <C-S-Tab> ���ѭ���л���ÿ��buffer��,���ڵ�ǰ���ڴ�

"------------------------------------------------------------------------------
"  < NERD_commenter ������� >
"------------------------------------------------------------------------------
"��Ҫ����C/C++����ע��(������Ҳ��)
"����Ϊ���Ĭ�Ͽ�ݼ�
"<Leader>ci ��ÿ��һ�� /* */ ע��ѡ����(ѡ������������)����������ȡ��ע��
"<Leader>cm ��һ�� /* */ ע��ѡ����(ѡ������������)������������ظ�ע��
"<Leader>cc ��ÿ��һ�� /* */ ע��ѡ������
"<Leader>cu ȡ��ѡ������(��)��ע�ͣ�ѡ������(��)��������һ�� /* */
"<Leader>ca ��/*...*/��//������ע�ͷ�ʽ���л�

"------------------------------------------------------------------------------
"  < vimtweak ������� >
"------------------------------------------------------------------------------
"����ֻ���ڴ���͸�����ö�
"����ģʽ�� Shift + k ��С͸���ȣ�Shift + j ����͸���ȣ�<Leader>t �����ö�����л�

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
"��ݼ�����
"map <s-k> :call Alpha_add()<cr>
"map <s-j> :call Alpha_sub()<cr>
"map <leader>t :call Top_window()<cr>

"------------------------------------------------------------------------------
"  < gvimfullscreen ������� >
"------------------------------------------------------------------------------
"����ȫ�����ڣ����� F11 �л�
"ȫ���������ز˵�������������������Ч������
map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>

"------------------------------------------------------------------------------
"  < indent_guides ������� >
"------------------------------------------------------------------------------
"������ʾ������
"Ĭ�ϼ���ӳ��Ϊ <leader>ig
let g:indent_guides_guide_size=1            "���ö����߿��Ϊ1

"------------------------------------------------------------------------------
"  < omnicppcomplete ������� >
"------------------------------------------------------------------------------
"����C/C++���벹ȫ�����ֲ�ȫ��Ҫ��������ռ䡢�ࡢ�ṹ����ͬ��Ƚ��в�ȫ����ϸ
"˵�����Բο�����������̵̳�
"ʹ��ǰ��ִ������ ctags ����
"ctags -R --c++-kinds=+p --fields=+iaS --extra=+q
"��ʹ������Ĳ������ɱ�ǩ�󣬶Ժ���ʹ����תʱ����ֶ��ѡ��
"�����Ҿͽ�--c++-kinds=+p������ȥ���ˣ����������ʲô�����������ϣ����Ҫ����ѽ
set completeopt=menu                        "�ر�Ԥ������

"------------------------------------------------------------------------------
"  < snipMate ������� >
"------------------------------------------------------------------------------
"���ڸ��ִ��벹ȫ�����ֲ�ȫ��һ�ֶԴ����еĴ����������д��ȫ����ϸ�÷����Բ�
"��ʹ��˵��������̵̳ȡ�������ʱ��Ҳ���� supertab ����ڲ�ȫʱ������ͻ�������
"����ʲô�����������ϣ����Ҫ����ѽ

"------------------------------------------------------------------------------
"  < supertab ������� >
"------------------------------------------------------------------------------
"����Ҫ������� omnicppcomplete ������ڰ� Tab ��ʱ�Զ���ȫЧ�����ø���

"------------------------------------------------------------------------------
"  < a.vim ������� >
"------------------------------------------------------------------------------
"�����л�C/C++ͷ�ļ�
":A     ---�л�ͷ�ļ�����ռ��������
":AV    ---�л�ͷ�ļ�����ֱ�ָ��
":AS    ---�л�ͷ�ļ���ˮƽ�ָ��
nnoremap <silent> <F4> :A<CR>

"------------------------------------------------------------------------------
"  < txtbrowser ������� >
"------------------------------------------------------------------------------
"�����ı��ļ����ɱ�ǩ�����﷨����������TagList������ɱ�ǩ��������ԣ�
au BufEnter *.txt setlocal ft=txt

"------------------------------------------------------------------------------
"  < visualmark ������� >
"------------------------------------------------------------------------------
"�������ɱ�ǩ(����Ctrl + F2)
"F2 ���������ǩ��Shift + F2���������ǩ 

"------------------------------------------------------------------------------
"  < auto-pairs ������� >
"------------------------------------------------------------------------------
"���������������Զ���ȫ���������뺯��ԭ����ʾ���echofunc��ͻ
"�����Ҿ�û�м���echofunc���

"------------------------------------------------------------------------------
"  < echofunc ������� >
"------------------------------------------------------------------------------
"���Ų�ȫ�Ƚϼ��ߣ��������������

"------------------------------------------------------------------------------
"  < ���� >
"------------------------------------------------------------------------------
"ע�����������е�"<Leader>"�ڱ����������Ϊ"\"����������ķ�б�ܣ����� <Leader>t ָ��
"����ģʽ�°�"\"����"t"�������ﲻ��ͬʱ���������Ȱ�"\"����"t"���������һ����


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
"-i���Դ�Сд
"nnoremap <silent> <F3> :grep -i<CR> 

"ctags -R --c++-kinds=+px --fields=+ialS --extra=+q
"set tags+=d:\inc_tags				"ddk��tag�ļ�

autocmd FileType * setlocal formatoptions-=cro "ȡ���Զ�ע��

"����python���벹ȫ
filetype plugin on	"����
filetype plugin indent on "���Զ�����
"autocmd FileType python set omnifunc=pythoncomplete#Complete
imap <C-L> <C-x><C-o>
"�����ļ�����ѡ����ص�tag�ļ�
if expand("%:e") == "py"
    set tags+=~/.vim/py_tags
    "����supertab.vim�Ĳ�ȫ
    let g:SuperTabDefaultCompletionType="<C-X><C-O>"
    source ~/.vim/supertab.vim
elseif expand("%:e") == "c"
    set tags+=~/.vim/c_tags
elseif expand("%:e") == "cpp"
    set tags+=~/.vim/c_tags
    set tags+=~/.vim/cpp_tags
endif

"�����������ڱ༭.py�ļ�ʱ����������������¼�������
if expand("%:e") != "py"
    source ~/.vim/snipMate.vim
endif

"pydiction 1.2 python auto complete
"filetype plugin on
"let g:pydiction_location='~/.vim/after/ftplugin/complete-dict'
"defalut g:pydiction_menu_height==15
"let g:pydiction_menu_height=8

map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> "�Զ�����tags�ļ�


"�ؼ��֣�ע�͵���ɫ����
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

"OmniCppComplete�������
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " ��ʾ���������б�
let OmniCpp_MayCompleteDot = 1   " ���� .  ���Զ���ȫ
let OmniCpp_MayCompleteArrow = 1 " ���� -> ���Զ���ȫ
let OmniCpp_MayCompleteScope = 1 " ���� :: ���Զ���ȫ
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" �Զ��رղ�ȫ����
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest
highlight   Pmenu     guibg=darkgrey  guifg=black 
highlight   PmenuSel  guibg=lightgrey guifg=black

"set tags+=~/.vim/tags


"doxygentoolkit.vim����Ϳ�ݼ�����
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

"ӳ��ttΪ����һ��(���������з�)
nmap    tt  y$


"config for vundle
set nocompatible              " be iMproved
filetype off                  " required!

"set rtp+=~/.vim/bundle/vundle/
"call vundle#rc()

" let Vundle manage Vundle
" required! 
"Bundle 'gmarik/vundle'

" My bundles here:
"
" original repos on GitHub
"Bundle 'tpope/vim-rails.git'
"Bundle 'Rykka/colorv.vim.git'
" vim-scripts repos
"Bundle 'FuzzyFinder'
" non-GitHub repos
"Bundle 'git://git.wincent.com/command-t.git'
" Git repos on your local machine (i.e. when working on your own plugin)
"Bundle 'file:///Users/gmarik/path/to/plugin'
" ...


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
