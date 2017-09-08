"
" cream-print -- All printing functionalities
"
" Cream -- An easy-to-use configuration of the famous Vim text editor
" [ http://cream.sourceforge.net ] Copyright (C) 2001-2011 Steve Hall
"
" License:
" This program is free software; you can redistribute it and/or modify
" it under the terms of the GNU General Public License as published by
" the Free Software Foundation; either version 2 of  the  License,  or
" (at your option) any later version.
" [ http://www.gnu.org/licenses/gpl.html ]
"
" This program is distributed in the hope that it will be useful,  but
" WITHOUT  ANY  WARRANTY;   without  even  the  implied  warranty   of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR  PURPOSE.  See  the  GNU
" General Public License for more details.
"
" You should have received a copy of the GNU  General  Public  License
" along with  this  program;  if  not,  write  to  the  Free  Software
" Foundation,  Inc.,   59  Temple  Place,   Suite  330,   Boston,   MA
" 02111-1307, USA.
"

" Cream_print() {{{1
function! Cream_print(mode)
" print and provides option dialog where plausible

	call Cream_print_init()

	if Cream_print_dialog() == -1
		return
	endif

	if a:mode == "v"
		let n = confirm(
			\ "Print selection or document?\n" .
			\ "\n", "&Selection\n&Document\n&Cancel", 1, "Info")
		if n == 1
			normal gv
			let firstline = line("'<")
			let lastline = line("'>")
			execute ":" . firstline . "," . lastline . "hardcopy"
		elseif n == 2
			hardcopy
		else
			return
		endif
	else
		hardcopy
	endif

endfunction

" Cream_print_dialog() {{{1
function! Cream_print_dialog()
" dialog current settings

	" string values
	let str = ""

	let str = str . "Print using these options?\n"
	let str = str . "\n"
	let str = str . "  Paper size:                  " . substitute(strpart(g:CREAM_PRINT_PAPERSIZE, 6), '\w\+', '\u&', 'g') . "\n"

	if match(g:CREAM_PRINT_ORIENTATION, "y$") != -1
		let str = str . "  Orientation:                 " . "Portrait" . "\n"
	else
		let str = str . "  Orientation:                 " . "Landscape" . "\n"
	endif

	let str = str . "\n"

	let str = str . "                                " . strpart(g:CREAM_PRINT_MARGIN_TOP, 4) . " (top)\n"
	let str = str . "  Margins:      " . strpart(g:CREAM_PRINT_MARGIN_LEFT, 5) . " (left)          " . strpart(g:CREAM_PRINT_MARGIN_RIGHT, 6) . " (right)\n"
	let str = str . "                                " . strpart(g:CREAM_PRINT_MARGIN_BOTTOM, 7) . " (bottom)\n"

	let str = str . "\n"

	let str = str . "  Header Height:            " . strpart(g:CREAM_PRINT_HEADER, 7) . " lines" . "\n"
	let str = str . "  Header Text:               " . "\"" . g:CREAM_PRINT_HEADER_TEXT . "\"" . "\n"

	let str = str . "\n"
	if match(g:CREAM_PRINT_SYNTAX, "y$") != -1
		let str = str . "  Syntax Highlighting:    " . "Yes" . "\n"
	elseif match(g:CREAM_PRINT_SYNTAX, "a$") != -1
		let str = str . "  Syntax Highlighting:    " . "Auto" . "\n"
	elseif match(g:CREAM_PRINT_SYNTAX, "n$") != -1
		let str = str . "  Syntax highlighting:    " . "No" . "\n"
	endif

	if match(g:CREAM_PRINT_NUMBER, "y$") != -1
		let str = str . "  Line Numbers:             " . "Yes" . "\n"
	else
		let str = str . "  Line Numbers:             " . "No" . "\n"
	endif

	if match(g:CREAM_PRINT_WRAP, "y$") != -1
		let str = str . "  Wrap at Margins:         " . "Yes" . "\n"
	else
		let str = str . "  Wrap at Margins:         " . "No" . "\n"
	endif

	let str = str . "  Font:                            " . g:CREAM_PRINT_FONT_{Cream_getoscode()} . "\n"
	let str = str . "  Encoding:                    " . g:CREAM_PRINT_ENCODING . "\n"
	if match(g:CREAM_PRINT_FORMFEED, "y$") != -1
		let str = str . "  Obey Formfeed Chars: " . "Yes" . "\n"
	else
		let str = str . "  Obey Formfeed Chars: " . "No" . "\n"
	endif


	let str = str . "\n"
	if match(g:CREAM_PRINT_COLLATE, "y$") != -1
		let str = str . "  Collate:                         " . "Yes" . "\n"
	else
		let str = str . "  Collate:                         " . "No" . "\n"
	endif

	if match(g:CREAM_PRINT_DUPLEX, "off$") != -1
		let str = str . "  Duplex:                         " . "Off" . "\n"
	elseif match(g:CREAM_PRINT_DUPLEX, "long$") != -1
		let str = str . "  Duplex:                         " . "Long side bind" . "\n"
	elseif match(g:CREAM_PRINT_DUPLEX, "short$") != -1
		let str = str . "  Duplex:                         " . "Short side bind" . "\n"
	endif

	if match(g:CREAM_PRINT_JOBSPLIT, "y$") != -1
		let str = str . "  Job Split Copies:            " . "Yes" . "\n"
	else
		let str = str . "  Job Split Copies:            " . "No" . "\n"
	endif

	if g:CREAM_PRINT_DEVICE != "" || g:CREAM_PRINT_EXPR != ""
		let str = str . "\n"
		if g:CREAM_PRINT_DEVICE != ""
			let str = str . "  Printer (device):\n\n" . g:CREAM_PRINT_DEVICE . "\n"
		endif
		if g:CREAM_PRINT_EXPR != ""
			let str = str . "  Printer expression:\n\n" . g:CREAM_PRINT_EXPR . "\n"
		endif
	endif


	" dialog
	if Cream_has("ms")
		let button = "Next..."
	else
		let button = "Print"
	endif
	let n = confirm(str . "\n", "&" . button . "\n&Cancel", 1, "Question")
	if n != 1
		return -1
	endif

