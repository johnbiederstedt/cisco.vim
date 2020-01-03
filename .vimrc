set encoding=utf-8
set nocompatible              " be iMproved, required
"filetype off                  " required
filetype plugin indent on    " required

" --history
set history=50    " history of commands and searches
set undolevels=50 " changes to be remembered

set backspace=start,indent,eol  " make backspace work like 'normal' text editors
"map! ;; <Esc>

" save global variables that consists of upper case letters
set viminfo+=!

set hlsearch   " highlight search terms
set incsearch  " show matches as they are found
"set ignorecase
set smartcase

"set nobackup
"set nowritebackup
"set noswapfile

syntax enable
set smartindent
set softtabstop=4
set shiftwidth=4
set expandtab
set shiftround
set wildmenu
set lazyredraw
set background=dark

set t_Co=256
" in case t_Co alone doesn't work, add this as well:
let &t_AB="\e[48;5;%dm"
let &t_AF="\e[38;5;%dm"
function Setdark()
    let g:gigamon_background=""
    let g:cisco_background=""
    set background=dark
endfunction

function Setlight()
    let g:gigamon_background="light"
    let g:cisco_background="light"
    set background=light
endfunction


if has("gui_running")
    nnoremap <C-q> <C-v>
    " normal copy/paste
    nnoremap <C-c> "+y
    inoremap <C-c> "+y
    nnoremap <C-v> "+gP
    inoremap <C-v> <ESC>"+gPi
    vmap <C-c> y<Esc>i
    vmap <C-x> d<Esc>i
    "imap <C-v> <Esc>pi
    "imap <C-y> <Esc>ddi
    "map <C-z> <Esc>
    "imap <C-z> <Esc>ui
    "
    let g:solarized_termcolors=256
    let g:solarized_termtrans=1
    let g:solarized_contrast="high"    "default value is normal
    let g:solarized_visibility="high"    "default value is normal
    "let g:solarized_degrade=1
    set background=dark
    colorscheme john
    set lines=48 columns=128
    if has("gui_gtk2")
        set guifont=Pointfree\ 13
"    elseif has("x11")
"        set guifont="-bitstream-bitstream vera sans mono-medium-r-normal-*-*-120-*-*-c-*-*-*"
    else
        set guifont=Bitstream_vera_sans_mono:h10:cDEFAULT
    endif
else " no gui, terminal mode
    if $TERM == 'rxvt'
        call Setlight()
        let g:cisco_background="grey"
    else
        call Setdark()
        let g:cisco_background="dark"
    endif
    let g:solarized_contrast="high"
    colorscheme john
endif 

set ruler

"<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<,
" V U N D L E
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'luochen1990/rainbow'
Plugin 'davidhalter/jedi-vim'
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle

Plugin 'jaxbot/semantic-highlight.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"
"
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
"
" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Track the engine.
"Plugin 'SirVer/ultisnips'

let g:UltiSnipsUsePythonVersion = 2
set runtimepath+=~/.vim/bundle/ultisnips
"
" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'
"
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<C-o>"
let g:UltiSnipsJumpForwardTrigger="<C-b>"
let g:UltiSnipsJumpBackwardTrigger="<C-z>"
"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"" Where snippets are
let g:UltiSnipsSnippetDirectories=["UltiSnips", "vim-snippets"]

Plugin 'tmhedberg/SimpylFold'
" if you want to enable previewing of your folded classes' and functions'
" docstrings in the fold textif you want to enable previewing of your folded
" classes' and functions' docstrings in the fold text
let g:SimpylFold_docstring_preview = 1

" if you don't want to see your docstrings folded
let g:SimpylFold_fold_docstring = 0

"if you don't want to see your imports foldedif you don't want to see your
"imports folded
let g:SimpylFold_fold_import = 0

"Plugin 'ervandew/supertab'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

Plugin 'alvan/vim-closetag'
" filenames like *.xml, *.html, *.xhtml, ...
" Then after you press > in these files, this plugin will try to close the current tag.
"
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non closing tags self closing in the specified files.
"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

" integer value [0|1]
" This will make the list of non closing tags case sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
"
"let g:closetag_emptyTags_caseSensitive = 1

