"=
" cream-find.vim -- A re-work of the replace command
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
" * allows non-regexp
" * case sensitivity
" * up/down option
"

" override 'ignorcase' if the search pattern contains upper case characters.
set nosmartcase
" search wraps around end of file.
set wrapscan

" **********************************************************************
" Note:
" This script is cream-replacemulti.vim with parts removed. DON'T edit
" here without incorporating changes into that master!!!!!!!
" **********************************************************************
"
"----------------------------------------------------------------------
function! Cream_find()
" Main function

	" save guioptions environment
	let myguioptions = &guioptions
	" do not use a vertical layout for dialog buttons
	set guioptions-=v

	" initialize variables if don't exist (however, remember if they do!)
	if !exists("g:CREAM_FFIND")
		let g:CREAM_FFIND = 'Find Me!'
	endif

	" option: case sensitive? (1=yes, 0=no)
	if !exists("g:CREAM_FCASE")
		" initialize off
		let g:CREAM_FCASE = 0
	endif

	" option: regular expressions? (1=yes, 0=no)
	if !exists("g:CREAM_FREGEXP")
		" initialize off
		let g:CREAM_FREGEXP = 0
	endif

	"*** Unique: initialize with find dialog for more intuitive use
	call Cream_find_find(g:CREAM_FFIND)
	"***

	" get find, replace info (verifying that Find isn't empty, too)
	let valid = '0'
	while valid == '0'
		" get find, replace and path/filename info
		let myreturn = Cream_find_request(g:CREAM_FFIND)
		" if quit code returned
		if myreturn == '2'
			break
		" verify criticals aren't empty (user pressed 'ok')
		elseif myreturn == '1'
			let valid = Cream_find_verify()
		endif
	endwhile

	" if not quit code, continue
	if myreturn != '2'
		" DO FIND/REPLACE! (Critical file states are verified within.)
		if valid == '1'
			call Cream_find_doit()
		else
			return
		endif
	endif

	" restore guioptions
	execute "set guioptions=" . myguioptions

endfunction


"----------------------------------------------------------------------
function! Cream_find_request(myfind)
" Dialog to obtain user information (find, replace, path/filename)
" * returns 0 for not finished (so can be recalled)
" * rewturns 1 for finished
" * returns 2 for quit

	" escape ampersand with second ampersand in dialog box
	" * JUST for display
	" * Just for Windows
	if      has("win32")
		\|| has("win16")
		\|| has("win95")
		\|| has("dos16")
		\|| has("dos32")
		let myfind_fixed = substitute(a:myfind, "&", "&&", "g")
	else
		let myfind_fixed = a:myfind
	endif

	let mychoice = 0
	let msg = "INSTRUCTIONS:\n"
	let msg = msg . "* Enter the literal find text below.\n"
	let msg = msg . "* Use \"\\n\" to represent new lines and \"\\t\" for tabs.\n"
	let msg = msg . "* Please read the Vim help to understand regular expressions (:help regexp)\n"
	let msg = msg . "\n"
	let msg = msg . "\n"
	let msg = msg . "FIND:                                           " . myfind_fixed . "  \n"
	let msg = msg . "\n"
	let msg = msg . "\n"
	let msg = msg . "OPTIONS:\n"
	if g:CREAM_FCASE == 1
		let msg = msg . "               [X] Yes   [_] No          Case Sensitive\n"
	else
		let msg = msg . "               [_] Yes   [X] No          Case Sensitive\n"
	endif
	if g:CREAM_FREGEXP == 1
		let msg = msg . "               [X] Yes   [_] No          Regular Expressions\n"
	else
		let msg = msg . "               [_] Yes   [X] No          Regular Expressions\n"
	endif
	let msg = msg . "\n"
	let mychoice = confirm(msg, "&Find\nOp&tions\n&Ok\n&Cancel", 3, "Info")
	if mychoice == 0
		" quit via Esc, window close, etc. (OS specific)
		return 2
	elseif mychoice == 1
		" call dialog to get find string
		call Cream_find_find(g:CREAM_FFIND)
		return
	elseif mychoice == 2
		" call dialog to set options. Continue to show until Ok(1) or Cancel(2)
		let valid = '0'
		while valid == '0'
			" let user set options
			let myreturn = Cream_find_options()
			" if Ok or Cancel, go back to main dialog
			if myreturn == '1' || myreturn == '2'
				let valid = '1'
			endif
		endwhile
		return
	elseif mychoice == 3
		" user thinks ok, return positive for actual verification
		return 1
	elseif mychoice == 4
		" quit
		return 2
	endif

	call confirm("Error in Cream_find_request(). Unexpected result.", "&Ok", "Error")
	return 2

endfunction


" Get input through dialog
" * Would be nice to detect Ok or Cancel here. (Cancel returns an empty string.)
" * These stupid spaces are to work around a Windows GUI problem: Input is only
"   allowed to be as long as the actual input box. Therefore, we're widening the
"   dialog box so the input box is wider. ;)
"----------------------------------------------------------------------
function! Cream_find_find(myfind)
	let myfind = inputdialog("Please enter a string to find...   " .
			\"                                                     ", a:myfind)
