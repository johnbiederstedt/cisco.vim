" Notes {{{
" Vim syntax file
" Language: cisco configuration files
" Version: .625
" 
" Inception: 29-jan-2006
" Inspiration:  Harry Schroeder's original cisco vim syntax file, and a discussion
"               on reddit.com in the vim subreddit on highlighting ip addresses in
"               a syntax file in 2005.  Grown from there.
" Notes:    
"           This does not follow the conventional notion in vim of separate
"           language and color definition files.  That's because cisco
"           configuration syntax, in spite of the misnomer 'code' used when
"           referring to cisco config files, is not a language.  It has no
"           branch logic, data structures, or flow control.  Moreover, in
"           terms purely of syntax, is doesn't have a consistent structure and
"           form.  Configuration lines do not express logic, but rather
"           command parameters.  The chief structure are subcommands, and
"           depending on the command chosen, there are a variable number of
"           nested subcommand mixed with parameters.  Also, I wanted to
"           underline major mode commands like 'interface' and underlining
"           isn't really available in all the syntax mode.  Pandoc does it,
"           but depending on the color scheme it's not always there and in
"           general it's confusing to highlight a command or subcomand using
"           tags meant for programming languages.  What's really needed are
"           tags for the cisco command structure.
"
"           So rather than define new two files, one for colors of highlighted
"           elements and one for determing which configuration words are
"           catagorized as which highlighting elements, all is in one file, to
"           simplify the process of adding new command/configuration line
"           elements.  To add highlighting for a new configuration line, a new
"           section is added to this file. However, in time a consistent
"           logical heirarchy may emerge as a result of this effort, and a
"           workable list of configuration syntax elements consistent and
"           common across all cisco gear and configurations may come into
"           existance.  At that point it will make sense to split this file
"           out into color theme and syntax definition files.
"
"
"           While there are a large collection of keywords as in Schroeder's work, 
"           a smaller set was chosen and highlighting changed so later keywords 
"           in a config line would receive different highlighting.
"
"
"           The most significant change was added when the Conqueterm plugin
"           became available, and a terminal session could be opened in a vim
"           buffer.  That allowed live terminal sessions to be highlighted
"           using a vim syntax file.  Chiefly, error conditions were given
"           initial attention, mostly in the output of 'show interface'
"           command.  From there other selected elements in command output
"           such as versions, interface status, and other items of interest.
"
"           Used with ConqueTerm running bash there is an undesireable side
"           effect when connecting to cisco nexus equipment, when a backspace
"           will 'blank' a line.  
"           To get around this:
"           :ConqueTerm screen -c ~/.screenrcnull
"
"           where .screenrcnull has:
"           vbell off
"
"           screen apparently cleans out what I think are superfluous CR or
"           LF characters the Conqueterm doesn't like.
"
"           The foreground colors will as such look the same in any color
"           scheme, so this will look good on some schemes like solarized, and
"           not as good in others, depending on the background.  In essence,
"           about all switching color schemes will do is change the background
"           color and the color of the default text.
"
"           A quick note about versioning.  Currently, three digits are used
"           past the decimal point, i.e. .621 where .622 indicates minor
"           tweaks to highlighting in the third digit.  Whereas .63 would
"           indicate a new subcommand.  This is not a particularily good
"           versioning system right now, so this will likely change in the
"           near future.
"
" Recent Revision notes:
"           .623
"               Added a global variable g:cisco_background, since I use a
"               terminal with a middle grey background that gives both black
"               and white charactes about the same visibility, about #888888.
"               This is checked for first if the mode is cterm, othewise
"               ignored.
"           .624
"               fixed big number interface rate highlighting
"               changed the switchport command to use keyword/parameter
"               conventions
"               misc removal of old color explicit highlighting syntax
"
"           .625
"               fixes some of the error highlighting for the output of
"               'show interface'
"
"
"
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
        if g:cisco_background == "grey"
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
" show interface error conditions {{{
syn match int_errors /[1-9][0-9]* collision[s]\{0,1}/ 
syn match int_errors /[1-9][0-9]* runts/ 
syn match int_errors /[1-9][0-9]* giants/ 
syn match int_errors /[1-9][0-9]* throttles/ 
syn match int_errors /[1-9][0-9]* input errors/ 
syn match int_errors /[1-9][0-9]* CRC/ 
syn match int_errors /[1-9][0-9]* frame/ 
syn match int_errors /[1-9][0-9]* overrun/ 
syn match int_errors /[1-9][0-9]* ignored/ 
syn match int_errors /[1-9][0-9]* watchdog/ 
syn match int_errors /[1-9][0-9]* input packets with dribble condition detected/ 
syn match int_errors /[1-9][0-9]* input discard/ 
syn match int_errors /[1-9][0-9]* output discard/ 
syn match int_errors /[1-9][0-9]* output error[s]\{0,1}/ 
syn match int_errors /[1-9][0-9]* unknown protocol drops/ 
syn match int_errors /[1-9][0-9]* babble[s]\{0,1}/ 
syn match int_errors /[1-9][0-9]* late collision/ 
syn match int_errors /[1-9][0-9]* deferred/ 
syn match int_errors /[1-9][0-9]* lost carrier/ 
syn match int_errors /[1-9][0-9]* no carrier/ 
syn match int_errors /[1-9][0-9]* no buffer/ 
syn match int_errors /[1-9][0-9]* input errors*/ 
syn match int_errors /[1-9][0-9]* short frame/ 
syn match int_errors /[1-9][0-9]* bad etype drop/ 
syn match int_errors /[1-9][0-9]* bad proto drop/ 
syn match int_errors /[1-9][0-9]* if down drop/ 
syn match int_errors /[1-9][0-9]* input with dribble/ 
syn match int_errors /[1-9][0-9]* output buffer failures/ 
syn match int_errors /[1-9][0-9]* underrun/ 
syn match int_errors /[1-9][0-9]* ignored/ 
syn match int_errors /[1-9][0-9]* storm suppression/ 
syn match int_errors /[1-9][0-9]* abort/ 
syn match int_errors /[eE]rr[Dd]isable[d ]/ 
exe s:h . " int_errors " . s:error

"}}}
" colorize big numbers {{{
" This is the *wrong* way to do it, but was a field expediant addition

" mini theme for bits per second.
let s:bitssec  = s:fglightblue
let s:kbitssec = s:fggreen
let s:mbitssec = s:fgorange
let s:gbitssec = s:fgyellow
let s:tbitssec = s:fgmagenta

" Bandwidth {{{ 1
syn region mbitsec_reg start=/\(BW\|bandwidth is\) [0-9]\{4} / end=/Kbit/ oneline keepend contains=mbitsec1b,mbitsec2b
syn match mbitsec2b excludenl  /[0-9]\{3}/ contained
exe s:h . " mbitsec2b " . s:bold . s:kbitssec
syn match mbitsec1b excludenl  /[0-9]\{1}/ contained nextgroup=mbitsec2b
exe s:h . " mbitsec1b " . s:bold . s:mbitssec

syn region mbitsec_reg1 start=/\(BW\|bandwidth is\) [0-9]\{5} / end=/Kbit/ oneline keepend contains=mbitsec3b,mbitsec4b
syn match mbitsec3b excludenl  /[0-9]\{3}/ contained
exe s:h . " mbitsec3b " . s:bold . s:kbitssec
syn match mbitsec4b excludenl  /[0-9]\{2}/ contained nextgroup=mbitsec3b
exe s:h . " mbitsec4b " . s:bold . s:mbitssec

syn region mbitsec_reg2 start=/\(BW\|bandwidth is\) [0-9]\{6} / end=/Kbit/ oneline keepend contains=mbitsec5b,mbitsec6b
syn match mbitsec6b excludenl  /[0-9]\{3}/ contained
exe s:h . " mbitsec6b " . s:bold . s:kbitssec
syn match mbitsec5b excludenl  /[0-9]\{3}/ contained nextgroup=mbitsec6b
exe s:h . " mbitsec5b " . s:bold . s:mbitssec


syn region gbitsec_reg start=/\(BW\|bandwidth is\) [0-9]\{7} / end=/Kbit/ oneline keepend contains=gbitsec2b,gbitsec3b,gbitsec4b
syn match gbitsec4b excludenl  /[0-9]\{3}/ contained 
exe s:h . " gbitsec4b " . s:bold . s:kbitssec
syn match gbitsec3b excludenl  /[0-9]\{3}/ contained nextgroup=gbitsec4b
exe s:h . " gbitsec3b " . s:bold . s:mbitssec
syn match gbitsec2b excludenl  /[0-9]\{1}/ contained nextgroup=gbitsec3b
exe s:h . " gbitsec2b " . s:bold . s:gbitssec

syn region gbitsec_reg2 start=/\(BW\|bandwidth is\) [0-9]\{8} / end=/Kbit/ oneline keepend contains=gbitsec5b,gbitsec6b,gbitsec7b
syn match gbitsec7b excludenl  /[0-9]\{3}/ contained 
exe s:h . " gbitsec7b " . s:bold . s:kbitssec
syn match gbitsec6b excludenl  /[0-9]\{3}/ contained nextgroup=gbitsec7b
exe s:h . " gbitsec6b " . s:bold . s:mbitssec
syn match gbitsec5b excludenl  /[0-9]\{2}/ contained nextgroup=gbitsec6b
exe s:h . " gbitsec5b " . s:bold . s:gbitssec

