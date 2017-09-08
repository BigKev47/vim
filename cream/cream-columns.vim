"
" cream-columns.vim
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
" Updated: 2006-05-13 14:32:50EDT
" Source: (excerpted from the Cream project)
" Author: Steve Hall  [ digitect@mindspring.com ]
"
" Description:
" Intuitively type, delete and backspace in a vertical column.
"
" One of the many custom utilities and functions for gVim from the
" Cream project ( http://cream.sourceforge.net ), a configuration of
" Vim for those of us familiar with Apple or Windows software.
"
" Installation:
"
" Known Issues:
" * Undo doesn't always track position correctly
"
" Notes:
" * redraw! is required for any key that changes the background
"   (color). Unfortunately this includes shifted-motion keys, the very
"   keys we'd like to avoid having to clear and redraw the screen
"   after due to speed concerns.

function! Cream_columns()
" setup stuff before calling main motion/insert stuff

	" Hack: We can select the first column only when list is on. So we
	" provide ourselves two sets of &listchars:
	"   On:     Cream_listchars_init()
	"   Off:    Cream_listchars_col_init()

	" make invisible (use execute to maintain trailing char!)
	if &list == 0
		call Cream_listchars_col_init()
		" MUST proceed initial Visual-block mode start
		set list
		" save "column &list" setting (we won't touch global)
		let g:cream_list_col = 0
	else
		let g:cream_list_col = 1
	endif

	" position (stupid work around for <C-b> stuff at first column over tab)
	let mycol = virtcol('.')

	" start visual block mode
	execute "normal \<C-v>"
	" show initial position
	redraw!

	" set virtual column behavior
	" save existing state
	let myvirtualedit = &virtualedit
	" all motions/bs/del are always one character
	set virtualedit=all

	" motion/bs/del space according to characters selected
	"*** TODO: Broken:
	" * flakey on Backspace
	" * flakey when selecting multiple lines preceded with mixed tabs
	"   and spaces
	"set virtualedit=
	"***

	"*** TODO: broken--makes window pos jump
	"" save screen pos
	"" HACK: set guifont=* moves screen on WinXP
	"call Cream_screen_get()
	"
	"" change to column-specific font
	"call Cream_fontset_columns()
	"
	"" restore screen
	"" HACK: set guifont=* moves screen on WinXP
	"call Cream_screen_init()
	"***

	" avoid the flash
	" save existing state
	let myerrorbells = &errorbells
	set noerrorbells

	" clear popup menu
	silent! unmenu PopUp
	silent! unmenu! PopUp

	" main call
	call Cream_column_mode()

	" reset mouse menu
	call Cream_menu_popup()

	"*** TODO: broken
	"" restore font
	"call Cream_font_init()
	"" restore screen
	"" HACK: set guifont=* moves screen on WinXP
	"call Cream_screen_init()
	"***

	" restore listchars
	call Cream_listchars_init()
	" restore list state
	" Note: The user may have toggled on/off during col mode. We'll
	" restore global settings based on last col state.
	if     g:cream_list_col == 1
		set list
		let g:LIST = 1
	elseif g:cream_list_col == 0
		set nolist
		let g:LIST = 0
	endif
	unlet g:cream_list_col
	" restore virtualedit
	let &virtualedit = myvirtualedit
	" restore errorbells
	let &errorbells = myerrorbells

endfunction

function! Cream_listchars_col_init()
	execute 'set listchars=eol:\ ,tab:\ \ ,trail:\ ,extends:\ ,precedes:\ '
endfunction

function! Cream_column_mode()
" Motion, insert and delete stuff (visual block mode has already been
" entered)

	" total loops
	let i = 0
	let j = 0
	let s:lastevent = "nothing"
	while i >= 0

		let i = i + 1

		" get character
		let mychar = getchar()

