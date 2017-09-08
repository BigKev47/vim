"
" cream-bookmarks.vim -- Practical, visible, anonymous bookmarks.
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
" These functions are adapted from original material, used with
" permission, by:
"	Anthony Kruize
" Source: http://vim.sourceforge.net/scripts/script.php?script_id=152
"	Wolfram 'Der WOK' Esser
" Source: http://vim.sourceforge.net/scripts/script.php?script_id=66
"
"----------------------------------------------------------------------
"	Bookmark display
"
" Cream Notes:
" * Functions and calls have had "Cream_" prepended to them for parallel
"   installation with the original.
" * All functions defined with the script scope ("s:") have been re-scoped to
"   global.
" * Indication of actual character names for the marks have been eliminated.
"   (The names were changing whenever any mark was added/removed anyway. The names
"   served no purpose.)
" * Bookmarks are turned on by default for every buffer. (If no marks exist in
"   the document, the two character margin is simply not expanded.)

"......................................................................
" Source: http://vim.sourceforge.net/scripts/script.php?script_id=152
"
" Name:        ShowMarks
" Description: Visually displays the location of marks local to a buffer.
" Authors:     Anthony Kruize <trandor@labyrinth.net.au>
"              Michael Geddes <michaelrgeddes@optushome.com.au>
" Version:     1.1
" Modified:    6 February 2002
" License:     Released into the public domain.
" ChangeLog:   1.1 - Added support for the A-Z marks.
"                    Fixed sign staying placed if the line it was on is deleted.
"                    Clear autocommands before making new ones.
"              1.0 - First release.
" Usage:       Copy this file into the plugins directory so it will be
"              automatically sourced.
"
"              Default key mappings are:
"                <Leader>mt  - Toggles ShowMarks on and off.
"                <Leader>mh  - Hides a mark.
"
"              Hiding a mark doesn't actually remove it, it simply moves it to
"              line 1 and hides it visually.
"......................................................................

" Don't load if signs feature not available
if !has("signs")
	if !exists("g:CREAM_SIGNSCHECK")
		let g:CREAM_SIGNSCHECK = 1
	endif
	if g:CREAM_SIGNSCHECK < 3
		let g:CREAM_SIGNSCHECK = g:CREAM_SIGNSCHECK + 1
		call confirm(
			\"Unable to use Cream bookmarking features,\n" .
			\"no compiled support for signs. (Please use the \n" .
			\"\"configure --with-features=big\" if you compiled \n" .
			\"Vim from source yourself.) (" . g:CREAM_SIGNSCHECK . " of 2 warnings)\n" .
			\"\n", "&Ok", 1, "Info")
	endif
	finish
endif


" Check if we should continue loading
if exists("Cream_loaded_showmarks")
	finish
endif
let Cream_loaded_showmarks = 1

""	Book marking
"" Jump forward/backward and toggle 'anonymous' marks for lines (by using marks a-z)
"imap <silent> <F2> <C-b>:call Cream_WOK_mark_next()<CR>
"imap <silent> <S-F2> <C-b>:call Cream_WOK_mark_prev()<CR>
"imap <silent> <M-F2> <C-b>:call Cream_WOK_mark_toggle()<CR>
"imap <silent> <M-S-F2> <C-b>:call Cream_WOK_mark_killall()<CR>
"imap <silent> <C-F2> <C-b>:call Cream_ShowMarksToggle()<CR>

"+++ Cream: moved to autocmd file
"" AutoCommands:
"" CursorHold checks the marks and set the signs
"" GuiEnter loads the default theme for graphical icons
"augroup Cream_ShowMarks
"    autocmd!
"    "autocmd CursorHold * call Cream_ShowMarks()
"    " always turn on bookmarks and show when opening a new file
"    autocmd BufRead * let b:Cream_ShowMarks_Enabled=1
"    autocmd VimEnter,BufRead * call Cream_ShowMarks()
"augroup END
"+++