syn region gbitsec_reg3 start=/\(BW\|bandwidth is\) [0-9]\{9} / end=/Kbit/ oneline keepend contains=gbitsec8b,gbitsec9b,gbitsec10b
syn match gbitsec10b excludenl  /[0-9]\{3}/ contained 
exe s:h . " gbitsec10b " . s:bold . s:kbitssec
syn match gbitsec9b excludenl  /[0-9]\{3}/ contained nextgroup=gbitsec10b
exe s:h . " gbitsec9b " . s:bold . s:mbitssec
syn match gbitsec8b excludenl  /[0-9]\{3}/ contained nextgroup=gbitsec9b
exe s:h . " gbitsec8b " . s:bold . s:gbitssec


syn region tbitsec_reg start=/\(BW\|bandwidth is\) [0-9]\{10} / end=/Kbit/ oneline keepend contains=tbitsec2b,tbitsec3b,tbitsec4b,tbitsec5b
syn match tbitsec5b excludenl /[0-9]\{3}/ contained 
exe s:h . " tbitsec5b " . s:bold . s:kbitssec
syn match tbitsec4b excludenl /[0-9]\{3}/ contained nextgroup=tbitsec5b
exe s:h . " tbitsec4b " . s:bold . s:mbitssec
syn match tbitsec3b excludenl /[0-9]\{3}/ contained nextgroup=tbitsec4b
exe s:h . " tbitsec3b " . s:bold . s:gbitssec
syn match tbitsec2b excludenl /[0-9]\{1}/ contained nextgroup=tbitsec3b
exe s:h . " tbitsec2b " . s:bold . s:tbitssec
"}}} 1

" input/output bits per second {{{ 1
syn region bitsec_reg start=/ \(rate\|is\) [0-9]\{2,3} / end=/bit\/sec/ oneline keepend contains=bitsec
syn match bitsec excludenl /[0-9]\{1,3}/ contained 
exe s:h . " bitsec " . s:bold . s:bitssec

syn region kbitsec_reg start=/\(is\|rate\) [0-9]\{4} / end=/bit/  oneline keepend contains=kbitsec1,kbitsec2
syn match kbitsec2 excludenl /[0-9]\{3}/ contained 
exe s:h . " kbitsec2 " . s:bold . s:bitssec
syn match kbitsec1 excludenl  /[0-9]\{1}/ contained nextgroup=kbitsec2
exe s:h . " kbitsec1 " . s:bold . s:kbitssec

syn region kbitsec_reg2 start=/\(is\|rate\) [0-9]\{5} / end=/bit/  oneline keepend contains=kbitsec3,kbitsec4 
syn match kbitsec4 excludenl /[0-9]\{3}/ contained 
exe s:h . " kbitsec4 " . s:bold . s:bitssec
syn match kbitsec3 excludenl  / [0-9]\{2}/ contained nextgroup=kbitsec4
exe s:h . " kbitsec3 " . s:bold . s:kbitssec

syn region kbitsec_reg3 start=/\(is\|rate\) [0-9]\{6} / end=/bit/  oneline keepend contains=kbitsec5,kbitsec6
syn match kbitsec6 excludenl /[0-9]\{3}/ contained 
exe s:h . " kbitsec6 " . s:bold . s:bitssec
syn match kbitsec5 excludenl  / [0-9]\{3}/ contained nextgroup=kbitsec6
exe s:h . " kbitsec5 " . s:bold . s:kbitssec



syn region mbitsec_reg start=/\(is\|rate\) [0-9]\{7} / end=/bit/ oneline keepend contains=mbitsec1,mbitsec2,mbitsec3
syn match mbitsec3 excludenl  /[0-9]\{3}/ contained 
exe s:h . " mbitsec3 " . s:bold . s:bitssec
syn match mbitsec2 excludenl  /[0-9]\{3}/ contained nextgroup=mbitsec3
exe s:h . " mbitsec2 " . s:bold . s:kbitssec
syn match mbitsec1 excludenl  /[0-9]\{1}/ contained nextgroup=mbitsec2
exe s:h . " mbitsec1 " . s:bold . s:mbitssec

syn region mbitsec_reg2 start=/\(is\|rate\) [0-9]\{8} / end=/bit/ oneline keepend contains=mbitsec4,mbitsec5,mbitsec6
syn match mbitsec6 excludenl  /[0-9]\{3}/ contained 
exe s:h . " mbitsec6 " . s:bold . s:bitssec
syn match mbitsec5 excludenl  /[0-9]\{3}/ contained nextgroup=mbitsec6
exe s:h . " mbitsec5 " . s:bold . s:kbitssec
syn match mbitsec4 excludenl  /[0-9]\{2}/ contained nextgroup=mbitsec5
exe s:h . " mbitsec4 " . s:bold . s:mbitssec

syn region mbitsec_reg3 start=/\(is\|rate\) [0-9]\{9} / end=/bit/ oneline keepend contains=mbitsec9,mbitsec8,mbitsec7
syn match mbitsec7 excludenl  /[0-9]\{3}/ contained 
exe s:h . " mbitsec7 " . s:bold . s:bitssec
syn match mbitsec8 excludenl  /[0-9]\{3}/ contained nextgroup=mbitsec7
exe s:h . " mbitsec8 " . s:bold . s:kbitssec
syn match mbitsec9 excludenl  /[0-9]\{3}/ contained nextgroup=mbitsec8
exe s:h . " mbitsec9 " . s:bold . s:mbitssec



syn region gbitsec_reg start=/\(is\|rate\) [0-9]\{10} / end=/bit/ oneline keepend contains=gbitsec1,gbitsec2,gbitsec3,gbitsec4
syn match gbitsec4 excludenl  /[0-9]\{3}/ contained 
exe s:h . " gbitsec4 " . s:bold . s:bitssec
syn match gbitsec3 excludenl  /[0-9]\{3}/ contained nextgroup=gbitsec4
exe s:h . " gbitsec3 " . s:bold . s:kbitssec
syn match gbitsec2 excludenl  /[0-9]\{3}/ contained nextgroup=gbitsec3
exe s:h . " gbitsec2 " . s:bold . s:mbitssec
syn match gbitsec1 excludenl  /[0-9]\{1}/ contained nextgroup=gbitsec2
exe s:h . " gbitsec1 " . s:bold . s:gbitssec

syn region gbitsec_reg2 start=/\(is\|rate\) [0-9]\{11} / end=/bit/ oneline keepend contains=gbitsec5,gbitsec6,gbitsec7,gbitsec8
syn match gbitsec8 excludenl  /[0-9]\{3}/ contained 
exe s:h . " gbitsec8 " . s:bold . s:bitssec
syn match gbitsec7 excludenl  /[0-9]\{3}/ contained nextgroup=gbitsec8
exe s:h . " gbitsec7 " . s:bold . s:kbitssec
syn match gbitsec6 excludenl  /[0-9]\{3}/ contained nextgroup=gbitsec7
exe s:h . " gbitsec6 " . s:bold . s:mbitssec
syn match gbitsec5 excludenl  /[0-9]\{2}/ contained nextgroup=gbitsec6
exe s:h . " gbitsec5 " . s:bold . s:gbitssec

syn region gbitsec_reg3 start=/\(is\|rate\) [0-9]\{12} / end=/bit/ oneline keepend contains=gbitsec9,gbitsec10,gbitsec11,gbitsec12
syn match gbitsec12 excludenl  /[0-9]\{3}/ contained 
exe s:h . " gbitsec12 " . s:bold . s:bitssec
syn match gbitsec11 excludenl  /[0-9]\{3}/ contained nextgroup=gbitsec12
exe s:h . " gbitsec11 " . s:bold . s:kbitssec
syn match gbitsec10 excludenl  /[0-9]\{3}/ contained nextgroup=gbitsec11
exe s:h . " gbitsec10 " . s:bold . s:mbitssec
syn match gbitsec9 excludenl  /[0-9]\{3}/ contained nextgroup=gbitsec10
exe s:h . " gbitsec9 " . s:bold . s:gbitssec


syn region tbitsec_reg start=/\(is\|rate\) [0-9]\{13} / end=/bit/ oneline keepend contains=tbitsec1,tbitsec2,tbitsec3,tbitsec4,tbitsec5
syn match tbitsec5 excludenl /[0-9]\{3}/ contained 
exe s:h . " tbitsec5 " . s:bold . s:bitssec
syn match tbitsec4 excludenl /[0-9]\{3}/ contained nextgroup=tbitsec5
exe s:h . " tbitsec4 " . s:bold . s:kbitssec
syn match tbitsec3 excludenl /[0-9]\{3}/ contained nextgroup=tbitsec4
exe s:h . " tbitsec3 " . s:bold . s:mbitssec
syn match tbitsec2 excludenl /[0-9]\{3}/ contained nextgroup=tbitsec3
exe s:h . " tbitsec2 " . s:bold . s:gbitssec
syn match tbitsec1 excludenl /[0-9]\{1}/ contained nextgroup=tbitsec2
exe s:h . " tbitsec1 " . s:bold . s:tbitssec
"}}} 1


"}}}
" other show interface info of interest {{{
syn match channel_members /Members in this channel:/ 
exe s:h . " channel_members " . s:fgmagenta

syn match half_duplex /[Hh]alf-duplex/ 
exe s:h . " half_duplex " . s:fgwhite . s:bgred

syn region media_type excludenl start=/media type is /hs=e+1 end=/$/ excludenl
exe s:h . " media_type " . s:fgpurple

syn match output_drops /output drops: [1-9][0-9]*/ excludenl
exe s:h . " output_drops " . s:bold . s:fgwhite . s:bgred

syn match no_input_output_rate /rate 0 bits\/sec/hs=s+4 
exe s:h . " no_input_output_rate " . s:fgred

