" Notes {{{
" Vim syntax file
" Language: gigamon configuration files
" Version: .001
" 
" Inception: 29-jan-2006
" Inspiration:  Harry Schroeder's original gigamon vim syntax file, and a discussion
"               on reddit.com in the vim subreddit on highlighting ip addresses in
"               a syntax file in 2005.  Grown from there.
" }}}
" Setup {{{
syn clear
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

"syn case ignore
setlocal iskeyword+=/
setlocal iskeyword+=:
setlocal iskeyword+=.
setlocal iskeyword+=-

" Define the default hightlighting.

"}}}
" detect and mark gui .vs. term mode set light .vs. dark background color pallets {{{
" gui and 256 terminals will end up with a much richer set of colors.  In the
" 16 color terminal world, colors will that don't exist will just get
" duplicated with the next nearest color - i.e. light red will just be red.
if (has("gui_running"))
    let s:vmode       = " gui"
    if &background == "light"
        let s:white         =   "#ffffff"  " 256 term color 15
        let s:gray          =   "#808080"  " 256 term color 244
        let s:black         =   "#444444"  " 256 term color 238
        let s:param         =   "#303030"  " 256 term color 236
        let s:red           =   "#cd0000"  " 256 term color 1
        let s:orange        =   "#af5f00"  " 256 term color 130
        let s:brown         =   "#875f00"  " 256 term color 94
        let s:yellow        =   "#af8700"  " 256 term color 136
        let s:blue          =   "#0000ff"  " 256 term color 21
        let s:bluegreen     =   "#005f5f"  " 256 term color 23
        let s:cyan          =   "#008787"  " 256 term color 30
        let s:green         =   "#005f00"  " 256 term color 22
        let s:magenta       =   "#5f005f"  " 256 term color 53
        let s:lightmagenta  =   "#ff00ff"  " 256 term color 201
        let s:purple        =   "#5f0087"  " 256 term color 54
        let s:pink          =   "#af005f"  " 256 term color 125
        let s:lime          =   "#5f8700"  " 256 term color 64
        let s:emph_bg       =   "#ffdddd"  " 256 term color 15
        let s:lightblue     =   "#005fff"  " 256 term color 27
    else " assume dark background
        let s:white         =   "#eeeeee"  " 256 term color 255
        let s:gray          =   "#8a8a8a"  " 256 term color 246
        let s:black         =   "#303030"  " 256 term color 236
        let s:param         =   "#e5e5e5"  " 256 term color 7
        let s:red           =   "#ff0000"  " 256 term color 196
        let s:orange        =   "#ff8700"  " 256 term color 208
        let s:brown         =   "#af8700"  " 256 term color 136
        let s:yellow        =   "#ffff00"  " 256 term color 226
        let s:blue          =   "#0087ff"  " 256 term color 33
        let s:bluegreen     =   "#008787"  " 256 term color 30
        let s:cyan          =   "#00ffff"  " 256 term color 51
        let s:green         =   "#00ff00"  " 256 term color 46
        let s:magenta       =   "#ff00ff"  " 256 term color 201
        let s:lightmagenta  =   "#ff87ff"  " 256 term color 213
        let s:purple        =   "#af5fff"  " 256 term color 135
        let s:pink          =   "#ff5fd7"  " 256 term color 206
        let s:lime          =   "#5fff00"  " 256 term color 82
        let s:emph_bg       =   "#400000"  " 256 term color 0
        let s:lightblue     =   "#00afff"  " 256 term color 39
    endif
else " assume terminal mode
    let s:vmode = " cterm"
    if &t_Co == 256
        if g:gigamon_background == "grey"
            let s:white         =   "15"
            let s:gray          =   "244"
            let s:black         =   "238"
            let s:param         =   "236"
            let s:red           =   "124"
            let s:orange        =   "130"
            let s:brown         =   "52"
            let s:yellow        =   "226"
            let s:blue          =   "19"
            let s:bluegreen     =   "30"
            let s:cyan          =   "14"
            let s:green         =   "10"
            let s:magenta       =   "126"
            let s:lightmagenta  =   "165"
            let s:purple        =   "54"
            let s:pink          =   "126"
            let s:lime          =   "118"
            let s:emph_bg       =   "15"
            let s:lightblue     =   "26"
        elseif &background == "light"
            let s:white         =   "15"
            let s:gray          =   "244"
            let s:black         =   "238"
            let s:param         =   "236"
            let s:red           =   "1"
            let s:orange        =   "130"
            let s:brown         =   "94"
            let s:yellow        =   "136"
            let s:blue          =   "19"
            let s:bluegreen     =   "37"
            let s:cyan          =   "30"
            let s:green         =   "22"
            let s:magenta       =   "53"
            let s:lightmagenta  =   "199"
            let s:purple        =   "54"
            let s:pink          =   "125"
            let s:lime          =   "64"
            let s:emph_bg       =   "15"
            let s:lightblue     =   "27"
        else " assume dark background
            let s:white         =   "255"
            let s:gray          =   "246"
            let s:black         =   "236"
            let s:param         =   "7"  
            let s:red           =   "196"
            let s:orange        =   "208"
            let s:brown         =   "136"
            let s:yellow        =   "226"
            let s:blue          =   "33"
            let s:bluegreen     =   "30"
            let s:cyan          =   "51"
            let s:green         =   "46"
            let s:magenta       =   "200"
            let s:lightmagenta  =   "213"
            let s:purple        =   "135"
            let s:pink          =   "206"
            let s:lime          =   "82"
            let s:emph_bg       =   "0"
            let s:lightblue     =   "39"
        endif
    else
        if &background == "light"
            let s:white         =   "15"
            let s:gray          =   "8"
            let s:black         =   "0"
            let s:param         =   "0"
            let s:red           =   "1"
            let s:orange        =   "9"
            let s:brown         =   "1"
            let s:yellow        =   "3"
            let s:blue          =   "4"
            let s:bluegreen     =   "6"
            let s:cyan          =   "6"
            let s:green         =   "2"
            let s:magenta       =   "5"
            let s:lightmagenta  =   "5 term=bold"
            let s:purple        =   "12 term=bold"
            let s:pink          =   "5 term=bold"
            let s:lime          =   "2"
            let s:emph_bg       =   "15"
            let s:lightblue     =   "12 term=bold"
        else " assume dark background
            let s:white         =   "15"
            let s:gray          =   "8"
            let s:black         =   "0"
            let s:param         =   "15"  
            let s:red           =   "9"
            let s:orange        =   "9 term=bold"
            let s:brown         =   "1 term=bold"
            let s:yellow        =   "11"
            let s:blue          =   "12"
            let s:bluegreen     =   "14"
            let s:cyan          =   "14"
            let s:green         =   "10"
            let s:magenta       =   "13"
            let s:lightmagenta  =   "13 term=bold"
            let s:purple        =   "12 term=bold"
            let s:pink          =   "13 term=bold"
            let s:lime          =   "10"
            let s:emph_bg       =   "0 term=bold"
            let s:lightblue     =   "12 term=bold"
        endif
    endif
