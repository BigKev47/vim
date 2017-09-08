"
" Filename: cream-lib-win-tab-buf.vim
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
" Window and buffer related functions
"
" We refer to windows in the following fashion:
"
"     +---+---+---+--------------+
"     |   |   |   |    :    :    |
"     |   |   |   |    :    :    |
"     |   |   |   |   Primary    |
"     | Specials  |    :    :    |
"     |   |   |   |    :    :    |
"     |   |   |   +--------------+
"     |   |   |   |              |
"     |   |   |   |     Help     |
"     |   |   |   |              |
"     +---+---+---+--------------+
"
" Note that Help is also considered a Special.
"

" Cream_nextwindow() {{{1
function! Cream_nextwindow()
" go to next valid window or tab (if multiple) or buffer (if not)

	" multiple windows: change windows
	if NumberOfWindows() > 1
		execute "wincmd w"
		" if unnamed, unmodified buffer, go to next if others exist
		if  Cream_buffer_isnewunmod() == 1
		\&& Cream_NumberOfBuffers("neither") > 0
			call Cream_TryAnotherBuffer()
		endif
	" single window: change tabs or buffers
	else
		" try tabs first
		if tabpagenr('$') > 1
			tabnext
			" if current is unnamed, unmodified buffer, go to next (Once!
			" If more than 1 exist, the user created one this session.)
			if bufname("%") == "" && &modified == 0
				tabnext
			endif
		else
			bnext
			" if current is unnamed, unmodified buffer, go to next (Once!
			" If more than 1 exist, the user created one this session.)
			if bufname("%") == "" && &modified == 0
				bnext
			endif
		endif

	endif

endfunction

" Cream_prevwindow() {{{1
function! Cream_prevwindow()
" go to next valid window or tab (if multiple) or buffer (if not)

	" multiple windows: change windows
	if NumberOfWindows() > 1
		execute "wincmd W"
		" if unnamed, unmodified buffer, go to next if others exist
		if  Cream_buffer_isnewunmod() == 1
		\&& Cream_NumberOfBuffers("neither") > 0
			call Cream_TryAnotherBuffer()
		endif
	" single window: change buffers
	else
		" try tabs first
		if tabpagenr('$') > 1
			tabprevious
			" if current is unnamed, unmodified buffer, go to next (Once!
			" If more than 1 exist, the user created one this session.)
			if bufname("%") == "" && &modified == 0
				tabprevious
			endif
		else
			bprevious
			" if current is unnamed, unmodified buffer, go to next (Once!
			" If more than 1 exist, the user created one this session.)
			if bufname("%") == "" && &modified == 0
				bprevious
			endif
		endif

	endif

endfunction

" Cream_buffer_edit() {{{1
function! Cream_buffer_edit(bufnum)
" test current window is not special (calendar, help) before edit
" a buffer in it. If it is, we try to switch to a "valid" window
" first.
" Arguments: buffer number to be edited

	" ignore specials
	call Cream_TryAnotherWindow()

	if exists("g:CREAM_TABPAGES") && g:CREAM_TABPAGES == 1
		" go to each tab, test if matches a:bufnum (assumes only one
		" buffer per tab)
		let tabcnt = tabpagenr("$")
		let i = 1
		while i <= tabcnt
			" quit if current
			if bufnr("%") == a:bufnum
				break
			endif
			tabnext
			let i = i + 1
		endwhile
	else
		execute "buffer " . a:bufnum
	endif

endfunction

" Cream_TryAnotherWindow() {{{1
function! Cream_TryAnotherWindow(...)
" try to go to another window if current is special
" optional agument "nonewmod" avoids unnamed modified too

	let trys = 0
	let attempts = Cream_NumberOfWindows("neither")
	while trys <= attempts
		let trys = trys + 1
		if  Cream_buffer_isspecial() == 1
		\|| Cream_buffer_isnewunmod() == 1
		\|| a:0 > 0 && a:1 == "nonewmod" && Cream_buffer_isnewmod() == 1
			call Cream_nextwindow()
			continue
		else
			" found a non-special buffer
			break
		endif
	endwhile

endfunction

" Cream_TryAnotherBuffer() {{{1
function! Cream_TryAnotherBuffer()
" go to another buffer (in same window) if current is special or new

	let trys = 0
	let attempts = Cream_buffer_isspecial("specialct") + Cream_NumberOfBuffers("new")
	while trys <= attempts
		let trys = trys + 1
		if  Cream_buffer_isspecial() == 1
		\|| Cream_buffer_isnewunmod() == 1
			bnext
			continue
		else
			" found a non-special buffer
			break
		endif
	endwhile

