"=
" cream-highlight-mbyte.vim
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
	\ 'Highlight Multibyte', 
	\ 'Show characters with decimal values 128-255', 
	\ "Highlight characters with decimal values between 128-255. These characters may not appear the same on all systems when Vim uses an encoding other than latin1. (If used in Vim script, these characters could potentially cause script to fail.)", 
	\ 'Highlight Multibyte', 
	\ 'call Cream_highlight_mbyte()', 
	\ '<C-u>call Cream_highlight_mbyte()'
	\ )
endif

function! Cream_highlight_mbyte()
" * functionalized search
" * The same from the command line would be:
"     /[<C-v>128-<C-v>255]
" * Test text:  
"      €‚ƒ„…†‡ˆ‰Š‹ŒŽ‘’“”•–—˜™š›œžŸ ¡¢£¤¥¦§¨©
"      ********** hi! I'm not multi-byte. **************
"      ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×
"      ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö ÷øùúûüýþÿ

	if g:CREAM_SEARCH_HIGHLIGHT == 0
		call Cream_search_highlight_toggle()
	endif

	let mystr = '[' . nr2char(127) . '-' . nr2char(255) . ']'

	" test first to avoid "not found" error
	let n = search(mystr)
	" if successful, do find
	if n > 0
		" if first time through
		if !exists("b:mbsearch")
			" back off the match
			normal h
			" go to previous match
			execute '?' . mystr
			" and turn on highlighting (sigh)
			redraw!
			" NOW we're can start! (with highlighting already on ;)
			let b:mbsearch = 1
		endif

		" find next
		execute '/' . mystr
		" handle edge-of-screen draws (but not on last line)
		if line('.') != line('$')
			normal lh
		endif
		" redraw (yes, again.)
		redraw!
	else
		call confirm("No characters found.", "&Ok", 1, "Info")
	endif

endfunction

