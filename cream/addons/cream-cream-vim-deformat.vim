"
" Filename: cream-cream-vim-deformat.vim
" Updated:  2004-11-04 07:23:28-0400
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

" register as Cream add-on
if exists("$CREAM")
	" don't list unless developer
	if !exists("g:cream_dev")
		finish
	endif

	call Cream_addon_register(
	\ "Vim Script Deformat",
	\ "Cream Devel -- Vim script deformatter",
	\ "Remove comments, indention, and empty lines from Vim script.",
	\ "Cream Devel.Vim Script Deformat",
	\ "call Cream_vimscript_crush()",
	\ '<Nil>'
	\ )
endif

function! Cream_vimscript_crush()
" Totally smoke the readibility of Vim script.

	if fnamemodify(expand("%"), ":e") != "vim"
		call confirm(
			\ "Not in file a Vim file. Quitting...\n" .
			\ "\n", "&Ok", 1, "Info")
		return
	endif

	let n = confirm(
		\ "Do you really want to destroy the readability of this file?!\n\n(Remove indention, comments and empty lines.)\n" .
		\ "\n", "Yes\nNo", 2, "Info")
	if n != 1
		return
	endif

	" delete leading whitespace
	silent %substitute/^\s*//gei
	" delete commented lines
	silent %substitute/^".*$//gei
	" delete empty lines
	silent %substitute/\n\n\+/\r/gei

endfunction

