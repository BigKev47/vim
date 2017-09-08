"
" Filename: cream-colorinvert.vim
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
" Date:   04 Sep 2002
" Source: http://vim.sourceforge.net/scripts/script.php?script_id=???
" Author: Steve Hall  [ digitect@mindspring.com ]
" License: GPL (http://www.gnu.org/licenses/gpl.html)
"
" Description:
" Inverts a standard hexidecimal ("ffffcc"), abbreviated hexidecimal
" ("fc3"), or decimal ("255,204,0") RGB value
" * Initial "#" optional
" * Whitespace optional
"
" One of the many custom utilities and functions for gVim from the
" Cream project ( http://cream.sourceforge.net ), a configuration of
" Vim in the vein of Apple and Windows software you already know.
"
" Installation:
" Just copy this file and paste it into your vimrc. Or you can drop
" the entire file into your plugins directory.
"
" Use:
" Two arguments are possible:
"   mode    -- If some form of visual or selection mode, the current
"              selection taken as the value to be inverted
"   ...     -- if the mode argument does not indicate a current
"              selection, the second argument is taken as the value
"              (pass a mode of "n" to use)
"
" Examples:
" To invert a selection:        :call Cream_colorinvert("v")
" To invert a passed value:     :call Cream_colorinvert("n", value)
"

" Mapping Example:
"vmap <silent> <C-F12> :call Cream_colorinvert_v()<CR>


" register as a Cream add-on
if exists("$CREAM")
	call Cream_addon_register(
	\ 'Color Invert', 
	\ 'Invert a selected hex, short hex, or decimal RGB value.', 
	\ "Invert the color value of a selection. Accepts hexidecimal (\"ffffcc\"), abbreviated hexidecimal (\"fc3\"), or decimal (\"255,204,0\") RGB value. Both initial \"#\" and separating whitespace are optional.", 
	\ 'Color Invert', 
	\ '<Nil>', 
	\ '<C-u>call Cream_colorinvert("v")'
	\ )
endif

function! Cream_colorinvert(mode)
" get value from current selection

	if a:mode == "v"

		" reselect
		normal gv
		" yank
		normal "xy

		let @x = <SID>Cream_colorinvert(@x)

		" reselect
		normal gv
		" paste (over selection replacing it)
		normal "xp
		" reselect
		normal gv
	endif

endfunction

"----------------------------------------------------------------------
" Private

function! <SID>Cream_colorinvert(value)
" return inverted value

	" value passed
	let mystr = a:value

	" strip initial "#" if present
	if strpart(mystr, 0, 1) == "#"
		let mystartchar = "#"
		let mystr = strpart(mystr, 1)
	else
		let mystartchar = ""
	endif
	" lower case
	let mystr = tolower(mystr)
	" strip spaces
	let mystr = substitute(mystr, " ", "", "g")
	" strip tabs
	let mystr = substitute(mystr, "\<Tab>", "", "g")

	" get form, validate
	let myform = <SID>Cream_colorinvert_form(mystr)
	if myform == ""
		" error--quit
		return
	endif

""*** DEBUG:
"let mychoice = confirm(
"    \ "Debug info:\n" .
"    \ " myform     = " . myform . "\n" .
"    \ "\n", "&Ok\n&Cancel", 1, "Info")
"if mychoice != 1
"    return
"endif
""***

	" convert to decimal
	if myform != "decimal"
		let mystr = <SID>Cream_colorinvert_hex2dec(mystr, myform)
	endif

""*** DEBUG:
"let mychoice = confirm(
"    \ "Debug info:\n" .
"    \ " mystr     = " . mystr . "\n" .
"    \ "\n", "&Ok\n&Cancel", 1, "Info")
"if mychoice != 1
"    return
"endif
""***

	" calculate inverted value
	let mystr = <SID>Cream_colorinvert_calc(mystr)

	" convert back to original form
	if myform != "decimal"
		let mystr = <SID>Cream_colorinvert_dec2hex(mystr, myform)
	endif

	" return with initial "#" state
	return mystartchar . mystr

endfunction

