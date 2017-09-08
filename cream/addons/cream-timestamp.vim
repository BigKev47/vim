"
" Filename: cream-timestamp.vim
" Updated:  2004-09-25 10:33:29-0400
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
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
" General Public License for more details.
"
" You should have received a copy of the GNU General Public License
" along with this program; if not, write to the Free Software
" Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
" 02111-1307, USA.
"
" Information:
" o Please use ISO 8601! (http://www.saqqara.demon.co.uk/datefmt.htm)
"
" Description:
" A simple time stamp routine. Updates the text following the first
" (default, case sensitive) stamp tag "Updated:" in the current
" document with the stamp selected at the dialog.
"
" Notes:
" o Only the first occurance of the stamp tag within the current file
"   is updated.
" o All characters following the stamp tag up to a single quote,
"   double quote or end of line are replaced with the time stamp. An
"   exception is that white space following the stamp tag is
"   maintained.
" o The stamp tag text (default: "Updated:") can manually be
"   overridden and retained just by re-assigning the variable
"   "g:CREAM_TIMESTAMP_TEXT".
" o Timezone is supplied by Cream_timezone(), usually the value of
"   strtime("%Z"), but not on Windows. You can set the variable
"   "g:CREAM_TIMEZONE" to override.
"
" ChangeLog:
"
" 2004-09-25
" o Now dependent on external Cream_timezone().
"
" 2003-05-15
" o Added a few more subtle stamps, including compressed ISO8601 and a
"   human readable with 24h.
"
" 2003-02-19
" o Added timezone flexibilties
"

" register as a Cream add-on
if exists("$CREAM")
	call Cream_addon_register(
	\ 'Stamp Time', 
	\ "Update the time stamp of the current file.", 
	\ "Replace the characters following the first stamp tag \"Updated:\" (case sensitive) in the current file up to a single quote, double quote or end of line with the selected stamp format.",
	\ 'Stamp Time ',
	\ 'call Cream_timestamp()', 
	\ '<Nil>'
	\ )
endif

function! Cream_timestamp()

	" retain existing dialog button display orientation
	let sav_go = &guioptions
	" make vertical
	set guioptions+=v

	" retain current position
	let mypos = Cream_pos()

	" set default pick if no previous preference
	if !exists("g:CREAM_TIMESTAMP_STYLE")
		let g:CREAM_TIMESTAMP_STYLE = 2
	endif

	" set default find phrase
	if !exists("g:CREAM_TIMESTAMP_TEXT")
		let g:CREAM_TIMESTAMP_TEXT = "Updated:"
	endif

	" let button text equal current values
	let mybuttons =
		\ substitute(strftime('%d %B %Y'), '^0*', '', 'g') . "\n" .
		\ substitute(strftime('%d %b %Y'), '^0*', '', 'g') . "\n" .
		\ strftime('%Y %B %d') . "\n" .
		\ strftime('%Y %b %d') . "\n" .
		\ strftime('%Y-%b-%d') . "\n" .
		\ strftime("%Y-%m-%d") . "\n" .
		\ strftime("%Y-%m-%d, %I:%M") . tolower(strftime("%p")) . "\n" .
		\ strftime("%Y-%m-%d, %H:%M") . "\n" .
		\ strftime("%Y-%m-%d %H:%M:%S") . "\n" .
		\ strftime("%Y-%m-%d %H:%M:%S") . Cream_timezone() . "\n" .
		\ strftime("%Y%m%dT%H%M%S") . Cream_timezone() . "\n" .
		\ "&Cancel"

	let n = confirm(
		\ "Please select the time stamp format. \n" .
		\ "\n" .
		\ "(Stamp occurs at the first location of the\n" .
		\ "text \"" . g:CREAM_TIMESTAMP_TEXT . "\" found in the document,\n" .
		\ "and replaces all text on the line following it.)" .
		\ "\n", mybuttons, g:CREAM_TIMESTAMP_STYLE, "Info")

	if     n == 1
		" 14 February 2003 (minus leading 0's)
		let mytime = substitute(strftime('%d %B %Y'), '^0*', '', 'g')
	elseif n == 2
		" 14 Feb 2003 (minus leading 0's)
		let mytime = substitute(strftime('%d %b %Y'), '^0*', '', 'g')
	elseif n == 3
		" 2003 February 14
		let mytime = strftime('%Y %B %d')
	elseif n == 4
		" 2003 Mar 14
		let mytime = strftime("%Y %b %d")
	elseif n == 5
		" 2003-Mar-14
		let mytime = strftime("%Y-%b-%d")
	elseif n == 6
		" 2003-03-14
		let mytime = strftime("%Y-%m-%d")
	elseif n == 7
		" 2003-02-14, 10:28pm
		let mytime = strftime("%Y-%m-%d, %I:%M") . tolower(strftime("%p"))
	elseif n == 8
		" 2003-02-14, 22:28
		let mytime = strftime("%Y-%m-%d, %H:%M")
	elseif n == 9
		" 2003-02-14 22:28:14
		let mytime = strftime("%Y-%m-%d %H:%M:%S")
	elseif n == 10
		" 2003-02-14 22:28:23-0500
		let mytime = strftime("%Y-%m-%d %H:%M:%S") . Cream_timezone()
	elseif n == 11
		" 20030214T102823-0500
		let mytime = strftime("%Y%m%dT%H%M%S") . Cream_timezone()
	else

	endif

	" do substitution (first occurrence)
	if exists("mytime")
		" check to see if valid replacement text exists
		execute "0"
		if search(g:CREAM_TIMESTAMP_TEXT . "\\s*.\\{-}[\"\'\\n]") != 0
			" substitute
			execute '0;/' . g:CREAM_TIMESTAMP_TEXT . "\\(\\s*\\).\\{-}\\([\"\'\\n]\\)/substitute//" . g:CREAM_TIMESTAMP_TEXT . '\1' . mytime . '\2/geI'
		endif
	endif

	" remember selection
	if 0 < n && n < 11
		let g:CREAM_TIMESTAMP_STYLE = n
	endif

	" restore pos
	execute mypos
	" restore gui buttons
	let &guioptions = sav_go

endfunction