endif
" }}}
" Define formatting {{{
let s:none          = s:vmode."=NONE"
let s:ul            = s:vmode."=underline"
let s:underline     = s:vmode."=underline"
let s:rev           = s:vmode."=reverse"
let s:standout      = s:vmode."=standout"
let s:bold          = s:vmode."=bold"
if (has("gui_running"))
    let s:italic        = s:vmode."=italic"
    let s:ul_italic     = s:vmode."=underline,italic"
    let s:italic_rev    = s:vmode."=italic,reverse"
    let s:italic_stand  = s:vmode."=italic,standout"
    let s:bold_italic   = s:vmode."=bold,italic"
else
    let s:italic        = s:vmode."=none"
    let s:ul_italic     = s:vmode."=underline"
    let s:italic_rev    = s:vmode."=reverse"
    let s:italic_stand  = s:vmode."=standout"
    let s:bold_italic   = s:vmode."=bold"
endif
let s:ul_bold       = s:vmode."=underline,bold"
let s:ul_rev        = s:vmode."=underline,reverse"
let s:ul_stand      = s:vmode."=underline,standout"
let s:bold_rev      = s:vmode."=bold,reverse"
let s:bold_stand    = s:vmode."=bold,standout"
" }}}
" background and foreground variables {{{

let s:fgparameter       =   s:vmode . "fg=" . s:param           . " "
" the keyword heirarchy
let s:fgkeyword         =   s:vmode . "fg=" . s:lightblue       . " "
let s:fgkeyword2        =   s:vmode . "fg=" . s:bluegreen       . " "
let s:fgkeyword3        =   s:vmode . "fg=" . s:purple          . " "
let s:fgkeyword4        =   s:vmode . "fg=" . s:magenta         . " "
let s:fgkeyword5        =   s:vmode . "fg=" . s:green           . " "
let s:fgkeyword6        =   s:vmode . "fg=" . s:lightmagenta    . " "
let s:fgkeyword7        =   s:vmode . "fg=" . s:blue            . " "
" the other foreground stuff...
let s:fgwhite           =   s:vmode . "fg=" . s:white           . " "
let s:fggray            =   s:vmode . "fg=" . s:gray            . " "
let s:fgblack           =   s:vmode . "fg=" . s:black           . " "
let s:fgred             =   s:vmode . "fg=" . s:red             . " "
let s:fgorange          =   s:vmode . "fg=" . s:orange          . " "
let s:fgbrown           =   s:vmode . "fg=" . s:brown           . " "
let s:fgyellow          =   s:vmode . "fg=" . s:yellow          . " "
let s:fgblue            =   s:vmode . "fg=" . s:blue            . " "
let s:fglightblue       =   s:vmode . "fg=" . s:lightblue       . " "
let s:fgbluegreen       =   s:vmode . "fg=" . s:bluegreen       . " "
let s:fgcyan            =   s:vmode . "fg=" . s:cyan            . " "
let s:fggreen           =   s:vmode . "fg=" . s:green           . " "
let s:fgmagenta         =   s:vmode . "fg=" . s:magenta         . " "
let s:fglightmagenta    =   s:vmode . "fg=" . s:lightmagenta    . " "
let s:fgpurple          =   s:vmode . "fg=" . s:purple          . " "
let s:fgpink            =   s:vmode . "fg=" . s:pink            . " "
let s:fglime            =   s:vmode . "fg=" . s:lime            . " "
" backgrounds
let s:bgparameter       =   s:vmode . "bg=" . s:param           . " "
let s:bgwhite           =   s:vmode . "bg=" . s:white           . " "
let s:bggray            =   s:vmode . "bg=" . s:gray            . " "
let s:bgblack           =   s:vmode . "bg=" . s:black           . " "
let s:bgred             =   s:vmode . "bg=" . s:red             . " "
let s:bgorange          =   s:vmode . "bg=" . s:orange          . " "
let s:bgbrown           =   s:vmode . "bg=" . s:brown           . " "
let s:bgyellow          =   s:vmode . "bg=" . s:yellow          . " "
let s:bgblue            =   s:vmode . "bg=" . s:blue            . " "
let s:bglightblue       =   s:vmode . "bg=" . s:lightblue       . " "
let s:bgbluegreen       =   s:vmode . "bg=" . s:bluegreen       . " "
let s:bgcyan            =   s:vmode . "bg=" . s:cyan            . " "
let s:bggreen           =   s:vmode . "bg=" . s:green           . " "
let s:bgmagenta         =   s:vmode . "bg=" . s:magenta         . " "
let s:bglightmagenta    =   s:vmode . "bg=" . s:lightmagenta    . " "
let s:bgpurple          =   s:vmode . "bg=" . s:purple          . " "
let s:bgpink            =   s:vmode . "bg=" . s:pink            . " "
let s:bglime            =   s:vmode . "bg=" . s:lime            . " "
let s:bgemph            =   s:vmode . "bg=" . s:emph_bg         . " "
let s:bgprompt          =   s:vmode . "bg=" . s:lightblue       . " "
" }}}
" formatting Meta {{{
" This may be where themes may at one point come to be.
"
let s:description = s:fgbrown . s:bold_italic
let s:parameter = s:fgparameter . s:bold
let s:parameter2 = s:fgorange   . s:bold
let s:parameter3 = s:fgyellow   . s:bold
let s:parameter4 = s:fgcyan     . s:bold
let s:parameter5 = s:fgred      . s:bold
let s:keyword1 = s:fgkeyword    " lightblue
let s:keyword2 = s:fgkeyword2   " purple
let s:keyword3 = s:fgkeyword3   " bluegreen
let s:keyword4 = s:fgkeyword4   " magenta
let s:keyword5 = s:fgkeyword5   " green
let s:keyword6 = s:fgkeyword6   " light magenta
let s:keyword7 = s:fgkeyword7   " blue
let s:emphasis = s:fgred . s:bgemph
let s:error = s:bold . s:fgwhite . s:bgred

