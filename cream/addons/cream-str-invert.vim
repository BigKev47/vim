"
" cream-str-invert.vim
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

" register as a Cream add-on
if exists("$CREAM")

	call Cream_addon_register(
	\ 'Invert Selected String', 
	\ "Inverts characters in a selection", 
	\ "Inverts characters in a selection", 
	\ 'Invert Selected String', 
	\ '<Nil>', 
	\ "call Cream_str_reverse(\"v\")"
	\ )
endif

function! Cream_str_reverse(mode)
" reverse the string selected

	if a:mode != "v"
		call confirm(
			\ "Cream_str_reverse() requires visual mode.\n" .
			\ "\n", "&Ok", 1, "Info")
		return
	endif
	" reselect, copy
	normal gv
	" cut
	normal "xy
	" reverse input
	set revins

	" the magic
	let @x = Cream_str_invert(@x)
	normal gv
	normal "xp

	" set input normal
	set norevins
	" reselect
	normal gv

endfunction

function! Cream_str_invert(str)
" returns inverted string
" by Preben "Peppe" Guldberg, originally "InvertString()"
	return substitute(a:str, '.\(.*\)\@=', '\=a:str[strlen(submatch(1))]', 'g')
endfunction