" Shortcut for closing tags, default is '>'
"
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
"
let g:closetag_close_shortcut = '<leader>>'
" two commas will jump you past the closing tag
inoremap ,, <ESC>vat<ESC>a<ESC>o

"Plugin 'vim-pandoc/vim-pandoc'
"Plugin 'vim-pandoc/vim-pandoc-syntax'

"Plugin 'w0rp/ale'
Plugin 'Valloric/YouCompleteMe'

Plugin 'ColinKennedy/vim-python-function-expander'
"Bundle 'chase/vim-ansible-yaml'
Plugin 'MicahElliott/Rocannon'
Plugin 'pearofducks/ansible-vim'
let g:ansible_unindent_after_newline = 1
let g:ansible_yamlKeyName = 'yamlKey'
let g:ansible_attribute_highlight = "ob"
" 'd' for dim 'b' for bright
let g:ansible_name_highlight = 'b'
let g:ansible_extra_keywords_highlight = 1
let g:ansible_normal_keywords_highlight = 'Constant'
let g:ansible_with_keywords_highlight = 'Constant'
let g:ansible_template_syntaxes = { '*.rb.j2': 'ruby' }


" All of your Plugins must be added before the following line
call vundle#end()            " required
">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

execute pathogen#infect()
"
" P O W E R L I N E
" \/\/\/\/\/\/\/\/\/
"python from powerline.vim import setup as powerline_setup
"python powerline_setup()
"python del powerline_setup
"set rtp+=/home/john/.vim/powerline/build/lib.linux-x86_64-2.7/powerline/bindings/vim

" S Y N T A S T I C
" /\/\/\/\/\/\/\/\/\
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

"To tell syntastic to use pylint, you would use this setting:
"let g:syntastic_python_checkers=['pylint']
let g:syntastic_python_checkers=['flake8']
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=5
"let g:syntastic_rst_checkers = ['sphinx_build']
"let g:syntastic_python_pylint_args="--disable=W"
"let g:syntastic_python_checker_args="--ignore=F401,E302,E303,E221,E501"
let g:syntastic_quiet_messages = {'regex': 'W\|116\|122\|127\|128\|221\|222\|266\|302\|303\|305\|401\|402\|403\|405\|501\|701\|702\|711\|741\|811\|841'}
"let g:syntastic_quiet_messages = { 'regex': '[EF]401\|E30[235]\|E2[21]1\|E501\|E2[35]1\|E2[76]1\|E999\|W[23]91\|E701\|W293\|E222\|E265\|E228\|E20[12]\|F40[35]'  }
"let g:pymode_lint_ignore = "E401,W0611,E221,W605,E501,E302,E305,E303"

let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_always_populate_loc_list = 1

let g:syntastic_cpp_checkers = ['gcc']

let g:syntastic_auto_jump = 1
let g:syntastic_enable_balloons = 1

let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = '-std=c++11 -Wall -Wextra'

let g:syntastic_aggregate_errors = 1

let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_auto_refresh_includes = 1

"let b:syntastic_cpp_cflags = '-I/home/user/dev/cpp/boost_1_55_0'
let g:syntastic_cpp_include_dirs = [ 
            \ '/opt/boost_1_55_0',
            \ '/opt/cryptopp-5.6.2',
            \ '/opt/llvm_install/include/llvm',
            \ '/opt/llvm_install/include/clang' ]


" Y O U C O M P L E T E M E
" \/\/\/\/\/\/\/\/\/\/\/\/\

let g:ycm_register_as_syntastic_checker = 1

let g:ycm_register_as_syntastic_checker = 1 "default 1
let g:Show_diagnostics_ui = 1 "default 1

"will put icons in Vim's gutter on lines that have a diagnostic set.
"Turning this off will also turn off the YcmErrorLine and YcmWarningLine
"highlighting
let g:ycm_enable_diagnostic_signs = 1
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_always_populate_location_list = 1 "default 0
let g:ycm_open_loclist_on_ycm_diags = 1 "default 1