endfunction

" Cream_buffer_isspecial() {{{1
function! Cream_buffer_isspecial(...)
" returns 1 if "special" buffer, 0 if not argument is buffer number
" aguments:
"   empty == "%"
"   number = [bufnr]
"   "specialct" = number of special buffers

	" verify
	call Cream_buffer_nr()

	" use current if no buffer number passed
	if     a:0 == 0
		let mybufnr = b:cream_nr
	elseif a:1 == "specialct"
		return 6
	elseif a:1 == "tempbufname"
		return "_cream_temp_buffer_"
	else
		let mybufnr = a:1
	endif

	" true "special"
	if  bufname(mybufnr) == "_opsplorer"
	\|| bufname(mybufnr) == "__Calendar"
	\|| bufname(mybufnr) == "__Tag_List__"
	\|| bufname(mybufnr) == "-- EasyHtml --"
	" TODO: Only for old file explorer.	Removed since it has to poll
	" file/directory just to test (slow over long connection).
	"\|| isdirectory(bufname(mybufnr))
		return 1
	endif

	" help
	if Cream_buffer_ishelp(mybufnr) == 1
		return 1
	endif

	return 0
	
endfunction

" Cream_buffer_isnewunmod() {{{1
function! Cream_buffer_isnewunmod(...)
" returns 1 if new, unmodified buffer, 0 if not
" argument is buffer number

	" use current if no buffer number passed
	if a:0 == 0
		let mybufnr = bufnr("%")
	else
		let mybufnr = a:1
	endif

	if  bufname(mybufnr) == ""
	\&& getbufvar(mybufnr, "&modified") == 0
	\&& bufexists(mybufnr) == 1
		return 1
	" no earthly idea why this is here
	elseif bufexists(mybufnr) == 0
		return -1
	endif

	return 0

endfunction

" Cream_buffer_isnewmod() {{{1
function! Cream_buffer_isnewmod(...)
" returns 1 if new, unmodified buffer, 0 if not
" argument is buffer number

	" use current if no buffer number passed
	if a:0 == 0
		let mybufnr = bufnr("%")
	else
		let mybufnr = a:1
	endif

	if  bufname(mybufnr) == ""
	\&& getbufvar(mybufnr, "&modified") == 1
	\&& bufexists(mybufnr) == 1
		return 1
	elseif bufexists(mybufnr) == 0
		return -1
	endif

	return 0
	
endfunction

" Cream_buffer_ishelp() {{{1
function! Cream_buffer_ishelp(...)
" returns 1 if "help" buffer, 0 if not argument is buffer number
" aguments:
"   empty == "%"
"   number = [bufnr]

	" verify
	call Cream_buffer_nr()

	" use current if no buffer number passed
	if     a:0 == 0
		let mybufnr = b:cream_nr
	else
		let mybufnr = a:1
	endif

	if     bufexists(mybufnr) == 0
		return -1
	elseif getbufvar(mybufnr, "&buftype") == "help"
		return 1
	endif

	return 0
	
endfunction

" NumberOfBuffers() {{{1
function! NumberOfBuffers()
" return number of existing buffers
" *** This should be part of genutils--it's not Cream-specific ***

	let i = 0
	let j = 0
	while i < bufnr('$')
		let i = i + 1
		if bufexists(bufnr("%"))
			let j = j + 1
		endif
	endwhile
	return j

endfunction

" Cream_NumberOfWindows() {{{1
function! Cream_NumberOfWindows(filter)
" return the number of Cream windows (buffers currently open/shown)
" filtered per argument
" (see also NumberOfWindows() )

	let i = 1
	let j = 0

	if     a:filter == "special"
		while winbufnr(i) != -1
			if  Cream_buffer_isspecial(winbufnr(i)) == 1
				let j = j + 1
			endif
			let i = i + 1
		endwhile
	elseif a:filter == "nospecial"
		while winbufnr(i) != -1
			if  Cream_buffer_isspecial(winbufnr(i)) == 0
				let j = j + 1
			endif
			let i = i + 1
		endwhile
	elseif a:filter == "new"
		while winbufnr(i) != -1
			if  Cream_buffer_isnewunmod(winbufnr(i)) == 1
				let j = j + 1
			endif
			let i = i + 1
		endwhile
	elseif a:filter == "nonew"
		while winbufnr(i) != -1
			if  Cream_buffer_isnewunmod(winbufnr(i)) == 0
				let j = j + 1
			endif
			let i = i + 1
		endwhile
	elseif a:filter == "newmod"
		while i < bufnr('$')
			let i = i + 1
			if  Cream_buffer_isnewmod(winbufnr(i)) == 1
				let j = j + 1
			endif
		endwhile
	elseif a:filter == "newunmod"
		while i < bufnr('$')
			let i = i + 1
			if  Cream_buffer_isnewunmod(winbufnr(i)) == 1
				let j = j + 1
			endif
		endwhile
	elseif a:filter == "neither"
		while winbufnr(i) != -1
			" only count if isn't special
			if  Cream_buffer_isspecial(winbufnr(i)) == 0
			\&& Cream_buffer_isnewunmod(winbufnr(i)) == 0
				let j = j + 1
			endif
			let i = i + 1
		endwhile
	elseif a:filter == "all"
		while winbufnr(i) != -1
			let j = j + 1
			let i = i + 1
		endwhile
	else
		" bad argument
		let j = 0
	endif

	return j

