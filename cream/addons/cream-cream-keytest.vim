"
" Filename: cream-cream-keytest.vim
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
" Description:
" Test and interpret individual keyboard characters. Useful to see
" exactly what code your hardware and software combination returns for
" a given keystroke. Where our interpretation table isn't complete,
" the actual decimal values for the key pressed are returned.
"
" Updated: 2003-12-20 01:49:04EST
" Version: 2.0
" Source:  http://vim.sourceforge.net/script.php?script_id=488
" Author:  Steve Hall  [ digitect@mindspring.com ]
" License: GPL (http://www.gnu.org/licenses/gpl.html)
"
" Installation:
" Just drop this file into your plugins directory, and start Vim.
"
" Usage:
" * Call "Cream_keytest()" to get feedback about each key pressed.
" * Call "Cream_keyinterpret()" to return only the interpretation.
"   An empty return means character not yet in the table.
"
" Notes:
" * The interpretation table is currently unfinished. There are
"   literally between 400 and 700 possible keystroke combinations on
"   the average keyboard. Please look at the complete Ctrl/Shift/Alt
"   combination interpretations of the Ins, Del, Home, End, PgUp, PgDn
"   keys for an example of a full test.
"
" * This has only been tested with &encoding=latin1.
"
" * If you take the time to develop the script further, please forward
"   your explorations or improvements them back to us! (Besides,
"   that's what the GPL is all about. ;)
"

" register as a Cream add-on
if exists("$CREAM")
	" don't list unless Cream developer
	if !exists("g:cream_dev")
		finish
	endif

	call Cream_addon_register(
	\ 'Key Test',
	\ 'Interpret keystroke characters',
	\ "Test and interpret individual keyboard characters. Useful to see exactly what code your hardware and software combination returns for a given keystroke. Where our table isn't complete, the actual decimal value(s) are returned.",
	\ 'Cream Devel.Key Test',
	\ 'call Cream_keytest()',
	\ '<Nil>'
	\ )
endif

function! Cream_keytest()

	let n = confirm(
		\ "Please press continue then press a key to interpret. (Esc to Quit)",
		\ "&Continue", 1, "Info")
	if n != 1
		return
	endif

	while n == 1
		let myreturn = Cream_keyinterpret2()
		if myreturn ==? "esc"
		\ || myreturn ==? "027 ESC"
			break
		endif
	endwhile

endfunction