syn match tx_rx_load /[rt]xload [0-9]\{1,3}\/[0-9]\{1,3}/ excludenl
exe s:h . " tx_rx_load " . s:fgblue

syn match jumbos /[1-9][0-9]* jumbo/ 
exe s:h . "jumbos" . s:bold . s:bgred

syn match is_down /is down/ 
exe s:h . " is_down " . s:ul . s:fgred

syn match is_up /is up/
exe s:h . " is_up " . s:ul . s:fggreen

syn match int_resets /[1-9][0-9]* interface resets/ excludenl
exe "hi int_resets " . s:bold . s:fgred

"syn cluster show_interface_highlights contains=input_output_rate,is_down,is_up,int_resets,ciscodescription

syn match rxtx_pause /[1-9][0-9]* [RT]x pause/
exe s:h . " rxtx_pause " . s:fgred . s:bgemph

syn match lastclearing /Last clearing of "show interface" counters/ nextgroup=lastclearing_time skipwhite
exe s:h . " lastclearing " . s:italic

syn match lastclearing_time /.*$/ contained excludenl
exe s:h . "lastclearing_time" . s:fgorange

syn match output_buffers_swapped_out /[1-9][0-9]* output buffers swapped out/ excludenl
exe s:h . "output_buffers_swapped_out" . s:bold . s:fgred

syn match SFP_not_inserted /SFP not inserted/
exe s:h . "SFP_not_inserted" . s:bgyellow . s:fgred

"}}}
" Interface names {{{
" This is the secion where the interface name is highlighted.
syn match ciscointerfacetype excludenl /[A-Za-z\-]\{2,} \{0,1}/                 nextgroup=ciscointerfacenumber skipwhite contained keepend
syn match ciscointerfacetype excludenl /[vV][Ee]th \{0,1}/                      nextgroup=ciscointerfacenumber skipwhite contained keepend
syn match ciscointerfacetype excludenl /[vV][Ee]thernet \{0,1}/                 nextgroup=ciscointerfacenumber skipwhite contained keepend
syn match ciscointerfacetype excludenl /[Ee]th \{0,1}/                          nextgroup=ciscointerfacenumber skipwhite contained keepend
syn match ciscointerfacetype excludenl /[Ee]thernet \{0,1}/                     nextgroup=ciscointerfacenumber skipwhite contained keepend
syn match ciscointerfacetype excludenl /[Ff]a \{0,1}/                           nextgroup=ciscointerfacenumber skipwhite contained keepend
syn match ciscointerfacetype excludenl /[Ff]as \{0,1}/                          nextgroup=ciscointerfacenumber skipwhite contained keepend
syn match ciscointerfacetype excludenl /[Ff]ast[Ee]thernet \{0,1}/              nextgroup=ciscointerfacenumber skipwhite contained keepend
syn match ciscointerfacetype excludenl /[Gg]i \{0,1}/                           nextgroup=ciscointerfacenumber skipwhite contained keepend
syn match ciscointerfacetype excludenl /[Gg]ig \{0,1}/                          nextgroup=ciscointerfacenumber skipwhite contained keepend
syn match ciscointerfacetype excludenl /[Gg]igabit[Ee]thernet \{0,1}/           nextgroup=ciscointerfacenumber skipwhite contained keepend
syn match ciscointerfacetype excludenl /[Tt]e \{0,1}/                           nextgroup=ciscointerfacenumber skipwhite contained keepend
syn match ciscointerfacetype excludenl /[Tt]en \{0,1}/                          nextgroup=ciscointerfacenumber skipwhite contained keepend
syn match ciscointerfacetype excludenl /[Tt]en[Gg]i \{0,1}/                     nextgroup=ciscointerfacenumber skipwhite contained keepend
syn match ciscointerfacetype excludenl /[Tt]en[Gg]igabit[Ee]thernet \{0,1}/     nextgroup=ciscointerfacenumber skipwhite contained keepend
syn match ciscointerfacetype excludenl /[Dd]ot11[Rr]adio \{0,1}/                nextgroup=ciscointerfacenumber skipwhite contained keepend
syn match ciscointerfacetype excludenl /[Ss]er \{0,1}/                          nextgroup=ciscointerfacenumber skipwhite contained keepend
syn match ciscointerfacetype excludenl /[Ss]erial \{0,1}/                       nextgroup=ciscointerfacenumber skipwhite contained keepend
syn match ciscointerfacetype excludenl /[Ll]o \{0,1}/                           nextgroup=ciscointerfacenumber skipwhite contained keepend
syn match ciscointerfacetype excludenl /[Ll]oopback \{0,1}/                     nextgroup=ciscointerfacenumber skipwhite contained keepend
syn match ciscointerfacetype excludenl /[Tt]un \{0,1}/                          nextgroup=ciscointerfacenumber skipwhite contained keepend
syn match ciscointerfacetype excludenl /[Tt]unnel \{0,1}/                       nextgroup=ciscointerfacenumber skipwhite contained keepend
syn match ciscointerfacetype excludenl /[Pp]o \{0,1}/                           nextgroup=ciscointerfacenumber skipwhite contained keepend
syn match ciscointerfacetype excludenl /[Pp]ort.\{0,1}[cC]hannel \{0,1}/        nextgroup=ciscointerfacenumber skipwhite contained keepend
syn match ciscointerfacetype excludenl /[Vv]l \{0,1}/                           nextgroup=ciscointerfacenumber skipwhite contained keepend
syn match ciscointerfacetype excludenl /[Vv]lan \{0,1}/                         nextgroup=ciscointerfacenumber skipwhite contained keepend
syn match ciscointerfacetype excludenl /[Pp][Vv]lan \{0,1}/                     nextgroup=ciscointerfacenumber skipwhite contained keepend
syn match ciscointerfacetype excludenl /mgmt/                                   nextgroup=ciscointerfacenumber skipwhite contained keepend
syn match ciscointerfacetype excludenl /Null0/ contained keepend
exe s:h . "ciscointerfacetype" . s:ul_bold . s:fgcyan

syn match ciscointerfacenumber excludenl /\d\{1,4}/ contained nextgroup=interfacenumberafterslash skipwhite keepend
exe s:h . "ciscointerfacenumber" . s:ul_bold . s:fgyellow

syn match interfacenumberafterslash excludenl /\/\d\{1,2}\/\{0,1}\d\{0,2}/ contained nextgroup=ciscosubinterface skipwhite keepend
exe s:h . "interfacenumberafterslash"  . s:ul_bold . s:fgyellow

syn match ciscosubinterface excludenl /[:.]\{0,1}\d\{0,4}/ contained keepend
exe s:h . "ciscosubinterface" . s:ul_bold . s:fgorange
" this section is where the interface name region is detected.  Above is where
" it is highlighted
syn region ciscointregion excludenl start="\v[vV][eE]th {0,1}\d{-1,4}[^0-9a-zA-Z]"          end=/$/ end="[,-: ]\|\s"re=e-1 transparent contains=ciscointerfacetype
syn region ciscointregion excludenl start="\v[vV][eE]thernet {0,1}\d{-1,4}"                 end=/$/ end="[,-: ]\|\s"re=e-1 transparent contains=ciscointerfacetype
syn region ciscointregion excludenl start="\v[eE]th {0,1}\d{-1,3}[^0-9a-zA-Z]"              end=/$/ end="[,-: ]\|\s"re=e-1 transparent contains=ciscointerfacetype
syn region ciscointregion excludenl start="\v[eE]thernet {0,1}\d{-1,3}"                     end=/$/ end="[,-: ]\|\s"re=e-1 transparent contains=ciscointerfacetype
syn region ciscointregion excludenl start="\v[fF]as{0,1} {0,1}\d{-1,2}[^0-9a-zA-Z]"         end=/$/ end="[,-: ]\|\s" transparent contains=ciscointerfacetype
syn region ciscointregion excludenl start="\v[fF]ast[eE]thernet {0,1}\d{-1,2}"              end=/$/ end="[,-: ]\|\s" transparent contains=ciscointerfacetype
syn region ciscointregion excludenl start="\v[gG]ig{0,1} {0,1}\d{-1,2}[^0-9a-zA-Z]"         end=/$/ end="[,-: ]\|\s" transparent contains=ciscointerfacetype
syn region ciscointregion excludenl start="\v[gG]igabit[eE]thernet {0,1}\d{-1,2}"           end=/$/ end="[,-: ]\|\s" transparent contains=ciscointerfacetype
syn region ciscointregion excludenl start="\v[tT]en{0,1} {0,1}\d{-1,2}[^0-9a-zA-Z]"         end=/$/ end="[,-: ]\|\s" transparent contains=ciscointerfacetype
syn region ciscointregion excludenl start="\v[tT]en[gG]i {0,1}\d{-1,2}"                     end=/$/ end="[,-: ]\|\s" transparent contains=ciscointerfacetype
syn region ciscointregion excludenl start="\v[tT]en[gG]igabit[eE]thernet {0,1}\d{-1,2}"     end=/$/ end="[,-: ]\|\s" transparent contains=ciscointerfacetype
syn region ciscointregion excludenl start="\v[Dd]ot11[Rr]adio {0,1}\d{-1,2}"                end=/$/ end="[,-: ]\|\s" transparent contains=ciscointerfacetype
syn region ciscointregion excludenl start="\v[pP]o {0,1}\d{-1,4}[^0-9a-zA-Z]"               end=/$/ end="[,-: ]\|\s" transparent contains=ciscointerfacetype
syn region ciscointregion excludenl start="\v[pP]ort.{0,1}[Cc]hannel {0,1}\d{-1,4}"         end=/$/ end="[,-: ]\|\s" transparent contains=ciscointerfacetype
syn region ciscointregion excludenl start="\v[vV]lan {0,1}\d{-1,4}"                         end=/$/ end="[,-: ]\|\s" transparent contains=ciscointerfacetype
syn region ciscointregion excludenl start="\v[vV]l {0,1}\d{-1,4}"                           end=/$/ end="[,-: ]\|\s" transparent contains=ciscointerfacetype
syn region ciscointregion excludenl start="\v[pP][vV]lan {0,1}\d{-1,2}"                     end=/$/ end="[,-: ]\|\s" transparent contains=ciscointerfacetype
syn region ciscointregion excludenl start="\v[lL]oopback {0,1}\d{-1,2}"                     end=/$/ end="[,-: ]\|\s" transparent contains=ciscointerfacetype
syn region ciscointregion excludenl start="\v[tT]unnel {0,1}\d{-1,2}"                       end=/$/ end="[,-: ]\|\s" transparent contains=ciscointerfacetype
syn region ciscointregion excludenl start="\v[sS]erial {0,1}\d{-1,2}"                       end=/$/ end="[,-: ]\|\s" transparent contains=ciscointerfacetype
syn region ciscointregion excludenl start="\v[lL]o {0,1}\d{1,4}[^0-9a-zA-Z]"                end=/$/ end="[,-: ]\|\s" transparent contains=ciscointerfacetype
syn region ciscointregion excludenl start="\v[tT]un {0,1}\d{1,4}[^0-9a-zA-Z]"               end=/$/ end="[,-: ]\|\s" transparent contains=ciscointerfacetype
syn region ciscointregion excludenl start="\v[sS]er {0,1}\d{1,4}[^0-9a-zA-Z]"               end=/$/ end="[,-: ]\|\s" transparent contains=ciscointerfacetype
syn region ciscointregion excludenl start="\vmgmt\d{1,2}[^0-9a-zA-Z]"                       end=/$/ end="[,-: ]\|\s" transparent contains=ciscointerfacetype
syn region ciscointregion excludenl start="Null0"                                           end=/$/ end="[,-: ]\|\s" transparent contains=ciscointerfacetype