endfunction

" Cream_print_set() {{{1
function! Cream_print_set(mode, feature, ...)
" change a printing configuration
" {mode}    is "i" or "v"
" {feature} is one of the accepted cases below
" {...}     is a user string used to set one of the options below
"           where accepted

	if a:mode != "i" && a:mode != "v"
		call confirm(
			\ "Error: Invalid mode passed to Cream_print_set()\n" .
			\ "\n", "&Ok", 1, "Info")
	endif

	" &printdevice
	if     a:feature == "device"
		if a:0 > 0
			let g:CREAM_PRINT_DEVICE = a:1
		endif

	" &printencoding
	elseif a:feature == "encoding"
		if a:0 > 0
			let g:CREAM_PRINT_ENCODING = a:1
		endif

	" &printexpr
	elseif a:feature == "expr"
		if a:0 > 0
			let g:CREAM_PRINT_EXPR = a:1
		endif

	" &printfont
	elseif a:feature == "font"
		if a:0 > 0
			let g:CREAM_PRINT_FONT_{Cream_getoscode()} = a:1
		endif

	" &printheader
	elseif a:feature == "headertext"
		if a:0 > 0
			let g:CREAM_PRINT_HEADER_TEXT = a:1
		endif

	" &printoptions
	elseif a:feature == "left"
		if a:0 > 0
			let g:CREAM_PRINT_MARGIN_LEFT = a:1
		endif
	elseif a:feature == "right"
		if a:0 > 0
			let g:CREAM_PRINT_MARGIN_RIGHT = a:1
		endif
	elseif a:feature == "top"
		if a:0 > 0
			let g:CREAM_PRINT_MARGIN_TOP = a:1
		endif
	elseif a:feature == "bottom"
		if a:0 > 0
			let g:CREAM_PRINT_MARGIN_BOTTOM = a:1
		endif

	elseif a:feature == "headerlines"
		if a:0 > 0
			let g:CREAM_PRINT_HEADER = a:1
		endif

	elseif a:feature == "syntax:n"
	\||    a:feature == "syntax:y"
	\||    a:feature == "syntax:a"
		let g:CREAM_PRINT_SYNTAX = a:feature

	elseif a:feature == "number:y"
	\||    a:feature == "number:n"
		let g:CREAM_PRINT_NUMBER = a:feature

	elseif a:feature == "wrap:y"
	\||    a:feature == "wrap:n"
		let g:CREAM_PRINT_WRAP = a:feature

	elseif a:feature == "duplex:off"
	\||    a:feature == "duplex:long"
	\||    a:feature == "duplex:short"
		let  g:CREAM_PRINT_DUPLEX = a:feature

	elseif a:feature == "collate:y"
	\||    a:feature == "collate:n"
		let  g:CREAM_PRINT_COLLATE = a:feature

	elseif a:feature == "jobsplit:y"
	\||    a:feature == "jobsplit:n"
		let  g:CREAM_PRINT_JOBSPLIT = a:feature

	elseif a:feature == "portrait:y"
	\||    a:feature == "portrait:n"
		let g:CREAM_PRINT_ORIENTATION = a:feature

	elseif a:feature == "paper:letter"
	\||    a:feature == "paper:legal"
	\||    a:feature == "paper:ledger"
	\||    a:feature == "paper:statement"
	\||    a:feature == "paper:A3"
	\||    a:feature == "paper:A4"
	\||    a:feature == "paper:A5"
	\||    a:feature == "paper:B4"
	\||    a:feature == "paper:B5"
		let g:CREAM_PRINT_PAPERSIZE = a:feature

	elseif a:feature == "formfeed:y"
	\||    a:feature == "formfeed:n"
		let  g:CREAM_PRINT_FORMFEED = a:feature

	endif


	if a:mode == "v"
		normal gv
	endif