"+++ Cream: Moved to colors modules
"" highlight settings for bookmark
"highlight default ShowMarksHL ctermfg=blue ctermbg=lightblue cterm=bold guifg=blue guibg=lightblue gui=bold
"+++

" Setup the sign definitions for each mark
function! Cream_ShowMarksSetup()
	let n = 0
	while n < 26
		let c = nr2char(char2nr('a') + n)
		let C = nr2char(char2nr('A') + n)
		"if &encoding == "latin1"
		"    execute 'sign define Cream_ShowMark' . c . ' text=»» texthl=Cream_ShowMarksHL'
		"    execute 'sign define Cream_ShowMark' . C . ' text=»» texthl=Cream_ShowMarksHL'
		"else
			execute 'sign define Cream_ShowMark' . c . ' text==> texthl=Cream_ShowMarksHL'
			execute 'sign define Cream_ShowMark' . C . ' text==> texthl=Cream_ShowMarksHL'
		"endif
		let n = n + 1
	endwhile
endfunction
call Cream_ShowMarksSetup()

" Toggle display of bookmarks
function! Cream_ShowMarksToggle()
	" if un-initialized
	if !exists("b:Cream_ShowMarks_Enabled")
		let b:Cream_ShowMarks_Enabled = 1
	endif

	" if off
	if b:Cream_ShowMarks_Enabled == 0
		let b:Cream_ShowMarks_Enabled = 1
		"+++ Cream: tampering
		"augroup Cream_ShowMarks
		"    "autocmd CursorHold * call Cream_ShowMarks()
		"    autocmd BufRead * let b:Cream_ShowMarks_Enabled=1
		"    autocmd BufRead * call Cream_ShowMarks()
		"augroup END
		call Cream_ShowMarks()
		"+++
	" if on
	else
		let b:Cream_ShowMarks_Enabled = 0
		let n = 0
		" find next available tag
		while n < 26
			let c = nr2char(char2nr('a') + n)
			let C = nr2char(char2nr('A') + n)
			let id = n + 52 * winbufnr(0)
			let ID = id + 26
			if exists('b:Cream_placed_' . c)
				let b:Cream_placed_{c} = 1
				execute 'sign unplace ' . id . ' buffer=' . winbufnr(0)
			endif
			if exists('b:Cream_placed_' . C)
				let b:Cream_placed_{C} = 1
				execute 'sign unplace ' . ID . ' buffer=' . winbufnr(0)
			endif
			let n = n + 1
		endwhile
		"+++ Cream: tampering
		"augroup Cream_ShowMarks
		"    autocmd!
		"augroup END
		"+++
	endif
endfunction

function! Cream_ShowMarks_Exist()
" returns 1 if a sign has been placed, 0 if not

	let n = 0
	" find next available tag
	while n < 26
		let c = 'b:Cream_placed_' . nr2char(char2nr('a') + n)
		let C = 'b:Cream_placed_' . nr2char(char2nr('A') + n)
		if exists(c)
			execute "let test = b:Cream_placed_" . nr2char(char2nr('a') + n)
			if test > 0
				return 1
			endif
		endif
		if exists(C)
			execute "let test = b:Cream_placed_" . nr2char(char2nr('A') + n)
			if test > 0
				return 1
			endif
		endif
		let n = n + 1
	endwhile
	return 0

endfunction


