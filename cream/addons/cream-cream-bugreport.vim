"
" cream-bugreport.vim -- Debug info report
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

" Updated: 2004-10-05 22:54:32-0400
"

" register as a Cream add-on
if exists("$CREAM")
	call Cream_addon_register(
	\ 'Cream Config Info', 
	\ "Create report of Cream and Vim application information", 
	\ "Create report of Cream and Vim application information", 
	\ 'Cream Config Info', 
	\ 'call Cream_bugreport()', 
	\ '<Nil>'
	\ )
endif

function! Cream_bugreport()
" Use existing debug functions to obtain debugging information and
" dump into a report (new, unsaved document).

	let @x = Cream_debug_info()
	call Cream_file_new()
	put! x

	setlocal foldmethod=marker

endfunction