syn region dont_highlight excludenl start=/\v[a-zA-Z0-9][Tt]e {0,1}\d{-1,2}/                end=/$/ end="[,:]\|\s" contains=nohighlight
syn region dont_highlight excludenl start=/\v[a-zA-Z0-9][Gg]i {0,1}\d{-1,2}/                end=/$/ end="[,:]\|\s" contains=nohighlight
syn match nohighlight /.*/ contained keepend

"}}}
" interface line config highlighting region {{{

syn match ciscointerface /^int / contained nextgroup=ciscointerfacetype skipwhite keepend
syn match ciscointerface /^interface / contained nextgroup=ciscointerfacetype skipwhite keepend
syn match ciscointerface /^Interface:/ contained nextgroup=ciscointerfacetype skipwhite keepend
exe s:h . "ciscointerface" . s:ul_bold . s:keyword1

syn region interfaceregion  excludenl start="^int[e]\{,1}[r]\{,1}[f]\{,1}[a]\{,1}[c]\{,1}[e]\{,1}" end=".$" transparent keepend contains=ciscointerface

"}}}
" vservices creation line {{{
syn match vserviceline /vservice /          contained containedin=vserviceline_config nextgroup=vserviceline_mode
exe s:h . "vserviceline" . s:ul_bold . s:keyword1

syn match vserviceline_mode /global /       contained containedin=vserviceline nextgroup=vserviceline_kw1
syn match vserviceline_mode /node /         contained containedin=vserviceline nextgroup=vserviceline_node_name
syn match vserviceline_mode /path /         contained containedin=vserviceline nextgroup=vserviceline_path_name
exe s:h . "vserviceline_mode" . s:ul . s:fgorange

syn match vserviceline_kw1 /type /          contained nextgroup=vserviceline_type
exe s:h . "vserviceline_kw1" . s:ul . s:keyword2

syn match vserviceline_type /[^ ]\+$/       contained
exe s:h . "vserviceline_type" . s:ul_bold . s:fgpurple

syn match vserviceline_path_name /[^ ]\+/   contained 
exe s:h . "vserviceline_path_name" . s:ul . s:fgcyan

syn match vserviceline_node_name /[^ ]\+ /  contained nextgroup=vserviceline_kw1
exe s:h . "vserviceline_node_name" . s:ul . s:fgcyan

syn region vserviceline_config start=/^vservice / end=/.$/ excludenl transparent keepend contains=vserviceline

"}}}
" vservice line mirrors vservice creation line sans underline {{{
syn match vservice /vservice /          contained containedin=vservice_line nextgroup=vservice_mode
exe s:h . "vservice" .  s:keyword1

syn match vservice_mode /path /         contained containedin=vservice nextgroup=vservice_path_name
exe s:h . "vservice_mode" . s:fgorange

syn match vservice_path_name /[^ ]\+/   contained 
exe s:h . "vservice_path_name" . s:fgcyan

syn region vservice_line start=/^  vservice / end=/.$/ excludenl transparent keepend contains=vservice

"}}}
" Nexus 1000v org line in port profiles {{{
syn match org_root /^  org root\// nextgroup=org_root_name


syn match org_root_name /[^ /]\+/ contained containedin=org_root_slash
exe s:h . "org_root_name" . s:bold . s:fgcyan

"}}}
" port-profile config highlighting region {{{

syn match port_profile /\v^port-p[r]{0,1}[o]{0,1}[f]{0,1}[i]{0,1}[l]{0,1}[e]{0,1} / skipwhite contained nextgroup=port_profile_kw
syn match port_profile excludenl /^port-profile / skipwhite contained containedin=port_profile_region nextgroup=port_profile_kw
exe s:h . "port_profile" . s:ul_bold . s:keyword1

syn match port_profile_kw /type / skipwhite contained containedin=port_profile nextgroup=port_profiletype
exe s:h ."port_profile_kw" . s:ul . s:keyword2

syn match port_profiletype /vethernet / contained containedin=port_profile_kw nextgroup=port_profilename
exe s:h . "port_profiletype" . s:ul . s:fgblue

syn match port_profilename /[^ ]\+$/ contained containedin=port_profiletype
exe s:h . "port_profilename" . s:ul_bold . s:fggreen

syn region port_profile_region  start="\v^port-p[r]{,1}[o]{,1}[f]{,1}[i]{,1}[l]{,1}[e]{,1}" end="$" transparent keepend contains=port_profile

" kind of related
syn region port_profile_default_region matchgroup=port_profile_default_group start="\v^port-profile default" end="$" transparent keepend contains=port_profile_defaults

syn match port_profile_default_group excludenl /\v^port-profile default/ skipwhite contained containedin=port_profile_default_region
exe s:h . "port_profile_default_group" . s:keyword1

syn match port_profile_defaults excludenl /max-ports /    skipwhite contained containedin=port_profile_default_region nextgroup=port_profile_default_param
syn match port_profile_defaults excludenl /port-binding / skipwhite contained containedin=port_profile_default_region nextgroup=port_profile_default_param
exe s:h . "port_profile_defaults" . s:keyword2

syn match port_profile_default_param /[^ ]\+$/ skipwhite contained containedin=port_profile_defaults
exe s:h . "port_profile_default_param" . s:parameter


"}}}
" virtual-service-blade config highlighting region {{{

syn match virtual_service_blade /\v^vi[r]{0,1}[t]{0,1}[u]{0,1}[a]{0,1}[l]{0,1}[-]{0,1}[s]{0,1}[e]{0,1}[r]{0,1}[v]{0,1}[i]{0,1}[c]{0,1}[e]{0,1}[-]{0,1}[b]{0,1}[l]{0,1}[a]{0,1}[d]{0,1}[e]{0,1} / skipwhite contained nextgroup=virtual_service_bladetype_kw
syn match virtual_service_blade /^virtual-service-blade / contained containedin=virtual_service_blade_region nextgroup=virtual_service_blade_name
exe s:h . "virtual_service_blade" . s:ul_bold . s:fglightmagenta

syn match virtual_service_blade_name /[^ ]\+$/ contained containedin=virtual_service_blade_region
exe s:h . "virtual_service_blade_name" . s:ul_bold . s:fggreen

syn region virtual_service_blade_region  start="\v^vi[r]{0,1}[t]{0,1}[u]{0,1}[a]{0,1}[l]{0,1}[-]{0,1}[s]{0,1}[e]{0,1}[r]{0,1}[v]{0,1}[i]{0,1}[c]{0,1}[e]{0,1}[-]{0,1}[b]{0,1}[l]{0,1}[a]{0,1}[d]{0,1}[e]{0,1}" end=".$" transparent keepend contains=virtual_service_blade

"}}}
" show cdp neighbor  {{{

syn match DeviceID_text excludenl /[^ ()]\+/ contained nextgroup=DeviceID_Serial keepend
exe s:h . "DeviceID_text" . s:ul_bold . s:fgblue

syn match DeviceID_Serial excludenl /(.*)/ contained keepend
exe s:h . "DeviceID_Serial" . s:fgorange

syn match DeviceID_kw excludenl /Device ID: \?/ nextgroup=DeviceID_text
"exe s:h . "DeviceID_kw" . s:fgblue

"syn region DeviceID start="Device ID:" end=".$" contains=DeviceID_kw,DeviceID_Serial,DeviceID_text keepend transparent 

syn match SystemName_text excludenl /[^ ]\+/ contained keepend
exe s:h . "SystemName_text" . s:fgblue

syn match SystemName_KW excludenl /System Name:/ keepend nextgroup=SystemName_text skipwhite
"exe s:h . "SystemName_KW" . s:fgblue