let g:ycm_complete_in_strings = 1 "default 1
let g:ycm_collect_identifiers_from_tags_files = 0 "default 0
let g:ycm_path_to_python_interpreter = '' "default ''

let g:ycm_server_use_vim_stdout = 0 "default 0 (logging to console)
let g:ycm_server_log_level = 'info' "default info


let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'  "where to search for .ycm_extra_conf.py if not found
let g:ycm_confirm_extra_conf = 1

let g:ycm_goto_buffer_command = 'same-buffer' "[ 'same-buffer', 'horizontal-split', 'vertical-split', 'new-tab' ]
let g:ycm_filetype_whitelist = { '*': 1 }
let g:ycm_key_invoke_completion = '<C-Space>'
let g:ycm_server_log_level = 'critical'

nnoremap <F11> :YcmForceCompileAndDiagnostics <CR>

" F O L D I N G
" \/\/\/\/\/\/\/
fu! CustomFoldText()
    "get first non-blank line
    let fs = v:foldstart
    while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
    endwhile
    if fs > v:foldend
        let line = getline(v:foldstart)
    else
        let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
    endif

    let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
    let foldSize = 1 + v:foldend - v:foldstart
    let foldSizeStr = " " . foldSize . " lines "
    let foldLevelStr = repeat("+ - - - ", v:foldlevel)
    let lineCount = line("$")
    let foldPercentage = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
    let expansionString = repeat(" . ",(w-strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))/3)
    return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endfunction

set foldtext=CustomFoldText()
set foldmethod=marker


" uncomment if you want changes in .vimrc to take effect immediately
" use with great caution - ONE TYPO AND VIM MAY BREAK!
" Included for amusement purposes only
"autocmd! bufwritepost .vimrc source %

function! Term()
    let g:ycm_auto_trigger=0
    execute ':set clipboard=unnamed'
    execute ':set clipboard=unnamed'
    execute ':ConqueTerm screen -c ~/.screenrcnull'
endfunction

function! Cisco(port, host)
    let g:ycm_auto_trigger=0
    execute ':set clipboard=unnamed'
    let &titlestring=a:host
    set title
    let command = ":ConqueTerm screen -c ~/.screenrcnull telnet localhost " . a:port
    execute command
endfunction

" K  E  Y     M  A  P  P  I  N  G  S
"
let mapleader=","
let maplocalleader="\\"
noremap <C-n> :nohl<CR>
noremap <C-z> :update<CR>
vnoremap <C-z> <C-C>:update<CR>
inoremap <C-z> <C-O>:update<CR>

"noremap <Leader>e :quit<CR>
"noremap <Leader>E :qa!<CR>
"vnoremap <Leader>s :sort<CR>

"block indentations
vnoremap < <gv
vnoremap > >gv
inoremap <c-u> <ESC>viwUi
inoremap <C-b> <ESC>:resize +1<CR>i
noremap <C-b> :resize +1<CR>
"inoremap <tab> <c-r>=InsertTabWrapper()<cr>

noremap <C-U>:call Setdark()<CR>
inoremap <C-U><ESC>:call Setdark()<CR>i

nnoremap <C-W>s :syntax enable
inoremap <C-w>t <ESC>:ConqueTerm screen -c ~/.screenrcnull<CR>
nnoremap <C-w>t :ConqueTerm screen -c ~/.screenrcnull<CR>
inoremap <C-W>c <ESC>:set filetype=cisco<CR>
nnoremap <C-W>c :set filetype=cisco<CR>
inoremap <C-w><C-w> <ESC><C-w>wi
"inoremap <C-W><C-W> <ESC><C-w>w

inoremap <C-1> <ESC><C-w><i
inoremap <C-2> <ESC><C-w>>i
noremap <C-1> <C-w><
noremap <C-2> <C-w>>

" map space to html tag completion 
":iabbrev </ </<C-X><C-O>
inoremap <C-]> <C-x><C-o>

" Function Keys
"
inoremap <F1> <ESC>:w<CR>i
noremap <F1> :w<CR>

"inoremap <F2> <ECS>:tabnew<CR>i
"noremap <F2> :tabnew<CR>