""*** DEBUG:
"let n = confirm(
"    \ "DEBUG:\n" .
"    \ "         mychar   = \"" . mychar . "\"\n" .
"    \ " char2nr(mychar)  = \"" . char2nr(mychar) . "\"\n" .
"    \ " nr2char(mychar)  = \"" . nr2char(mychar) . "\"\n" .
"    \ "  strlen(mychar)  = \"" . strlen(mychar) . "\"\n" .
"    \ "\n", "&Ok\n&Cancel", 1, "Info")
"if n != 1
"    return
"endif
""***

		if exists("eattest")
			" <C-u>
			if mychar == 21
				" eat the rest
				call s:Cream_column_eatchar()
				normal gv

				" we can't yet recover from this error
				call s:Cream_column_backspace()
				" unselect (from select mode)
				normal vv
				redraw!
				break
			endif
		endif

		" ":" (loop if precursor to <C-u>)
		if mychar == 58
			let eattest = ":"
			call s:Cream_column_insert(mychar)
		endif

		" test character for motion/selection
		" <Esc> quit
		if      mychar == 27
			execute "normal " . mychar
			redraw!
			break

		" <Undo> (Ctrl+Z)
		elseif mychar == 26
		\||    mychar == "\<Undo>"
			execute "normal \<Esc>"
			normal u
			normal gv
			" backup a column to maintain insertion positions
			if s:lastevent == "insert"
				normal h
				normal o
				normal h
			elseif s:lastevent == "backspace"
				normal l
				normal o
				normal l
			endif

			redraw!

		" <C-c> (Copy)
		elseif  mychar == 3
		\ ||    mychar == "\<C-c>"
		\ || nr2char(mychar) == ""
			execute "normal \"+y<CR>"
			normal gv
			redraw!
			call confirm(
				\ "To paste this selection in columns, re-enter Column Mode first (Edit > Column Select).\n" .
				\ "\n", "&Ok", 1, "Info")

		" (alpha-numeric) or <Tab>, but not colon ":"
		elseif  mychar > 31
			\&& mychar < 127
			\&& mychar != 58
			\|| mychar == 9

			call s:Cream_column_insert(mychar)

		" <CR> (same as delete)
		elseif mychar == 13
			normal x
			break

		" <C-b> and <C-u> (menu calls)
		elseif  mychar == 15
		\ || nr2char(mychar) == ""

			" eat chars until <CR>
			call s:Cream_column_eatchar()

		" <Del>
		elseif char2nr(mychar[0]) == 128
		   \&& char2nr(mychar[1]) == 107
		   \&& char2nr(mychar[2]) == 68
		" Note:
		"
		"    elseif  mychar == "\<Del>"
		"    \ ||    mychar == 127
		"
		" The above fails, apparently due to case-sensitivity with
		" <Down> ("€kd") conflicting with <Del> ("€kD").

			" delete
			normal x
			normal gv

			" retract selection width to a single column
			let mycol = virtcol(".")
			normal o
			if virtcol(".") < mycol
				" negate left-to-right v. right-to-left selection
				" discrepancies
				let mycol = virtcol(".")
				normal o
			endif
			while virtcol(".") > mycol
				normal h
			endwhile

			let s:lastevent = "delete"

			redraw!

		" toggle &list
		elseif mychar == "\<F4>"
			" Note: List must stay on during column mode to
			" work around some Vim bugs. We'll just toggle
			" whether the characters show or not based on the
			" two sets of listchars we set at the top.

			if g:cream_list_col == 0
				call Cream_listchars_init()
				let g:cream_list_col = 1
				let g:LIST = 1
			else
				call Cream_listchars_col_init()
				let g:cream_list_col = 0
				let g:LIST = 0
			endif
			redraw!

		elseif  mychar == "\<Down>"
			\|| mychar == "\<Up>"
			\|| mychar == "\<PageUp>"
			\|| mychar == "\<PageDown>"
			" bail
			execute "normal " . mychar
			break

		elseif  mychar == "\<Left>"
			\|| mychar == "\<Right>"
			\|| mychar == "\<Home>"
			\|| mychar == "\<End>"
			" bail
			execute "normal " . mychar
			break

		elseif  mychar == "\<BS>"

			call s:Cream_column_backspace()
			let s:lastevent = "backspace"

		elseif  mychar == "\<S-Left>"
			\|| mychar == "\<S-Right>"
			\|| mychar == "\<S-Home>"
			\|| mychar == "\<S-End>"

			execute "normal " . mychar
			let s:lastevent = "motion"
			redraw!

		elseif  mychar == "\<LeftMouse>"
			\||     char2nr(mychar[0]) == 128
				\&& char2nr(mychar[1]) == 253
				\&& char2nr(mychar[2]) == 44
				\&& char2nr(mychar[3]) == 0
			execute "normal " . mychar

			redraw!
			break

		"""elseif  mychar == "\<RightMouse>"
		"""    \||     char2nr(mychar[0]) == 128
		"""        \&& char2nr(mychar[1]) == 253
		"""        \&& char2nr(mychar[2]) == 50
		"""        \&& char2nr(mychar[3]) == 0
		"""    \|| mychar == "\<MiddleMouse>"
		"""    \||     char2nr(mychar[0]) == 128
		"""        \&& char2nr(mychar[1]) == 253
		"""        \&& char2nr(mychar[2]) == 47
		"""        \&& char2nr(mychar[3]) == 0
		"""
		"""    call confirm(
		"""        \ "Right and Middle mouse buttons are not functional in column mode.\n" .
		"""        \ "\n", "&Ok", 1, "Info")
		"""    redraw!
		"""
		"""elseif  mychar == "\<S-RightMouse>"
		"""    \|| mychar == "\<M-S-RightMouse>"
		"""
		"""    call confirm(
		"""        \ "Sorry, S-RightMouse not handled in column mode yet!\n" .
				\ "\n", "&Ok", 1, "Info")

		" <C-x> (Cut)
		elseif  char2nr(mychar[0]) == 50
			\&& char2nr(mychar[1]) == 52
			execute "normal \"+x<CR>"

			redraw!
			
			call confirm(
				\ "To paste this selection in columns, re-enter Column Mode first (Edit > Column Select).\n" .
				\ "\n", "&Ok", 1, "Info")

			break

		" <C-p> (Paste)
		elseif  char2nr(mychar[0]) == 50
			\&& char2nr(mychar[1]) == 50
			execute "normal \"+p<CR>"

			redraw!
			break

		" other key (untrapped)
		else

			" just execute that key
			execute "normal " . mychar
			" forget backspace condition
			if exists("s:stop")
				unlet s:stop
			endif

			redraw!

		endif

	endwhile

	redraw!

endfunction

function! s:Cream_column_eatchar()
" eat input until a <CR> is reached

	" loop if menu called (on <C-b> discovered below)
	while !exists("finished")
		let mychar = getchar()
		" until <CR>
		if mychar == 13
			let finished = 1
			call confirm(
				\ "Sorry, menu items are not yet available during column mode.\n" .
				\ "\n", "&Ok", 1, "Info")
		endif
	endwhile

endfunction

function! s:Cream_column_insert(char)

	" retract selection width to a single column
	let mycol = virtcol(".")
	normal o
	if virtcol(".") < mycol
		" negate left-to-right v. right-to-left selection
		" discrepancies
		let mycol = virtcol(".")
		normal o
	endif
	while virtcol(".") > mycol
		normal h
	endwhile

	" forget backspace condition
	if exists("s:stop")
		unlet s:stop
	endif

	" insert character
	execute "normal I" . nr2char(a:char)
	" reselect and recover position
	normal gv
	normal l
	normal o
	normal l
	"normal o

	let s:lastevent = "insert"

	redraw!

endfunction

function! s:Cream_column_backspace()

	" at non-first columns, move left a column
	if virtcol(".") != 1
		normal h
		normal o
		normal h
		normal o
	endif

	" delete selection
	normal x
	" reselect
	normal gv

	" retract selection width to a single column
	let mycol = virtcol(".")
	normal o
	if virtcol(".") < mycol
		" negate left-to-right v. right-to-left selection
		" discrepancies
		let mycol = virtcol(".")
		normal o
	endif
	while virtcol(".") > mycol
		normal h
	endwhile
	redraw!

endfunction

" column mode font set/change
function! Cream_fontset_columns()
	let myos = Cream_getoscode()
	if exists("g:CREAM_FONT_COLUMNS_{myos}")
		" had a problem with guifont being set to * in an error.
		if g:CREAM_FONT_COLUMNS_{myos} != "*"
			let &guifont = g:CREAM_FONT_COLUMNS_{myos}
		endif
	else
		" Don't prompt to initialize font... use default.
		"call Cream_font_init()
	endif
endfunction

function! Cream_fontinit_columns()
	let mymsg = "" .
		\ "This font setting is specifically for column mode. We highly\n" .
		\ "recommend that you choose the same font as your regular font\n" .
		\ "with only a style variation such as \"italic.\""
	if has("gui_running") && has("dialog_gui")
		call confirm(mymsg, "&Ok", 1, "Info")
	else
		echo mymsg
	endif

	let myos = Cream_getoscode()

	" call dialog...
	set guifont=*
	" if still empty or a "*", user may have cancelled; do nothing
	if    &guifont == ""  && g:CREAM_FONT_COLUMNS_{myos} != "" ||
		\ &guifont == "*" && g:CREAM_FONT_COLUMNS_{myos} != ""
		" do nothing
	else
		let g:CREAM_FONT_COLUMNS_{myos} = &guifont
	endif
	" revert to main font if we're not in column mode
	let mymode = mode()
	if mymode != ""
		if exists("g:CREAM_FONT_{myos}")
			let &guifont = g:CREAM_FONT_{myos}
		endif
	endif
endfunction