"syn region SystemName start="System Name:" end=".$" contains=SystemName_KW,SystemName_text keepend transparent 

"}}}
" Misc Global Keywords {{{
" 
syntax match ciscono / no /
syntax match ciscono /^no /
exe s:h . "ciscono" . s:fgred

syn match connected /connected/ 
exe s:h . "connected" . s:fggreen

syn match notconnect /not *connect/
syn match notconnect /not *connec[t]\{,1}[e]\{,1}[d]\{,1}/
syn match notconnect /secViolEr/
syn match notconnect /errDisable/
exe s:h . "notconnect" . s:rev . s:fgred

syn match ciscodisable /disable[d]/
exe s:h . "ciscodisable" . s:bold_rev . s:fgorange

syn region vlan_list_reg start=/^vlan [0-9]\{-1,4},/ end="$" contains=vlan_kw,vlan_number transparent keepend
syn match vlan_kw /vlan/ contained
exe s:h . "vlan_kw" . s:keyword1

syn match vlan_number /\d\{1,4}/ contained
exe s:h . "vlan_number" . s:fgparameter

syn match hostname_keyword /hostname / nextgroup=hostname
exe s:h . "hostname_keyword" . s:keyword1

syn match hostname /[^ ]\+ */ contained
exe s:h . "hostname" . s:parameter2 . s:underline

syn match name_keyword / name / nextgroup=name_text
syn match name_keyword /^name / nextgroup=name_text
exe s:h . "name_keyword" . s:keyword1

syn match name_text /[^ ]\+ */ contained
exe s:h . "name_text" . s:parameter2 . s:underline

syn match version_keyword /[vV]ersion/ contained
exe s:h . "version_keyword" . s:keyword1

syn match version_number excludenl /[^ ]\+ */ contained containedin=version_region
exe s:h . "version_number" . s:parameter2 . s:underline

syn region version_region matchgroup=version_keyword start=/[Vv]ersion / end=/$/ end=/ / keepend transparent skipwhite contains=version_number

syn match feature_keyword /feature / nextgroup=feature
exe s:h . "feature_keyword" . s:keyword1

syn match feature /[^ ]\+ */ contained
exe s:h . "feature" . s:parameter2

syn match permit_statement /permit/
exe s:h . "permit_statement" . s:fggreen 

syn match deny_statement /deny/
exe s:h . "deny_statement" . s:fgred 

syn match match_any_keyword /match-any / nextgroup=match_any_text
exe s:h . "match_any_keyword" . s:parameter4

syn match match_any_text /[^ ]\+ */ contained
exe s:h . "match_any_text" . s:parameter2 

syn match keyword2 / location/ nextgroup=name_text skipwhite
syn match keyword2 /contact/ nextgroup=name_text skipwhite
exe s:h . "keyword2" . s:keyword1

syn match boot_system_flash_phrase /boot system flash / nextgroup=boot_image_name skipwhite
exe s:h . "boot_system_flash_phrase" . s:keyword1

syn match boot_image_name /.*/ contained
exe s:h . "boot_image_name" . s:parameter2

syn match interface_speed /^ \?speed/ nextgroup=speed skipwhite
exe s:h . " interface_speed " . s:keyword1

syn match speed /[0-9]\{2,5}/ contained
exe s:h . " speed " . s:bold . s:parameter

syn match duplex_error excludenl /\v[^ ]+/ contained
exe s:h . " duplex_error " . s:rev . s:fgred

syn match interface_duplex /^ \?duplex/ nextgroup=duplex_full,duplex_half,duplex_auto,duplex_error skipwhite
exe s:h . " interface_duplex " . s:keyword1

syn match duplex_auto /auto/ contained containedin=interface_duplex
exe s:h . "duplex_auto" . s:bold . s:parameter

syn match duplex_half /half/ contained containedin=interface_duplex
exe s:h . " duplex_half " . s:parameter5

syn match duplex_full /full/ contained containedin=interface_duplex
exe s:h . " duplex_full " . s:parameter

"syn match cisco_no /no /he=e-1
"exe s:h " cisco_no " . s:bold

syn match shutdown /shutdown/
exe s:h . "shutdown" . s:parameter5

syn match no_shutdown /no shut/
syn match no_shutdown /no shutdown/
exe s:h . "no_shutdown" . s:bold . s:fggreen 

"}}}
" show vlan region {{{
"syntax match vlannumber /^[0-9]\{1,4}/ contained nextgroup=vlanname
"HiLink    vlannumber       Keyword
"syntax match vlanname /[a-zA-Z]\{1,32}/ contained
"HiLink    vlanname         Repeat  
"syntax region showvlan start="sh.*vl" end="^[^ ]\{1,63}#" end=/[\r]\{1,63}\#/ contains=vlannumber,ciscointerfacetype,more,ciscointregion,hash_prompt
"}}}
" MTU {{{
syn match MTU_kw excludenl /mtu/ nextgroup=MTU_parameter skipwhite
exe s:h . "MTU_kw" . s:keyword1

syn match MTU_parameter excludenl /[0-9]\{3,4}/ contained
exe s:h . "MTU_parameter" . s:parameter

"}}}

" Interface Description and comment highlighting {{{

syn match ciscodescription excludenl /[dD]escription[:]\{0,1}/ nextgroup=ciscodescriptiontext skipwhite
exe s:h . "ciscodescription" . s:keyword1

syn match ciscodescriptiontext excludenl /.*$/ contained
exe s:h . "ciscodescriptiontext" . s:description

syn match commenttext excludenl /.*$/ contained
exe s:h . "commenttext"  . s:italic . s:fggray 

syn region comment excludenl start=/\!/ end=/$/ contains=commenttext keepend transparent

"}}}
" route-map highlighting {{{
syn match routemap_match_WORD /[^ ]\+ */ contained
exe s:h . "routemap_match_WORD" . s:parameter2

syn match routemap_match_kw1 /address/                skipwhite contained containedin=routemap_match_region
syn match routemap_match_kw1 /access-group/           skipwhite contained containedin=routemap_match_region
syn match routemap_match_kw1 /name/                   skipwhite contained containedin=routemap_match_region nextgroup=routemap_match_WORD
syn match routemap_match_kw1 /next-hop/               skipwhite contained containedin=routemap_match_region
syn match routemap_match_kw1 /route-source/           skipwhite contained containedin=routemap_match_region
syn match routemap_match_kw1 /prefix-list/            skipwhite contained containedin=routemap_match_region
syn match routemap_match_kw1 /redistribution-source/  skipwhite contained containedin=routemap_match_region
syn match routemap_match_kw1 /multicast/              skipwhite contained containedin=routemap_match_region
syn match routemap_match_kw1 /unicast/                skipwhite contained containedin=routemap_match_region
syn match routemap_match_kw1 /level-1/                skipwhite contained containedin=routemap_match_region
syn match routemap_match_kw1 /level-2/                skipwhite contained containedin=routemap_match_region
syn match routemap_match_kw1 /local/                  skipwhite contained containedin=routemap_match_region
syn match routemap_match_kw1 /nssa-external/          skipwhite contained containedin=routemap_match_region
syn match routemap_match_kw1 /external/               skipwhite contained containedin=routemap_match_region
syn match routemap_match_kw1 /internal/               skipwhite contained containedin=routemap_match_region
syn match routemap_match_kw1 /bgp/                    skipwhite contained containedin=routemap_match_region
syn match routemap_match_kw1 /connected/              skipwhite contained containedin=routemap_match_region
syn match routemap_match_kw1 /eigrp/                  skipwhite contained containedin=routemap_match_region
syn match routemap_match_kw1 /isis/                   skipwhite contained containedin=routemap_match_region
syn match routemap_match_kw1 /mobile/                 skipwhite contained containedin=routemap_match_region
syn match routemap_match_kw1 /ospf/                   skipwhite contained containedin=routemap_match_region
syn match routemap_match_kw1 /rip /                   skipwhite contained containedin=routemap_match_region
syn match routemap_match_kw1 /static/                 skipwhite contained containedin=routemap_match_region
syn match routemap_match_kw1 /as-path/                skipwhite contained containedin=routemap_match_region
syn match routemap_match_kw1 /cln /                   skipwhite contained containedin=routemap_match_region
syn match routemap_match_kw1 /community/              skipwhite contained containedin=routemap_match_region
syn match routemap_match_kw1 /extcommunity/           skipwhite contained containedin=routemap_match_region
syn match routemap_match_kw1 /interface/              skipwhite contained containedin=routemap_match_region
syn match routemap_match_kw1 /ip /                    skipwhite contained containedin=routemap_match_region
syn match routemap_match_kw1 /ipv6/                   skipwhite contained containedin=routemap_match_region
syn match routemap_match_kw1 /length/                 skipwhite contained containedin=routemap_match_region
syn match routemap_match_kw1 /local-preference/       skipwhite contained containedin=routemap_match_region
syn match routemap_match_kw1 /metric/                 skipwhite contained containedin=routemap_match_region
syn match routemap_match_kw1 /mpls-label/             skipwhite contained containedin=routemap_match_region
syn match routemap_match_kw1 /nlri/                   skipwhite contained containedin=routemap_match_region
syn match routemap_match_kw1 /policy-list/            skipwhite contained containedin=routemap_match_region
syn match routemap_match_kw1 /route-type/             skipwhite contained containedin=routemap_match_region
syn match routemap_match_kw1 /source-protocol/        skipwhite contained containedin=routemap_match_region
syn match routemap_match_kw1 /tag /                   skipwhite contained containedin=routemap_match_region
exe s:h . "routemap_match_kw1" . s:keyword1

