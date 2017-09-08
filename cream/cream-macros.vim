"
" Filename: cream-macros.vim
"
" Cream -- An easy-to-use configuration of the famous Vim text editor
" (http://cream.sourceforge.net) Copyright (C) 2001-2011 Steve Hall
"
" License:
" This program is free software; you can redistribute it and/or modify
" it under the terms of the GNU General Public License as published by
" the Free Software Foundation; either version 3 of the License, or
" (at your option) any later version.
" (http://www.gnu.org/licenses/gpl.html)
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

" Cream_macro_record() {{{1
function! Cream_macro_record(...)
" Record to register. Optional argument is register letter

	if exists("a:1")
		" test single register
		if strlen(a:1) > 1
			call confirm(
				\ "Error: Multiple characters passed to Cream_macro_record().\n" .
				\ "\n", "&Ok", 1, "Info")
			return
		endif
		" test non-alpha
		if match(a:1, '\a') == -1
			call confirm(
				\ "Error: Non-character argument in Cream_macro_record().\n" .
				\ "\n", "&Ok", 1, "Info")
			return
		endif
		let myreg = a:1
	else
		let myreg = Cream_macro_getregister()
		if myreg == -1
			return
		endif
	endif

	if exists("g:recording")
		" stop
		unlet g:recording
		let g:recording_fix = 1
		normal q

		" fixes
		execute "let x = @" . myreg

		" remove trailing <S-F8> mapping
		"let x = substitute(x, nr2char(128) . nr2char(253) . nr2char(13) . "$", "", "")
		"let x = substitute(x, "€ý", '', '')
		let x = substitute(x, "...$", '', '')

		execute "let @" . myreg . " = x"
	else
		" start
		let g:recording = 1
		execute "normal q" . myreg
	endif

endfunction


" Cream_macro_play() {{{1
function! Cream_macro_play(...)

	if exists("a:1")
		" test single register
		if strlen(a:1) > 1
			call confirm(
				\ "Error: Multiple characters passed to Cream_macro_play().\n" .
				\ "\n", "&Ok", 1, "Info")
			return
		endif
		" test non-alpha
		if match(a:1, '\a') == -1
			call confirm(
				\ "Error: Non-character argument in Cream_macro_play().\n" .
				\ "\n", "&Ok", 1, "Info")
			return
		endif
		let myreg = a:1
	else
		let myreg = Cream_macro_getregister()
		if myreg == -1
			return
		endif
	endif

	" add an insertmode call to temp register depending on col position
	execute "let x = @" . myreg
	if   col('.') != col('$')
	\ && col('.') != col('$') - 1
		let posfix = "i"
	else
		let posfix = "a"
	endif
	let @1 = posfix . x

	" play register
	normal @1


	" fix position unless on first column of empty line
	if   col('.') != col('$')
	\ && col('.') != col('$') - 1
		normal l
	endif

	"""let myline = ('.')
	"""normal l
	"""if line('.') > myline
	"""    normal ha
	"""endif

endfunction

" Cream_macro_getregister() {{{1
function! Cream_macro_getregister()
" get register from user

	let myreg = Inputdialog(
		\ "Enter a register (A-z) to use for macro\n(only first letter used):", "q")

	" test cancel
	if myreg == "{cancel}"
		" No warning, just quit silently.
		return -1
	endif
	" test at least one character
	if myreg == ""
		call confirm(
			\ "One alphabetic character is required.\n" .
			\ "\n", "&Ok", 1, "Info")
		return -1
	endif
	" test at least one character
	if myreg == ""
		" No warning, just quit silently.
		return -1
	endif
	" test single register
	if strlen(myreg) > 1
		call confirm(
			\ "Only one character is allowed.\n" .
			\ "\n", "&Ok", 1, "Info")
		return -1
	endif
	" test non-alpha
	if match(myreg, '\a') == -1
		call confirm(
			\ "Register must be a letter (upper or lower case) A-Z, a-z.\n" .
			\ "\n", "&Ok", 1, "Info")
		return -1
	endif

	return myreg

endfunction

" 1}}}
" vim:foldmethod=marker
