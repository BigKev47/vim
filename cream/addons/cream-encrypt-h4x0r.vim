"
" cream-encrypt-h4x0r.vim -- General "encryption" functions.
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
	\ 'Encrypt, h4x0r', 
	\ 'Encrypt, h4x0r', 
	\ 'Encrypt a selection by substituting certain letters or numbers with others that mimic the look of the original. An example would be the number 4 for a capital A.', 
	\ 'Encrypt.h4x0r', 
	\ 'call Cream_encrypt_h4x0r()', 
	\ '<C-u>call Cream_encrypt_h4x0r("v")'
	\ )
endif

function! Cream_encrypt_h4x0r(...)
" "h4x0r" mode encryption--Converts selection into alphabetic
" o See functions at bottom for char equivalant tables
" o Requires selection before calling

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

	" yank into register
	normal "xy

	" encrypt
	let @x = Cream_h4x0r(@x)

	" reselect
	normal gv
	" paste over selection (replacing it)
	normal "xp

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

function! Cream_h4x0r(mystr)
" return a "h4x0r encrypted" string 

	"*****************************************************************
	" NOTE: YOU CAN'T DO SIMPLE SUBSTITUTIONS HERE! We are *toggling*
	" characters, meaning "e"s go to "3"s while at the same time "3"s
	" go to "e"s! Without specifying either the position up to which
	" the process has taken place, or specifying which it is we're
	" doing, there's no way to know whether we're encrypting or
	" unencrypting. You always end up where you started. ;)
	"*****************************************************************

	let mypos = 0
	let newstr = a:mystr
	" do while char still found
	while mypos < strlen(newstr)
		" get first part
		let mystrfirst = strpart(newstr, 0, mypos)
		" get middle part (always one char)
		let mystrmiddle = strpart(newstr, mypos, 1)
		" get last part
		let mystrlast = strpart(newstr, mypos + 1)

		" USE ONLY ONE BELOW!
		""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
		let mystrmiddle = s:Cream_encrypt_h4x0r_7bit(mystrmiddle)
		"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
		"" multi-byte substitution
		"" *** BROKEN: some of the positioning stuff above appears to
		""             mis-count multi-byte chars.
		"let char = s:Cream_encrypt_h4x0r_8bit(mystrmiddle)
		"" account for multi-byte offsets
		"if     strlen(mystrmiddle) == 1 && strlen(char) == 2
		"    let mypos = mypos + 1
		"elseif strlen(mystrmiddle) == 2 && strlen(char) == 1
		"    let mypos = mypos - 1
		"endif
		"let mystrmiddle = char
		"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

		" concatenate
		let newstr = mystrfirst . mystrmiddle . mystrlast
		" find new pos
		let mypos = mypos + 1
	endwhile

	return newstr

endfunction

function! s:Cream_encrypt_h4x0r_7bit(char)
" return a char based on the table:
"     abcdefghijklmnopqrstuvwxyz
"     4   3 6 1     0   $7     2

	" convert to decimal (to maintain case)
	let char = char2nr(a:char)

	" a/4
	if     char == char2nr("a")
		return "4"
	elseif char == char2nr("4")
		return "a"
	" e/3
	elseif char == char2nr("e")
		return "3"
	elseif char == char2nr("3")
		return "e"
	" g/6
	elseif char == char2nr("g")
		return "6"
	elseif char == char2nr("6")
		return "g"
	" i/1
	elseif char == char2nr("i")
		return "1"
	elseif char == char2nr("1")
		return "i"
	" o/0
	elseif char == char2nr("o")
		return "0"
	elseif char == char2nr("0")
		return "o"
	" s/$
	elseif char == char2nr("s")
		return "$"
	elseif char == char2nr("$")
		return "s"
	" t/7
	elseif char == char2nr("t")
		return "7"
	elseif char == char2nr("7")
		return "t"
	" z/2
	elseif char == char2nr("z")
		return "2"
	elseif char == char2nr("2")
		return "z"
	endif

	return a:char

endfunction

function! s:Cream_encrypt_h4x0r_8bit(char)
" return a char based on the table:
"     abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ
"     @Þ¢ êƒ  ¡  1 ñø 9®$†µ  ×ýž Aß©Ð3 6 ¦  £ ÑØ¶  Š7Û  %Ÿ2

	"" convert to decimal (to maintain case)
	"let char = char2nr(a:char)
	let char = a:char

	" a/@
	if     char == "a"
		return "4"
	elseif char == "4"
		return "a"
	" b/Þ
	elseif char == "b"
		return "Þ"
	elseif char == "Þ"
		return "b"
	" c/¢
	elseif char == "c"
		return "¢"
	elseif char == "¢"
		return "c"
	" e/ê
	elseif char == "e"
		return "ê"
	elseif char == "ê"
		return "e"
	" f/ƒ
	elseif char == "f"
		return "ƒ"
	elseif char == "ƒ"
		return "f"
	" i/¡
	elseif char == "i"
		return "¡"
	elseif char == "¡"
		return "i"
	" l/1
	elseif char == "l"
		return "1"
	elseif char == "1"
		return "l"
	" n/ñ
	elseif char == "n"
		return "ñ"
	elseif char == "ñ"
		return "n"
	" o/ø
	elseif char == "o"
		return "ø"
	elseif char == "ø"
		return "o"
	" q/9
	elseif char == "q"
		return "9"
	elseif char == "9"
		return "q"
	" r/®
	elseif char == "r"
		return "®"
	elseif char == "®"
		return "r"
	" s/$
	elseif char == "s"
		return "$"
	elseif char == "$"
		return "s"
	" t/†
	elseif char == "t"
		return "†"
	elseif char == "†"
		return "t"
	" u/µ
	elseif char == "u"
		return "µ"
	elseif char == "µ"
		return "u"
	" x/×
	elseif char == "x"
		return "×"
	elseif char == "×"
		return "x"
	" y/ý
	elseif char == "y"
		return "ý"
	elseif char == "ý"
		return "y"
	" z/ž
	elseif char == "z"
		return "ž"
	elseif char == "ž"
		return "z"
	" A/A
	elseif char == "A"
		return "A"
	elseif char == "A"
		return "A"
	" B/ß
	elseif char == "B"
		return "ß"
	elseif char == "ß"
		return "B"
	" C/©
	elseif char == "C"
		return "©"
	elseif char == "©"
		return "C"
	" D/Ð
	elseif char == "D"
		return "Ð"
	elseif char == "Ð"
		return "D"
	" E/3
	elseif char == "E"
		return "3"
	elseif char == "3"
		return "E"
	" G/6
	elseif char == "G"
		return "6"
	elseif char == "6"
		return "G"
	" I/¦
	elseif char == "I"
		return "¦"
	elseif char == "¦"
		return "I"
	" L/£
	elseif char == "L"
		return "£"
	elseif char == "£"
		return "L"
	" N/Ñ
	elseif char == "N"
		return "Ñ"
	elseif char == "Ñ"
		return "N"
	" S/Š
	elseif char == "S"
		return "Š"
	elseif char == "Š"
		return "S"
	" T/7
	elseif char == "T"
		return "7"
	elseif char == "7"
		return "T"
	" U/Û
	elseif char == "U"
		return "Û"
	elseif char == "Û"
		return "U"
	" X/%
	elseif char == "X"
		return "%"
	elseif char == "%"
		return "X"
	" Y/Ÿ
	elseif char == "Y"
		return "Ÿ"
	elseif char == "Ÿ"
		return "Y"
	" Z/2
	elseif char == "Z"
		return "2"
	elseif char == "2"
		return "Z"
	endif

	return a:char

endfunction