" let's not go overboard with the data entry width
"			\"                                                     " .
"			\"                                                     " .
"			\"                                                     " .
	" if user cancels, returns empty. Don't allow.
	if myfind != ""
		let g:CREAM_FFIND = myfind
	endif
	return
endfunction

"----------------------------------------------------------------------
function! Cream_find_options()

	let mychoice = 0
	let msg = "Options:\n"
	let msg = msg . "\n"
	let msg = msg . "\n"
	if g:CREAM_FCASE == 1
		let strcase = "X"
	else
		let strcase = "_"
	endif
	if g:CREAM_FREGEXP == 1
		let strregexp = "X"
	else
		let strregexp = "_"
	endif
	let msg = msg . "    [" . strcase . "]  Case Sensitive\n"
	let msg = msg . "    [" . strregexp . "]  Regular Expressions\n"
	let msg = msg . "\n"
	let mychoice = confirm(msg, "Case\ Sensitive\nRegular\ Expressions\n&Ok", 1, "Info")
	if mychoice == 0
		" quit via Esc, window close, etc. (OS specific)
		return 2
	elseif mychoice == 1
		" case sensitive
		if g:CREAM_FCASE == 1
			let g:CREAM_FCASE = 0
		else
			let g:CREAM_FCASE = 1
		endif
		return
	elseif mychoice == 2
		" regular expressions
		if g:CREAM_FREGEXP == 1
			let g:CREAM_FREGEXP = 0
		else
			let g:CREAM_FREGEXP = 1
		endif
		return
	elseif mychoice == 3
		" ok
		return 1
	endif
	return
endfunction


"----------------------------------------------------------------------
function! Cream_find_verify()
" Verify that Find and Path not empty (although Replace can be)
" * Returns '1' when valid

	if g:CREAM_FFIND == ''
		call confirm("Find may not be empty.", "&Ok", "Warning")
		return
	else
		return 1
	endif
endfunction


"----------------------------------------------------------------------
function! Cream_find_doit()
" Main find/replace function. Also validates files and state

	"......................................................................
	" find/replace in file

	" capture current magic state
	let mymagic = &magic
	" turn off
	if mymagic == "1"
		set nomagic
	endif

	" strings
	" * use local variable to maintain global strings
	" * work around ridiculous differences between {pattern} and {string}
	let myfind = g:CREAM_FFIND

	" condition: case-sensitive
	if g:CREAM_FCASE == 1
		let mycase = "I"
		set noignorecase
	else
		let mycase = "i"
		set ignorecase
	endif

	" condition: regular expressions
	if g:CREAM_FREGEXP == 1
		let myregexp = ""
		set magic
	else
		let myregexp = "\\V"
		set nomagic

		" escape strings
		" escape all backslashes
		" * This effectively eliminates ALL magical special pattern
		"   meanings! Only those patterns "unescaped" at the next step
		"   become effective. (Diehards are gonna kill us for this.)
		let myfind = substitute(myfind, '\\', '\\\\', 'g')

		" un-escape desired escapes
		" * Anything not recovered here is escaped forever ;)
		let myfind = substitute(myfind, '\\\\n', '\\n', 'g')
		let myfind = substitute(myfind, '\\\\t', '\\t', 'g')

		" escape slashes so as not to thwart the :s command below!
		let myfind = substitute(myfind, '/', '\\/', 'g')

	endif

	"......................................................................
	" find ( :/{pattern} )
	" * {pattern}
	"   \V -- eliminates magic (ALL specials must be escaped, most
	"           of which we thwarted above, MWUHAHAHA!!)

	let mycmd = ':silent! /' . myregexp . myfind

	" test if expression exists in file first
	if search(myregexp . myfind) != 0

		" initial find command
		execute mycmd

		" Hack: back up to previous find, the replace command goes forward from current pos
		normal N

		" turn on search highlighting
		set hlsearch

		" loop next/previous
		let mycontinue = ""
		while mycontinue != "no"
			" start visual mode
			normal v
			" select word found
			let i = 0
			while i < strlen(myfind)
				" adjust
				normal l
				let i = i + 1
			endwhile
			" refresh selection
			redraw
			" continue?
			if !exists("mypick")
				let mypick = 1
			endif
			let mypick = confirm("Continue find?", "&Next\n&Previous\n&Cancel", mypick, "Question")
			if mypick == 1
				" terminate visual mode
				normal v
				" next
				normal n
			elseif mypick == 2
				" terminate visual mode
				normal v
				" back up our adjustment
				normal b
				" previous
				normal N
			else
				" terminate visual mode
				normal v
				" quit
				break
			endif
		endwhile

		" turn off search highlighting
		set nohlsearch

	else
		call confirm("No match found", "&Ok", 1, "Info")
	endif

	" return magic state
	if mymagic == "1"
		set magic
	else
		set nomagic
	endif
	unlet mymagic

endfunction