endfunction


" Set, &printdevice {{{1
function! Cream_print_set_device(mode)
	let mystr = Inputdialog("Please enter a string for your printer.", &printdevice)
	if mystr == "{cancel}"
		return
	endif
	call Cream_print_set(a:mode, "device", mystr)
endfunction

" Set, &printexpr {{{1
function! Cream_print_set_expr(mode)
	let mystr = Inputdialog("Please enter a string for your printer expression.", &printexpr)
	if mystr == "{cancel}"
		return
	endif
	call Cream_print_set(a:mode, "expr", mystr)
endfunction

" Set, &printfont {{{1
function! Cream_print_set_font(mode)
" hack... we have to use the return of "set guifont=*" to select a
" print font in order to use a dialog.

	if !has("gui_running")
		return -1
	endif

	" save environment
	execute 'let myguifont = "' . escape(&guifont, " ") . '"'

	let myos = Cream_getoscode()

	" save screen pos
	" HACK: set guifont=* moves screen on WinXP
	call Cream_screen_get()

	silent! set guifont=*
	" if still empty or a "*", user may have cancelled; do nothing
	if  &guifont == "*" || &guifont == ""
		" do nothing
	else

		let &printfont = &guifont
		let g:CREAM_PRINT_FONT_{myos} = &printfont

""*** DEBUG:
"let n = confirm(
"    \ "DEBUG:\n" .
"    \ "  &guifont    = \"" . &guifont . "\"\n" .
"    \ "  g:CREAM_FONT_{myos}    = \"" . g:CREAM_FONT_{myos} . "\"\n" .
"    \ "  &printfont    = \"" . &printfont . "\"\n" .
"    \ "  g:CREAM_PRINT_FONT_{myos}    = \"" . g:CREAM_PRINT_FONT_{myos} . "\"\n" .
"    \ "\n", "&Ok\n&Cancel", 1, "Info")
"if n != 1
"    return
"endif
""***

	endif

	" restore &guifont
	let &guifont = myguifont

	" restore screen pos
	call Cream_screen_init()

	if a:mode == "v"
		normal gv
	endif