endfunction

" Cream_NumberOfBuffers() {{{1
function! Cream_NumberOfBuffers(filter)
" return number of buffers filtered per argument

	let i = 0
	let j = 0

	if     a:filter == "special"
		while i < bufnr('$')
			let i = i + 1
			if  Cream_buffer_isspecial(i) == 1
				let j = j + 1
			endif
		endwhile
	elseif a:filter == "nospecial"
		while i < bufnr('$')
			let i = i + 1
			if Cream_buffer_isspecial(i) == 0
				let j = j + 1
			endif
		endwhile
	elseif a:filter == "new"
		while i < bufnr('$')
			let i = i + 1
			if  Cream_buffer_isnewunmod(i) == 1
				let j = j + 1
			endif
		endwhile
	elseif a:filter == "nonew"
		while winbufnr(i) != -1
			if  Cream_buffer_isnewunmod(i) == 0
				let j = j + 1
			endif
			let i = i + 1
		endwhile
	elseif a:filter == "newmod"
		while i < bufnr('$')
			let i = i + 1
			if  Cream_buffer_isnewmod(i) == 1
				let j = j + 1
			endif
		endwhile
	elseif a:filter == "newunmod"
		while i < bufnr('$')
			let i = i + 1
			if  Cream_buffer_isnewunmod(i) == 1
				let j = j + 1
			endif
		endwhile
	elseif a:filter == "neither"
		while i < bufnr('$')
			let i = i + 1
			if  Cream_buffer_isspecial(i) == 0
			\&& Cream_buffer_isnewunmod(i) == 0
				let j = j + 1
			endif
		endwhile
	elseif a:filter == "all"
		while i < bufnr('$')
			let i = i + 1
			if  bufnr(i) != -1
				let j = j + 1
			endif
		endwhile
	else
		" bad argument
		let j = 0
	endif

	return j

endfunction