syn match routemap_match_kw /match / contained
exe s:h . "routemap_match_kw" . s:keyword1

syn region routemap_match_region matchgroup=routemap_match_kw start=/[ ]*[ ]\+match / end=/$/ transparent contains=routemap_match_kw1

"}}}
" Cisco vrf highlighting {{{
syn match vrf_kw /vrf/ contained nextgroup=vrf_keyword skipwhite
exe s:h . "vrf_kw" . s:keyword1

syn match vrf_keyword /context/     contained nextgroup=vrf_name skipwhite
syn match vrf_keyword /member/      contained nextgroup=vrf_name skipwhite
syn match vrf_keyword /forwarding/  contained nextgroup=vrf_name skipwhite
exe s:h . "vrf_keyword" . s:keyword3

syn match vrf_name /[^ ]\+ */ contained
exe s:h . "vrf_name" . s:parameter5

syn region vrf_region start="vrf context" start="vrf forwarding" start="vrf member" end="$" keepend transparent contains=vrf_kw, vrf_keyword

"}}}
" switchport command {{{
" This is a good example of why cisco highlighting can't really be done well
" in the context of highlighting a conventional programming language.  One
" could simply re-use keyword, preproc, repeat, and so forth, but it's more
" straightforward to just say "purple", blue, green, and so forth.  That said,
" the highlighting variable "s:keyword" is used in places, but not to the
" extent of "s:keyword,2,3,4" and so on.  That's one approach that would
" make it easier to have custom color schemes, but that also doesn't fit the
" paradigm of highlighting a conventional programming language.
"
" TODO  make these local to each subgroup, even at the expense of defining
"       the same pattern with different names

"syn match switchport_kw_err excludenl /\v[^ ]+/ contained 
"exe s:h . "switchport_kw_err" . s:rev . s:fgred

syn match encapsulation_tag excludenl /\v[0-9]{1,4}/ contained 
syn match encapsulation_tag excludenl /ethertype/ contained 
exe s:h . "encapsulation_tag" . s:parameter2

syn match switchport_keyword /switchport/
exe s:h . "switchport_keyword" . s:keyword1

" the base set following the root.
" TODO  each should get its own subregion
syn match switchport_base_kwds excludenl /access/         contained 
syn match switchport_base_kwds excludenl /autostate/      contained skipwhite nextgroup=switchport_autostate_kw,switchport_kw_err
syn match switchport_base_kwds excludenl /backup/         contained skipwhite nextgroup=switchport_backup_kw,switchport_kw_err
syn match switchport_base_kwds excludenl /block/          contained skipwhite nextgroup=switchport_block_kw,switchport_kw_err
syn match switchport_base_kwds excludenl /capture/        contained 
syn match switchport_base_kwds excludenl /dot1q /         contained
syn match switchport_base_kwds excludenl /host/           contained 
syn match switchport_base_kwds excludenl /mode/           contained skipwhite nextgroup=switchport_mode_kwds
syn match switchport_base_kwds excludenl /monitor/        contained 
syn match switchport_base_kwds excludenl /trunk/          contained 
syn match switchport_base_kwds excludenl /port-security/  contained 
syn match switchport_base_kwds excludenl /private-vlan/   contained skipwhite nextgroup=switchport_mode_privatevlan_kwds 
syn match switchport_base_kwds excludenl /block/          contained 
syn match switchport_base_kwds excludenl /priority/       contained 
syn match switchport_base_kwds excludenl /encapsulation/  contained 
exe s:h . "switchport_base_kwds" . s:keyword2

" the switchport_command region contains subregions which in turn have end of line terminations
syn region switchport_command matchgroup=switchport_keyword start=/switchport/rs=e+1 end=/$/ contains=switchport_base_kwds,ethernet_address skipwhite keepend transparent

" switchport command nextgroups {{{2

syn match switchport_autostate_kw excludenl /exclude/ contained containedin=switchport_base_kwds skipwhite
exe s:h . "switchport_autostate_kw" . s:keyword3

syn match switchport_backup_kw excludenl /interface/ contained containedin=switchport_base_kwds skipwhite nextgroup=ciscointerfacetype
exe s:h . "switchport_backup_kw" . s:keyword3

syn match switchport_block_kw /unicast/ contained
syn match switchport_block_kw /multicast/ contained
exe s:h . "switchport_block_kw" . s:keyword4
"hi switchport_block_kw ctermfg=red guifg=darkorange

"}}}
" switchport dot1q ethertype {{{2

syn match switchport_dot1q_kw /[dD]ot1[qQ] / contained containedin=switchport_dot1q_ethertype_region
exe s:h . "switchport_dot1q_kw" . s:keyword2 

syn match switchport_dot1q_ethertype_kw /ethertype/ contained containedin=switchport_dot1q_ethertype_region skipwhite nextgroup=switchport_dot1q_ethertype_value
exe s:h . "switchport_dot1q_ethertype_kw" . s:keyword3

syn match switchport_dot1q_ethertype_value /0x[6-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]/ contained containedin=switchport_dot1q_ethertype_kw
exe s:h . "switchport_dot1q_ethertype_value" . s:parameter

syn region switchport_dot1q_ethertype_region start=/[dD]ot1[qQ] ethertype/ end=/$/ transparent contained containedin=switchport_command
"}}}
" switchport capture allowed vlan {{{2

syn match switchport_capture_allowed_vlan excludenl  /add/     contained containedin=switchport_capture_allowed_vlan_region skipwhite nextgroup=switchport_capture_allowed_vlan_kw
syn match switchport_capture_allowed_vlan excludenl  /except/  contained containedin=switchport_capture_allowed_vlan_region skipwhite nextgroup=switchport_capture_allowed_vlan_kw
syn match switchport_capture_allowed_vlan excludenl  /remove/  contained containedin=switchport_capture_allowed_vlan_region skipwhite nextgroup=switchport_capture_allowed_vlan_kw
syn match switchport_capture_allowed_vlan excludenl  /all/     contained containedin=switchport_capture_allowed_vlan_region
exe s:h . "switchport_capture_allowed_vlan" . s:keyword3 

syn match switchport_capture_allowed_vlan_kw excludenl  /vlan/ contained containedin=switchport_capture_allowed_vlan_region
exe s:h . "switchport_capture_allowed_vlan_kw" . s:keyword4

syn match switchport_capture_allowed_kw excludenl  /allowed/ contained containedin=switchport_capture_allowed_vlan_region
exe s:h . "switchport_capture_allowed_kw" . s:keyword5

syn match switchport_capture_allowed_vlan_list excludenl  /[0-9,-]\+/ contained containedin=switchport_capture_allowed_vlan
exe s:h . "switchport_capture_allowed_vlan_list" . s:parameter

syn region switchport_capture_allowed_vlan_region matchgroup=switchport_base_kwds start=/capture allowed vlan/rs=e-13 end=/$/ contains=switchport_kw_err skipwhite transparent contained containedin=switchport_command
"}}}
" switchport access {{{2

syn match switchport_conf_access_vlan_kw excludenl  /vlan/ skipwhite contained containedin=switchport_conf_access nextgroup=switchport_conf_access_kw_WORDS
exe s:h . "switchport_conf_access_vlan_kw" . s:keyword4 

syn match switchport_conf_access_kw_WORDS excludenl  /[0-9 ,]\+/ contained containedin=switchport_conf_access
exe s:h . "switchport_conf_access_kw_WORDS" . s:parameter 

syn region switchport_conf_access matchgroup=switchport_base_kwds start=/access/rs=e end=/$/ skipwhite contained containedin=switchport_command

"}}}
" switchport trunk {{{2

syn match switchport_trunk_kwds /encapsulation/ contained skipwhite containedin=switchport_trunk nextgroup=switchport_trunk_encap_kwds
syn match switchport_trunk_kwds /ethertype/     contained skipwhite containedin=switchport_trunk nextgroup=switchport_trunk_ethertype_value
syn match switchport_trunk_kwds /pruning/       contained skipwhite containedin=switchport_trunk nextgroup=switchport_trunk_pruning_vlan_list
syn match switchport_trunk_kwds /allowed/       contained skipwhite containedin=switchport_trunk 
syn match switchport_trunk_kwds /native/        contained skipwhite containedin=switchport_trunk 
exe s:h . "switchport_trunk_kwds" . s:keyword3

syn match switchport_trunk_encap_kwds /encapsulation [Dd]ot1[qQ]/ms=s+13,hs=s+13 contained containedin=switchport_trunk_encap_kwds
syn match switchport_trunk_encap_kwds /[iI][sS][lL]/ contained containedin=switchport_trunk_kwds,switchport_trunk,switchport_command
syn match switchport_trunk_encap_kwds /negotiate/ contained containedin=switchport_trunk_kwds,switchport_trunk
exe s:h . "switchport_trunk_encap_kwds" . s:keyword4 

syn match switchport_trunk_native_vlan_ID /\d\{-1,4}/ contained containedin=switchport_trunk_kwds
syn match switchport_trunk_native_vlan_ID /tag/       contained containedin=switchport_trunk_kwds
exe s:h . "switchport_trunk_native_vlan_ID" . s:parameter 

syn match switchport_trunk_ethertype_value /0x[05-9a-fA-F][e-fE-F]\{0,1}[fF]\{0,1}[fF]\{0,1}/ contained containedin=switchport_trunk_kwds
exe s:h . "switchport_trunk_ethertype_value" . s:parameter

syn match switchport_trunk_pruning_vlan_list /[0-9,\- ]\+/ contained containedin=switchport_trunk_kwds
exe s:h . "switchport_trunk_pruning_vlan_list" . s:parameter

