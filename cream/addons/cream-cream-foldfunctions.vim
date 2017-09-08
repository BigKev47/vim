"
" cream-vim-foldfunctions.vim
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
"
" Description:
" Add fold marks for all functions in the form
"
"   " MyFunction() {_{_{_1
"   function! MyFunction()
"
" and place 
"
"   " vim_:_foldmethod=marker
"
" at the bottom of the current file. (Where the underscores "_" are
" omitted above.)
"


" register as a Cream add-on
if exists("$CREAM")

	call Cream_addon_register(
	\ 'Vim Fold Functions', 
	\ 'Fold all functions in the current document', 
	\ "Create a comment line above each Vim function with the function's name followed by a fold marker.", 
	\ 'Cream Devel.Fold Vim Functions', 
	\ 'call Cream_vim_foldfunctions()', 
	\ '<Nil>'
	\ )
endif

function! Cream_vim_foldfunctions()
" fold all functions in a given Vim filetype document
" Note: Weirdness in syntaxes below is to prevent folding. ;)

	" if filetype not Vim, quit
	if &filetype != "vim"
		call confirm(
			\ "Function designed only for Vim files. Please check this document's filetype.\n" .
			\ "\n", "&Ok", 1, "Info")
		return
	endif

	" fold all functions
	execute '%substitute/^function[!] \(\k\+\)()$/" \1() {' . '{' . '{' . '1\r\1()/gei'

	" add fold marker at bottom line
	""*** BROKEN
	"call setline("$", getline("$") . "\n\" vim" . ":foldmethod=marker")
	""***
	let mypos = Cream_pos()
	" go to last line
	normal G
	normal $
	execute "normal a\<CR>\" }" . "}" . "}" . "1\<CR>"
	call setline("$", "\" vim" . ":foldmethod=marker")

	execute mypos

endfunction