" Cream_keyinterpret() [obsolete] {{{1
function! Cream_keyinterpret_old(...)
" if optional argument provided, use per-character feedback dialog

	" currently, we've only tested &encoding=latin1
	if &encoding !=? 'latin1'
		call confirm(
			\ "Not tested with &encoding value \"" . &encoding . "\". Quitting...\n" .
			\ "(Please contact us if you wish to test an alternate coding!)\n" .
			\ "\n", "&Ok", 1, "Info")
		return
	endif

	" our interpretation
	let mycharname = ""
	let multi = ""

	" get character
	let mychar = getchar()

	" alpha-numeric
	if    mychar > 32
	\ &&  mychar < 127
		let mycharname = nr2char(mychar)

	elseif mychar == 9
		let mycharname = "tab"
	elseif mychar == 10
		let mycharname = "linefeed"
	elseif mychar == 13
		let mycharname = "return"
	elseif mychar == 26
		let mycharname = "ctrl+z"
	elseif mychar == 27
		let mycharname = "esc"
	elseif mychar == 32
		let mycharname = "space"

	" multi-byte has initial Esc {{{2
	elseif mychar[0] == nr2char("128")
		" interpret *remainder*
		let mytemp = strpart(mychar, 1)

		" backspace
		if     mytemp ==# "kb"
			let mycharname = "backspace"
		elseif mytemp ==# "��kb"
			let mycharname = "shift+backspace"

		" down
		elseif mytemp ==# "kd"
			let mycharname = "down"

		" up
		elseif mytemp ==# "ku"
			let mycharname = "up"

		" left
		elseif mytemp ==# "kl"
			let mycharname = "left"
		elseif mytemp ==# "#4"
			let mycharname = "shift+left"

		" right
		elseif mytemp ==# "kr"
			let mycharname = "right"
		elseif mytemp ==# "%i"
			let mycharname = "shift+right"

		" insert
		elseif mytemp ==# "kI"
			let mycharname = "insert"
		elseif mytemp ==# "#3"
			let mycharname = "shift+insert"
		elseif mytemp ==# "��kI"
			let mycharname = "ctrl+insert"
		elseif mytemp ==# "��kI"
			let mycharname = "alt+insert"
		elseif mytemp ==# "��kI"
			let mycharname = "ctrl+alt+insert"
		elseif mytemp ==# "��#3"
			let mycharname = "ctrl+shift+insert"
		elseif mytemp ==# "��#3"
			let mycharname = "alt+shift+insert"
		elseif mytemp ==# "��#3"
			let mycharname = "ctrl+alt+shift+insert"

		" delete
		elseif mytemp ==# "kD"
			let mycharname = "delete"
		elseif mytemp ==# "*4"
			let mycharname = "shift+delete"
		elseif mytemp ==# "��kD"
			let mycharname = "ctrl+delete"
		elseif mytemp ==# "��kD"
			let mycharname = "alt+delete"
		elseif mytemp ==# "��*4"
			let mycharname = "ctrl+shift+delete"
		elseif mytemp ==# "��kD"
			let mycharname = "ctrl+alt+delete"
		elseif mytemp ==# "��*4"
			let mycharname = "alt+shift+delete"
		elseif mytemp ==# "��*4"
			let mycharname = "ctrl+alt+shift+delete"

		" home
		elseif mytemp ==# "kh"
			let mycharname = "home"
		elseif mytemp ==# "#2"
			let mycharname = "shift+home"
		elseif mytemp ==# "�O"
			let mycharname = "ctrl+home"
		elseif mytemp ==# "��kh"
			let mycharname = "alt+home"
		elseif mytemp ==# "��#2"
			let mycharname = "ctrl+shift+home"
		elseif mytemp ==# "���O"
			let mycharname = "ctrl+alt+home"
		elseif mytemp ==# "��#2"
			let mycharname = "alt+shift+home"
		elseif mytemp ==# "��#2"
			let mycharname = "ctrl+alt+shift+home"

		" end
		elseif mytemp ==# "@7"
			let mycharname = "end"
		elseif mytemp ==# "*7"
			let mycharname = "shift+end"
		elseif mytemp ==# "�P"
			let mycharname = "ctrl+end"
		elseif mytemp ==# "��@7"
			let mycharname = "alt+end"
		elseif mytemp ==# "��*7"
			let mycharname = "ctrl+shift+end"
		elseif mytemp ==# "���P"
			let mycharname = "ctrl+alt+end"
		elseif mytemp ==# "��*7"
			let mycharname = "alt+shift+end"
		elseif mytemp ==# "��*7"
			let mycharname = "ctrl+alt+shift+end"

		" pgup
		elseif mytemp ==# "kP"
			let mycharname = "pgup"
		elseif mytemp ==# "��kP"
			let mycharname = "shift+pgup"
		elseif mytemp ==# "��kP"
			let mycharname = "ctrl+pgup"
		elseif mytemp ==# "��kP"
			let mycharname = "alt+pgup"
		elseif mytemp ==# "��kP"
			let mycharname = "ctrl+shift+pgup"
		elseif mytemp ==# "��kP"
			let mycharname = "ctrl+alt+pgup"
		""*** broken (252.010.128.107.080) -- 010 removes to line end!
		"elseif mytemp ==# "� �kP"
		"    let mycharname = "alt+shift+pgup"
		elseif mytemp ==# "��kP"
			let mycharname = "ctrl+alt+shift+pgup"

		" pgdn
		elseif mytemp ==# "kN"
			let mycharname = "pgdn"
		elseif mytemp ==# "��kN"
			let mycharname = "shift+pgdn"
		elseif mytemp ==# "��kN"
			let mycharname = "ctrl+pgdn"
		elseif mytemp ==# "��kN"
			let mycharname = "alt+pgdn"
		elseif mytemp ==# "��kN"
			let mycharname = "ctrl+shift+pgdn"
		elseif mytemp ==# "��kN"
			let mycharname = "ctrl+alt+pgdn"
		""*** broken (252.010.128.107.078) -- 010 removes to line end!
		"elseif mytemp ==# "� �kN"
		"    let mycharname = "alt+shift+pgdn"
		elseif mytemp ==# "��kN"
			let mycharname = "ctrl+alt+shift+pgdn"


		" F-keys
		elseif mytemp ==# "k1"
			let mycharname = "F1"
		elseif mytemp ==# "�"
			let mycharname = "shift+F1"
		elseif mytemp ==# "��k1"
			let mycharname = "ctrl+F1"

		elseif mytemp ==# "k2"
			let mycharname = "F2"
		elseif mytemp ==# "�"
			let mycharname = "shift+F2"
		elseif mytemp ==# "��k2"
			let mycharname = "ctrl+F2"

		elseif mytemp ==# "k3"
			let mycharname = "F3"
		elseif mytemp ==# "�"
			let mycharname = "shift+F3"
		elseif mytemp ==# "��k3"
			let mycharname = "ctrl+F3"

		elseif mytemp ==# "k4"
			let mycharname = "F4"
		elseif mytemp ==# "�	"
			let mycharname = "shift+F4"
		elseif mytemp ==# "��k4"
			let mycharname = "ctrl+F4"

		elseif mytemp ==# "k5"
			let mycharname = "F5"
		""*** broken (128.253.010) -- 010 removes to line end!
		"elseif mytemp ==# "� "
		"    let mycharname = "shift+F5"
		elseif mytemp ==# "��k5"
			let mycharname = "ctrl+F5"

		elseif mytemp ==# "k6"
			let mycharname = "F6"
		elseif mytemp ==# "�"
			let mycharname = "shift+F6"
		elseif mytemp ==# "��k6"
			let mycharname = "ctrl+F6"

		elseif mytemp ==# "k7"
			let mycharname = "F7"
		elseif mytemp ==# "�"
			let mycharname = "shift+F7"
		elseif mytemp ==# "��k7"
			let mycharname = "ctrl+F7"

		elseif mytemp ==# "k8"
			let mycharname = "F8"
		elseif mytemp ==# "�"
			let mycharname = "shift+F8"
		elseif mytemp ==# "��k8"
			let mycharname = "ctrl+F8"

		elseif mytemp ==# "k9"
			let mycharname = "F9"
		elseif mytemp ==# "�"
			let mycharname = "shift+F9"
		elseif mytemp ==# "��k9"
			let mycharname = "ctrl+F9"

		elseif mytemp ==# "k;"
			let mycharname = "F10"
		elseif mytemp ==# "�"
			let mycharname = "shift+F10"
		" unknown (Windows usurps, didn't reboot to GNU/Linux ;)
		"elseif mytemp ==# "��k1"
		"    let mycharname = "ctrl+F10"

		elseif mytemp ==# "F1"
			let mycharname = "F11"
		elseif mytemp ==# "�"
			let mycharname = "shift+F11"
		elseif mytemp ==# "��F1"
			let mycharname = "ctrl+F11"

		elseif mytemp ==# "F2"
			let mycharname = "F12"
		elseif mytemp ==# "�"
			let mycharname = "shift+F12"
		elseif mytemp ==# "��F2"
			let mycharname = "ctrl+F12"

		endif
		" 2}}}
	else
		" uninterpreted, but not preceded by Esc.
	endif

	" requested optional per-character feedback
	if exists("a:1")

		if mycharname != ""
			let msg = " mycharname       = " . mycharname . "\n"
		else
			" decipher each char of multi-char codes
			if strlen(mychar) > 1
				let i = 0
				while i < strlen(mychar)
					if i != 0
						let multi = multi . " + "
					endif
					let multi = multi . char2nr(mychar[i])
					let i = i + 1
				endwhile
			endif
			" compose message
			let msg = ""
			let msg = msg . "Character not interpreted:\n"
			"let msg = msg . "         mychar   = " . mychar . "\n"
			let msg = msg . " char2nr(mychar)  = " . char2nr(mychar) . "\n"
			let msg = msg . " nr2char(mychar)  = " . nr2char(mychar) . "\n"
			let msg = msg . "         (multi)  = " . multi . "\n"
			let msg = msg . "\n"
			let msg = msg . " mycharname       = " . mycharname . "\n"
		endif

		" feedback
		call confirm(
			\ msg .
			\ "\n", "&Ok", 1, "Info")

	endif

	return mycharname

endfunction
" 1}}}