nnoremap <F2> "=strftime("- %m/%d/%y %H:%M: ")<CR>P
inoremap <F2> <C-R>=strftime("- %m/%d/%y %H:%M: ")<CR>

"inoremap <F3> <ESC>:let g:cisco_background="grey"<CR>:set background=dark<CR>i
"noremap <F3> <ESC>:let g:cisco_background="grey"<CR>:set background=dark<CR>

"inoremap <F3> <ESC>?sho run<CR>jvGy:tabnew<CR>p
"nnoremap <F3>  ?sho runjvGy:tabnewp/switchnamew"byw:w b-=strftime("%Y%m%d%H%M").cfg
"inoremap <F3>  <ESC>?sho runjvGy:tabnewp/switchname\\|hostnamew"byw:w b-=strftime("%Y%m%d%H%M").cfg
"nnoremap <F3>  ?sho runjvGy:tabnewp/switchname\\|hostnamew"byw:w b-=strftime("%Y%m%d%H%M").cfg

inoremap <F3> <ESC>:SyntasticReset<CR>
noremap <F3> :SyntasticReset<CR>

"inoremap <F4> <ESC><C-w>wi
"noremap <F4> <C-w>w

inoremap <F5> <C-O>za
nnoremap <F5> za
onoremap <F5> <C-C>za
vnoremap <F5> zf

noremap <F6> :call Term()<CR>
noremap <C-y> :call Term()<CR>

inoremap <F7> <ESC>:set filetype=cisco<CR>i
inoremap <C-u> <ESC>:set filetype=cisco<CR>i
noremap <F7> :set filetype=cisco<CR>
noremap <C-u> :set filetype=cisco<CR>

inoremap <F8> :TagbarToggle<CR>
noremap <F8> :TagbarToggle<CR>

"noremap <F8> <ESC>:qall!<CR>
"inoremap <F8> <ESC>:qall!<CR>

"inoremap <F9> <C-O>za
"nnoremap <F9> za
"onoremap <F9> <C-C>za
"vnoremap <F9> zf

inoremap <F10> <ESC>:set filetype=gigamon<CR>i
noremap <F10> :set filetype=gigamon<CR>

inoremap <F11> <ESC>:tabp<CR>
noremap <F11> <ESC>:tabp<CR>

inoremap <F12> <ESC>:tabn<CR>

noremap <F12> <ESC>:tabn<CR>


"source ~/.vim/scripts/closetag.vim

" ConqueTerm options
let g:ConqueTerm_InsertOnEnter = 1
let g:ConqueTerm_TERM = 'vt100'
let g:ConqueTerm_CloseOnEnd = 1
let g:ConqueTerm_InsertOnEnter = 1
let g:ConqueTerm_SendVisKey = '<F9>'
hi Folded term=NONE cterm=NONE gui=NONE

" indent guides
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
au! FileType python setl nosmartindent

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS


    ""\   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
let g:rainbow_conf = {
    \   'guifgs': ['cyan', 'magenta', 'yellow', 'red', 'lime', 'orange'],
    \   'ctermfgs': ['033', '196', '051', '201', '046', '226', '129'],
    \   'operators': '_,_',
    \   'parentheses': [['(',')'], ['\[','\]'], ['{','}']],
    \   'separately': {
    \       '*': {},
    \       'lisp': {
    \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
    \           'ctermfgs': ['darkgray', 'darkblue', 'darkmagenta', 'darkcyan', 'darkred', 'darkgreen'],
    \       },
    \       'vim': {
    \           'parentheses': [['fu\w* \s*.*)','endfu\w*'], ['for','endfor'], ['while', 'endwhile'], ['if','_elseif\|else_','endif'], ['(',')'], ['\[','\]'], ['{','}']],
    \       },
    \       'tex': {
    \           'parentheses': [['(',')'], ['\[','\]'], ['\\begin{.*}','\\end{.*}']],
    \       },
    \       'css': 0,
    \       'stylus': 0,
    \   }
    \}

"au filetype html inoremap <F2> <ESC><Right>a

"let g:jedi#auto_initialization = 0
"let g:jedi#auto_vim_configuration = 0
autocmd FileType python setlocal completeopt-=preview