" }}}
" Highlighting commands {{{
let s:h = "hi! "
" this may not be in use - check
exe "let s:interface_type = ' ".s:ul." ".s:vmode."fg=".s:cyan." ".s:vmode."bg=".s:none."'"
" }}}
" Generic parameter nextgroups {{{
" This can be used as a nextgroup in most situations
syn match parameter /[^ ]\+/ contained
exe s:h . "parameter" . s:parameter
syn match parameter2 /[^ ]\+/ contained
exe s:h . "parameter2" . s:parameter2
syn match parameter3 /[^ ]\+/ contained
exe s:h . "parameter3" . s:parameter3
syn match parameter4 /[^ ]\+/ contained
exe s:h . "parameter4" . s:parameter4
syn match parameter5 /[^ ]\+/ contained
exe s:h . "parameter5" . s:parameter5
" }}}

" colorize big numbers {{{

" mini theme for bits per second.
let s:bitssec  = s:fglightblue
let s:kbitssec = s:fggreen
let s:mbitssec = s:fgorange
let s:gbitssec = s:fgyellow
let s:tbitssec = s:fgmagenta
let s:pbitssec = s:fgcyan

" counters {{{ 1
"syn region mbytes_reg start=/ [0-9]\{4}/ end=/,\| \|$/re=e-1 oneline keepend contains=mbytes1b,mbytes2b
"syn match mbytes2b excludenl  /[0-9]\{3}/ contained
"exe s:h . " mbytes2b " . s:bold . s:kbitssec
"syn match mbytes1b excludenl  /[0-9]\{1}/ contained nextgroup=mbytes2b
"exe s:h . " mbytes1b " . s:bold . s:mbitssec

syn region mbytes_reg1 start=/ [0-9]\{5}/ end=/,\| \|$/re=e-1,me=e-1 oneline keepend contains=mbytes3b,mbytes4b
syn match mbytes3b excludenl /[0-9]\{3}/ contained
exe s:h . " mbytes3b " . s:bold . s:kbitssec
syn match mbytes4b excludenl  /[0-9]\{2}/ contained nextgroup=mbytes3b
exe s:h . " mbytes4b " . s:bold . s:mbitssec

syn region mbytes_reg2 start=/ [0-9]\{6}/ end=/,\| \|$/re=e-1,me=e-1 oneline keepend contains=mbytes5b,mbytes6b
syn match mbytes6b excludenl  /[0-9]\{3}/ contained
exe s:h . " mbytes6b " . s:bold . s:kbitssec
syn match mbytes5b excludenl  /[0-9]\{3}/ contained nextgroup=mbytes6b
exe s:h . " mbytes5b " . s:bold . s:mbitssec


syn region gbytes_reg start=/ [0-9]\{7}/ end=/,\| \|$/re=e-1,me=e-1 oneline keepend contains=gbytes2b,gbytes3b,gbytes4b
syn match gbytes4b excludenl  /[0-9]\{3}/ contained 
exe s:h . " gbytes4b " . s:bold . s:kbitssec
syn match gbytes3b excludenl  /[0-9]\{3}/ contained nextgroup=gbytes4b
exe s:h . " gbytes3b " . s:bold . s:mbitssec
syn match gbytes2b excludenl  /[0-9]\{1}/ contained nextgroup=gbytes3b
exe s:h . " gbytes2b " . s:bold . s:gbitssec

syn region gbytes_reg2 start=/ [0-9]\{8}/ end=/,\| \|$/re=e-1,me=e-1 oneline keepend contains=gbytes5b,gbytes6b,gbytes7b
syn match gbytes7b excludenl  /[0-9]\{3}/ contained 
exe s:h . " gbytes7b " . s:bold . s:kbitssec
syn match gbytes6b excludenl  /[0-9]\{3}/ contained nextgroup=gbytes7b
exe s:h . " gbytes6b " . s:bold . s:mbitssec
syn match gbytes5b excludenl  /[0-9]\{2}/ contained nextgroup=gbytes6b
exe s:h . " gbytes5b " . s:bold . s:gbitssec

syn region gbytes_reg3 start=/ [0-9]\{9}/ end=/,\| \|$/re=e-1,me=e-1 oneline keepend contains=gbytes8b,gbytes9b,gbytes10b
syn match gbytes10b excludenl  /[0-9]\{3}/ contained 
exe s:h . " gbytes10b " . s:bold . s:kbitssec
syn match gbytes9b excludenl  /[0-9]\{3}/ contained nextgroup=gbytes10b
exe s:h . " gbytes9b " . s:bold . s:mbitssec
syn match gbytes8b excludenl  /[0-9]\{3}/ contained nextgroup=gbytes9b
exe s:h . " gbytes8b " . s:bold . s:gbitssec