" Cream_bwipeout() {{{1
function! Cream_bwipeout(...)
" handle special window/buffer conditions when closing current buffer
" *** File save verification must occur before here!! ***
" * Optional argument is buffer number to be removed
" * Window management here is laissez-faire. (Wrap functions
"   elsewhere.)
" * Buffer managment simply tries to not end in special or new

	if a:0 == 0
		let mybufnr = bufnr("%")
	else
		if bufexists(a:1) == 0
			call confirm(
				\ "Error: Buffer number passed to Cream_bwipeout() \n" .
				\ "       doesn't exist. No action taken.\n" .
				\ "\n", "&Ok", 1, "Info")
			return
		endif
		let mybufnr = a:1
	endif


	" no special buffers

	"......................................................................
	" current is single new--alone
	if  Cream_NumberOfBuffers("all") == 1
	\&& Cream_buffer_isnewunmod() == 1
		" do nothing
		return
	endif

	"......................................................................
	" no special buffers, just normal(s) (and possibly new ones)
	if Cream_NumberOfBuffers("special") == 0
		" simple close--Vim handles merging of existing windows
		execute "bwipeout! " . mybufnr
		call Cream_TryAnotherWindow()
		" setup remaining
		call Cream_window_setup()
		return
	endif

	" special buffer current (by definition, multiple windows)

	"......................................................................
	" current buffer is special
	if Cream_buffer_isspecial() == 1
		if bufname(mybufnr) == "__Calendar"
			" unset calendar environment
			if exists("g:CREAM_CALENDAR")
				unlet g:CREAM_CALENDAR
			endif
		endif

		" other special buffer conditions here...

		" go to next named window/buffer
		call Cream_nextwindow()
		" close special window/buffer w/out save
		execute "bwipeout! " . mybufnr
		" only try if we have at least one non-new/special (otherwise,
		" we could bounce into one of the specials we're trying to
		" manage!)
		if Cream_NumberOfWindows("neither") > 0
			call Cream_TryAnotherWindow()
		endif
		" setup remaining
		call Cream_window_setup()
		return

	endif

	" special buffer(s), none current

	"......................................................................
	" current is single new--adjacent to special(s)
	if  Cream_buffer_isnewunmod() == 1
	\&& Cream_NumberOfWindows("special") > 0
	\&& Cream_NumberOfBuffers("neither") == 0
		" do nothing
		return
	endif

	"......................................................................
	" current is single *not* new--adjacent to special(s)
	" (start new file in current window)
	" * Remember: we've already handled current buffer == special  above
	if  Cream_buffer_isnewunmod() == 0
	\&& Cream_NumberOfWindows("special") > 0
	\&& Cream_NumberOfBuffers("neither") == 1
		if Cream_NumberOfBuffers("new") == 0
			" start a new buffer in same window (":enew")
			call Cream_file_new()
		else
			" move to new buffer
			let i = 0
			while i < bufnr('$')
				if  Cream_buffer_isnewunmod(i) == 1
					execute "buffer " . i
					break
				endif
				let i = i + 1
			endwhile
		endif
		" then close old buffer
		execute "bwipeout! " . mybufnr
		"call Cream_TryAnotherWindow()
		" setup remaining
		call Cream_window_setup()
		return
	endif

	"......................................................................
	" multiple buffers, all windowed
	if Cream_NumberOfBuffers("all") <= Cream_NumberOfWindows("all")
		" let Vim manage windows
		execute "bwipeout! " . mybufnr
		call Cream_TryAnotherWindow()
		" setup remaining
		call Cream_window_setup()
		return
	endif

	"......................................................................
	" multiple buffers, some un-windowed
	if Cream_NumberOfBuffers("all") > Cream_NumberOfWindows("all")
		" place next unshown buffer in same window
		" iterate through buffers, check each if windowed
		let i = 1
		while i <= bufnr('$')
			" if buffer exists, isn't special, and isn't the
			" current buffer(!)
			if  bufexists(i) != 0
			\&& Cream_buffer_isspecial(i) == 0
			\&& Cream_buffer_isnewunmod(i) == 0
			\&& bufnr(i) != bufnr("%")
			" is hidden
			"\&& bufwinnr(i) == -1
				" edit it here
				execute "buffer " . i
				" then close old buffer
				execute "bwipeout! " . mybufnr
				" stop
				break
			endif
			let i = i + 1
		endwhile
		call Cream_TryAnotherWindow()
		" setup remaining
		call Cream_window_setup()
		return
	endif

"*** DEBUG:
call confirm(
	\ "Whoops! Unexpectedly dropped through Cream_bwipeout()!\n" .
	\ "(Window and buffer management didn't happen.)\n" .
	\ "\n", "&Ok", 1, "Info")
"***

endfunction

" Cream_buffers_delete_untitled() {{{1
function! Cream_buffers_delete_untitled()
" wipeout all unnamed, unmodified (Untitled) buffers

	" get out of any special (including Untitled)
	call Cream_TryAnotherBuffer()

	" remember
	let mybufnr = bufnr("%")
	let i = 0
	while i < bufnr('$')
		let i = i + 1
		if Cream_buffer_isnewunmod(i) == 1
			" ignore current buffer
			if i != mybufnr
				" delete
				execute "bwipeout! " . i
			endif
		endif
	endwhile
	" recall if wasn't deleted
	if exists("mybufnr")
		execute "buffer " . mybufnr
	endif
endfunction

" Cream_buffers_delete_special() {{{1
function! Cream_buffers_delete_special()
" wipeout special buffers

	"" not in a special
	"call Cream_TryAnotherBuffer()

	" remember
	let mybufnr = bufnr("%")
	let i = 0
	while i < bufnr('$')
		let i = i + 1
		if Cream_buffer_isspecial(i) == 1
			" forget current if untitled
			if mybufnr == i
				unlet mybufnr
			endif
			" delete
			execute "bwipeout! " . i
		endif
	endwhile
	" recall if wasn't deleted
	if exists("mybufnr")
		execute "buffer " . mybufnr
	endif
endfunction