" This function is called on the CursorHold autocommand.
" It runs through all the marks and displays or removes signs as appropriate.
function! Cream_ShowMarks()
	if exists("b:Cream_ShowMarks_Enabled")
		if b:Cream_ShowMarks_Enabled == 0
			return
		endif
	endif
	let n = 0
	while n < 26
		let c = nr2char(char2nr('a') + n)
		let id = n + 52 * winbufnr(0)
		let ln = line("'" . c)
		let C = nr2char(char2nr('A') + n)
		let ID = id + 26
		let LN = line("'" . C)

		if ln == 0 && (exists('b:Cream_placed_' . c) && b:Cream_placed_{c} != ln )
			execute 'sign unplace ' . id . ' buffer=' . winbufnr(0)
		elseif ln != 0 && (!exists('b:Cream_placed_' . c) || b:Cream_placed_{c} != ln )
			execute 'sign unplace ' . id . ' buffer=' . winbufnr(0)
			execute 'sign place '. id . ' name=Cream_ShowMark' . c . ' line=' . ln . ' buffer=' . winbufnr(0)
		endif

		if LN == 0 && (exists('b:Cream_placed_' . C) && b:Cream_placed_{C} != LN )
			execute 'sign unplace ' . ID . ' buffer=' . winbufnr(0)
		elseif LN != 0 && (!exists('b:Cream_placed_' . C) || b:Cream_placed_{C} != LN )
			execute 'sign unplace ' . ID . ' buffer=' . winbufnr(0)
			execute 'sign place ' . ID . ' name=Cream_ShowMark' . C . ' line=' . LN . ' buffer=' . winbufnr(0)
		endif

		let b:Cream_placed_{c} = ln
		let b:Cream_placed_{C} = LN
	let n = n + 1
	endwhile
endfunction


" Hide the mark at the current line.
" This simply moves the mark to line 1 and hides the sign.
"+++ Cream: Unused
function! Cream_HideMark()
	let ln = line(".")
	let n = 0
	while n < 26
		let c = nr2char(char2nr('a') + n)
		let C = nr2char(char2nr('A') + n)
		let markln = line("'" . c)
		let markLN = line("'" . C)
		if ln == markln
			let id = n + 52 * winbufnr(0)
			execute 'sign unplace ' . id . ' buffer=' . winbufnr(0)
			execute '1 mark ' . c
			let b:Cream_placed_{c} = 1
		endif
		if ln == markLN
			let ID = (n + 52 * winbufnr(0)) + 26
			execute 'sign unplace ' . ID . ' buffer=' . winbufnr(0)
			execute '1 mark ' . C
			let b:Cream_placed_{C} = 1
		endif
		let n = n + 1
	endwhile
endfunction
"+++


"----------------------------------------------------------------------
"	Bookmark management
"
"......................................................................
" Source: http://vim.sourceforge.net/scripts/script.php?script_id=66
" Name:   _vim_wok_visualcpp01.zip
"
" Wolfram 'Der WOK' Esser, 2001-08-21
" mailto:wolfram@derwok.de
" http://www.derwok.de
" Version 0.1, 2001-08-21 - initial release
"......................................................................

" WOK: 2001-06-08
" simulates anonymous marks with named marks "a-z"
" Jumps to next following mark after current cursor
" Wraps at bottom of file
function! Cream_WOK_mark_next()

	let curline = line(".")
	let nextmark = 99999999
	let firstmark = 99999999
	
	" ASCII A-Z, a-z == 65-90, 97-122
	let i = 97
	"let i = 65
	while i < 123
		"if i == 91
		"	let i = 97
		"endif
		let m = nr2char(i)
		let ml = line("'" . m)
		if(ml != 0)
			if (ml > curline && ml < nextmark)
				let nextmark = ml
			endif
			if (ml < firstmark)
				let firstmark = ml
			endif
		endif
		
		let i = i + 1
	endwhile

	if (nextmark != 99999999)
		execute "normal " . nextmark . "G<CR>"
		normal 0
	elseif (firstmark != 99999999)
		execute "normal " . firstmark . "G<CR>"
		normal 0
		"echo "WRAP TO FIRST MARK"
	else
		"echo "SORRY, NO MARKS (set with CTRL-F2)"
	endif

endfunction