syn region tbytes_reg start=/ [0-9]\{10}/ end=/,\| \|$/re=e-1,me=e-1 oneline keepend contains=tbytes2b,tbytes3b,tbytes4b,tbytes5b
syn match tbytes5b excludenl /[0-9]\{3}/ contained 
exe s:h . " tbytes5b " . s:bold . s:kbitssec
syn match tbytes4b excludenl /[0-9]\{3}/ contained nextgroup=tbytes5b
exe s:h . " tbytes4b " . s:bold . s:mbitssec
syn match tbytes3b excludenl /[0-9]\{3}/ contained nextgroup=tbytes4b
exe s:h . " tbytes3b " . s:bold . s:gbitssec
syn match tbytes2b excludenl /[0-9]\{1}/ contained nextgroup=tbytes3b
exe s:h . " tbytes2b " . s:bold . s:tbitssec


syn region tbytes_reg2 start=/ [0-9]\{11}/ end=/,\| \|$/re=e-1,me=e-1 oneline keepend contains=tbytes6b,tbytes7b,tbytes8b,tbytes9b
syn match tbytes9b excludenl /[0-9]\{3}/ contained 
exe s:h . " tbytes9b " . s:bold . s:kbitssec
syn match tbytes8b excludenl /[0-9]\{3}/ contained nextgroup=tbytes9b
exe s:h . " tbytes8b " . s:bold . s:mbitssec
syn match tbytes7b excludenl /[0-9]\{3}/ contained nextgroup=tbytes8b
exe s:h . " tbytes7b " . s:bold . s:gbitssec
syn match tbytes6b excludenl /[0-9]\{2}/ contained nextgroup=tbytes7b
exe s:h . " tbytes6b " . s:bold . s:tbitssec

syn region tbytes_reg3 start=/ [0-9]\{12}/ end=/,\| \|$/re=e-1,me=e-1 oneline keepend contains=tbytes10b,tbytes11b,tbytes12b,tbytes13b,tbytes14b
syn match tbytes13b excludenl /[0-9]\{3}/ contained 
exe s:h . " tbytes13b " . s:bold . s:kbitssec
syn match tbytes12b excludenl /[0-9]\{3}/ contained nextgroup=tbytes13b
exe s:h . " tbytes12b " . s:bold . s:mbitssec
syn match tbytes11b excludenl /[0-9]\{3}/ contained nextgroup=tbytes12b
exe s:h . " tbytes11b " . s:bold . s:gbitssec
syn match tbytes10b excludenl /[0-9]\{3}/ contained nextgroup=tbytes11b
exe s:h . " tbytes10b " . s:bold . s:tbitssec

syn region pbytes_reg start=/ [0-9]\{13}/ end=/,\| \|$/re=e-1,me=e-1 oneline keepend contains=pbytes1b,pbytes2b,pbytes3b,pbytes4b,pbytes5b
syn match pbytes5b excludenl /[0-9]\{3}/ contained 
exe s:h . " pbytes5b " . s:bold . s:kbitssec
syn match pbytes4b excludenl /[0-9]\{3}/ contained nextgroup=pbytes5b
exe s:h . " pbytes4b " . s:bold . s:mbitssec
syn match pbytes3b excludenl /[0-9]\{3}/ contained nextgroup=pbytes4b
exe s:h . " pbytes3b " . s:bold . s:gbitssec
syn match pbytes2b excludenl /[0-9]\{3}/ contained nextgroup=pbytes3b
exe s:h . " pbytes2b " . s:bold . s:tbitssec
syn match pbytes1b excludenl /[0-9]\{1}/ contained nextgroup=pbytes2b
exe s:h . " pbytes1b " . s:bold . s:pbitssec

syn region pbytes_reg2 start=/ [0-9]\{14}/ end=/,\| \|$/re=e-1,me=e-1 oneline keepend contains=pbytes6b,pbytes7b,pbytes8b,pbytes9b,pbytes10b
syn match pbytes10b excludenl /[0-9]\{3}/ contained 
exe s:h . " pbytes10b " . s:bold . s:kbitssec
syn match pbytes9b excludenl /[0-9]\{3}/ contained nextgroup=pbytes10b
exe s:h . " pbytes9b " . s:bold . s:mbitssec
syn match pbytes8b excludenl /[0-9]\{3}/ contained nextgroup=pbytes9b
exe s:h . " pbytes8b " . s:bold . s:gbitssec
syn match pbytes7b excludenl /[0-9]\{3}/ contained nextgroup=pbytes8b
exe s:h . " pbytes7b " . s:bold . s:tbitssec
syn match pbytes6b excludenl /[0-9]\{2}/ contained nextgroup=pbytes7b
exe s:h . " pbytes6b " . s:bold . s:pbitssec

syn region pbytes_reg3 start=/ [0-9]\{15}/ end=/,\| \|$/re=e-1,me=e-1 oneline keepend contains=pbytes11b,pbytes12b,pbytes13b,pbytes14b,pbytes15b
syn match pbytes15b excludenl /[0-9]\{3}/ contained 
exe s:h . " pbytes15b " . s:bold . s:kbitssec
syn match pbytes14b excludenl /[0-9]\{3}/ contained nextgroup=pbytes15b
exe s:h . " pbytes14b " . s:bold . s:mbitssec
syn match pbytes13b excludenl /[0-9]\{3}/ contained nextgroup=pbytes14b
exe s:h . " pbytes13b " . s:bold . s:gbitssec
syn match pbytes12b excludenl /[0-9]\{3}/ contained nextgroup=pbytes13b
exe s:h . " pbytes12b " . s:bold . s:tbitssec
syn match pbytes11b excludenl /[0-9]\{3}/ contained nextgroup=pbytes12b
exe s:h . " pbytes11b " . s:bold . s:pbitssec


"}}} 1



" }}}

" rule command {{{
syn match rule_kw /rule / skipwhite contained containedin=rule_cmd
exe s:h . "rule_kw" . s:keyword1

syn region rule_cmd matchgroup=rule_kw start=/rule /rs=e end=/$/ keepend skipwhite transparent excludenl 

