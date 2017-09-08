"
" cream-expertmode.vim
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
" Expert mode: <Esc> and <C-[> keys toggle between normal and insert
" mode

function! Cream_expertmode(state)
" control expert mode--a:state must be 0 or 1
	if a:state == 1
		let g:CREAM_EXPERTMODE = 1
		inoremap <silent> <Esc> <C-\><C-n>
		 noremap <silent> <Esc> a
		inoremap <silent> <C-[> <C-\><C-n>
		 noremap <silent> <C-[> a
		set selectmode=
	else
		let g:CREAM_EXPERTMODE = 0
		silent! unmap! <Esc>
		silent! unmap! <C-[>
		set selectmode=key,mouse
	endif
endfunction

function! Cream_expertmode_toggle()
" toggle expert mode from existing state (assumes already initialized)
	if g:CREAM_EXPERTMODE == 1
		call Cream_expertmode(0)
		call Cream_menu_settings_preferences()
	else
		let n = confirm(
		\ "Expert mode uses the Esc and Ctrl+[ keys to toggle out of normal\n" .
		\ "Cream behavior to Vim style:\n" .
		\ "  * Normal mode (insertmode turned off)\n" .
		\ "  * Visual mode (selectmode turned off)\n" .
		\ "\n" .
		\ "Unless you are an experienced Vim user, you are advised not to proceed.\n" .
		\ "\n" .
		\ "Continue?\n" .
		\ "\n", "&Yes\n&Cancel", 2, "Warning")
		if n == 1
			call Cream_expertmode(1)
			call Cream_menu_settings_preferences()
		endif
	endif
endfunction

function! Cream_expertmode_init()
" initialize Cream environment for expert mode
	if !exists("g:CREAM_EXPERTMODE")
		call Cream_expertmode(0)
	else
		if g:CREAM_EXPERTMODE == 1
			call Cream_expertmode(1)
		else
			call Cream_expertmode(0)
		endif
	endif
endfunction