" WOK: 2001-06-08
" simulates anonymous marks with named marks "a-z"
" Jumps to first Preceding Mark before current cursor
" Wraps at top of file
function! Cream_WOK_mark_prev()

	let curline = line(".")
	let prevmark = -1
	let lastmark = -1
	
	" ASCII A-Z, a-z == 65-90, 97-122
	let i = 97
	"let i = 65
	while i < 123
		"if i == 91
		"	let i = 97
		"endif
		let m = nr2char(i)
		let ml = line("'" . m)
		if(ml != 0)
			if (ml < curline && ml > prevmark)
				let prevmark = ml
			endif
			if (ml > lastmark)
				let lastmark = ml
			endif
		endif
		
		let i = i + 1
	endwhile

	if (prevmark != -1)
		execute "normal " . prevmark . "G<CR>"
		normal 0
	elseif (lastmark != -1)
		execute "normal " . lastmark . "G<CR>"
		normal 0
		"echo "WRAP TO LAST MARK"
	else
		"echo "SORRY, NO MARKS (set with CTRL-F2)"
	endif

endfunction

" WOK: 2001-06-08
" simulates anonymous marks with named marks "a-z"
" Adds/Deletes 'anonymous' Mark on current line
function! Cream_WOK_mark_toggle()

	let curline = line(".")
	let freemark = ""
	let foundfree = 0
	let mymodified = &modified

	" suchen, ob Zeile ein Mark hat, wenn ja, alle sammeln in killmarks!
	let killmarks = ""
	let killflag = 0

	" ASCII A-Z, a-z == 65-90, 97-122
	let i = 97
	"let i = 65
	while i < 123
		"if i == 91
		"	let i = 97
		"endif
		let m = nr2char(i)
		let ml = line("'" . m)
		if (ml == curline)
			let killmarks = killmarks . "m" . m
			let killflag = 1
		endif
		
		let i = i + 1
	endwhile

	if (killflag)
		" alte Mark(s) löschen??
		"echo "KILLMARKS: '" . killmarks . "'"
		normal o
		execute "normal " . killmarks . "<CR>"
		normal dd
		normal 0
		normal k
		"+++ Cream:
		"normal h
		"+++
	else
		" oder neues Mark einfügen?

		" ASCII A-Z, a-z == 65-90, 97-122
		let i = 97
		"let i = 65
		while i < 123
			"if i == 91
			"	let i = 97
			"endif
			" erstes freies suchen...
			let m = nr2char(i)
			let ml = line("'" . m)
			if(ml == 0)
				let freemark = m
				let foundfree = 1
				let i = 130
			endif
			
			let i = i + 1
		endwhile

		if (foundfree)
			"echo "NEWMARK: '" . freemark . "'"
			execute "normal m" . freemark . "<CR>"
		endif
	endif

	"+++ Cream:
	" turn on bookmark indications if using this feature
	let b:Cream_ShowMarks_Enabled = 1
	" required to refresh
	call Cream_ShowMarks()
	"+++

	let &modified = mymodified

endfunction

" WOK: 2001-06-08
" simulates anonymous marks with named marks "a-z"
" removes all marks "a" - "z"
function! Cream_WOK_mark_killall()
	let killmarks = ""
	let killflag = 0

	" ASCII A-Z, a-z == 65-90, 97-122
	let i = 97
	"let i = 65
	while i < 123
		"if i == 91
		"	let i = 97
		"endif
		let m = nr2char(i)
		let ml = line("'" . m)
		" ex. dieses Mark?
		if (ml != 0)
			let killmarks = killmarks . "m" . m
			let killflag = 1
		endif
		
		let i = i + 1
	endwhile

	if (killflag)
		" alte Mark(s) löschen
		"echo "KILL ALL MARKS IN FILE: '" . killmarks . "'"
		normal o
		execute "normal " . killmarks . "<CR>"
		normal dd
		normal 0
		normal k
	endif

	"+++ Cream:
	" turn on bookmark indications if using this feature
	let b:Cream_ShowMarks_Enabled = 1
	" required to refresh
	call Cream_ShowMarks()
	"+++

endfunction