syn match rule_cmd_kw /add/         skipwhite contained containedin=rule_cmd
syn match rule_cmd_kw /copy\-from/   skipwhite contained containedin=rule_cmd
syn match rule_cmd_kw /delete/      skipwhite contained containedin=rule_cmd
syn match rule_cmd_kw /edit/        skipwhite contained containedin=rule_cmd
exe s:h . "rule_cmd_kw" . s:keyword2

"syn region rule_add_cmd start=/ add /rs=e end=/$/ skipwhite keepend transparent excludenl contained containedin=rule_cmd

syn match  rule_add_cmd_pass_kw /pass/ skipwhite contained containedin=rule_cmd
exe s:h . "rule_add_cmd_pass_kw" . s:fggreen
syn match  rule_add_cmd_drop_kw /drop/ skipwhite contained containedin=rule_cmd
exe s:h . "rule_add_cmd_drop_kw" . s:fgred


"syn region rule_add_pass_cmd start=/ pass /rs=e end=/$/ skipwhite keepend transparent excludenl contained containedin=rule_add_cmd,rule_cmd

syn match rule_add_pass_kw /bidir/ skipwhite contained containedin=rule_cmd
syn match rule_add_pass_kw /comment/ skipwhite contained containedin=rule_cmd
syn match rule_add_pass_kw /dscp/ skipwhite contained containedin=rule_cmd
syn match rule_add_pass_kw /ethertype/ skipwhite contained containedin=rule_cmd
syn match rule_add_pass_kw /ip6fl/ skipwhite contained containedin=rule_cmd
syn match rule_add_pass_kw /ipfrag/ skipwhite contained containedin=rule_cmd
syn match rule_add_pass_kw /ipver/ skipwhite contained containedin=rule_cmd
syn match rule_add_pass_kw /protocol/ skipwhite contained containedin=rule_cmd
syn match rule_add_pass_kw /tcpctl/ skipwhite contained containedin=rule_cmd
syn match rule_add_pass_kw /tosval/ skipwhite contained containedin=rule_cmd
syn match rule_add_pass_kw /ttl/ skipwhite contained containedin=rule_cmd
"syn match rule_add_pass_kw /uda1\-data/ skipwhite contained containedin=rule_cmd
"syn match rule_add_pass_kw /uda2\-data/ skipwhite contained containedin=rule_cmd
syn match rule_add_pass_kw /vlan/ skipwhite contained containedin=rule_cmd
exe s:h . "rule_add_pass_kw" . s:keyword3

syn match rule_add_is_src_kw /ip6src/ skipwhite contained containedin=rule_cmd
syn match rule_add_is_src_kw /ip6srcdst/ skipwhite contained containedin=rule_cmd
syn match rule_add_is_src_kw /ipsrc/ skipwhite contained containedin=rule_cmd
syn match rule_add_is_src_kw /ipsrcdst/ skipwhite contained containedin=rule_cmd
syn match rule_add_is_src_kw /macsrc/ skipwhite contained containedin=rule_cmd
syn match rule_add_is_src_kw /portsrc/ skipwhite contained containedin=rule_cmd
syn match rule_add_is_src_kw /portsrcdst/ skipwhite contained containedin=rule_cmd
exe s:h . "rule_add_is_src_kw" . s:fgcyan

syn match rule_add_is_dst_kw /ip6dst/ skipwhite contained containedin=rule_cmd
syn match rule_add_is_dst_kw /ipdst/ skipwhite contained containedin=rule_cmd
syn match rule_add_is_dst_kw /macdst/ skipwhite contained containedin=rule_cmd
syn match rule_add_is_dst_kw /portdst/ skipwhite contained containedin=rule_cmd
exe s:h . "rule_add_is_dst_kw" . s:fgorange

syn match rule_add_is_src_kw /ip6srcmask/ skipwhite contained containedin=rule_cmd
syn match rule_add_is_src_kw /ip6srcdstmask/ skipwhite contained containedin=rule_cmd
syn match rule_add_is_src_kw /ipsrcmask/ skipwhite contained containedin=rule_cmd
syn match rule_add_is_src_kw /ipsrcdstmask/ skipwhite contained containedin=rule_cmd
syn match rule_add_is_src_kw /macsrcmask/ skipwhite contained containedin=rule_cmd
exe s:h . "rule_add_is_src_kw" . s:fgcyan

syn match rule_add_is_dst_kw /ip6dstmask/ skipwhite contained containedin=rule_cmd
syn match rule_add_is_dst_kw /ipdstmask/ skipwhite contained containedin=rule_cmd
syn match rule_add_is_dst_kw /macdstmask/ skipwhite contained containedin=rule_cmd
exe s:h . "rule_add_is_dst_kw" . s:fgorange


syn match rule_add_tool_list /[a-zA-Z0-9_ -]\+$/ skipwhite contained containedin=rule_add_tool
exe s:h . "rule_add_tool_list" . s:parameter5

syn match rule_add_tool_kw /tool/ skipwhite contained
exe s:h . "rule_add_tool_kw" . s:keyword4

syn region rule_add_tool matchgroup=rule_add_tool_kw start=/ tool / end=/$/ skipwhite contained containedin=rule_cmd contains=rule_add_tool_kw,rule_add_tool_list


" }}}
" Misc Keywords {{{
"
syn match gig_map /map-rule/ skipwhite nextgroup=aliasname
syn match gig_map /^map / skipwhite nextgroup=map_alias
syn match gig_map /^inline-network / skipwhite nextgroup=map_alias
syn match gig_map /^inline-network-group / skipwhite nextgroup=map_alias
syn match gig_map /^inline-tool / skipwhite nextgroup=map_alias
syn match gig_map /^inline-tool-group / skipwhite nextgroup=map_alias
syn match gig_map /^map-scollector / skipwhite nextgroup=map_alias
syn match gig_map /^map-passall / skipwhite nextgroup=map_alias
exe s:h . "gig_map" . s:keyword1 . s:underline

syn match map_alias /alias / skipwhite contained nextgroup=mapaliasname
exe s:h . "map_alias" . s:keyword2 . s:underline

