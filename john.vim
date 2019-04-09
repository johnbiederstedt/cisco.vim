"	local	syntax	file	-	set	colors	on	a	per-machine	basis:
"	vim:	tw=0	ts=4	sw=4
"	Vim	color	file
"	Maintainer:	Ron	Aaron	<ron@ronware.org>
"	Last	Change:	2003	May	02

hi	clear
if	exists("syntax_on")
	syntax	reset
endif
let	g:colors_name	=	"john"

hi	MatchParen	    cterm=bold	        ctermfg=black		    ctermbg=magenta		guifg=#ff00ff	guibg=#640064	gui=bold
"hi	Normal		    cterm=none	        guibg=#1f1f2c		    guifg=#e0e0f0
hi	Normal		    cterm=none	        guibg=#1c1b1a		    guifg=#e0e0f0
if &background == 'dark'
    hi	Comment		    cterm=none	        ctermfg=129	        ctermbg=017   guifg=#8855ff   guibg=#000044   gui=italic,bold
else
    hi	Comment		    cterm=none	        ctermfg=129	        guifg=#8855ff   guibg=#000044   gui=italic,bold
endif
hi	Constant	    cterm=none	        ctermfg=darkGreen	    guifg=#ff2222	gui=NONE
hi	Identifier	    cterm=none	        ctermfg=darkCyan	    guifg=#eaf6a6		gui=none
hi	Function	    cterm=bold	        ctermfg=Cyan	        guifg=Cyan	        gui=bold
hi	Include		    cterm=none	        cterm=none			    ctermbg=none	    ctermfg=darkyellow	guifg=darkyellow
hi	Ignore		    cterm=none	        ctermfg=black		    guifg=darkgrey
"hi	PreProc		    cterm=underline	    ctermfg=darkred	        guifg=#e5786d	    gui=underline
hi	PreProc		    cterm=bold	        ctermfg=red	            guifg=#ff2222	    gui=bold
hi	PreCondit	    cterm=none	        ctermfg=lightMagenta	guifg=lightMagenta  gui=bold
hi	Search		    cterm=bold          ctermbg=021             ctermfg=white      guifg=white		guibg=Blue
hi	Special		    cterm=none		    ctermfg=red		        guifg=#ff2222
hi	Type		    cterm=none		    ctermfg=darkGreen	    guifg=#cae682	    gui=none
hi	Error		    cterm=reverse	    ctermbg=Red			    ctermfg=White	    guibg=Red	guifg=White gui=bold
hi	Todo		    cterm=bold          ctermbg=yellow	        ctermfg=red	        guifg=Blue	guibg=Yellow gui=bold
"	From	the	source:
hi	Cursor			guifg=Orchid	    guibg=fg
hi	Directory	    cterm=none		    ctermfg=darkCyan	    guifg=Cyan
hi	ErrorMsg	    cterm=standout	    ctermbg=Red			    ctermfg=White	    guibg=Red	guifg=White
hi	IncSearch	    cterm=reverse	    cterm=reverse		    gui=reverse
hi	LineNr		    cterm=underline	    ctermfg=Yellow		    guifg=Yellow
hi	ModeMsg		    cterm=bold		    gui=bold
hi	MoreMsg		    cterm=none		    ctermfg=LightGreen	    gui=bold		    guifg=SeaGreen
hi	NonText		    cterm=none		    ctermfg=Blue		    gui=bold		    guifg=Blue
hi	Question	    cterm=bold          ctermfg=LightGreen	    gui=bold		    guifg=Green
hi	SpecialKey	    cterm=none		    ctermfg=LightBlue	    guifg=Cyan
hi	StatusLine	    cterm=reverse	    cterm=reverse		    gui=NONE		    guifg=White	guibg=darkblue
hi	StatusLineNC	cterm=reverse	    gui=NONE		        guifg=white	        guibg=#333333
hi	Title		    cterm=none		    ctermfg=Magenta         guifg=magenta       gui=bold
hi	WarningMsg	    cterm=bold		    ctermfg=darkred		    guifg=darkRed           gui=bold
hi	Visual		    cterm=reverse	    cterm=reverse		    gui=NONE		    guifg=white	guibg=darkgreen

hi	Statement	    cterm=bold		    ctermfg=Yellow	        guifg=yellow	    gui=bold
hi	Boolean			ctermfg=yellow	    cterm=bold		        guifg=yellow        gui=bold
hi	Repeat			ctermfg=magenta	    cterm=bold		        guifg=violet
hi	Label			ctermfg=darkyellow	cterm=none	            guifg=darkyellow
hi	Conditional		ctermfg=magenta	    cterm=bold		        guifg=magenta       gui=bold
hi	String			ctermfg=green       cterm=bold              guifg=lime  	    gui=italic
hi	Keyword			ctermfg=lightblue   guifg=lightblue	        gui=none
hi	Number			ctermfg=red         guifg=#ff2222               gui=bold
hi	Operator		ctermfg=red         guifg=orangered 
hi	Character		ctermfg=magenta     cterm=bold              guifg=Magenta       gui=italic,bold

hi	Folded		    cterm=none	        ctermbg=None            ctermfg=lightblue      guibg=#2c2b2a   guifg=#c0c0d0


highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guibg=#00005f
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guibg=#00005f
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guibg=#00005f
highlight DiffText   cterm=bold ctermfg=10 ctermbg=52 gui=none guibg=#3f0000

syntax match pythonDim /\v#[^ ].*$/
hi pythonDim cterm=none ctermfg=240 guifg=grey gui=none
syntax match pythonComment /\v#[# ].*$/ contains=pythonTodo,@Spell