endfunction

" Set, &printheader {{{1
function! Cream_print_set_headertext(mode)
	let mystr = Inputdialog(
		\ "Please enter a string for your printer expression.\n" .
		\ "Allowable strings conform to Vim's statusline options:\n" .
		\ "\n" .
		\ "  %N    Page number\n" .
		\ "  %F    Full path\n" .
		\ "  %t     File name\n" .
		\ "  %L    Total number of lines\n" .
		\ "  %m    Modified status\n" .
		\ "  %r     Readonly status\n" .
		\ "  %y    File type\n" .
		\ "  %<    Where to truncate line if too long\n" .
		\ "  %=    Point between left- and right-aligned items\n" .
		\ "\n" .
		\ "Example:\n" .
		\ "\n" .
		\ "   %<%F%t%   %L Lines Total=Page %N\n" .
		\ "\n" .
		\ "would produce a header that looks like:\n" .
		\ "\n" .
		\ "  C:\\Docs\\File.txt   195 Lines Total                  Page 3\n" .
		\ "\n" .
		\ "\n", g:CREAM_PRINT_HEADER_TEXT)
	if mystr == "{cancel}"
		return
	endif
	call Cream_print_set(a:mode, "headertext", mystr)
endfunction

" Set, &printoptions, margins {{{1
" margin:left
function! Cream_print_set_margin_left(mode)
	let mystr = Cream_print_set_margin_dialog(g:CREAM_PRINT_MARGIN_LEFT)
	if mystr == "{cancel}"
		return
	endif
	call Cream_print_set(a:mode, "left", mystr)
endfunction
" margin:right
function! Cream_print_set_margin_right(mode)
	let mystr = Cream_print_set_margin_dialog(g:CREAM_PRINT_MARGIN_RIGHT)
	if mystr == "{cancel}"
		return
	endif
	call Cream_print_set(a:mode, "right", mystr)
endfunction
" margin:top
function! Cream_print_set_margin_top(mode)
	let mystr = Cream_print_set_margin_dialog(g:CREAM_PRINT_MARGIN_TOP)
	if mystr == "{cancel}"
		return
	endif
	call Cream_print_set(a:mode, "top", mystr)
endfunction
" margin:bottom
function! Cream_print_set_margin_bottom(mode)
	let mystr = Cream_print_set_margin_dialog(g:CREAM_PRINT_MARGIN_BOTTOM)
	if mystr == "{cancel}"
		return
	endif
	call Cream_print_set(a:mode, "bottom", mystr)
endfunction

function! Cream_print_set_margin_dialog(existing)
" dialog for margin settings

	let side = matchstr(a:existing, '^.\+:\@=')
	" we allow a period character optionally in front of a number but
	" not trailing one
	let size = matchstr(a:existing, '\d*\.\=\d\+')
	let unit = matchstr(a:existing, '..$')

	let mystr = Inputdialog(
		\ "Please enter your " . side . " margin width and unit as \n" .
		\ "shown in these four examples:\n" .
		\ "\n" .
		\ "    \"0.5in\"    (inches)\n" .
		\ "    \"5mm\"    (millimeters)\n" .
		\ "    \"5pc\"    (percentage of paper width)\n" .
		\ "    \"5pt\"    (points equal 1/72 of an inch)\n" .
		\ "\n" .
		\ "(Fractions required in decimal form.)\n" .
		\ "\n", size . unit)
	if mystr == "{cancel}"
		return mystr
	endif
	" remove spaces
	let mystr = substitute(mystr, ' ', '', 'g')
	" lower case
	let mystr = tolower(mystr)
	" validate
	let unitnew = matchstr(mystr, '..$')

	if  unitnew != "in"
	\&& unitnew != "mm"
	\&& unitnew != "pc"
	\&& unitnew != "pt"
		call confirm(
			\ "Invalid unit specified.\n" .
			\ "\n", "&Ok", 1, "Error")
		return "{cancel}"
	endif

	let sizenew = matchstr(mystr, '\d*\.\=\d\+')
	" Vim doesn't allow leading decimal--pad with 0
	if match(sizenew, '\.') == 0
		let sizenew = "0" . sizenew
	endif
	if  sizenew == ""
		call confirm(
			\ "Invalid size specified.\n" .
			\ "\n", "&Ok", 1, "Error")
		return "{cancel}"
	endif

