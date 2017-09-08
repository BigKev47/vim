"
" cream-playpen.vim -- Experiments, things in flux or unresolved.
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

" register as a Cream add-on
if exists("$CREAM")
	call Cream_addon_register(
	\ 'De-binary', 
	\ "Delete a file's non-ASCII characters.", 
	\ 'Brute force filtration of a binary file into recognizable ASCII characters by deleting those not between 32-126.', 
	\ 'De-binary', 
	\ 'call Cream_debinary()',
	\ '<Nil>'
	\ )
endif

function! Cream_debinary()
" Brute force function to filter a binary file into something remotely
" resembling ASCII. Useful for string reduction out of data that might
" otherwise be ensared in an unhelpful binary file format. (Such as
" a corrupt word processing file.)

	let n = confirm(
		\ "Debinary is a brute force function to filter a binary file into\n" .
		\ "something remotely resembling ASCII. It's useful for string reduction\n" .
		\ "out of data that might otherwise be ensared in an unhelpful binary\n" .
		\ "file format. (Such as a corrupt word processing file.)\n" .
		\ "\n" .
		\ "You should not use this unless you know what you are doing! Continue?\n" .
		\ "\n", "&Ok\n&Cancel", 2, "Info")
	if n != 1
		return
	endif

	" remove <Nul> characters (decimal 0)
	execute "%s/" . nr2char(0) . "//gei"

	" convert all binary characters to returns
	silent! %substitute/[-]/\r/g

	" replace all 128s with spaces (great for Word Perfect docs)
	silent! %substitute/€/ /g

	" uhh... "foreign" characters might be useful! 
	" prompt
	let n = confirm(
		\ "Remove characters with ASCII values above 126?\n" .
		\ "\n", "&Ok\n&No", 1, "Info")
	if n == 1
		silent! %substitute/[-ÿ]/\r/g
	endif

	" delete all blank lines (last)
	call Cream_emptyline_collapse()

	"" replace all returns with tabs (for readability)
	"silent! %substitute/\n/\t/g

endfunction