function! Cream_keyinterpret2()
" returns a string describing the character captured.
" (empty string) if none interpreted

	let mycharname = ""
	let multicodes = ""

	" get character
	let mychar = getchar()

	" alpha-numeric
	if mychar > 32
	\ &&   mychar < 127
		let mycharname = nr2char(mychar)

	" space
	elseif nr2char(mychar) == "\<Space>"
		let mycharname = "Space"
	elseif mychar == "\<S-Space>"
		let mycharname = "S-Space"
	elseif mychar == "\<M-Space>"
		let mycharname = "M-Space"
	elseif mychar == "\<C-Space>"
		let mycharname = "C-Space"
	elseif mychar == "\<M-S-Space>"
		let mycharname = "M-S-Space"
	elseif mychar == "\<C-S-Space>"
		let mycharname = "C-S-Space"
	elseif mychar == "\<C-M-Space>"
		let mycharname = "C-M-Space"
	elseif mychar == "\<C-M-S-Space>"
		let mycharname = "C-M-S-Space"

	" single byte ctrl chars {{{1

	elseif nr2char(mychar) == "\<Nul>"
		let mycharname = "000 NUL"
	elseif nr2char(mychar) == ""
		let mycharname = "001 SOH"
	elseif nr2char(mychar) == ""
		let mycharname = "002 STX"
	elseif nr2char(mychar) == ""
		let mycharname = "003 ETX"
	elseif nr2char(mychar) == ""
		let mycharname = "004 EOT"
	elseif nr2char(mychar) == ""
		let mycharname = "005 ENQ"
	elseif nr2char(mychar) == ""
		let mycharname = "006 ACK"
	elseif nr2char(mychar) == ""
		let mycharname = "007 BEL"
	elseif nr2char(mychar) == ""
		let mycharname = "008 BS"
	elseif nr2char(mychar) == "\<Tab>"
		let mycharname = "009 TAB"
	elseif nr2char(mychar) == "\<NL>"
		let mycharname = "010 NL (LF)"
	elseif nr2char(mychar) == ""
		let mycharname = "011 VT"
	elseif nr2char(mychar) == "\<FF>"
		let mycharname = "012 FF"
	elseif nr2char(mychar) == "\<CR>"
		let mycharname = "013 CR"
	elseif nr2char(mychar) == ""
		let mycharname = "014 SO"
	elseif nr2char(mychar) == ""
		let mycharname = "015 SI"
	elseif nr2char(mychar) == ""
		let mycharname = "016 DLE"
	elseif nr2char(mychar) == ""
		let mycharname = "017 DC1"
	elseif nr2char(mychar) == ""
		let mycharname = "018 DC2"
	elseif nr2char(mychar) == ""
		let mycharname = "019 DC3"
	elseif nr2char(mychar) == ""
		let mycharname = "020 DC4"
	elseif nr2char(mychar) == ""
		let mycharname = "021 NAK"
	elseif nr2char(mychar) == ""
		let mycharname = "022 SYN"
	elseif nr2char(mychar) == ""
		let mycharname = "023 ETB"
	elseif nr2char(mychar) == ""
		let mycharname = "024 CAN"
	elseif nr2char(mychar) == ""
		let mycharname = "025 EM"
	elseif nr2char(mychar) == ""
		let mycharname = "026 SUB"
	elseif nr2char(mychar) == ""
		let mycharname = "027 ESC"
	elseif nr2char(mychar) == ""
		let mycharname = "028 FS"
	elseif nr2char(mychar) == ""
		let mycharname = "029 GS"
	elseif nr2char(mychar) == ""
		let mycharname = "030 RS"
	elseif nr2char(mychar) == ""
		let mycharname = "031 US"

	" single byte ctrls w/ mods {{{1
	elseif nr2char(mychar) == "\<BS>"
		let mycharname = "BS"
	elseif mychar == "\<S-BS>"
		let mycharname = "S-BS"
	elseif mychar == "\<M-BS>"
		let mycharname = "M-BS"
	elseif mychar == "\<C-BS>"
		let mycharname = "C-BS"
	elseif mychar == "\<M-S-BS>"
		let mycharname = "M-S-BS"
	elseif mychar == "\<C-S-BS>"
		let mycharname = "C-S-BS"
	elseif mychar == "\<C-M-BS>"
		let mycharname = "C-M-BS"
	elseif mychar == "\<C-M-S-BS>"
		let mycharname = "C-M-S-BS"

	elseif nr2char(mychar) == "\<Tab>"
		let mycharname = "Tab"
	elseif mychar == "\<S-Tab>"
		let mycharname = "S-Tab"
	elseif mychar == "\<M-Tab>"
		let mycharname = "M-Tab"
	elseif mychar == "\<C-Tab>"
		let mycharname = "C-Tab"
	elseif mychar == "\<M-S-Tab>"
		let mycharname = "M-S-Tab"
	elseif mychar == "\<C-S-Tab>"
		let mycharname = "C-S-Tab"
	elseif mychar == "\<C-M-Tab>"
		let mycharname = "C-M-Tab"
	elseif mychar == "\<C-M-S-Tab>"
		let mycharname = "C-M-S-Tab"

	elseif nr2char(mychar) == "\<Esc>"
		let mycharname = "Esc"
	elseif mychar == "\<S-Esc>"
		let mycharname = "S-Esc"
	elseif mychar == "\<M-Esc>"
		let mycharname = "M-Esc"
	elseif mychar == "\<C-Esc>"
		let mycharname = "C-Esc"
	elseif mychar == "\<M-S-Esc>"
		let mycharname = "M-S-Esc"
	elseif mychar == "\<C-S-Esc>"
		let mycharname = "C-S-Esc"
	elseif mychar == "\<C-M-Esc>"
		let mycharname = "C-M-Esc"
	elseif mychar == "\<C-M-S-Esc>"
		let mycharname = "C-M-S-Esc"

	elseif nr2char(mychar) == "\<Enter>"
		let mycharname = "Enter"
	elseif mychar == "\<S-Enter>"
		let mycharname = "S-Enter"
	elseif mychar == "\<M-Enter>"
		let mycharname = "M-Enter"
	elseif mychar == "\<C-Enter>"
		let mycharname = "C-Enter"
	elseif mychar == "\<M-S-Enter>"
		let mycharname = "M-S-Enter"
	elseif mychar == "\<C-S-Enter>"
		let mycharname = "C-S-Enter"
	elseif mychar == "\<C-M-Enter>"
		let mycharname = "C-M-Enter"
	elseif mychar == "\<C-M-S-Enter>"
		let mycharname = "C-M-S-Enter"

	" Arrows {{{1
	elseif mychar == "\<Up>"
		let mycharname = "Up"
	elseif mychar == "\<S-Up>"
		let mycharname = "S-Up"
	elseif mychar == "\<M-Up>"
		let mycharname = "M-Up"
	elseif mychar == "\<C-Up>"
		let mycharname = "C-Up"
	elseif mychar == "\<M-S-Up>"
		let mycharname = "M-S-Up"
	elseif mychar == "\<C-S-Up>"
		let mycharname = "C-S-Up"
	elseif mychar == "\<C-M-Up>"
		let mycharname = "C-M-Up"
	elseif mychar == "\<C-M-S-Up>"
		let mycharname = "C-M-S-Up"

	elseif mychar == "\<Down>"
		let mycharname = "Down"
	elseif mychar == "\<S-Down>"
		let mycharname = "S-Down"
	elseif mychar == "\<M-Down>"
		let mycharname = "M-Down"
	elseif mychar == "\<C-Down>"
		let mycharname = "C-Down"
	elseif mychar == "\<M-S-Down>"
		let mycharname = "M-S-Down"
	elseif mychar == "\<C-S-Down>"
		let mycharname = "C-S-Down"
	elseif mychar == "\<C-M-Down>"
		let mycharname = "C-M-Down"
	elseif mychar == "\<C-M-S-Down>"
		let mycharname = "C-M-S-Down"

	elseif mychar == "\<Left>"
		let mycharname = "Left"
	elseif mychar == "\<S-Left>"
		let mycharname = "S-Left"
	elseif mychar == "\<M-Left>"
		let mycharname = "M-Left"
	elseif mychar == "\<C-Left>"
		let mycharname = "C-Left"
	elseif mychar == "\<M-S-Left>"
		let mycharname = "M-S-Left"
	elseif mychar == "\<C-S-Left>"
		let mycharname = "C-S-Left"
	elseif mychar == "\<C-M-Left>"
		let mycharname = "C-M-Left"
	elseif mychar == "\<C-M-S-Left>"
		let mycharname = "C-M-S-Left"

	elseif mychar == "\<Right>"
		let mycharname = "Right"
	elseif mychar == "\<S-Right>"
		let mycharname = "S-Right"
	elseif mychar == "\<M-Right>"
		let mycharname = "M-Right"
	elseif mychar == "\<C-Right>"
		let mycharname = "C-Right"
	elseif mychar == "\<M-S-Right>"
		let mycharname = "M-S-Right"
	elseif mychar == "\<C-S-Right>"
		let mycharname = "C-S-Right"
	elseif mychar == "\<C-M-Right>"
		let mycharname = "C-M-Right"
	elseif mychar == "\<C-M-S-Right>"
		let mycharname = "C-M-S-Right"

	" Function keys {{{1
	elseif mychar == "\<F1>"
		let mycharname = "F1"
	elseif mychar == "\<S-F1>"
		let mycharname = "S-F1"
	elseif mychar == "\<M-F1>"
		let mycharname = "M-F1"
	elseif mychar == "\<C-F1>"
		let mycharname = "C-F1"
	elseif mychar == "\<M-S-F1>"
		let mycharname = "M-S-F1"
	elseif mychar == "\<C-S-F1>"
		let mycharname = "C-S-F1"
	elseif mychar == "\<C-M-F1>"
		let mycharname = "C-M-F1"
	elseif mychar == "\<C-M-S-F1>"
		let mycharname = "C-M-S-F1"

	elseif mychar == "\<F2>"
		let mycharname = "F2"
	elseif mychar == "\<S-F2>"
		let mycharname = "S-F2"
	elseif mychar == "\<M-F2>"
		let mycharname = "M-F2"
	elseif mychar == "\<C-F2>"
		let mycharname = "C-F2"
	elseif mychar == "\<M-S-F2>"
		let mycharname = "M-S-F2"
	elseif mychar == "\<C-S-F2>"
		let mycharname = "C-S-F2"
	elseif mychar == "\<C-M-F2>"
		let mycharname = "C-M-F2"
	elseif mychar == "\<C-M-S-F2>"
		let mycharname = "C-M-S-F2"

	elseif mychar == "\<F3>"
		let mycharname = "F3"
	elseif mychar == "\<S-F3>"
		let mycharname = "S-F3"
	elseif mychar == "\<M-F3>"
		let mycharname = "M-F3"
	elseif mychar == "\<C-F3>"
		let mycharname = "C-F3"
	elseif mychar == "\<M-S-F3>"
		let mycharname = "M-S-F3"
	elseif mychar == "\<C-S-F3>"
		let mycharname = "C-S-F3"
	elseif mychar == "\<C-M-F3>"
		let mycharname = "C-M-F3"
	elseif mychar == "\<C-M-S-F3>"
		let mycharname = "C-M-S-F3"

	elseif mychar == "\<F4>"
		let mycharname = "F4"
	elseif mychar == "\<S-F4>"
		let mycharname = "S-F4"
	elseif mychar == "\<M-F4>"
		let mycharname = "M-F4"
	elseif mychar == "\<C-F4>"
		let mycharname = "C-F4"
	elseif mychar == "\<M-S-F4>"
		let mycharname = "M-S-F4"
	elseif mychar == "\<C-S-F4>"
		let mycharname = "C-S-F4"
	elseif mychar == "\<C-M-F4>"
		let mycharname = "C-M-F4"
	elseif mychar == "\<C-M-S-F4>"
		let mycharname = "C-M-S-F4"

	elseif mychar == "\<F5>"
		let mycharname = "F5"
	elseif mychar == "\<S-F5>"
		let mycharname = "S-F5"
	elseif mychar == "\<M-F5>"
		let mycharname = "M-F5"
	elseif mychar == "\<C-F5>"
		let mycharname = "C-F5"
	elseif mychar == "\<M-S-F5>"
		let mycharname = "M-S-F5"
	elseif mychar == "\<C-S-F5>"
		let mycharname = "C-S-F5"
	elseif mychar == "\<C-M-F5>"
		let mycharname = "C-M-F5"
	elseif mychar == "\<C-M-S-F5>"
		let mycharname = "C-M-S-F5"

	elseif mychar == "\<F6>"
		let mycharname = "F6"
	elseif mychar == "\<S-F6>"
		let mycharname = "S-F6"
	elseif mychar == "\<M-F6>"
		let mycharname = "M-F6"
	elseif mychar == "\<C-F6>"
		let mycharname = "C-F6"
	elseif mychar == "\<M-S-F6>"
		let mycharname = "M-S-F6"
	elseif mychar == "\<C-S-F6>"
		let mycharname = "C-S-F6"
	elseif mychar == "\<C-M-F6>"
		let mycharname = "C-M-F6"
	elseif mychar == "\<C-M-S-F6>"
		let mycharname = "C-M-S-F6"

	elseif mychar == "\<F7>"
		let mycharname = "F7"
	elseif mychar == "\<S-F7>"
		let mycharname = "S-F7"
	elseif mychar == "\<M-F7>"
		let mycharname = "M-F7"
	elseif mychar == "\<C-F7>"
		let mycharname = "C-F7"
	elseif mychar == "\<M-S-F7>"
		let mycharname = "M-S-F7"
	elseif mychar == "\<C-S-F7>"
		let mycharname = "C-S-F7"
	elseif mychar == "\<C-M-F7>"
		let mycharname = "C-M-F7"
	elseif mychar == "\<C-M-S-F7>"
		let mycharname = "C-M-S-F7"

	elseif mychar == "\<F8>"
		let mycharname = "F8"
	elseif mychar == "\<S-F8>"
		let mycharname = "S-F8"
	elseif mychar == "\<M-F8>"
		let mycharname = "M-F8"
	elseif mychar == "\<C-F8>"
		let mycharname = "C-F8"
	elseif mychar == "\<M-S-F8>"
		let mycharname = "M-S-F8"
	elseif mychar == "\<C-S-F8>"
		let mycharname = "C-S-F8"
	elseif mychar == "\<C-M-F8>"
		let mycharname = "C-M-F8"
	elseif mychar == "\<C-M-S-F8>"
		let mycharname = "C-M-S-F8"

	elseif mychar == "\<F9>"
		let mycharname = "F9"
	elseif mychar == "\<S-F9>"
		let mycharname = "S-F9"
	elseif mychar == "\<M-F9>"
		let mycharname = "M-F9"
	elseif mychar == "\<C-F9>"
		let mycharname = "C-F9"
	elseif mychar == "\<M-S-F9>"
		let mycharname = "M-S-F9"
	elseif mychar == "\<C-S-F9>"
		let mycharname = "C-S-F9"
	elseif mychar == "\<C-M-F9>"
		let mycharname = "C-M-F9"
	elseif mychar == "\<C-M-S-F9>"
		let mycharname = "C-M-S-F9"

	elseif mychar == "\<F10>"
		let mycharname = "F10"
	elseif mychar == "\<S-F10>"
		let mycharname = "S-F10"
	elseif mychar == "\<M-F10>"
		let mycharname = "M-F10"
	elseif mychar == "\<C-F10>"
		let mycharname = "C-F10"
	elseif mychar == "\<M-S-F10>"
		let mycharname = "M-S-F10"
	elseif mychar == "\<C-S-F10>"
		let mycharname = "C-S-F10"
	elseif mychar == "\<C-M-F10>"
		let mycharname = "C-M-F10"
	elseif mychar == "\<C-M-S-F10>"
		let mycharname = "C-M-S-F10"

	elseif mychar == "\<F11>"
		let mycharname = "F11"
	elseif mychar == "\<S-F11>"
		let mycharname = "S-F11"
	elseif mychar == "\<M-F11>"
		let mycharname = "M-F11"
	elseif mychar == "\<C-F11>"
		let mycharname = "C-F11"
	elseif mychar == "\<M-S-F11>"
		let mycharname = "M-S-F11"
	elseif mychar == "\<C-S-F11>"
		let mycharname = "C-S-F11"
	elseif mychar == "\<C-M-F11>"
		let mycharname = "C-M-F11"
	elseif mychar == "\<C-M-S-F11>"
		let mycharname = "C-M-S-F11"

	elseif mychar == "\<F12>"
		let mycharname = "F12"
	elseif mychar == "\<S-F12>"
		let mycharname = "S-F12"
	elseif mychar == "\<M-F12>"
		let mycharname = "M-F12"
	elseif mychar == "\<C-F12>"
		let mycharname = "C-F12"
	elseif mychar == "\<M-S-F12>"
		let mycharname = "M-S-F12"
	elseif mychar == "\<C-S-F12>"
		let mycharname = "C-S-F12"
	elseif mychar == "\<C-M-F12>"
		let mycharname = "C-M-F12"
	elseif mychar == "\<C-M-S-F12>"
		let mycharname = "C-M-S-F12"

	" Insert/Delete/Home/End/PageUp/PageDown {{{1
	elseif mychar == "\<Insert>"
		let mycharname = "Insert"
	elseif mychar == "\<S-Insert>"
		let mycharname = "S-Insert"
	elseif mychar == "\<M-Insert>"
		let mycharname = "M-Insert"
	elseif mychar == "\<C-Insert>"
		let mycharname = "C-Insert"
	elseif mychar == "\<M-S-Insert>"
		let mycharname = "M-S-Insert"
	elseif mychar == "\<C-S-Insert>"
		let mycharname = "C-S-Insert"
	elseif mychar == "\<C-M-Insert>"
		let mycharname = "C-M-Insert"
	elseif mychar == "\<C-M-S-Insert>"
		let mycharname = "C-M-S-Insert"

	elseif mychar == "\<Del>"
		let mycharname = "Del"
	elseif mychar == "\<S-Del>"
		let mycharname = "S-Del"
	elseif mychar == "\<M-Del>"
		let mycharname = "M-Del"
	elseif mychar == "\<C-Del>"
		let mycharname = "C-Del"
	elseif mychar == "\<M-S-Del>"
		let mycharname = "M-S-Del"
	elseif mychar == "\<C-S-Del>"
		let mycharname = "C-S-Del"
	elseif mychar == "\<C-M-Del>"
		let mycharname = "C-M-Del"
	elseif mychar == "\<C-M-S-Del>"
		let mycharname = "C-M-S-Del"

	elseif mychar == "\<Home>"
		let mycharname = "Home"
	elseif mychar == "\<S-Home>"
		let mycharname = "S-Home"
	elseif mychar == "\<M-Home>"
		let mycharname = "M-Home"
	elseif mychar == "\<C-Home>"
		let mycharname = "C-Home"
	elseif mychar == "\<M-S-Home>"
		let mycharname = "M-S-Home"
	elseif mychar == "\<C-S-Home>"
		let mycharname = "C-S-Home"
	elseif mychar == "\<C-M-Home>"
		let mycharname = "C-M-Home"
	elseif mychar == "\<C-M-S-Home>"
		let mycharname = "C-M-S-Home"

	elseif mychar == "\<End>"
		let mycharname = "End"
	elseif mychar == "\<S-End>"
		let mycharname = "S-End"
	elseif mychar == "\<M-End>"
		let mycharname = "M-End"
	elseif mychar == "\<C-End>"
		let mycharname = "C-End"
	elseif mychar == "\<M-S-End>"
		let mycharname = "M-S-End"
	elseif mychar == "\<C-S-End>"
		let mycharname = "C-S-End"
	elseif mychar == "\<C-M-End>"
		let mycharname = "C-M-End"
	elseif mychar == "\<C-M-S-End>"
		let mycharname = "C-M-S-End"

	elseif mychar == "\<PageUp>"
		let mycharname = "PageUp"
	elseif mychar == "\<S-PageUp>"
		let mycharname = "S-PageUp"
	elseif mychar == "\<M-PageUp>"
		let mycharname = "M-PageUp"
	elseif mychar == "\<C-PageUp>"
		let mycharname = "C-PageUp"
	elseif mychar == "\<M-S-PageUp>"
		let mycharname = "M-S-PageUp"
	elseif mychar == "\<C-S-PageUp>"
		let mycharname = "C-S-PageUp"
	elseif mychar == "\<C-M-PageUp>"
		let mycharname = "C-M-PageUp"
	elseif mychar == "\<C-M-S-PageUp>"
		let mycharname = "C-M-S-PageUp"

	elseif mychar == "\<PageDown>"
		let mycharname = "PageDown"
	elseif mychar == "\<S-PageDown>"
		let mycharname = "S-PageDown"
	elseif mychar == "\<M-PageDown>"
		let mycharname = "M-PageDown"
	elseif mychar == "\<C-PageDown>"
		let mycharname = "C-PageDown"
	elseif mychar == "\<M-S-PageDown>"
		let mycharname = "M-S-PageDown"
	elseif mychar == "\<C-S-PageDown>"
		let mycharname = "C-S-PageDown"
	elseif mychar == "\<C-M-PageDown>"
		let mycharname = "C-M-PageDown"
	elseif mychar == "\<C-M-S-PageDown>"
		let mycharname = "C-M-S-PageDown"

	" Keypad {{{1
	elseif mychar == "\<kHome>"
		let mycharname = "kHome"
	elseif mychar == "\<kEnd>"
		let mycharname = "kEnd"
	elseif mychar == "\<kPageUp>"
		let mycharname = "kPageUp"
	elseif mychar == "\<kPageDown>"
		let mycharname = "kPageDown"
	elseif mychar == "\<kPlus>"
		let mycharname = "kPlus"
	elseif mychar == "\<kMinus>"
		let mycharname = "kMinus"
	elseif mychar == "\<kMultiply>"
		let mycharname = "kMultiply"
	elseif mychar == "\<kDivide>"
		let mycharname = "kDivide"
	elseif mychar == "\<kEnter>"
		let mycharname = "kEnter"
	elseif mychar == "\<kPoint>"
		let mycharname = "kPoint"
	elseif mychar == "\<k0>"
		let mycharname = "k0"
	elseif mychar == "\<k1>"
		let mycharname = "k1"
	elseif mychar == "\<k2>"
		let mycharname = "k2"
	elseif mychar == "\<k3>"
		let mycharname = "k3"
	elseif mychar == "\<k4>"
		let mycharname = "k4"
	elseif mychar == "\<k5>"
		let mycharname = "k5"
	elseif mychar == "\<k6>"
		let mycharname = "k6"
	elseif mychar == "\<k7>"
		let mycharname = "k7"
	elseif mychar == "\<k8>"
		let mycharname = "k8"
	elseif mychar == "\<k9>"
		let mycharname = "k9"

	" Mouse {{{1
	elseif mychar == "\<LeftMouse>"
		let mycharname = "LeftMouse"
	elseif mychar == "\<S-LeftMouse>"
		let mycharname = "S-LeftMouse"
	elseif mychar == "\<M-LeftMouse>"
		let mycharname = "M-LeftMouse"
	elseif mychar == "\<C-LeftMouse>"
		let mycharname = "C-LeftMouse"
	elseif mychar == "\<M-S-LeftMouse>"
		let mycharname = "M-S-LeftMouse"
	elseif mychar == "\<C-S-LeftMouse>"
		let mycharname = "C-S-LeftMouse"
	elseif mychar == "\<C-M-LeftMouse>"
		let mycharname = "C-M-LeftMouse"
	elseif mychar == "\<C-M-S-LeftMouse>"
		let mycharname = "C-M-S-LeftMouse"

	elseif mychar == "\<2-LeftMouse>"
		let mycharname = "2-LeftMouse"
	elseif mychar == "\<S-2-LeftMouse>"
		let mycharname = "S-2-LeftMouse"
	elseif mychar == "\<M-2-LeftMouse>"
		let mycharname = "M-2-LeftMouse"
	elseif mychar == "\<C-2-LeftMouse>"
		let mycharname = "C-2-LeftMouse"
	elseif mychar == "\<M-S-2-LeftMouse>"
		let mycharname = "M-S-2-LeftMouse"
	elseif mychar == "\<C-S-2-LeftMouse>"
		let mycharname = "C-S-2-LeftMouse"
	elseif mychar == "\<C-M-2-LeftMouse>"
		let mycharname = "C-M-2-LeftMouse"
	elseif mychar == "\<C-M-S-2-LeftMouse>"
		let mycharname = "C-M-S-2-LeftMouse"

	elseif mychar == "\<3-LeftMouse>"
		let mycharname = "3-LeftMouse"
	elseif mychar == "\<S-3-LeftMouse>"
		let mycharname = "S-3-LeftMouse"
	elseif mychar == "\<M-3-LeftMouse>"
		let mycharname = "M-3-LeftMouse"
	elseif mychar == "\<C-3-LeftMouse>"
		let mycharname = "C-3-LeftMouse"
	elseif mychar == "\<M-S-3-LeftMouse>"
		let mycharname = "M-S-3-LeftMouse"
	elseif mychar == "\<C-S-3-LeftMouse>"
		let mycharname = "C-S-3-LeftMouse"
	elseif mychar == "\<C-M-3-LeftMouse>"
		let mycharname = "C-M-3-LeftMouse"
	elseif mychar == "\<C-M-S-3-LeftMouse>"
		let mycharname = "C-M-S-3-LeftMouse"

	elseif mychar == "\<4-LeftMouse>"
		let mycharname = "4-LeftMouse"
	elseif mychar == "\<S-4-LeftMouse>"
		let mycharname = "S-4-LeftMouse"
	elseif mychar == "\<M-4-LeftMouse>"
		let mycharname = "M-4-LeftMouse"
	elseif mychar == "\<C-4-LeftMouse>"
		let mycharname = "C-4-LeftMouse"
	elseif mychar == "\<M-S-4-LeftMouse>"
		let mycharname = "M-S-4-LeftMouse"
	elseif mychar == "\<C-S-4-LeftMouse>"
		let mycharname = "C-S-4-LeftMouse"
	elseif mychar == "\<C-M-4-LeftMouse>"
		let mycharname = "C-M-4-LeftMouse"
	elseif mychar == "\<C-M-S-4-LeftMouse>"
		let mycharname = "C-M-S-4-LeftMouse"

	elseif mychar == "\<LeftDrag>"
		let mycharname = "LeftDrag"
	elseif mychar == "\<S-LeftDrag>"
		let mycharname = "S-LeftDrag"
	elseif mychar == "\<M-LeftDrag>"
		let mycharname = "M-LeftDrag"
	elseif mychar == "\<C-LeftDrag>"
		let mycharname = "C-LeftDrag"
	elseif mychar == "\<M-S-LeftDrag>"
		let mycharname = "M-S-LeftDrag"
	elseif mychar == "\<C-S-LeftDrag>"
		let mycharname = "C-S-LeftDrag"
	elseif mychar == "\<C-M-LeftDrag>"
		let mycharname = "C-M-LeftDrag"
	elseif mychar == "\<C-M-S-LeftDrag>"
		let mycharname = "C-M-S-LeftDrag"

	elseif mychar == "\<LeftRelease>"
		let mycharname = "LeftRelease"
	elseif mychar == "\<S-LeftRelease>"
		let mycharname = "S-LeftRelease"
	elseif mychar == "\<M-LeftRelease>"
		let mycharname = "M-LeftRelease"
	elseif mychar == "\<C-LeftRelease>"
		let mycharname = "C-LeftRelease"
	elseif mychar == "\<M-S-LeftRelease>"
		let mycharname = "M-S-LeftRelease"
	elseif mychar == "\<C-S-LeftRelease>"
		let mycharname = "C-S-LeftRelease"
	elseif mychar == "\<C-M-LeftRelease>"
		let mycharname = "C-M-LeftRelease"
	elseif mychar == "\<C-M-S-LeftRelease>"
		let mycharname = "C-M-S-LeftRelease"

	elseif mychar == "\<MiddleMouse>"
		let mycharname = "MiddleMouse"
	elseif mychar == "\<S-MiddleMouse>"
		let mycharname = "S-MiddleMouse"
	elseif mychar == "\<M-MiddleMouse>"
		let mycharname = "M-MiddleMouse"
	elseif mychar == "\<C-MiddleMouse>"
		let mycharname = "C-MiddleMouse"
	elseif mychar == "\<M-S-MiddleMouse>"
		let mycharname = "M-S-MiddleMouse"
	elseif mychar == "\<C-S-MiddleMouse>"
		let mycharname = "C-S-MiddleMouse"
	elseif mychar == "\<C-M-MiddleMouse>"
		let mycharname = "C-M-MiddleMouse"
	elseif mychar == "\<C-M-S-MiddleMouse>"
		let mycharname = "C-M-S-MiddleMouse"

	elseif mychar == "\<2-MiddleMouse>"
		let mycharname = "2-MiddleMouse"
	elseif mychar == "\<S-2-MiddleMouse>"
		let mycharname = "S-2-MiddleMouse"
	elseif mychar == "\<M-2-MiddleMouse>"
		let mycharname = "M-2-MiddleMouse"
	elseif mychar == "\<C-2-MiddleMouse>"
		let mycharname = "C-2-MiddleMouse"
	elseif mychar == "\<M-S-2-MiddleMouse>"
		let mycharname = "M-S-2-MiddleMouse"
	elseif mychar == "\<C-S-2-MiddleMouse>"
		let mycharname = "C-S-2-MiddleMouse"
	elseif mychar == "\<C-M-2-MiddleMouse>"
		let mycharname = "C-M-2-MiddleMouse"
	elseif mychar == "\<C-M-S-2-MiddleMouse>"
		let mycharname = "C-M-S-2-MiddleMouse"

	elseif mychar == "\<3-MiddleMouse>"
		let mycharname = "3-MiddleMouse"
	elseif mychar == "\<S-3-MiddleMouse>"
		let mycharname = "S-3-MiddleMouse"
	elseif mychar == "\<M-3-MiddleMouse>"
		let mycharname = "M-3-MiddleMouse"
	elseif mychar == "\<C-3-MiddleMouse>"
		let mycharname = "C-3-MiddleMouse"
	elseif mychar == "\<M-S-3-MiddleMouse>"
		let mycharname = "M-S-3-MiddleMouse"
	elseif mychar == "\<C-S-3-MiddleMouse>"
		let mycharname = "C-S-3-MiddleMouse"
	elseif mychar == "\<C-M-3-MiddleMouse>"
		let mycharname = "C-M-3-MiddleMouse"
	elseif mychar == "\<C-M-S-3-MiddleMouse>"
		let mycharname = "C-M-S-3-MiddleMouse"

	elseif mychar == "\<4-MiddleMouse>"
		let mycharname = "4-MiddleMouse"
	elseif mychar == "\<S-4-MiddleMouse>"
		let mycharname = "S-4-MiddleMouse"
	elseif mychar == "\<M-4-MiddleMouse>"
		let mycharname = "M-4-MiddleMouse"
	elseif mychar == "\<C-4-MiddleMouse>"
		let mycharname = "C-4-MiddleMouse"
	elseif mychar == "\<M-S-4-MiddleMouse>"
		let mycharname = "M-S-4-MiddleMouse"
	elseif mychar == "\<C-S-4-MiddleMouse>"
		let mycharname = "C-S-4-MiddleMouse"
	elseif mychar == "\<C-M-4-MiddleMouse>"
		let mycharname = "C-M-4-MiddleMouse"
	elseif mychar == "\<C-M-S-4-MiddleMouse>"
		let mycharname = "C-M-S-4-MiddleMouse"

	elseif mychar == "\<MiddleDrag>"
		let mycharname = "MiddleDrag"
	elseif mychar == "\<S-MiddleDrag>"
		let mycharname = "S-MiddleDrag"
	elseif mychar == "\<M-MiddleDrag>"
		let mycharname = "M-MiddleDrag"
	elseif mychar == "\<C-MiddleDrag>"
		let mycharname = "C-MiddleDrag"
	elseif mychar == "\<M-S-MiddleDrag>"
		let mycharname = "M-S-MiddleDrag"
	elseif mychar == "\<C-S-MiddleDrag>"
		let mycharname = "C-S-MiddleDrag"
	elseif mychar == "\<C-M-MiddleDrag>"
		let mycharname = "C-M-MiddleDrag"
	elseif mychar == "\<C-M-S-MiddleDrag>"
		let mycharname = "C-M-S-MiddleDrag"

	elseif mychar == "\<MiddleRelease>"
		let mycharname = "MiddleRelease"
	elseif mychar == "\<S-MiddleRelease>"
		let mycharname = "S-MiddleRelease"
	elseif mychar == "\<M-MiddleRelease>"
		let mycharname = "M-MiddleRelease"
	elseif mychar == "\<C-MiddleRelease>"
		let mycharname = "C-MiddleRelease"
	elseif mychar == "\<M-S-MiddleRelease>"
		let mycharname = "M-S-MiddleRelease"
	elseif mychar == "\<C-S-MiddleRelease>"
		let mycharname = "C-S-MiddleRelease"
	elseif mychar == "\<C-M-MiddleRelease>"
		let mycharname = "C-M-MiddleRelease"
	elseif mychar == "\<C-M-S-MiddleRelease>"
		let mycharname = "C-M-S-MiddleRelease"


	elseif mychar == "\<RightMouse>"
		let mycharname = "RightMouse"
	elseif mychar == "\<S-RightMouse>"
		let mycharname = "S-RightMouse"
	elseif mychar == "\<M-RightMouse>"
		let mycharname = "M-RightMouse"
	elseif mychar == "\<C-RightMouse>"
		let mycharname = "C-RightMouse"
	elseif mychar == "\<M-S-RightMouse>"
		let mycharname = "M-S-RightMouse"
	elseif mychar == "\<C-S-RightMouse>"
		let mycharname = "C-S-RightMouse"
	elseif mychar == "\<C-M-RightMouse>"
		let mycharname = "C-M-RightMouse"
	elseif mychar == "\<C-M-S-RightMouse>"
		let mycharname = "C-M-S-RightMouse"

	elseif mychar == "\<2-RightMouse>"
		let mycharname = "2-RightMouse"
	elseif mychar == "\<S-2-RightMouse>"
		let mycharname = "S-2-RightMouse"
	elseif mychar == "\<M-2-RightMouse>"
		let mycharname = "M-2-RightMouse"
	elseif mychar == "\<C-2-RightMouse>"
		let mycharname = "C-2-RightMouse"
	elseif mychar == "\<M-S-2-RightMouse>"
		let mycharname = "M-S-2-RightMouse"
	elseif mychar == "\<C-S-2-RightMouse>"
		let mycharname = "C-S-2-RightMouse"
	elseif mychar == "\<C-M-2-RightMouse>"
		let mycharname = "C-M-2-RightMouse"
	elseif mychar == "\<C-M-S-2-RightMouse>"
		let mycharname = "C-M-S-2-RightMouse"

	elseif mychar == "\<3-RightMouse>"
		let mycharname = "3-RightMouse"
	elseif mychar == "\<S-3-RightMouse>"
		let mycharname = "S-3-RightMouse"
	elseif mychar == "\<M-3-RightMouse>"
		let mycharname = "M-3-RightMouse"
	elseif mychar == "\<C-3-RightMouse>"
		let mycharname = "C-3-RightMouse"
	elseif mychar == "\<M-S-3-RightMouse>"
		let mycharname = "M-S-3-RightMouse"
	elseif mychar == "\<C-S-3-RightMouse>"
		let mycharname = "C-S-3-RightMouse"
	elseif mychar == "\<C-M-3-RightMouse>"
		let mycharname = "C-M-3-RightMouse"
	elseif mychar == "\<C-M-S-3-RightMouse>"
		let mycharname = "C-M-S-3-RightMouse"

	elseif mychar == "\<4-RightMouse>"
		let mycharname = "4-RightMouse"
	elseif mychar == "\<S-4-RightMouse>"
		let mycharname = "S-4-RightMouse"
	elseif mychar == "\<M-4-RightMouse>"
		let mycharname = "M-4-RightMouse"
	elseif mychar == "\<C-4-RightMouse>"
		let mycharname = "C-4-RightMouse"
	elseif mychar == "\<M-S-4-RightMouse>"
		let mycharname = "M-S-4-RightMouse"
	elseif mychar == "\<C-S-4-RightMouse>"
		let mycharname = "C-S-4-RightMouse"
	elseif mychar == "\<C-M-4-RightMouse>"
		let mycharname = "C-M-4-RightMouse"
	elseif mychar == "\<C-M-S-4-RightMouse>"
		let mycharname = "C-M-S-4-RightMouse"

	elseif mychar == "\<RightDrag>"
		let mycharname = "RightDrag"
	elseif mychar == "\<S-RightDrag>"
		let mycharname = "S-RightDrag"
	elseif mychar == "\<M-RightDrag>"
		let mycharname = "M-RightDrag"
	elseif mychar == "\<C-RightDrag>"
		let mycharname = "C-RightDrag"
	elseif mychar == "\<M-S-RightDrag>"
		let mycharname = "M-S-RightDrag"
	elseif mychar == "\<C-S-RightDrag>"
		let mycharname = "C-S-RightDrag"
	elseif mychar == "\<C-M-RightDrag>"
		let mycharname = "C-M-RightDrag"
	elseif mychar == "\<C-M-S-RightDrag>"
		let mycharname = "C-M-S-RightDrag"

	elseif mychar == "\<RightRelease>"
		let mycharname = "RightRelease"
	elseif mychar == "\<S-RightRelease>"
		let mycharname = "S-RightRelease"
	elseif mychar == "\<M-RightRelease>"
		let mycharname = "M-RightRelease"
	elseif mychar == "\<C-RightRelease>"
		let mycharname = "C-RightRelease"
	elseif mychar == "\<M-S-RightRelease>"
		let mycharname = "M-S-RightRelease"
	elseif mychar == "\<C-S-RightRelease>"
		let mycharname = "C-S-RightRelease"
	elseif mychar == "\<C-M-RightRelease>"
		let mycharname = "C-M-RightRelease"
	elseif mychar == "\<C-M-S-RightRelease>"
		let mycharname = "C-M-S-RightRelease"


	" ctrl-chars [BROKEN] {{{1
	elseif mychar == ""
	\ ||   mychar == "\<C-u>"
	\ ||   mychar == '<C-u>'
		let mycharname = "C-u"
	elseif mychar == ""
	\ ||   mychar == "\<C-c>"
	\ ||   mychar == '<C-c>'
		let mycharname = "C-c"
	elseif mychar == ""
	\ ||   mychar == "\<C-o>"
	\ ||   mychar == '<C-o>'
		let mycharname = "C-o"

	" 1}}}

	endif

	" feedback
	" if not interpreted
	if mycharname == ""

		" decipher each char of multi-char codes
		let multicodes = Cream_getchar_code(mychar)

		" compose message
		let msg = ""
		let msg = msg . "Character not interpreted:\n"
		"let msg = msg . "         mychar   = " . mychar . "\n"
		let msg = msg . " char2nr(mychar)  = " . char2nr(mychar) . "\n"
		let msg = msg . " nr2char(mychar)  = " . nr2char(mychar) . "\n"
		let msg = msg . "    (multicodes)  = " . multicodes . "\n"
		let msg = msg . "\n"

	else
		let msg = " mycharname       = " . mycharname . "\n"
	endif
	call confirm( msg, "&Ok", 1, "Info")

	return mycharname

endfunction

function! Cream_getchar_code(char)
" returns a string expressing the argument's character code(s)
" o Multi-byte characters are returned in the form "128 + 147 + 28"

	"if     a:char[0] != nr2char("128")
	"    return a:char
	"elseif char2nr(a:char[1]) == 0
	"    return a:char
	"endif

	let multicodes = ""
	let i = 0
	"while char2nr(a:char)[i] != 0
	while i < strlen(a:char)
		" concatenate if not first
		if i != 0
			let multicodes = multicodes . " + "
		endif
		let multicodes = multicodes . char2nr(a:char[i])
		let i = i + 1
	endwhile

"Ctrl+O = 49+53
"Ctrl+U = 50+49
"Ctrl+C = 50

	return multicodes

endfunction

" vim:fileencoding=latin1:foldmethod=marker