" blur is a local script that calls xprob to apply alpha blurring to konsole
":call system('blur')

set guioptions-=T


function! Incr()
  let a = line('.') - line("'<")
  let c = virtcol("'<")
  if a > 0
    execute 'normal! '.c.'|'.a."\<C-a>"
  endif
  normal `<
endfunction
vnoremap <C-a> :call Incr()<CR>

if &diff
    "set diffopt=filler,context:1000000
    set foldmethod=indent
    if has("gui_running")
        " GUI is running or is about to start.
        " Maximize gvim window (for an alternative on Windows, see simalt below).
        set columns=132
    endif
endif

"let delimitMate_expand_cr = 1
"let delimitMate_balance_matchpairs = 1
""let delimitMate_smart_matchpairs = '^\%(\w\|\!\|[Â£$]\|[^[:punct:][:space:]]\)'
"let delimitMate_apostrophes = ''
"let delimitMate_apostrophes_list = []
"let delimitMate_autoclose = 1
"let delimitMate_balance_matchpairs = 1
"let delimitMate_eol_marker = ''
"let delimitMate_excluded_regions = 'Comment'
"let delimitMate_excluded_regions_enabled = 1
"let delimitMate_excluded_regions_list = ['Comment']
"let delimitMate_expand_cr = 1
"let delimitMate_expand_inside_quotes = 1
"let delimitMate_expand_space = 1
"let delimitMate_insert_eol_marker = 1
"let delimitMate_jump_expansion = 1
"let delimitMate_left_delims = ['(', '{', '[']
"let delimitMate_matchpairs = '(:),{:},[:]'
"let delimitMate_matchpairs_list = [['(', ')'], ['{', '}'], ['[', ']']]
"let delimitMate_nesting_quotes = ['"','`']
"let delimitMate_quotes = '" '' `'
"let delimitMate_quotes_list = ['"', '''', '`']
"let delimitMate_right_delims = [')', '}', ']']
"let delimitMate_smart_matchpairs = '^\%(\w\|\!\|[Â£$]\|[^[:punct:][:space:]]\)'
""let delimitMate_smart_quotes = '\%(\w\|[^[:punct:][:space:]"''`]\|\%(\\\\\)*\\\)\%#\|\%#\%(\w\|[^[:space:][:punct:]"''`]\)'
""let delimitMate_smart_quotes = '\%(\w\|[^[:punct:][:space:]]\|\%(\\\\\)*\\\)\%#\|\%#\%(\w\|[^[:space:][:punct:]]\)'
"let delimitMate_smart_quotes = '\%(\w\|[^[:punct:][:space:]]\|\%(\\\\\)*\\\)\%#\|\%#\%(\w\|[^[:space:][:punct:]]\)'
""let delimitMate_smart_quotes = '\w'
"let delimitMate_tab2exit = 1
"let g:delimitMate_excluded_ft = ''

"=======================================================================================
"
"no more drinking and computing
"let @a = '^wwwwistrwwwww€krdwdwi bbbbvw€kl€kly$a/""" + pa.prefixlen + '
"let @a = '^wwwwxxxxwdwdwdwdwdwdwdwdwdwdwdws.with_prefixlen +'
noremap <F2> @a

let g:jedi#popup_on_dot = 1
let g:jedi#popup_select_first = 1
let g:jedi#use_tabs_not_buffers = 1
let g:jedi#show_call_signatures = "2"


function! Demo()
  let curline = getline('.')
  call inputsave()
  let name = input('Enter name: ')
  call inputrestore()
  call setline('.', curline . ' ' . name)
endfunction

