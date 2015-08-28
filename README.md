# cisco.vim
Vim syntax file to highlight cisco configuration files

To get this file, cd to ~/.vim/syntax and simply:

git clone https://github.com/johnbiederstedt/cisco.vim cisco.vim

You should now have the most recent copy of the file.

NOTEs:

This does not follow the conventional notion in vim of separate
language and color definition files.  That's because cisco
configuration syntax, in spite of the misnomer 'code' used when
referring to cisco config files, is not a language.  It has no
branch logic, data structures, or flow control.  Moreover, in
terms purely of syntax, is doesn't have a consistent structure and
form.  Configuration lines do not express logic, but rather
command parameters.  The chief structure are subcommands, and
depending on the command chosen, there are a variable number of
nested subcommand mixed with parameters.  Also, I wanted to
underline major mode commands like 'interface' and underlining
isn't really available in all the syntax mode.  Pandoc does it,
but depending on the color scheme it's not always there and in
general it's confusing to highlight a command or subcomand using
tags meant for programming languages.  What's really needed are
tags for the cisco command structure.

So rather than define new two files, one for colors of highlighted
elements and one for determing which configuration words are
catagorized as which highlighting elements, all is in one file, to
simplify the process of adding new command/configuration line
elements.  To add highlighting for a new configuration line, a new
section is added to this file. However, in time a consistent
logical heirarchy may emerge as a result of this effort, and a
workable list of configuration syntax elements consistent and
common across all cisco gear and configurations may come into
existance.  At that point it will make sense to split this file
out into color theme and syntax definition files.


While there are a large collection of keywords as in Schroeder's work, 
a smaller set was chosen and highlighting changed so later keywords 
in a config line would receive different highlighting.


The most significant change was added when the Conqueterm plugin
became available, and a terminal session could be opened in a vim
buffer.  That allowed live terminal sessions to be highlighted
using a vim syntax file.  Chiefly, error conditions were given
initial attention, mostly in the output of 'show interface'
command.  From there other selected elements in command output
such as versions, interface status, and other items of interest.

Used with ConqueTerm running bash there is an undesireable side
effect when connecting to cisco nexus equipment, when a backspace
will 'blank' a line.  
To get around this:
:ConqueTerm screen -c ~/.screenrcnull

where .screenrcnull has:
vbell off

screen apparently cleans out what I think are superfluous CR or
LF characters the Conqueterm doesn't like.

The foreground colors will as such look the same in any color
scheme, so this will look good on some schemes like solarized, and
not as good in others, depending on the background.  In essence,
about all switching color schemes will do is change the background
color and the color of the default text.

A quick note about versioning.  Currently, three digits are used
past the decimal point, i.e. .621 where .622 indicates minor
tweaks to highlighting in the third digit.  Whereas .63 would
indicate a new subcommand.  This is not a particularily good
versioning system right now, so this will likely change in the
near future.
