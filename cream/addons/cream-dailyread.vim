"
" cream-dailyread.vim -- Select a daily reading from master document.
"
" Cream -- An easy-to-use configuration of the famous Vim text editor
" [ http://cream.sourceforge.net ] Copyright (C) 2001-2011 Steve Hall
" 
" License:
" This program is free software; you can redistribute it and/or modify
" it under the terms of the GNU General Public License as published by
" the Free Software Foundation; either version 3 of the License, or
" (at your option) any later version.
" [ http://www.gnu.org/licenses/gpl.html ]
" 
" This program is distributed in the hope that it will be useful, but
" WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
" General Public License for more details.
" 
" You should have received a copy of the GNU General Public License
" along with this program; if not, write to the Free Software
" Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
" 02111-1307, USA.
"
" Description:
" * open a given document
" * chop out the section equivalent to the portion and position for
"   that day of the year plus a day on either side. (Optional, prompt
"   or pass argument for which day's portion to get.)
" * paste into a temporary document for daily reading
" * demarcate today's read from context

" register as a Cream add-on
if exists("$CREAM")
	call Cream_addon_register(
	\ "Daily Read", 
	\ "Read a days portion of a document", 
	\ "Choose a document to read in entirety over a year and select and present that day's portion, including a day's context on either side. Great for meditative or religious readings.", 
	\ "Daily Read", 
	\ "call Cream_dailyread()",
	\ '<Nil>'
	\ )
endif

function! Cream_dailyread(...)

	" determine what we're reading
	" if unset
	if !exists("g:CREAM_DAILYREAD")
		call confirm("Select a file from which to read daily portions...", "&Continue...", 1, "Info")
		let myreturn = s:Cream_dailyread_setfile()
		if myreturn != 1
			call confirm("Valid file not found. Quitting...", "&Ok", 1, "Error")
			return
		endif
	endif
	" if unreadable
	if !filereadable(g:CREAM_DAILYREAD)
		call confirm("Unable to read previously selected daily read document. Select a new file...", "&Continue...", 1, "Info")
		let myreturn = s:Cream_dailyread_setfile()
		if myreturn != 1
			call confirm("Valid file not found. Quitting...", "&Ok", 1, "Error")
			return
		endif
	endif

	" dialog
	let n = confirm(
		\ "Select option...\n" .
		\ "\n", "&Select\ Day\n&Select\ New\ Document\n&Ok\n&Cancel", 3, "Info")
	let myday = ""
	while myday == ""
		if     n == 1
			" get optional day to display
			" manual call uses argument for day
			if exists("a:1")
				let myday = a:1
			endif
			" otherwise, prompt for day
			if myday == ""
				let myday = inputdialog("Please enter desired day number for reading.\n(Default is today, below.)", strftime("%j"))
				" if empty, user is trying to quit
				if myday == ""
					call confirm(
						\ "No day entered. Quitting...\n" .
						\ "\n", "&Ok", 1, "Info")
					return
				endif
			endif
		elseif n == 2
			let n = s:Cream_dailyread_setfile()
			if n != 1
				" didn't find a valid file
				return
			endif
		elseif n == 3
			" continue, use current day
			let myday = strftime("%j")
		else
			" abort
			return
		endif
	endwhile

	" remove leading 0s on myday (known strftime() error on Win95)
	while myday[0] == 0
		let myday = strpart(myday, 1)
	endwhile

	" turn off myautoindent
	let myautoindent = &autoindent
	set noautoindent

	" escape spaces and backslashes
	let myfile = escape(g:CREAM_DAILYREAD, ' \')

	" open master
	execute "silent! view " . myfile

	" calculate how long 1/(days in year) is by bytes (don't use
	" getfsize()--will cause error with compressed files)
	let mydoclen = line2byte("$")
	" number of days in the year
	let days = Cream_daysinyear()
	let mydaylen = mydoclen / days
	" must be at least one
	if mydaylen < 1
		let mydaylen = 1
	endif

	" validate day number (must happen after days calculated)
	if myday > days || myday < 1
		call confirm("Invalid day number provided. Defaulting to today...", "&Ok", 1, "Info")
		unlet myday
	endif

	" find day of year number (if options above don't already provide)
	if !exists("myday")
		" numerical day of the year
		let myday = strftime("%j") - 1
	endif
	" calculate current date's pos in year
	" position = day count * length/day
	let mypos = myday * mydaylen - mydaylen - mydaylen
	if mypos < 0
		let mypos = 1
	endif

	" go to byte count equivalent to day's start position
	silent! execute "normal :goto " . mypos . "\<CR>"
	if myday != 1
		" select 3/364th of document down
		silent! execute "normal v" . (mypos + (mydaylen * 3)) . "go"
	else
		" select 2/364th of document down
		silent! execute "normal v" . (mypos + (mydaylen * 2)) . "go"
	endif

	" copy (register "x")
	silent! normal "xy
	" close master (don't save)
	silent! bwipeout!
	" open new document named with today's day number
	silent! execute "silent! edit! " . myday
	" paste (register "x")
	silent! normal "xp

	" mark today from context
	" quit visual mode
	if mode() == "v"
		normal v
	endif
	normal i
	" go to start of read
	if myday != 1
		silent! execute "normal :goto " . mydaylen . "\<CR>"
	else
		silent! execute "normal :goto " . 1 . "\<CR>"
	endif
	" start of line
	normal g0
	" insert line
	silent! execute "silent! normal i\n\n======================================================================\n"
	silent! execute "silent! normal i\t(Today's read below)\n\n"
	" go to end of read
	if myday != 1
		silent! execute "normal :goto " . ((mydaylen * 2) + 5) . "\<CR>"
	else
		silent! execute "normal :goto " . ((mydaylen * 1) + 5) . "\<CR>"
	endif
	" start of line
	normal g0
	" insert line
	silent! execute "silent! normal i\n\n\t(Today's read above)\n"
	silent! execute "silent! normal i======================================================================\n\n"
	" go back to beginning of today's read
	if myday != 1
		silent! execute "normal :goto " . (mydaylen + 4) . "\<CR>"
	else
		silent! execute "normal :goto " . (    1    + 4) . "\<CR>"
	endif

	" return autoinsert state
	let &autoindent = myautoindent

	" don't warn the user about unsaved state
	set nomodified

endfunction

function! s:Cream_dailyread_setfile()
" file open dialog to select file
" establish global for daily read file
" return -1 if file not found or unreadable

	if exists("g:CREAM_DAILYREAD")
		" default path (current)
		let tmp1 = fnamemodify(g:CREAM_DAILYREAD, ":p:h")
		let tmp1 = escape(tmp1, ' ')
		" default filename (current)
		let tmp2 = fnamemodify(g:CREAM_DAILYREAD, ":p")
		let tmp2 = escape(tmp2, ' ')
		" reverse backslashes
		if has("win32")
			let tmp1 = substitute(tmp1, '/', '\\', 'g')
			let tmp2 = substitute(tmp2, '/', '\\', 'g')
		endif
		let myfile = browse('1', 'Select Daily Read file...', tmp1, tmp2)
	else
		let myfile = browse("1", "Select Daily Read file...", getcwd(), "")
	endif

	" at least on unix, requires a full path
	let myfile = fnamemodify(myfile, ":p")

	" results
	if filereadable(myfile) != 1
		return -1
	else
		let g:CREAM_DAILYREAD = myfile
		return 1
	endif

endfunction