syn match mapaliasname /[^ ]\+/ excludenl contained
exe s:h . "mapaliasname" . s:fgwhite . s:bold . s:bgemph . s:underline

syn match alias /alias / skipwhite nextgroup=aliasname
exe s:h . "alias" . s:keyword1

syn match aliasname /[^ ]\+/ skipwhite contained
exe s:h . "aliasname" . s:fgbrown

syn match port /portsrc / skipwhite nextgroup=parameter2
syn match port /portdst / skipwhite nextgroup=parameter2
exe s:h . 'port' s:keyword3

syn match gig_mapping /mapping /
exe s:h . "gig_mapping" . s:keyword5 . s:bold

syn match Console_Error /^%.*/
exe s:h . "Console_Error" . s:emphasis

syn match enabled / enabled/hs=s+1
exe s:h . "enabled" . s:fggreen

syn match disabled / disabled/hs=s+1
exe s:h . "disabled" . s:fgred

syn match up / up/hs=s+1
exe s:h . 'up' .s:fggreen

syn match down / down/hs=s+1
exe s:h . 'down' . s:emphasis

syn match network_list /network-list/
exe s:h . "network_list" . s:keyword3

syn match hybrid /hybrid/
exe s:h . "hybrid" . s:parameter3

syn match use /use / nextgroup=gsop
exe s:h . "use" . s:keyword1

syn match gsop /gsop / nextgroup=parameter4
exe s:h . "gsop" . s:keyword2

syn match comment /comment / nextgroup=comment_text
exe s:h . "comment" . s:keyword1

syn match from /  from /
exe s:h . "from" . s:keyword1

syn match comment_text /.*/ skipwhite contained
exe s:h . "comment_text" . s:description

syn region map_source_region start=/  from / end=/$/ transparent excludenl contains=map_sources,gigamonintregion
syn region map_dest_region start=/  to / end=/$/ transparent excludenl contains=map_destinations,gigamonintregion

syn match map_sources /[^ ]/ skipwhite contained
exe s:h . "map_sources" . s:fgyellow . s:bold

syn match map_destinations /[^ ]/ skipwhite contained
exe s:h . "map_destinations" . s:fgmagenta . s:bold

syn match map_dest_kw /from/ skipwhite contained containedin=map_source_region
exe s:h . "map_dest_kw" . s:keyword1

syn match map_dest_kw /to/ skipwhite contained containedin=map_dest_region
exe s:h . "map_dest_kw" . s:keyword1

syn match Alias /Alias *:/ skipwhite nextgroup=parameter2
exe s:h . "Alias" . s:keyword1

syn match Comment /Comment:/ skipwhite nextgroup=up,down
exe s:h . "Comment" . s:keyword1

syn match up /UP/ skipwhite contained
syn match up /up/ skipwhite contained
exe s:h . 'up' s:bold . s:fggreen

syn match down /DOWN/ skipwhite contained
syn match down /down/ skipwhite contained
exe s:h . 'down' s:bold . s:fgred

syn match Port /^Port */ skipwhite nextgroup=parameter
exe s:h . 'Port' s:keyword1

syn match Separater_lines /==*/ skipwhite
exe s:h . 'Separater_lines' s:fggray

syn match KW_assign /assign/
exe s:h . 'KW_assign' . s:keyword1

syn match KW_replace /replace/
exe s:h . 'KW_replace' . s:keyword2

syn match KW_Default /Default/
exe s:h . 'KW_Default' . s:keyword3

syn match KW_level /level/ skipwhite nextgroup=parameter
exe s:h . 'KW_level' . s:keyword4

syn match KW_params /params/
exe s:h . 'KW_params ' . s:keyword1

syn match KW_admin /admin/ skipwhite nextgroup=parameter
exe s:h . 'KW_admin ' . s:keyword2

syn match KW_type /type/ skipwhite nextgroup=inline_net,inline_tool,network_type,tool_type,hybrid_type
exe s:h . 'KW_type ' . s:keyword1

syn match inline_net /inline-net/ contained
exe s:h . 'inline_net ' . s:parameter3

syn match inline_tool /inline-tool/ contained
exe s:h . 'inline_tool ' . s:parameter4

syn match network_type /network/ contained
exe s:h . 'network_type ' . s:fgpurple . s:bold

syn match tool_type /tool/ contained
exe s:h . 'tool_type ' . s:parameter5

syn match hybrid_type /hybrid/ contained
exe s:h . 'hybrid_type ' . s:fglime . s:bold

syn match KW_exit /exit/
exe s:h . 'KW_exit' . s:fggray

syn region roles start=/roles replace/rs=e-13 end=/$/ contains=roles, replace, admin_default, owner_view_roles

syn match roles /roles / contained skipwhite
exe s:h . 'roles' . s:keyword1

syn match replace /replace / contained skipwhite
exe s:h . 'replace' . s:keyword2

syn match admin_default /admin to/he=e-3 contained skipwhite nextgroup=parameter
syn match admin_default /Default to/he=e-3 contained skipwhite nextgroup=parameter
exe s:h . 'admin_default' . s:keyword3

syn match KW_snmp_server /snmp-server / skipwhite
exe s:h 'KW_snmp_server' . s:keyword1

" }}}
" Ethernet address {{{

syn match ethernet_address excludenl /\v[0-9A-Fa-f]{4}\.[0-9A-Fa-f]{4}\.[0-9A-Fa-f]{4}/ 
syn match ethernet_address excludenl /\v[0-9A-Fa-f]{2}[-:][0-9A-Fa-f]{2}[-:][0-9A-Fa-f]{2}[-:][0-9A-Fa-f]{2}[-:][0-9A-Fa-f]{2}[-:][0-9A-Fa-f]{2}/ 
exe s:h . "ethernet_address" . s:bold . s:fgred