" switchport trunk may have subregions that in turn have end of line terminations
syn region switchport_trunk matchgroup=switchport_base_kwds start=/trunk/rs=e end=/$/ skipwhite keepend transparent contained containedin=switchport_command
"}}}
" switchport trunk allowed vlan {{{2
syn match switchport_trunk_allowed_vlan_kwds /add/      skipwhite contained containedin=switchport_trunk_allowed_vlan_region nextgroup=switchport_trunk_allowed_vlan_list
syn match switchport_trunk_allowed_vlan_kwds /all/      skipwhite contained containedin=switchport_trunk_allowed_vlan_region
syn match switchport_trunk_allowed_vlan_kwds /except/   skipwhite contained containedin=switchport_trunk_allowed_vlan_region nextgroup=switchport_trunk_allowed_vlan_list
syn match switchport_trunk_allowed_vlan_kwds /remove/   skipwhite contained containedin=switchport_trunk_allowed_vlan_region nextgroup=switchport_trunk_allowed_vlan_list
syn match switchport_trunk_allowed_vlan_kwds /none/     contained 
exe s:h . "switchport_trunk_allowed_vlan_kwds" . s:keyword5

syn match switchport_trunk_allowed_vlan_list /\v[0-9,\- ]+/ contained containedin=switchport_trunk_allowed_vlan_kwds,switchport_trunk_allowed_vlan_region
exe s:h . "switchport_trunk_allowed_vlan_list" . s:parameter

"syn match switchport_trunk_allowed_kw /allowed/ contained excludenl containedin=switchport_trunk_allowed_vlan_region
"exe s:h . "switchport_trunk_allowed_kw" . s:keyword4

syn match switchport_trunk_allowed_vlan_kw /vlan/ contained containedin=switchport_trunk_allowed_vlan_region nextgroup=switchport_trunk_allowed_vlan_list
exe s:h . "switchport_trunk_allowed_vlan_kw" . s:keyword4

" NOTE: inserting 'keepend' here breaks it, but removing 'keepend' up at the switchport_trunk region definition also breaks it
syn region switchport_trunk_allowed_vlan_region matchgroup=switchport_trunk_kwds start=/allowed/ end=/$/ skipwhite transparent contained containedin=switchport_command

"}}}
" switchport trunk native vlan {{{2

syn match switchport_trunk_native_vlan_list /\v[0-9,-]+/ contained containedin=switchport_trunk_native_vlan_kw,switchport_trunk_native_vlan_region
exe s:h . "switchport_trunk_native_vlan_list" . s:parameter

syn match switchport_trunk_native_kw /native/ contained containedin=switchport_trunk_native_vlan_region
exe s:h . "switchport_trunk_native_kw" . s:keyword3

syn match switchport_trunk_native_vlan_kw /vlan/ contained containedin=switchport_trunk_native_vlan_region
exe s:h . "switchport_trunk_native_vlan_kw" . s:keyword4

syn region switchport_trunk_native_vlan_region matchgroup=switchport_trunk_kwds start=/native/ end=/$/ skipwhite transparent contained containedin=switchport_trunk,switchport_command

"}}}
" switchport mode private-vlan {{{2

syn match switchport_mode_privatevlan_kwds /host/               contained skipwhite containedin=switchport_privatevlan
syn match switchport_mode_privatevlan_kwds /promiscuous/        contained skipwhite containedin=switchport_privatevlan
syn match switchport_mode_privatevlan_kwds /mapping/            contained skipwhite containedin=switchport_privatevlan nextgroup=switchport_privatevlan_1
syn match switchport_mode_privatevlan_kwds /native/             contained skipwhite containedin=switchport_privatevlan nextgroup=switchport_privatevlan_1
syn match switchport_mode_privatevlan_kwds /allowed/            contained skipwhite containedin=switchport_privatevlan nextgroup=switchport_privatevlan_1
syn match switchport_mode_privatevlan_kwds /vlan/               contained skipwhite containedin=switchport_privatevlan nextgroup=switchport_privatevlan_1
syn match switchport_mode_privatevlan_kwds /trunk/              contained skipwhite containedin=switchport_privatevlan nextgroup=switchport_trunk
syn match switchport_mode_privatevlan_kwds /host\-association/   contained skipwhite containedin=switchport_privatevlan nextgroup=switchport_privatevlan_1
exe s:h . "switchport_mode_privatevlan_kwds" . s:keyword4

syn match switchport_privatevlan_1 /\v[0-9\- ]+/ contained containedin=switchport_mode_privatevlan_kwds skipwhite nextgroup=switchport_privatevlan_2
exe s:h . "switchport_privatevlan_1" . s:parameter2

syn match switchport_privatevlan_2 /\v[0-9\- ]+/ contained 
exe s:h . "switchport_privatevlan_2" . s:parameter4
"hi switchport_privatevlan_2 ctermfg=red guifg=red gui=italic

syn region switchport_privatevlan matchgroup=switchport_base_kwds start=/private-vlan/rs=e+1 end=/$/ contains=switchport_kw_err skipwhite transparent keepend contained containedin=switchport_trunk,switchport_mode

" }}}
" switchport mode {{{2
syn match switchport_mode_kwds /access/             contained containedin=switchport_mode
syn match switchport_mode_kwds /dot1q\-tunnel/      contained containedin=switchport_mode
syn match switchport_mode_kwds /fex\-fabric/        contained containedin=switchport_mode
syn match switchport_mode_kwds /trunk/              contained containedin=switchport_mode
syn match switchport_mode_kwds /dynamic/            contained containedin=switchport_mode
syn match switchport_mode_kwds /dot1[qQ]\-tunnel/   contained containedin=switchport_mode
syn match switchport_mode_kwds /private-vlan/       contained containedin=switchport_mode skipwhite nextgroup=parameter
exe s:h . "switchport_mode_kwds" . s:keyword3

syn region switchport_mode matchgroup=switchport_base_kwds start=/mode/rs=e end=/$/ skipwhite transparent contained containedin=switchport_command
" }}}
"
" switchport block {{{2
syn match switchport_block_kw /unicast/     contained containedin=switchport_block
syn match switchport_block_kw /multicast/   contained containedin=switchport_block
exe s:h . "switchport_block_kw" . s:keyword3
"hi switchport_block_kw ctermfg=darkyellow

syn region switchport_block matchgroup=switchport_base_kwds start=/block/rs=e end=/$/ contains=switchport_kw_err skipwhite transparent contained containedin=switchport_command
"}}}
"switchport priority {{{2

syn match switchport_priority_extend_kw /extend/    contained containedin=switchport_priority nextgroup=switchport_priority_extend_words
exe s:h . "switchport_priority_extend_kw" . s:keyword3

syn match switchport_priority_extend_words /trust/  contained containedin=switchport_priority 
syn match switchport_priority_extend_words /[0-7]/  contained containedin=switchport_priority
syn match switchport_priority_extend_words /cos/    contained skipwhite containedin=switchport_priority nextgroup=switchport_extent_cos_values
exe s:h . "switchport_priority_extend_words" . s:keyword4

syn match switchport_extent_cos_values /[0-9]\{-1,3}/ contained containedin=switchport_priority_extend_words
exe s:h . "switchport_extent_cos_values" . s:parameter3

syn region switchport_priority matchgroup=switchport_base_kwds start=/priority/rs=e+1 end=/$/ contains=switchport_kw_err contained transparent skipwhite containedin=switchport_command

"}}}
" encapsulation command {{{

syn match encapsulation_error /\v[^ ]+/ contained
exe s:h . "encapsulation_error" . s:rev . s:fgred

syn match encapsulation_kw /encapsulation/ contained excludenl containedin=encapsulation_command skipwhite nextgroup=encapsulation_type
exe s:h . "encapsulation_kw" . s:fgblue

" encapsulation_tag was defined in switchport command - re-using it in this region
syn match encapsulation_type /dot1[Qq]/ contained excludenl skipwhite nextgroup=encapsulation_tag
exe s:h . "encapsulation_type" . s:fgmagenta

"syn region encapsulation_command excludenl start=/encapsulation / end=/$/ contains=encapsulation_error keepend transparent
syn region encapsulation_command excludenl start=/encapsulation / end=/$/ keepend transparent

" }}}
" channeling {{{
" NOTE: this is currently a template to be backmigrated to other areas if it
" works out well - JDB 1/9/2015

syn region channel_group_region start=/channel-group / end=/$/ transparent 

syn match channel_group_kw /channel-group/ contained containedin=channel_group_region skipwhite nextgroup=channel_group_number
exe s:h . "channel_group_kw" . s:keyword1

syn match channel_group_number /\v[0-9]+/ contained skipwhite nextgroup=channel_group_mode_kw
exe s:h . "channel_group_number" . s:parameter

syn match channel_group_mode_kw /mode/ contained skipwhite nextgroup=channel_group_mode
exe s:h . "channel_group_mode_kw" . s:keyword2

syn match channel_group_mode /on/           contained
syn match channel_group_mode /active/       contained
syn match channel_group_mode /passive/      contained
syn match channel_group_mode /auto/         contained
syn match channel_group_mode /desirable/    contained
exe s:h . "channel_group_mode" . s:parameter

syn region channel_protocol_region start=/channel-protocol / end=/$/ transparent 

syn match channel_protocol_kw /channel-protocol/ contained containedin=channel_protocol_region skipwhite nextgroup=channel_protocol
exe s:h "channel_protocol_kw" . s:keyword1

syn match channel_protocol /lacp/ contained skipwhite
syn match channel_protocol /pagp/ contained skipwhite
exe s:h . "channel_protocol" . s:parameter