""*** DEBUG:
"let n = confirm(
"    \ "DEBUG:\n" .
"    \ "  side    = \"" . side . "\"\n" .
"    \ "  size    = \"" . size . "\"\n" .
"    \ "  unit    = \"" . unit . "\"\n" .
"    \ "  mystr   = \"" . mystr . "\"\n" .
"    \ "  unitnew = \"" . unitnew . "\"\n" .
"    \ "  sizenew = \"" . sizenew . "\"\n" .
"    \ "\n", "&Ok\n&Cancel", 1, "Info")
"if n != 1
"    return "{cancel}"
"endif
""***

	return side . ":" . sizenew . unitnew

endfunction

" Set, &printoptions, header {{{1
function! Cream_print_set_header(mode)
	let mystr = Inputdialog("Please enter the header height in number of lines.", matchstr(g:CREAM_PRINT_HEADER, '\d\+$'))
	if mystr == "{cancel}"
		return
	endif
	" error if we find any char other than 0-9
	if match(mystr, '[^0-9]') != -1
		call confirm(
			\ "Only numbers are allowed.\n" .
			\ "\n", "&Ok", 1, "Error")
		return
	endif
	call Cream_print_set(a:mode, "header", mystr)
endfunction

" Set, &printoptions, syntax {{{1
function! Cream_print_set_syntax(mode)
	if     g:CREAM_PRINT_SYNTAX == "syntax:y"
		let button = 1
	elseif g:CREAM_PRINT_SYNTAX == "syntax:a"
		let button = 3
	else
		let button = 2
	endif
	let n = confirm(
		\ "Print syntax highlighting?\n" .
		\ "(Auto tries if printer appears able to print color or grey.)\n" .
		\ "\n", "&Yes\n&No\n&Auto\n&Cancel", button, "Question")
	if     n == 1
		call Cream_print_set(a:mode, "syntax:y")
	elseif n == 2
		call Cream_print_set(a:mode, "syntax:n")
	elseif n == 3
		call Cream_print_set(a:mode, "syntax:a")
	endif
endfunction

" Set, &printoptions, number {{{1
function! Cream_print_set_number(mode)
	if     g:CREAM_PRINT_NUMBER == "number:y"
		let button = 1
	else
		let button = 2
	endif
	let n = confirm(
		\ "Print line numbers?\n" .
		\ "\n", "&Yes\n&No\n&Cancel", button, "Question")
	if     n == 1
		call Cream_print_set(a:mode, "number:y")
	elseif n == 2
		call Cream_print_set(a:mode, "number:n")
	endif
endfunction

" Set, &printoptions, wrap {{{1
function! Cream_print_set_wrap(mode)
	if     g:CREAM_PRINT_WRAP == "wrap:y"
		let button = 1
	else
		let button = 2
	endif
	let n = confirm(
		\ "Wrap words at page margin?\n" .
		\ "\n", "&Yes\n&No\n&Cancel", button, "Question")
	if     n == 1
		call Cream_print_set(a:mode, "wrap:y")
	elseif n == 2
		call Cream_print_set(a:mode, "wrap:n")
	endif
endfunction

" Set, &printoptions, duplex {{{1
function! Cream_print_set_duplex(mode)
	if     g:CREAM_PRINT_DUPLEX == "duplex:long"
		let button = 2
	elseif g:CREAM_PRINT_DUPLEX == "duplex:short"
		let button = 3
	else
		let button = 1
	endif
	let n = confirm(
		\ "Duplex?\n" .
		\ "\n", "&Off\n&Long\ Side\n&Short\ Side\n&Cancel", button, "Question")
	if     n == 1
		call Cream_print_set(a:mode, "duplex:off")
	elseif n == 2
		call Cream_print_set(a:mode, "duplex:long")
	elseif n == 3
		call Cream_print_set(a:mode, "duplex:short")
	endif