" Cream_window_setup() {{{1
function! Cream_window_setup()
" general window management, called whenever something opened or closed

	" turn on equal settings, must be on to specify others(?!)
	let myequalalways = &equalalways
	set equalalways

	" get current window (could be special)
	let mybuf = bufnr("%")

	" manage tabs from here, too.
	if exists("g:CREAM_TABPAGES") && g:CREAM_TABPAGES == 1
		call Cream_tabpages_refresh()
	endif

	" go to a non-special window (temp, won't be changed below)
	call Cream_TryAnotherWindow()
	"" get current (temp) non-special window
	"let buftemp = bufnr("%")

	" arrange special windows
	call Cream_window_setup_special()

	" restore cursor to original buffer's window
	call MoveCursorToWindow(bufwinnr(mybuf))

	" restore equal split preference	
	let &equalalways = myequalalways

endfunction

" Cream_window_setup_special() {{{1
function! Cream_window_setup_special()
" set all "special" windows to pre-defined locations around a single
" primary (working) window.
" * Special windows are vertical, to the left (see order below)
" * Help window is horizontal below primary window
" * Primary window(s) remain untouched
"
" Strategy: Close everything but non-new/specials, then re-open them.

	call Cream_window_hide_specials()

	" parse through each buffer placing specials as found
	let bufnr = -1

	" help (do first so is below all normal windows if horizontal tile)
	let i = 1
	while i <= bufnr('$')
		if getbufvar(i, "&buftype") == "help"
			let bufnr = i
			" re-open in correct position/size
			execute "botright sbuffer " . bufnr
			if exists("g:cream_help_size")
				execute "resize " . g:cream_help_size
			else
				execute "resize " . 20
			endif
		endif
		let i = i + 1
	endwhile

	" easyhtml
	let bufnr = FindBufferForName("-- EasyHtml --")
	if bufnr != -1
		" re-open in correct position/size
		execute "topleft vertical sbuffer " . bufnr
		let mybuf1 = bufnr
		setlocal nowrap
		setlocal nonumber
	endif
	" taglist
	let bufnr = FindBufferForName("__Tag_List__")
	if bufnr != -1
		"" always split from the same window (our temp)
		"execute "call MoveCursorToWindow(bufwinnr(" . buftemp . "))"
		" re-open in correct position/size
		execute "topleft vertical sbuffer " . bufnr
		let mybuf2 = bufnr
		setlocal nowrap
		setlocal nonumber
	endif
	" calendar
	let bufnr = FindBufferForName("__Calendar")
	if bufnr != -1
		" re-open in correct position/size
		execute "topleft vertical sbuffer " . bufnr
		let mybuf3 = bufnr
		setlocal nowrap
		setlocal nonumber
	endif
	" explorer -- this is going to be obsolete, let's pass
	"
	" opsplorer
	let bufnr = FindBufferForName("_opsplorer")
	if bufnr != -1
		" re-open in correct position/size
		execute "topleft vertical sbuffer " . bufnr
		let mybuf4 = bufnr
		setlocal nowrap
		setlocal nonumber
	endif

	" resize (after all have been opened)
	if exists("mybuf4")
		call MoveCursorToWindow(bufwinnr(mybuf4))
		topleft vertical resize 25
	endif
	if exists("mybuf3")
		call MoveCursorToWindow(bufwinnr(mybuf3))
		topleft vertical resize 22
	endif
	if exists("mybuf2")
		call MoveCursorToWindow(bufwinnr(mybuf2))
		topleft vertical resize 30
	endif
	if exists("mybuf1")
		call MoveCursorToWindow(bufwinnr(mybuf1))
		topleft vertical resize 25
	endif

endfunction

" Cream_window_hide() {{{1
function! Cream_window_hide(bufnr)
" hide all windows matching bufnr
" argument: second (optional) is 1 if special, 0 if normal
" * cursor drop controled by Vim, wrapper should manage
" * buffer name is actually accepted, too, but a bad idea

	" turn off equal settings so special widths are retained
	let myequalalways = &equalalways
	set equalalways

	" no buffer by this number exists, but isn't help
	if bufexists(a:bufnr) == 0
	\&& Cream_buffer_ishelp(a:bufnr) != 1
		return
	endif
	" no window associated
	if bufwinnr(a:bufnr) == -1
		return
	endif

	" go to it's window
	call MoveCursorToWindow(bufwinnr(a:bufnr))