" LACP port priority {{{2
syn region lacp_priority_region start=/lacp port\-prior/ end=/$/ transparent 

syn match lacp_kw /lacp/ contained containedin=lacp_priority_region contained skipwhite containedin=lacp_priority_region
exe s:h . "lacp_kw" . s:keyword1

syn match lacp_port_priority_kw /port\-priority/ contained skipwhite containedin=lacp_priority_region nextgroup=lacp_port_priority
exe s:h . "lacp_port_priority_kw" . s:keyword2

syn match lacp_port_priority /\v[0-9]+/ contained skipwhite containedin=lacp_priority_region
exe s:h . "lacp_port_priority" . s:parameter
"}}}
" }}}
" interface mode ip subcommands {{{
"
"TODO: build out each KW into it's own region

syn region int_ip_reg matchgroup=int_ip_KW start=/^ \{1,2}ip \|# \{1,2}/ end=/$/ keepend transparent contains=int_ip_reg_KW,ipaddr_in_ciscoipaddr

syn match int_ip_KW /ip/ contained containedin=int_ip_reg
exe s:h . "int_ip_KW" . s:keyword1

syn match int_ip_reg_KW /address/            skipwhite contained containedin=int_ip_reg 
syn match int_ip_reg_KW /arp/                skipwhite contained containedin=int_ip_reg 
syn match int_ip_reg_KW /authentication/     skipwhite contained containedin=int_ip_reg 
syn match int_ip_reg_KW /bandwidth/          skipwhite contained containedin=int_ip_reg 
syn match int_ip_reg_KW /bandwidth-percent/  skipwhite contained containedin=int_ip_reg 
syn match int_ip_reg_KW /delay/              skipwhite contained containedin=int_ip_reg 
syn match int_ip_reg_KW /directed-broadcast/ skipwhite contained containedin=int_ip_reg 
syn match int_ip_reg_KW /distribute-list/    skipwhite contained containedin=int_ip_reg 
syn match int_ip_reg_KW /eigrp/              skipwhite contained containedin=int_ip_reg 
syn match int_ip_reg_KW /hello-interval/     skipwhite contained containedin=int_ip_reg 
syn match int_ip_reg_KW /hold-time/          skipwhite contained containedin=int_ip_reg 
syn match int_ip_reg_KW /igmp/               skipwhite contained containedin=int_ip_reg 
syn match int_ip_reg_KW /local-proxy-arp/    skipwhite contained containedin=int_ip_reg 
syn match int_ip_reg_KW /mtu/                skipwhite contained containedin=int_ip_reg 
syn match int_ip_reg_KW /next-hop-self/      skipwhite contained containedin=int_ip_reg 
syn match int_ip_reg_KW /offset-list/        skipwhite contained containedin=int_ip_reg 
syn match int_ip_reg_KW /passive-interface/  skipwhite contained containedin=int_ip_reg 
syn match int_ip_reg_KW /pim/                skipwhite contained containedin=int_ip_reg 
syn match int_ip_reg_KW /port-unreachable/   skipwhite contained containedin=int_ip_reg 
syn match int_ip_reg_KW /proxy-arp/          skipwhite contained containedin=int_ip_reg 
syn match int_ip_reg_KW /redirects/          skipwhite contained containedin=int_ip_reg 
syn match int_ip_reg_KW /router/             skipwhite contained containedin=int_ip_reg 
syn match int_ip_reg_KW /split-horizon/      skipwhite contained containedin=int_ip_reg 
syn match int_ip_reg_KW /summary-address/    skipwhite contained containedin=int_ip_reg 
syn match int_ip_reg_KW /unreachables/       skipwhite contained containedin=int_ip_reg 
exe s:h . "int_ip_reg_KW" . s:keyword2

" }}}

" ip {{{"{{{
syn region ip start=/^ip / end=/$/ keepend transparent 

syn match ip_route /route/ skipwhite contained containedin=ip nextgroup=ip_route_vrf
exe s:h . "ip_route" . s:fgbrown

syn match ip_route_vrf /vrf/ skipwhite contained containedin=ip_route nextgroup=ip_route_vrf_name skipwhite
exe s:h . "ip_route_vrf" . s:bold . s:fgcyan

syn match ip_route_vrf_name / [^ ]\+/ms=s+1 contained containedin=ip_route_vrf skipwhite
exe s:h . "ip_route_vrf_name" . s:none . s:fgbluegreen

syn cluster follows_ip_route contains=ipaddr,ip_route_vrf

syn match route_name_kw /name / skipwhite contained containedin=ip nextgroup=route_name_text
exe s:h . "route_name_kw" . s:fgbrown

syn match route_name_text /.*/ skipwhite contained 
exe s:h . "route_name_text" . s:fgbluegreen

syn match ip_address /address/ skipwhite contained containedin=ip
exe s:h . "ip_address" . s:parameter

" }}}"}}}
" prefix-list {{{
syn match prefix_name excludenl  / [^ ]\+/ skipwhite contained containedin=prefix_list_kw
exe s:h . "prefix_name" . s:fgbluegreen

syn match prefix_list_kw excludenl /prefix-list/ contained containedin=ip nextgroup=prefix_name skipwhite 
exe s:h . "prefix_list_kw" . s:keyword1

syntax cluster prefix_list contains=prefix_name,prefix_list_kw

syn match seq excludenl  /seq/ skipwhite contained transparent containedin=ip nextgroup=seqnum
exe s:h . "seq" . s:fgblue

syn match seqnum excludenl  /\v\d{1,5}/ skipwhite contained containedin=seq
exe s:h . "seqnum" . s:fggreen

"}}}
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

syn region ipaddr_in_ciscoipaddr matchgroup=ipaddr start=/\v(25[0-4]|2[0-4]\d|1\d\d|\d{1,2})\.(25[0-5]|2[0-4]\d|1\d\d|\d{1,2}|0)\.(25[0-5]|2[0-4]\d|1\d\d|\d{1,2}|0)\.(25[0-5]|2[0-4]\d|1\d\d|\d{1,2})/ end=/$/ keepend skipwhite excludenl transparent contains=ipaddr_cidr,ipaddr,ipaddr_subnetmask_in_ipaddr contained

syn region ipaddr_region matchgroup=ipaddr_kw start=/ip addr[e]\{,1}[s]\{,1}[s]\{,1}/rs=e+1 end=/$/ contains=ipaddr_in_ciscoipaddr keepend excludenl transparent skipwhite

"}}}
" log messages {{{

syntax match timestamp excludenl / \d\d:\d\d:\d\d[ .]/ keepend nextgroup=subseconds
exe s:h . "timestamp" . s:fgbluegreen

syntax match subseconds excludenl /\.\d\+/ contained keepend skipwhite 
exe s:h . "subseconds" . s:italic . s:fggray

syntax match ciscoerror excludenl /%[^ ]\{-}:/ keepend skipwhite excludenl
exe s:h . "ciscoerror" . s:bold . s:fgred

"syntax region message excludenl start=/\s \d\d/ end=/.\$/ contains=devicedaystamp,ciscoerror
"exe s:h . "region" . s:fgorange

"syntax match logtimestamp excludenl /\v\d\d:\d\d:\d\d\.+/ contained nextgroup=ciscodevice,subseconds skipwhite
"exe s:h . "match" . s:fgbluegreen

"syntax match logdaystamp /^\u\w\+\s\+\d\+\s/ nextgroup=logtimestamp skipwhite
"exe s:h . "match" . s:fgorange

"syntax match devicetimestamp /\d\d:\d\d:\d\d/ contained keepend
"exe s:h . "match" . s:fgbluegreen

"syntax match devicedaystamp / \u\w\+\s\+\d\+\s / nextgroup=devicetimestamp skipwhite keepend 
"exe s:h . "match" . s:fgorange

"}}}
" Prompts {{{
"syn match config_prompt /^[^ ]\{-1,63}([a-zA-Z\-]*)#/ contained
"exe s:h . "config_prompt" . s:fgwhite . s:bgbrown
"hi config_prompt ctermfg=white ctermbg=darkred guibg=firebrick guifg=white

syn match config_prompt_hostname excludenl  /^[^ ]\{-1,63}(/ contained nextgroup=config_word
exe s:h . "config_prompt_hostname" . s:fgwhite . s:bgbluegreen
"hi config_prompt_hostname ctermfg=white ctermbg=darkred guibg=firebrick guifg=white

syn match config_word excludenl /config/ contained 
exe s:h . "config_word" . s:fgwhite . s:bgred
"hi config_word ctermbg=red ctermfg=white guibg=red guifg=white

syn match config_mode excludenl /-[^ )]\{1,32}/ contained 
exe s:h . "config_mode" . s:fgwhite . s:bgorange
"hi config_mode ctermbg=darkyellow ctermfg=white guibg=darkorange guifg=white

syn match config_prompt_end excludenl /)#/ contained 
exe s:h . "config_prompt_end" . s:fgwhite . s:bgbluegreen
"hi config_prompt_end ctermfg=white ctermbg=darkred guibg=firebrick guifg=white

syn match hash_prompt excludenl  /^[^ ]\{-1,63}\#/ excludenl
exe s:h . "hash_prompt" . s:bold . s:fgwhite . s:bgbluegreen
"hi hash_prompt cterm=none ctermfg=white ctermbg=darkblue gui=bold guifg=white guibg=brown
syn region config_prompt_reg keepend start=/^[a-zA-Z0-9]\{-1,63}([a-zA-Z\-]*)#/ end=" " transparent contains=config_prompt_hostname,config_word,config_mode,config_prompt_end


"}}}

let b:current_syntax = "cisco"

