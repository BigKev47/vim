"
" cream-encrypt-hexme.vim -- "Encrypts" string into Hexidecimal
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
	\ 'Encrypt, HexMe', 
	\ 'Encrypt, HexMe', 
	\ 'Encrypt a selection by converting characters to their hexidecimal equivilent.', 
	\ 'Encrypt.HexMe', 
	\ 'call Cream_encrypt_hexme()', 
	\ '<C-u>call Cream_encrypt_hexme("v")'
	\ )
endif

function! Cream_encrypt_hexme(...)
" "hexme" mode encryption--Converts selection into hexidecimal
" o Arguments:
"   "silent" quiets operation
"   "v" implies a visual mode selection
"   (nothing) implies to do the entire file

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
				\ "Encrypt/Unencrypt entire file?\n" .
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

	" yank into register
	normal "xy

	" encrypt/unencrypts
	" test hex (contain only [0-9A-Fa-f] or NUL, NL, CR
	let n = match(@x, '[^ \t0-9A-Fa-f[:cntrl:]]')
	if n > -1
		" yes, string
		let @x = String2Hex(@x)
	else
		" no, hex
		let @x = Hex2String(@x)
	endif

	" reselect
	normal gv
	" paste over selection (replacing it)
	normal "xp

	" recover position if select all
	if exists("mypos_orig")
		" go back to insert mode
		normal i
		execute mypos_orig
	endif

	" do not recover selection

endfunction

