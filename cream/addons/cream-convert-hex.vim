"
" cream-convert-hex.vim -- Functions derived from Vim distribution
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

" register as a Cream add-on
if exists("$CREAM")

	call Cream_addon_register(
	\ 'Convert ASCII to Hex',
	\ 'Convert ASCII to Hex.',
	\ 'Convert ASCII from Hex using xxd binary. (Distributed with Vim on Windows, usually available on Unix systems.',
	\ 'Convert.ASCII to Hex',
	\ 'call Cream_ascii2hex("i")',
	\ '<C-u>call Cream_ascii2hex("v")'
	\ )
	call Cream_addon_register(
	\ 'Convert Hex to ASCII',
	\ 'Convert Hex to ASCII.',
	\ 'Convert Hex to ASCII using xxd binary. (Distributed with Vim on Windows, usually available on Unix systems.)',
	\ 'Convert.Hex to ASCII',
	\ 'call Cream_hex2ascii("i")',
	\ '<C-u>call Cream_hex2ascii("v")'
	\ )
endif

function! Cream_ascii2hex(mode)

	if     a:mode == "v"
		normal gv
	elseif a:mode == "i"
		let n = confirm(
			\ "Convert entire file to hex?\n" .
			\ "\n", "&Ok\n&Cancel", 1, "Info")
		if n != 1
			return
		endif
	else
		return
	endif

	let mod = &modified
	call s:XxdFind()
	" quote path/filename on Windows in case of spaces
	if has("win32") || has ("dos32")
		let myquote = '"'
	else
		let myquote = ""
	endif

	if     a:mode == "v"
		execute "'\<,'>!" . myquote . g:xxdprogram . myquote
	elseif a:mode == "i"
		execute "%!" . myquote . g:xxdprogram . myquote
	endif

	set filetype=xxd
	let &modified = mod

endfunction

function! Cream_hex2ascii(mode)

	if     a:mode == "v"
		normal gv
	elseif a:mode == "i"
		let n = confirm(
			\ "Return entire file to ASCII?\n" .
			\ "\n", "&Ok\n&Cancel", 1, "Info")
		if n != 1
			return
		endif
	else
		return
	endif

	let mod = &modified
	call s:XxdFind()
	" quote path/filename on Windows in case of spaces
	if has("win32") || has ("dos32")
		let myquote = '"'
	else
		let myquote = ""
	endif

	if     a:mode == "v"
		execute "'\<,'>!" . myquote . g:xxdprogram . myquote . " -r"
	elseif a:mode == "i"
		execute "%!" . myquote . g:xxdprogram . myquote . " -r"
	endif

	set filetype=
	doautocmd filetypedetect BufReadPost
	let &modified = mod
endfunction

function! s:XxdFind()
" sets "g:xxdprogram" to the location of an xxd binary
	if !exists("g:xxdprogram")
		" On Windows, xxd may not be in the path but in the install
		" directory
		if (has("win32") || has("dos32")) && !executable("xxd")
			let g:xxdprogram = $VIMRUNTIME . (&shellslash ? '/' : '\') . "xxd.exe"
		else
			let g:xxdprogram = "xxd"
		endif
	endif
endfunction