"}}}
" IP Address highlighting {{{
" The error catching isn't really vetted out here.  It should highlight *any*
" bad IP address or subnet mask in a way such to show it's wrong.  Doesn't
" quite do that yet.
"
" experimental ip address octet by octet matching and error catch {{{2
" ends up looking kind of trippy, but gives a good impression of how match
" progression works.
"
"syn match anyerror /[^0-9]*/ contained
"syn match anyerror /[0-9][^0-9]\+/ contained
"HiLink    anyerror ErrorMsg
"
"syn match ipaddr_octet_1 /\v(25[0-4]|2[0-4]\d|1\d{,2}|\d{1,2})\./ nextgroup=ipaddr_octet_2,anyerror contained containedin=ipaddr_region
"HiLink ipaddr_octet_1 gitcommitDiscardedType
"
"syn match ipaddr_octet_2 contained /\v(25[0-4]|2[0-4]\d|1\d{,2}|\d{1,2})\./ nextgroup=ipaddr_octet_3,anyerror
"HiLink ipaddr_octet_2 pandocSubscript
"
"syn match ipaddr_octet_3 contained /\v(25[0-4]|2[0-4]\d|1\d{,2}|\d{1,2})\./ nextgroup=ipaddr_octet_4,anyerror
"HiLink ipaddr_octet_3 javaScript
"
"syn match ipaddr_octet_4 contained /\v(25[0-4]|2[0-4]\d|1\d{,2}|\d{1,2})/ nextgroup=cidr
"HiLink ipaddr_octet_4 helpNote

"2}}}
syn match zeros excludenl /\s0\.0\.0\.0/ nextgroup=ipaddr,ipaddr_cidr,subnetmask,wildcard skipwhite 
exe s:h . "zeros" . s:bold . s:fgpink

"syn match ipaddress /(1\d\d|2[0-4]\d|25[0-5]|[1-9]\d|\d)\.(1\d\d|2[0-4]\d|25[0-5]|[1-9]\d|\d)\.(1\d\d|2[0-4]\d|25[0-5]|[1-9]\d|\d)\.(1\d\d|2[0-4]\d|25[0-5]|[1-9]\d|\d)/

syn match ipaddress excludenl /\v\s(25[0-4]|2[0-4]\d|1\d{1,2}|[1-9]\d|[1-9])\.(25[0-5]|2[0-4]\d|1\d\d|\d{1,2})\.(25[0-5]|2[0-4]\d|1\d\d|\d{1,2})\.(25[0-5]|2[0-4]\d|1\d\d|\d{1,2})/ nextgroup=ipaddr,ipaddr_cidr,subnetmask,wildcard skipwhite 
exe s:h . "ipaddress" . s:fgpink


syn match badmask /\v (12[0-79]|19[013-9]|1[013-8]\d|22[0-35-9]|24[13-9]|25[0136-9]|0\d{1,})\.
					   \(12[0-79]|19[013-9]|1[013-8]\d|22[0-35-9]|24[13-9]|25[0136-9]|0\d{1,})\.
					   \(12[0-79]|19[013-9]|1[013-8]\d|22[0-35-9]|24[13-9]|25[0136-9]|0\d{1,})\.
					   \(12[0-79]|19[013-9]|1[013-8]\d|22[0-35-9]|24[13-9]|25[0136-9]|0\d{1,})excludenl / contained 
exe s:h . "badmask" . s:rev . s:fgred

" BadIPaddr match {{{2
syn match BadIPaddr /\v(25[6-9]|2[6-9]\d|[3-9]\d\d)\.\d{1,3}\.\d{1,3}\.\d{1,3}/       contained excludenl containedin=ipaddr_region
syn match BadIPaddr /\v\d{1,3}\.(2[5][6-9]|2[6-9]\d|[3-9]\d\d)\.\d{1,3}\.\d{1,3}/     contained excludenl containedin=ipaddr_region
syn match BadIPaddr /\v\d{1,3}\.\d{0,3}\.(2[5][6-9]|2[6-9]\d|[3-9]\d\d)\.\d{1,3}/     contained excludenl containedin=ipaddr_region
syn match BadIPaddr /\v\d{1,3}\.\d{1,3}\.\d{1,3}\.(2[5][6-9]|2[6-9]\d|[3-9]\d\d)/     contained excludenl containedin=ipaddr_region
syn match BadIPaddr /\v(25[6-9]|2[6-9]\d|[3-9]\d\d)\.
                        \(25[6-9]|2[6-9]\d|[3-9]\d\d)\.
                        \(25[6-9]|2[6-9]\d|[3-9]\d\d)\.
                        \(25[6-9]|2[6-9]\d|[3-9]\d\d)/                                contained excludenl containedin=ipaddr_region
syn match BadIPaddr /\v\d{1,3}\.\d{1,3}\.\d{4,}\.\d{1,3}/                             contained excludenl containedin=ipaddr_region
syn match BadIPaddr /\v\d{1,3}\.\d{4,}\.\d{1,3}\.\d{1,3}/                             contained excludenl containedin=ipaddr_region
syn match BadIPaddr /\v\d{4,}\.\d{1,3}\.\d{1,3}\.\d{1,3}/                             contained excludenl containedin=ipaddr_region
syn match BadIPaddr /\v\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{4,}\./                           contained excludenl containedin=ipaddr_region
syn match BadIPaddr /\v\d{1,3}\.\d{1,3}\.\d{4,}\.\d{1,3}\./                           contained excludenl containedin=ipaddr_region
syn match BadIPaddr /\v\d{1,3}\.\d{4,}\.\d{1,3}\.\d{1,3}\./                           contained excludenl containedin=ipaddr_region
syn match BadIPaddr /\v\d{4,}\.\d{1,3}\.\d{1,3}\.\d{1,3}\./                           contained excludenl containedin=ipaddr_region
syn match BadIPaddr /\v\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{4,}/                             contained excludenl containedin=ipaddr_region
exe s:h . "BadIPaddr" . s:standout . s:fgred
"2}}}


syn match subnetmask contained excludenl  /\v (0|192|224|240|248|252|254|255)\.(0|128|192|224|240|248|252|254|255)\.(0|128|192|224|240|248|252|254|255)\.(0|128|192|224|240|248|252|254|255)/he=e+1
exe s:h . "subnetmask" . s:italic . s:keyword1