endfunction

" Set, &printoptions, collate {{{1
function! Cream_print_set_collate(mode)
	if     g:CREAM_PRINT_COLLATE == "collate:y"
		let button = 1
	else
		let button = 2
	endif
	let n = confirm(
		\ "Collate?\n" .
		\ "\n", "&Yes\n&No\n&Cancel", button, "Question")
	if     n == 1
		call Cream_print_set(a:mode, "collate:y")
	elseif n == 2
		call Cream_print_set(a:mode, "collate:n")
	endif
endfunction

" Set, &printoptions, jobsplit {{{1
function! Cream_print_set_jobsplit(mode)
	if     g:CREAM_PRINT_JOBSPLIT == "jobsplit:y"
		let button = 1
	else
		let button = 2
	endif
	let n = confirm(
		\ "Print each copy as its own print job?\n" .
		\ "\n", "&Yes\n&No\n&Cancel", button, "Question")
	if     n == 1
		call Cream_print_set(a:mode, "jobsplit:y")
	elseif n == 2
		call Cream_print_set(a:mode, "jobsplit:n")
	endif
endfunction

" Set, &printoptions, formfeed {{{1
function! Cream_print_set_formfeed(mode)
	if     g:CREAM_PRINT_FORMFEED == "formfeed:y"
		let button = 1
	else
		let button = 2
	endif
	let n = confirm(
		\ "Obey or ignore formfeed characters?\n" .
		\ "(Obeying means a decimal 12 character will force\n" .
		\ "the beginning of a new page whenever encountered.)\n" .
		\ "\n", "&Obey\n&Ignore\n&Cancel", button, "Question")
	if     n == 1
		call Cream_print_set(a:mode, "formfeed:y")
	elseif n == 2
		call Cream_print_set(a:mode, "formfeed:n")
	endif
endfunction


" Cream_print_setup() {{{1
function! Cream_print_setup()
" set all Vim options related to printing
" (based on globals initialized elsewhere)

	execute "set printdevice=" . escape(g:CREAM_PRINT_DEVICE, ' ')
	if version >= 602
		execute "set printencoding=" . g:CREAM_PRINT_ENCODING
	endif
	execute "set printexpr=" . escape(g:CREAM_PRINT_EXPR, ' ')
	execute "set printfont=" . escape(g:CREAM_PRINT_FONT_{Cream_getoscode()}, ' ')
	execute "set printheader=" . escape(g:CREAM_PRINT_HEADER_TEXT, ' ')
	if version >= 602
		execute "set printoptions=" .
		\ g:CREAM_PRINT_MARGIN_LEFT . "," .
		\ g:CREAM_PRINT_MARGIN_RIGHT . "," .
		\ g:CREAM_PRINT_MARGIN_TOP . "," .
		\ g:CREAM_PRINT_MARGIN_BOTTOM . "," .
		\ g:CREAM_PRINT_HEADER . "," .
		\ g:CREAM_PRINT_SYNTAX . "," .
		\ g:CREAM_PRINT_NUMBER . "," .
		\ g:CREAM_PRINT_WRAP . "," .
		\ g:CREAM_PRINT_DUPLEX . "," .
		\ g:CREAM_PRINT_COLLATE . "," .
		\ g:CREAM_PRINT_JOBSPLIT . "," .
		\ g:CREAM_PRINT_ORIENTATION . "," .
		\ g:CREAM_PRINT_PAPERSIZE . "," .
		\ g:CREAM_PRINT_FORMFEED . "," .
		\ ""
	endif

endfunction