let g:semanticGUIColors = ["#9CD8F7", "#F5FA1D", "#F97C65", "#EB75D6", "#E5D180", "#D49DA5", "#F6B223", "#B4F1C3", "#99B730", "#F67C1B", "#EAAFF1", "#DE9A4E", "#BBEA87", "#EEF06D", "#EAA481", "#F58AAE", "#B5A5C5", "#EDD528", "#FA6BB2", "#F47F86", "#B8E01C", "#C5A127", "#D386F1", "#97DFD6", "#B1A96F", "#97AA49", "#EF874A", "#C0AE50", "#D7D1EB", "#B5AF1B", "#B7A5F0", "#D38AC6", "#C8EE63", "#ED9C36", "#9DEA74", "#EEA3C2", "#D8A66C", "#C4CE64", "#EA8C66", "#D2D43E", "#E5BCE8", "#E4B7CB", "#B092F4", "#D1E998", "#E19392", "#A8E5A4", "#BF9FD6", "#E8C25B", "#94C291", "#E8D65C", "#A7EA38", "#D38AE0", "#ECF453", "#B6BF6B", "#BEE1F1", "#B1D43E", "#EBE77B", "#CFEF7A", "#A3C557", "#E4BB34", "#ECB151", "#BDC9F2", "#E09764", "#9BE3C8", "#B3ADDC", "#B2AC36", "#C8CD4F", "#C797AF", "#DCDB26", "#BCA85E", "#E495A5", "#F37DB8", "#E49482", "#B3EDEE", "#DAEE34", "#EBD646", "#ECA2D2", "#A0A7E6", "#C098BF", "#F1882E", "#D4951F", "#A5C0D0", "#B892DE", "#F8CB31", "#A6A0B4", "#EA98E4", "#F38BE6", "#DC83A4"]
let g:semanticUseBackground = 1
let g:semanticTermColors = [1, 2, 3, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]

let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutBackInsert = '<C-p>'

function! ConvertExcelVars()
    execute ':%s/\vFormulas!B2([^0-9])/Datacenter\1/g'
    execute ':%s/Formulas!B3/tenant_ID/g'
    execute ':%s/Formulas!B4/Provider/g'
    execute ':%s/Formulas!B5/Zone/g'
    "execute ':%s/Formulas!B6/instance_number/g'
    "execute ':%s/Formulas!B8/uplink01_vlan/g'
    "execute ':%s/Formulas!B9/uplink02_vlan/g'
    "execute ':%s/Formulas!B11/tenant_octet3/g'
    "execute ':%s/Formulas!B12/tenant_octet4/g'
    "execute ':%s/Formulas!B13/tenant_netmask/g'
    execute ':%s/Formulas!B16/tenant_number/g'
    "execute ':%s/Formulas!B19/f5_3rd_octet/g'
    "execute ':%s/Formulas!B20/f5_4th_octet/g'
    execute ':%s/&/ + /g'
endfunction
noremap <Space>c :call ConvertExcelVars()<CR>

function! Get_visual_selection()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction
inoremap <F9> <ESC>:let this = Get_visual_selection()<CR>

" for vim-quickhl
nmap <Space>m <Plug>(quickhl-manual-this)
xmap <Space>m <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)

nmap <Space>j <Plug>(quickhl-cword-toggle)
nmap <Space>] <Plug>(quickhl-tag-toggle)
map H <Plug>(operator-quickhl-manual-this-motion)

set noshowmode
":source .vim/plugin/matchit.vim 

function! NextChange()
    while search('^.*', 'w') > 0
        if synIDattr(diff_hlID(line('.'),col('.')), 'name') is# 'DiffAdd'
            break
        endif
    endwhile
endfunction

com! NextChange :call NextChange()
noremap ]a :NextChange<CR>

colorscheme john

let g:airline_powerline_fonts = 0
let g:airline_theme='simple'

inoremap <F1> <ESC>:w<CR>i
set mouse=a
noremap <F4> :call SubnetSearch()<CR>/<CR>
inoremap <F4> <ESC>:call SubnetSearch()<CR>/<CR>i

" Add argument (can be negative, default 1) to global variable i.
" Return value of i before the change.
"function Inc(...)
"  let result = g:i
"  let g:i += a:0 > 0 ? a:1 : 1
"  return result
"endfunction
let g:airline#extensions#ale#enabled = 1
"let g:pymode_python = 'python'
"let g:pymode_options_colorcolumn = 0
autocmd FileType html
\ setlocal formatprg=tidy\ -indent\ -quiet\ --show-errors\ 0\ --tidy-mark\ no\ --show-body-only\ auto
set textwidth=128