""*** DEBUG:
"let n = confirm(
"    \ "DEBUG:\n" .
"    \ "  a:bufnr           = \"" . a:bufnr . "\"\n" .
"    \ "  bufwinnr(a:bufnr) = \"" . bufwinnr(a:bufnr) . "\"\n" .
"    \ "  bufnr(\"%\")      = \"" . bufnr("%") . "\"\n" .
"    \ "  bufname(\"%\")    = \"" . bufname("%") . "\"\n" .
"    \ "\n", "&Ok\n&Cancel", 1, "Info")
"if n != 1
"    return
"endif
""***

	" hide if currently open
	hide

""*** DEBUG:
"let n = confirm(
"    \ "DEBUG: (post hide)\n" .
"    \ "  a:bufnr           = \"" . a:bufnr . "\"\n" .
"    \ "  bufwinnr(a:bufnr) = \"" . bufwinnr(a:bufnr) . "\"\n" .
"    \ "  bufnr(\"%\")      = \"" . bufnr("%") . "\"\n" .
"    \ "  bufname(\"%\")    = \"" . bufname("%") . "\"\n" .
"    \ "\n", "&Ok\n&Cancel", 1, "Info")
"if n != 1
"    return
"endif
""***

	" restore equal split preference
	let &equalalways = myequalalways

endfunction

" Cream_window_hide_specials() {{{1
function! Cream_window_hide_specials()
" hide all special windows

	let myct = bufnr("$")
	let i = 1
	while i <= myct
		if Cream_buffer_isspecial(i) == 1
			" hide
			call Cream_window_hide(i)
		endif
		let i = i + 1
	endwhile

endfunction

" Cream_window_setup_tile() {{{1
function! Cream_window_setup_tile(layout)
" set up non-special buffer windows in tile mode in the (current)
" primary pane
" * Argument is orientation: "vertical" or "horizontal"
" * Assumes the current pane is alone!
" * Assumes specials set elsewhere
" * Sorts according to buffer number

	" only do it if more than one non-special (solves div by 0
	" problem, too)
	let bufct = Cream_NumberOfBuffers("neither")
	if bufct <= 1
		return
	endif

	" get out of specials
	call Cream_TryAnotherWindow()
	" remember current buffer
	let mybufnr = bufnr("%")
	"*** TEST: if we leave them open, Vim will account for them in spacing decisions.
	" hide specials
	call Cream_window_hide_specials()
	"***
	" do not start with new unmod as current
	call Cream_TryAnotherBuffer()

	" make lowest non-special exposed buffer current *and only*
	let i = 1
	while i <= bufnr("$")
		" non-special, non-new, must exist in a window in case
		" other non-specials are hidden
		if  bufexists(i) > 0
		\&& Cream_buffer_isspecial(i) == 0
		\&& Cream_buffer_isnewunmod(i) == 0
		"*** don't understand why it has to be shown, we're changing
		"    it to an :only window anyway. ***
		"\&& bufwinnr(i) != -1
			execute "buffer " . i
			let startbufnr = i
			break
		endif
		let i = i + 1
	endwhile
	" couldn't find non-special buffer in a window
	if !exists("startbufnr")
		" equal to current
		let startbufnr = 0
	endif

	" make a single window
	only

	" capture environment
	let mysplitright = &splitright
	let mysplitbelow = &splitbelow
	" turn on equal settings
	let myequalalways = &equalalways
	set equalalways

	" split
	if     a:layout ==? "vertical"
		" split right
		set splitright
		set nosplitbelow
		" split primary window into equal portions
		" width equals primary win divided by no. of non-special bufs
		let mywidth = winwidth(0) / bufct
	elseif a:layout ==? "horizontal"
		" split below
		set nosplitright
		set splitbelow
		" split primary window into equal portions
		" height equals primary win divided by no. of non-special bufs
		let mywidth = winheight(0) / bufct
	endif

	" split off buffers, highest first
	let i = bufnr("$")
	while i > 0
		" non-special, non-new only
		if  bufexists(i) > 0
		\&& Cream_buffer_isspecial(i) == 0
		\&& Cream_buffer_isnewunmod(i) == 0
		\&& i != startbufnr
			if a:layout ==? "vertical"
				execute "topleft vertical sbuffer " . i
				execute mywidth . "wincmd \|"
			elseif a:layout ==? "horizontal"
				execute "botright sbuffer " . i
				execute mywidth . "wincmd _"
			endif
			" move back to original window
			call MoveCursorToWindow(bufwinnr(startbufnr))
		endif
		let i = i - 1
	endwhile

	" restore equal split preference
	let &equalalways = myequalalways
	" restore environment
	let &splitright = mysplitright
	let &splitbelow = mysplitbelow

	" arrange windows
	call Cream_window_setup()

	" go to the original window (could be special)
	call MoveCursorToWindow(bufwinnr(mybufnr))

endfunction

" Cream_window_setup_maximize() {{{1
function! Cream_window_setup_maximize()
" ":only" ruins specials setup... handle.

	" don't maximize specials
	if Cream_buffer_isspecial(bufnr("%"))
		call confirm(
			\ "Can't maximize a special window.\n" .
			\ "\n", "&Ok", 1, "Info")
		return
	endif

	" already maximized if only one non-special exists
	if Cream_NumberOfWindows("neither") == 1
		call confirm(
			\ "Can't maximize any further.\n" .
			\ "\n", "&Ok", 1, "Info")
		return
	endif

	" make only
	only

	" arrange specials
	call Cream_window_setup()

endfunction

" Cream_window_setup_minimize() {{{1
function! Cream_window_setup_minimize()
" ":hide" can ruin specials setup... handle.

	" don't minimize specials
	if Cream_buffer_isspecial(bufnr("%"))
		call confirm(
			\ "Can't minimize a special window.\n" .
			\ "\n", "&Ok", 1, "Info")
		return
	endif

	" already minimized if only one non-special exists
	if Cream_NumberOfWindows("nospecial") == 1
		call confirm(
			\ "Can't minimize the last window.\n" .
			\ "\n", "&Ok", 1, "Info")
		return
	endif

	" :hide
	hide

	" arrange specials
	call Cream_window_setup()

endfunction

"}}}1
" Window width/heights {{{1
function! Cream_window_equal()
	wincmd =
endfunction
function! Cream_window_height_max()
	wincmd _
endfunction
function! Cream_window_height_min()
	"wincmd 1_
	"execute 'normal z1<CR>'
	resize 1
endfunction
function! Cream_window_width_max()
	wincmd |
endfunction
function! Cream_window_width_min()
	wincmd 1|
endfunction
" }}}1
" Window splits {{{1
function! Cream_window_new_ver()
	vnew
endfunction
function! Cream_window_new_hor()
	new
endfunction

function! Cream_window_split_exist_ver()
	wincmd v
endfunction
function! Cream_window_split_exist_hor()
	wincmd s
endfunction

" 1}}}
" Tab pages 
" Cream_tabpages_init() {{{1
function! Cream_tabpages_init()
" Initialize tab state.

	" uninitialized (no tabs exist to manage)
	if !exists("g:CREAM_TABPAGES")
		let g:CREAM_TABPAGES = 0
	" convert multiple tabs to one
	elseif g:CREAM_TABPAGES == 0
		set guioptions-=e
		set showtabline=0
	" multiple could exist, convert to tabs
	elseif g:CREAM_TABPAGES == 1
		" set 1: avoid default titles on startup
		call Cream_tabpages_labels()
		set guioptions+=e
		set sessionoptions+=tabpages
		set showtabline=2
		" set 2: refresh tab line
		call Cream_tabpages_labels()

		if Cream_NumberOfBuffers("neither") > 0
			"""" get out of specials before refreshing
			"""call Cream_TryAnotherWindow()
			" don't tab untitled or special
			call Cream_buffers_delete_untitled()
			" TODO: manage these in the current tab, don't delete
			call Cream_buffers_delete_special()
		endif

	endif

endfunction

" Cream_tabpages_toggle() {{{1
function! Cream_tabpages_toggle()
" Turn the tab bar on and off.
	if exists("g:CREAM_TABPAGES")
		if g:CREAM_TABPAGES == 0
			let g:CREAM_TABPAGES = 1
			call Cream_tabpages_init()
		elseif g:CREAM_TABPAGES == 1
			let g:CREAM_TABPAGES = 0
			call Cream_tabpages_init()
		endif
	endif
	call Cream_menu_settings_preferences()
endfunction

" Cream_tabpages_labels() {{{1
function! Cream_tabpages_labels()
	set guitablabel=%{Cream_statusline_filename()}%{Cream_tabpages_filestate()}
endfunction

" Cream_tabpages_filestate() {{{1
function! Cream_tabpages_filestate()
" Return tab label file modified state.
" Note: Unlike similar function for statusline, this function ignores
"       everything but modified state.
	if &modified != 0
		return '*'
	else
		return ''
	endif
endfunction

" Cream_tabpages_refresh() {{{1
function! Cream_tabpages_refresh()
" ensure one buffer per tab and refresh titles

	" remember current buffer
	let mybuf = bufnr("%")

	" start fresh
	"" get out of any specials
	"call Cream_TryAnotherBuffer()
	" kill off non-memorable buffers now hidden
	call Cream_buffers_delete_untitled()
	" make sure we haven't deleted it already
	if !bufexists(mybuf)
		return
	endif

	" close all tabs but one (silence if we only have one)
	silent! tabonly!
	" make first tab the first buffer
	bfirst
	" open a new tab for each non-special buffer
	let i = bufnr("%")
	while i < bufnr('$')
		let i = i + 1
		if  Cream_buffer_isspecial(i) != 1
		\&& Cream_buffer_isnewunmod(i) != 1
		\&& bufexists(i)
			" Broken, cannot ":tabedit bufnr"
			"execute "tabedit " . bufname(i)
			" TODO: The next two lines create a bunch of 
			" hidden untitled buffers which we hack-fix following.
			tabedit
			execute "buffer " . i
		endif
	endwhile
	" kill off non-memorable buffers now hidden
	call Cream_buffers_delete_untitled()

	" restore current buffer
	call Cream_tab_goto(mybuf)

	" TODO: need window/tab/highlighting refresh?
	redraw!

endfunction

" Cream_tab_goto(bufnr) {{{1
function! Cream_tab_goto(bufnr)
" Make tab active that contains {buffer}.

	" skip if not turned on
	if !exists("g:CREAM_TABPAGES") || g:CREAM_TABPAGES == 0
		return
	endif

	let i = 1
	while i <= tabpagenr('$')
		" we match, stop
		if bufnr("%") == a:bufnr
			break
		endif
		tabnext
		let i = i + 1
	endwhile

endfunction

"""function! Cream_tabnr(bufnr)
"""" Return the tab number containing {bufnr}.
"""
"""    " TODO: cleanup: Is there anyway to do this without paging all the
"""    " tabs twice?!
"""
"""    " remember this buffer(tab)
"""    let mybufnr = bufnr("%")
"""    " go to bufnr
"""    call Cream_tab_goto(a:bufnr)
"""    " remember bufnr
"""    let bufnr = bufnr("%")
"""    " restore original tab
"""    call Cream_tab_goto(mybufnr)
"""    return bufnr
"""
"""endfunction

" Cream_tabs_focusgained() {{{1
function! Cream_tabs_focusgained()
" fix when buffer externally added to session

	if !exists("g:CREAM_FOCUS_BUFNR")
		return
	endif

	" quit if no new buffer (old and new the same)
	if g:CREAM_FOCUS_BUFNR == bufnr("%")
		return
	endif
	" one buffer per tab
	call Cream_window_setup()
	" put this new tab after the previous current tab
	execute "tabmove " . tabpagenr()

endfunction

" Cream_tabs_focuslost() {{{1
function! Cream_tabs_focuslost()
" remember current buffer when focus lost
	let g:CREAM_FOCUS_BUFNR = bufnr("%")
endfunction

" Cream_tab_move_left() {{{1
function! Cream_tab_move_left()
" Move the current tab one tab to the left in a circular fashion
" i.e. if the tab is already at the leftmost position, move it all
" the way over to the right again.
	if tabpagenr() == 1
		execute "tabmove " . tabpagenr("$")
	else
		execute "tabmove " . (tabpagenr()-2)
	endif
	
	" Re-sync the tabs with the file buffers
	call Cream_window_setup()
endfunction

" Cream_tab_move_right() {{{1
function! Cream_tab_move_right()
" Move the current tab one tab to the right in a circular fashion
" i.e. if the tab is already at the rightmost position, move it
" all the way over to the left again.
	if tabpagenr() == tabpagenr("$")
		tabmove 0
	else
		execute "tabmove " . tabpagenr()
	endif
	
	" Re-sync the tabs with the file buffers
	call Cream_window_setup()
endfunction

" Cream_tab_move_first() {{{1
function! Cream_tab_move_first()
" Make the current tab first (move it to the far left)
	" nothing if already there
	if tabpagenr() == 1
		return
	endif
	tabmove 0

	" Re-sync the tabs with the file buffers
	call Cream_window_setup()
endfunction

" Cream_tab_move_last() {{{1
function! Cream_tab_move_last()
" Make the current tab last (move it to the far right)
	" nothing if already there
	if tabpagenr() == tabpagenr("$")
		return
	endif
	tabmove

	" Re-sync the tabs with the file buffers
	call Cream_window_setup()
endfunction


" 1}}}
" vim:foldmethod=marker
