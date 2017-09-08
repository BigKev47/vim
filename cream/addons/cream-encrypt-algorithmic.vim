"
" cream-encrypt-algorithmic.vim -- General "encryption" functions.
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


" register as a Cream add-on
if exists("$CREAM")
	call Cream_addon_register(
	\ 'Encrypt, Algorithmic', 
	\ 'Encrypt, Algorithmic', 
	\ "Encrypt or unencrypt a selection with optional neat formatting. (Actual mathematical encryption is not yet written; currently all characters are merely converted to four-digit decimal equivilents.)", 
	\ 'Encrypt.Algorithmic', 
	\ 'call Cream_encrypt_algorithmic()', 
	\ '<C-u>call Cream_encrypt_algorithmic("v")'
	\ )
endif

function! Cream_encrypt_algorithmic(...)
" converts string into decimal values in preparation for (not yet
" included) mathematical encryption.
" * Optional arguments:
"     "v"         -- acts on visual selection (without mode, does file)
"     "encrypt"   -- encrypts 
"     "unencrypt" -- unencrypts
"         argument "encrypt" or "unencrypt" performs as expected, but
"         where omitted, process is guessed based on the presence of
"         non-numeric/non-whitespace characters
"
"     "silent"    -- no prompting (does best/quickest option)
"
" * Dialog prompts for optional (slower) formatting into neat rows and
"   columns.
" * Currently has no real encryption algorithm. (Location
"   indicated--requires merely the conversion of the obtained string.)

	" capture current states
	let s:save_cpo = &cpo
	set cpoptions&vim

	" find arguments
	if a:0 > 0
		let i = 0
		while i < a:0
			let i = i + 1
			execute "let myarg = a:" . i
			if     myarg ==? "v"
				let dofile = 0
			elseif myarg ==? "encrypt"
				let myprocess = "encrypt"
			elseif myarg ==? "unencrypt"
				let myprocess = "unencrypt"
			elseif myarg ==? "silent"
				let silent = 1
			endif
		endwhile
	endif

	if exists("dofile")
		let dofile = dofile
	else
		let dofile = 1
	endif

	if exists("silent")
		let silent = silent
	else
		let silent = 0
	endif

	" get file or selection
	if dofile == 1
		if silent == 0
			" select all
			let n = confirm(
				\ "Encrypt entire file?\n" .
				\ "\n", "&Ok\n&Cancel", 1, "Info")
			if n != 1
				" return states
				let &cpo = s:save_cpo
				" quit
				return
			endif
		endif
		call Cream_select_all(1)
	else
		" reselect previous selection
		normal gv
	endif

	" copy selection into @x
	normal "xy

	" guess encryption process if not provided
	if !exists("myprocess")
		" if matches any character NOT numeric, space, <NL> or <CR>
		if match(@x, "[^0-9\ \n\r]", 0) != -1
			let myprocess = "encrypt"
		else
			let myprocess = "unencrypt"
		endif
	endif

""*** DEBUG:
"let n = confirm(
"    \ "DEBUG:\n" .
"    \ "  dofile     = \"" . dofile . "\"\n" .
"    \ "  myprocess  = \"" . myprocess . "\"\n" .
"    \ "  silent     = \"" . silent . "\"\n" .
"    \ "\n", "&Ok\n&Cancel", 1, "Info")
"if n != 1
"    return
"endif
""***

	" do it!
	if myprocess == "encrypt"
		if silent == 0
			let @x = Cream_encrypt_algorithmic_encrypt(@x)
		else
			let @x = Cream_encrypt_algorithmic_encrypt(@x, "silent")
		endif
	elseif myprocess == "unencrypt"
		if silent == 0
			let @x = Cream_encrypt_algorithmic_unencrypt(@x)
		else
			let @x = Cream_encrypt_algorithmic_unencrypt(@x, "silent")
		endif
	else
		"*** DEBUG:
		let n = confirm(
			\ "Error: No process detected in Cream_encrypt_algorithmic(). Quitting...\n" .
			\ "\n", "&Ok\n&Cancel", 1, "Info")
		return
	endif

	" re-select
	normal gv
	" paste back over selection
	normal "xp

	" return states
	let &cpo = s:save_cpo

endfunction

