"
" cream-encrypt-rot13.vim -- Rotate 13 "encryption"
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
	\ 'Encrypt, Rot13', 
	\ 'Encrypt, Rotate 13', 
	\ 'Encrypt a selection by rotating the alphabetic characters (no numbers) 13 places ahead in the alphabet.', 
	\ 'Encrypt.Rot13', 
	\ 'call Cream_encrypt_rot13()', 
	\ '<C-u>call Cream_encrypt_rot13("v")'
	\ )
endif

function! Cream_encrypt_rot13(...)
" Rot13 (rotate all alphas 13 chars forward)
" * Optional argument "v" encrypts current (or previous) selection;
"   otherwise entire buffer is processed

	" find arguments
	if a:0 > 0
		let i = 0
		while i < a:0
			let i = i + 1
			execute "let myarg = a:" . i
			if     myarg == "v"
				let dofile = 0
			elseif myarg == "silent"
				let silent = 1
			endif
		endwhile
	endif

	" handle not-founds
	if !exists("dofile")
		let dofile = 1
	endif
	
	" select
	if dofile == 0
		" reselect previous selection
		normal gv
	else
		if !exists("silent")
			let n = confirm(
				\ "Encrypt entire file?\n" .
				\ "\n", "&Ok\n&Cancel", 1, "Info")
			if n != 1
				" quit
				return
			endif
		endif
		" remember position
		let mypos_orig = Cream_pos()
		" select all
		call Cream_select_all(1)
	endif

	" rot13
	normal g?

	" recover position if select all
	if exists("mypos_orig")
		" go back to insert mode
		normal i
		execute mypos_orig
	" recover selection otherwise
	else
	    normal gv
	endif

endfunction