syn match wildcard contained excludenl  /\v (127|63|31|15|7|3|1|0)\.(255|127|63|31|15|7|3|1|0)\.(255|127|63|31|15|7|3|1|0)\.(255|127|63|31|15|7|3|1|0)/he=e+1
exe s:h . "wildcard" . s:italic . s:fgblue

syn match ipaddr_kw excludenl /ip address/ contained 
exe s:h . "ipaddr_kw" . s:keyword1

syn match badmaskoctect excludenl /\v( 12[0-79]|19[013-9]|1[013-8]\d|22[0-35-9]|24[13-9]|25[0136-9]|0\d{1,})/ contained 
exe s:h . "badmaskoctect" . s:standout . s:fgred

syn match ipaddr_anyerror "\a\|\d\|[.()!#^&*\-_=+{};'",.excludenl  /<>?]\+" contained containedin=ipaddr_region
exe s:h . "ipaddr_anyerror" . s:rev . s:fgred

syn match ipaddr_otherkw_param excludenl /.\+$/ contained 
exe s:h . "ipaddr_otherkw_param" . s:fgorange

" add more keywords that follow "ip address" in various places below as needed.
syn match ipaddr_other_keywords "prefix-lists:" nextgroup=ipaddr_otherkw_param skipwhite containedin=ipaddr_region
exe s:h . "ipaddr_other_keywords" . s:bold . s:keyword2

syn match ipaddr_cidr contained excludenl   /\v[/]\d{1,3}/
exe s:h . "ipaddr_cidr" . s:italic . s:keyword1

syn match ipaddr excludenl /\v(25[0-4]|2[0-4]\d|1\d{1,2}|[1-9]\d|[1-9])\.(25[0-5]|2[0-4]\d|1\d\d|\d{1,2})\.(25[0-5]|2[0-4]\d|1\d\d|\d{1,2})\.(25[0-5]|2[0-4]\d|1\d\d|\d{1,2})/ nextgroup=ipaddr_cidr,subnetmask,wildcard,skipwhite contained 
exe s:h . "ipaddr" . s:fgpink

syn region ipaddr_subnetmask_in_ipaddr matchgroup=subnetmask start=/\v(0|192|224|240|248|252|254|255)\.(0|128|192|240|224|248|252|254|255)\.(0|128|192|224|240|248|252|254|255)\.(0|128|192|224|240|248|252|254|255)/ end=/$/ keepend skipwhite transparent excludenl contains=subnetmask contained

syn region ipaddr_in_gigamonipaddr matchgroup=ipaddr start=/\v(25[0-4]|2[0-4]\d|1\d\d|\d{1,2})\.(25[0-5]|2[0-4]\d|1\d\d|\d{1,2}|0)\.(25[0-5]|2[0-4]\d|1\d\d|\d{1,2}|0)\.(25[0-5]|2[0-4]\d|1\d\d|\d{1,2})/ end=/$/ keepend skipwhite excludenl transparent contains=ipaddr_cidr,ipaddr,ipaddr_subnetmask_in_ipaddr contained

syn region ipaddr_region matchgroup=ipaddr_kw start=/ip addr[e]\{,1}[s]\{,1}[s]\{,1}/rs=e+1 end=/$/ contains=ipaddr_in_gigamonipaddr keepend excludenl transparent skipwhite

"}}}
" Prompts {{{
"syn match config_prompt /^[^ ]\{-1,63}([a-zA-Z\-]*)#/ contained

syn match config_prompt_hostname excludenl  /^[^ ]\{-1,63} (/ contained nextgroup=config_word
exe s:h . "config_prompt_hostname" . s:fgwhite . s:bgbluegreen

syn match config_word excludenl /config/ contained nextgroup=config_prompt_end
exe s:h . "config_word" . s:fgwhite . s:bgred

syn match config_prompt_end excludenl /) #/ contained 
exe s:h . "config_prompt_end" . s:fgwhite . s:bgbluegreen

syn match hash_prompt excludenl  /^[^ ]\{-1,63} \#/ excludenl
exe s:h . "hash_prompt" . s:bold . s:fgwhite . s:bgbluegreen

syn region config_prompt_reg keepend start=/^[a-zA-Z0-9]\{-1,63} ([a-zA-Z\-]*) #/ end=" " transparent contains=config_prompt_hostname,config_word,config_mode,config_prompt_end


"}}}
" Gigamon Port names {{{
" This is the secion where the interface name is highlighted.
syn match gigamon_port_bid excludenl /\d\// contained nextgroup=gigamon_port_slot skipwhite
exe s:h . "gigamon_port_bid" . s:ul_bold . s:fgcyan

syn match gigamon_port_slot excludenl /\d\// contained nextgroup=gigamon_port_number skipwhite
exe s:h . "gigamon_port_slot" . s:ul_bold . s:fggreen

syn match gigamon_port_number excludenl /[gqx]\d\{1,2}\.\{,2}[gxq]\{,2}\d\{,2}/ contained nextgroup=gigamonsub_port skipwhite
exe s:h . "gigamon_port_number"  . s:ul_bold . s:fgyellow

syn region gigamonintregion excludenl start="\d\/\d\/[gqx]\d\{1,2}\.\{,2}[gxq]\{,2}\d\{,2}" end=/$/ end="[,-.: ]\|\s"re=e-1 transparent contains=gigamon_port_bid

"}}}

" Link Status {{{
"
syn match link_status_label /Link Status:/ contained skipwhite
exe s:h . "link_status_label" . s:bold . s:keyword1

syn match link_status_up /\v 1 {0,1}/ contained
exe s:h . "link_status_up" . s:bold . s:fggreen . s:bgblack

syn match link_status_down /\v 0 {0,1}/ contained
exe s:h . "link_status_down" . s:bold . s:emphasis

syn region Link_Status matchgroup=link_status_label keepend start=/Link Status:/ end=/$/ transparent contains=link_status_up,link_status_down
" }}}

let b:current_syntax = "gigamon"