function! Cream_encrypt_algorithmic_encrypt(mystr, ...)
" returns an encrypted string from an unencrypted one

	" check silent
	if a:0 > 0 
		if a:1 ==? "silent"
			let silent = 1
		endif
	endif

	if !exists("silent")
		let silent = 0
	endif

	" determine return characteristics
	if     &fileformat == "unix"
		let myreturn = "\n"
		let myreturnlen = 1
	elseif &fileformat == "dos"
		let myreturn = "\r\n"
		let myreturnlen = 2
	elseif &fileformat == "mac"
		let myreturn = "\r"
		let myreturnlen = 1
	endif

	let newstr = a:mystr

	" notice
	let mytemp = strlen(a:mystr)
	if silent == 0
		let mychoice = confirm(
			\"Notes:\n" . 
			\" * Data is NOT currently being encrypted, just reduced to numerical ASCII values.\n" .
			\" * The routine automatically knows if you're encyrpting or unencrypting.\n" .
			\" * Formatting at least doubles processing time.\n" .
			\"      Estimatated time (unformatted): " . (mytemp / 300) . " seconds processing " . mytemp . " bytes)\n" .
			\"      Estimatated time (formatted):   " . (mytemp / 100) . " seconds processing " . mytemp . " bytes)\n" .
			\"\n", "&Encrypt\nEncrypt\ and\ &Format", 1, "Info")
		if mychoice == 1
			let myformat = 0
		else
			let myformat = 1
		endif
	else
		let myformat = 0
	endif

	"" give ourselves some room
	"execute "normal i" . myreturn
	"normal o
	"normal o
	"normal kk

	" string to decimal string
	let newstr = Cream_str2dec_pad(newstr)

	" simple format -- add returns at 78
	if myformat == 0
		let pos = 78
		while pos < strlen(newstr)
			let front = strpart(newstr, 0, pos)
			let back = strpart(newstr, pos + 1)
			let newstr = front . myreturn . back
			let pos = pos + 78 + myreturnlen
		endwhile
	endif


	"***********************************************
	"*** do amazing mathematical encryption here ***
	"***********************************************

	" format -- pretty
	if myformat == 1

		let mystrfirst = ""
		let mystrmiddle = ""
		let mystrlast = ""
		let mypos = 0
		let i = 0
		let j = 0

		while mypos < strlen(newstr)

			" get first part
			let mystrfirst = strpart(newstr, 0, mypos)
			" get middle part (always one char)
			let mystrmiddle = strpart(newstr, mypos, 1)
			" get last part
			let mystrlast = strpart(newstr, mypos + 1)

			" place <Space> every 5 chars
			let i = i + 1
			if i % 5 == 0
				let mystrmiddle = mystrmiddle . " "
				let mypos = mypos + 1
			endif

			" place return every 78 chars (65 chars + 65/5 spaces)
			let j = j + 1
			if j % 65 == 0
				let mystrmiddle = mystrmiddle . myreturn
				let mypos = mypos + myreturnlen
			endif

			" concatenate
			let newstr = mystrfirst . mystrmiddle . mystrlast
			" find new pos
			let mypos = mypos + 1

		endwhile
	endif

	return newstr

endfunction

function! Cream_encrypt_algorithmic_unencrypt(mystr, ...)
" returns an unencrypted string from an encrypted one

	" check silent
	if a:0 > 0 
		if a:1 ==? "silent"
			let silent = 1
		endif
	endif

	if !exists("silent")
		let silent = 0
	endif

	" determine return characteristics
	if     &fileformat == "unix"
		let myreturn = "\n"
		let myreturnlen = 1
	elseif &fileformat == "dos"
		let myreturn = "\n"
		let myreturnlen = 1
	elseif &fileformat == "mac"
		let myreturn = "\r"
		let myreturnlen = 1
	endif

	" initialize variables
	let mystrfirst = ""
	let mystrmiddle = ""
	let mystrlast = ""
	let mypos = 0
	let newstr = a:mystr

	" notice
	let mytemp = strlen(a:mystr)
	if silent == 0
		let mychoice = confirm(
			\"Unencrypting. (Roughly estimate " . (mytemp / 1000) . " seconds processing " . mytemp . " bytes)\n",
			\"&Begin", 1, "Info")
	endif

	" de-format

	" substitutions designed without
	let s:save_magic = &magic
	set nomagic

	" remove all linefeeds
	let newstr = substitute(newstr, "\n", "", "g")
	" remove all carriage returns
	let newstr = substitute(newstr, "\r", "", "g")
	" remove all spaces
	let newstr = substitute(newstr, " ", "", "g")

	" return state
	let &magic = s:save_magic

	"**************************************************
	"*** do amazing mathematical un-encryption here ***
	"**************************************************

	" decimal string to string
	let newstr = Cream_dec2str_pad(newstr)

	return newstr

endfunction

