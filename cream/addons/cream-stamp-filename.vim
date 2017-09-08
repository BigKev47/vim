"
" Filename: cream-stamp-filename.vim
" Updated:  2004-09-09 16:46:54-0400
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
"
" Description:
" A simple filename stamp routine. Updates the text following the
" first (default, case sensitive) stamp tag "Filename:" in the current
" document with the stamp selected at the dialog.
"
" Notes:
" o Only the first occurance of the stamp tag within the current file
"   is updated.
" o All characters following the stamp tag up to a single quote,
"   double quote or end of line are replaced with the stamp. An
"   exception is that white space following the stamp tag is
"   maintained.
" o The stamp tag text (default: "Filename:") can manually be
"   overridden and retained just by re-assigning the variable
"   "g:CREAM_STAMP_FILENAME_TEXT".
"

" register as a Cream add-on
if exists("$CREAM")
	call Cream_addon_register(
	\ 'Stamp Filename', 
	\ "Update the filename stamp of the current file.", 
	\ "Replace the characters following the first stamp tag \"Filename:\" (case sensitive) in the current file up to a single quote, double quote or end of line with the selected stamp format.",
	\ 'Stamp Filename', 
	\ 'call Cream_stamp_filename()', 
	\ '<Nil>'
	\ )
endif

function! Cream_stamp_filename()

	" retain existing dialog button display orientation
	let sav_go = &guioptions
	" make vertical
	set guioptions+=v

	" retain current position
	let mypos = Cream_pos()

	" set default pick if no previous preference
	if !exists("g:CREAM_STAMP_FILENAME_STYLE")
		let g:CREAM_STAMP_FILENAME_STYLE = 1
	endif

	" set default find phrase
	if !exists("g:CREAM_STAMP_FILENAME_TEXT")
		let g:CREAM_STAMP_FILENAME_TEXT = "Filename:"
	endif

	" get button label from current file
	let sample1 = fnamemodify(expand("%"), ":p:t")
	let sample2 = fnamemodify(expand("%"), ":p")

	" shorten button labels to < 45 chars
	" (use strpart() rather than str[idx] to handle multi-byte)
	if strlen(sample1) > 45
		let sample1 = strpart(sample1, 0, 42) . "..."
	endif

	if strlen(sample2) > 45
		" we want to trim with priority to filename over path:
		"   /pat.../filename
		" unless filename itself is too long, then we'll show a bit of path
		"   /pat.../filena...
		let fname = fnamemodify(expand("%"), ":p:t")
		let pname = fnamemodify(expand("%"), ":p")
		if strlen(fname) > 40
			let fname = strpart(fname, 0, 33) . "..."
			let pname = strpart(fname, 0, 6) . "..."
		else
			" trim path to 45 minus filename length minus ellipses
			let pname = strpart(pname, 0, 45 - strlen(fname) - 3) . "..."
		endif
		let sample2 = pname . fname
		" fix if on Windows
		if Cream_has("ms")
			let sample2 = substitute(sample2, '/', '\', 'g')
		endif
	endif

	" let button text equal current values
	let mybuttons = 
		\ sample1 . "\n" .
		\ sample2 . "\n" .
		\ "&Cancel"

	let n = confirm(
		\ "Please select the stamp format. \n" .
		\ "\n" .
		\ "(Stamp occurs at the first location of the\n" .
		\ "text \"" . g:CREAM_STAMP_FILENAME_TEXT . "\" found in the document,\n" .
		\ "and replaces all text on the line following it.)" .
		\ "\n", mybuttons, g:CREAM_STAMP_FILENAME_STYLE, "Info")
	if     n == 1
		" filename
		let mystr = fnamemodify(expand("%"), ":p:t")
	elseif n == 2
		" path-filename
		let mystr = fnamemodify(expand("%"), ":p")
		" fix if on Windows
		if Cream_has("ms")
			let mystr = substitute(mystr, '/', '\', 'g')
		endif
	else

	endif

	" do substitution (first occurrence)
	if exists("mystr")
		" only if check to see if valid replacement text exists successful
		execute "0"
		if search(g:CREAM_STAMP_FILENAME_TEXT . "\\s*.\\{-}[\"\'\\n]") != 0
			" substitute
			execute '0;/' . g:CREAM_STAMP_FILENAME_TEXT . "\\(\\s*\\).\\{-}\\([\"\'\\n]\\)/substitute//" . g:CREAM_STAMP_FILENAME_TEXT . '\1' . escape(mystr, '/\.') . '\2/geI'
		endif
	endif

	" remember selection
	if 0 < n && n < 9
		let g:CREAM_STAMP_FILENAME_STYLE = n
	endif

	" restore pos
	execute mypos
	" restore gui buttons
	let &guioptions = sav_go

endfunction