" Cream_print_init() {{{1
function! Cream_print_init()
" initialize print configuration based on defaults or globals

	" *** reset (comment to void) -- DEVEL ONLY
	"let reset = 1

	" &printdevice
	if !exists("g:CREAM_PRINT_DEVICE") || exists("reset")
		let g:CREAM_PRINT_DEVICE = &printdevice
	endif

	" &printencoding
	if !exists("g:CREAM_PRINT_ENCODING") || exists("reset")
		let g:CREAM_PRINT_ENCODING = &encoding
	endif

	" &printexpr
	if !exists("g:CREAM_PRINT_EXPR") || exists("reset")
		let g:CREAM_PRINT_EXPR = &printexpr
	endif

	" &printfont
	" default print font is same as GUI font
	if !exists("g:CREAM_PRINT_FONT_{Cream_getoscode()}")
		if exists("g:CREAM_FONT_{Cream_getoscode()}")
			let g:CREAM_PRINT_FONT_{Cream_getoscode()} = g:CREAM_FONT_{Cream_getoscode()}
		else
			let g:CREAM_PRINT_FONT_{Cream_getoscode()} = &guifont
		endif
	endif

	" &printheader
	if !exists("g:CREAM_PRINT_HEADER_TEXT") || exists("reset")
		let g:CREAM_PRINT_HEADER_TEXT = &printheader
	endif

	" &printoptions
	if !exists("g:CREAM_PRINT_MARGIN_LEFT") || exists("reset")
		let g:CREAM_PRINT_MARGIN_LEFT = "left:10pc"
	endif
	if !exists("g:CREAM_PRINT_MARGIN_RIGHT") || exists("reset")
		let g:CREAM_PRINT_MARGIN_RIGHT = "right:5pc"
	endif
	if !exists("g:CREAM_PRINT_MARGIN_TOP") || exists("reset")
		let g:CREAM_PRINT_MARGIN_TOP = "top:5pc"
	endif
	if !exists("g:CREAM_PRINT_MARGIN_BOTTOM") || exists("reset")
		let g:CREAM_PRINT_MARGIN_BOTTOM = "bottom:5pc"
	endif

	if !exists("g:CREAM_PRINT_HEADER") || exists("reset")
		let g:CREAM_PRINT_HEADER = "header:2"
	endif

	if !exists("g:CREAM_PRINT_SYNTAX") || exists("reset")
		let g:CREAM_PRINT_SYNTAX = "syntax:a"
	endif

	if !exists("g:CREAM_PRINT_NUMBER") || exists("reset")
		let g:CREAM_PRINT_NUMBER = "number:n"
	endif

	if !exists("g:CREAM_PRINT_WRAP") || exists("reset")
		let g:CREAM_PRINT_WRAP = "wrap:y"
	endif

	if !exists("g:CREAM_PRINT_DUPLEX") || exists("reset")
		" varies from Vim default
		let g:CREAM_PRINT_DUPLEX = "duplex:off"
	endif

	if !exists("g:CREAM_PRINT_COLLATE") || exists("reset")
		let g:CREAM_PRINT_COLLATE = "collate:y"
	endif

	if !exists("g:CREAM_PRINT_JOBSPLIT") || exists("reset")
		let g:CREAM_PRINT_JOBSPLIT = "jobsplit:n"
	endif

	" we use a different name
	if !exists("g:CREAM_PRINT_ORIENTATION") || exists("reset")
	\|| g:CREAM_PRINT_ORIENTATION == ""
		let g:CREAM_PRINT_ORIENTATION = "portrait:y"
	endif

	if !exists("g:CREAM_PRINT_PAPERSIZE") || exists("reset")
	\|| g:CREAM_PRINT_PAPERSIZE == ""
		let g:CREAM_PRINT_PAPERSIZE = "paper:letter"
	endif

	if !exists("g:CREAM_PRINT_FORMFEED") || exists("reset")
		" we use a different default
		let g:CREAM_PRINT_FORMFEED = "formfeed:y"
	endif

	" now activate Vim's various options
	call Cream_print_setup()

endfunction

" 1}}}
" vim:foldmethod=marker