function! <SID>Cream_colorinvert_form(value)
" validate and find which format the string is in
" * returns "hex", "hexshort", "decimal", or "" if invalid
" * valid forms: "FFFFFF" "ffffff" "ff00FF" "fc0" "255,255,51"
"   "255,255,51"

	let mystr = a:value

	" decimal ("255,255,255" or "1,1,1")
	" first comma match (after first char)
	let n = match(mystr, ",", 1)
	if n != -1
		" verify not too short or too long
		if strlen(mystr) <= 4 || strlen(mystr) >= 12
			call confirm(
				\ "Proper color value not detected\n" .
				\ "(incorrect length). Aborting...\n" .
				\ "\n", "&Ok", 1, "Info")
			return
		endif
		" second comma match (skip 1 char)
		let n = match(mystr, ",", n + 2)
		" verify second comma
		if n == -1
			call confirm(
				\ "Proper color value not detected\n" .
				\ "(single comma). Aborting...\n" .
				\ "\n", "&Ok", 1, "Info")
			return
		endif
		" verify second comma not at end
		if n == strlen(mystr)
			call confirm(
				\ "Proper color value not detected\n" .
				\ "(trailing comma). Aborting...\n" .
				\ "\n", "&Ok", 1, "Info")
			return
		endif
		" verify not third comma
		if match(mystr, ",", n + 1) != -1
			call confirm(
				\ "Proper color value not detected\n" .
				\ "(more than 2 commas). Aborting...\n" .
				\ "\n", "&Ok", 1, "Info")
			return
		endif
		" test for other invalid characters
		if match(a:value, "[^0-9,]") != -1
			call confirm(
				\ "Proper color value not detected\n" .
				\ "(invalid characters). Aborting...\n" .
				\ "\n", "&Ok", 1, "Info")
			return
		endif
		return "decimal"

	" hex ("ffaa00")
	elseif strlen(mystr) == 6
		" test for invalid characters
		if match(a:value, "[^0-9a-f]") != -1
			call confirm(
				\ "Proper color value not detected\n" .
				\ "(invalid characters). Aborting...\n" .
				\ "\n", "&Ok", 1, "Info")
			return
		endif
		return "hex"

	" hex, short ("fa0")
	elseif strlen(mystr) == 3
		" test for invalid characters
		if match(a:value, "[^0-9a-f]") != -1
			call confirm(
				\ "Proper color value not detected\n" .
				\ "(invalid characters). Aborting...\n" .
				\ "\n", "&Ok", 1, "Info")
			return
		endif
		return "hexshort"

	else
		call confirm(
			\ "Proper color value not detected\n" .
			\ "(character miscount). Aborting...\n" .
			\ "\n", "&Ok", 1, "Info")
		return
	endif

endfunction

function! <SID>Cream_colorinvert_hex2dec(hex, form)
" lengthen to normal if short hex form
" * return decimal value
	if a:form == "hexshort"
		let R = strpart(a:hex, 0, 1)
		let R = Hex2Nr(R . R)
		let G = strpart(a:hex, 1, 1)
		let G = Hex2Nr(G . G)
		let B = strpart(a:hex, 2, 1)
		let B = Hex2Nr(B . B)
	elseif a:form == "hex"
		let R = strpart(a:hex, 0, 2)
		let R = Hex2Nr(R)
		let G = strpart(a:hex, 2, 2)
		let G = Hex2Nr(G)
		let B = strpart(a:hex, 4, 2)
		let B = Hex2Nr(B)
	else
		" error
		call confirm(
			\ "Error: Invalid form in Cream_colorinvert_hex2dec().\n" .
			\ "Aborting...\n" .
			\ "\n", "&Ok", 1, "Info")
		return
	endif
	return R . "," . G . "," . B
endfunction

function! <SID>Cream_colorinvert_dec2hex(hex, form)
" lengthen to normal if short hex form
" * return decimal value
" * (we add 0 to ensure numerical type)
	if a:form == "hexshort"
		let R = MvElementAt(a:hex, ",", 0)
		let R = Nr2Hex(R / 16)
		let G = MvElementAt(a:hex, ",", 1)
		let G = Nr2Hex(G / 16)
		let B = MvElementAt(a:hex, ",", 2)
		let B = Nr2Hex(B / 16)
	elseif a:form == "hex"
		let R = MvElementAt(a:hex, ",", 0)
		let R = Nr2Hex(R)
		let G = MvElementAt(a:hex, ",", 1)
		let G = Nr2Hex(G)
		let B = MvElementAt(a:hex, ",", 2)
		let B = Nr2Hex(B)
		" pad to two characters
		if strlen(R) == 1 | let R = "0" . R | endif
		if strlen(G) == 1 | let G = "0" . G | endif
		if strlen(B) == 1 | let B = "0" . B | endif
	else
		" error
		call confirm(
			\ "Error: Invalid form in Cream_colorinvert_dec2hex().\n" .
			\ "Aborting...\n" .
			\ "\n", "&Ok", 1, "Info")
		return
	endif

""*** DEBUG:
"let mychoice = confirm(
"    \ "Debug info:\n" .
"    \ " a:hex  = " . a:hex . "\n" .
"    \ " a:form = " . a:form . "\n" .
"    \ " R      = " . R . "\n" .
"    \ " G      = " . G . "\n" .
"    \ " B      = " . B . "\n" .
"    \ "\n", "&Ok\n&Cancel", 1, "Info")
"if mychoice != 1
"    return
"endif
""***
	return tolower(R . G . B)
endfunction

function! <SID>Cream_colorinvert_calc(decimal)
" actually invert the decimal value here!
	let R = 255 - MvElementAt(a:decimal, ",", 0)
	let G = 255 - MvElementAt(a:decimal, ",", 1)
	let B = 255 - MvElementAt(a:decimal, ",", 2)
""*** DEBUG:
"call confirm(
"    \ "Debug info:\n" .
"    \ " a:decimal  = " . a:decimal . "\n" .
"    \ " output     = " . R . "," . G . "," . B . "\n" .
"    \ "\n", "&Ok\n&Cancel", 1, "Info")
""***
	return R . "," . G . "," . B
endfunction

