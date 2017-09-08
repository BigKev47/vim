"
" cream-menu-window-buffer.vim
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
" Source:
" o Origin: Extracted and modifified from the Vim 6.0 menu.vim
"   buffers.
" o 2002-08-28: Verified against Vim 6.1, no changes.
" o 2002-09-19: Removed all cruft and abandoned hope of ever
"   syncronizing with Vim's buffer menu again. (That's a good thing ;)


" wait with building the menu until after loading 'session' files.
" Makes startup faster.
let s:bmenu_wait = 1

" always reset
let g:bmenu_priority = '80.900'

" Truncate a long path to fit it in a menu item.
if !exists("g:bmenu_max_pathlen")
	let g:bmenu_max_pathlen = 35
endif

" BMShow() {{{1
function! BMShow(...)
" Create the buffer menu (delete an existing one first).

	let s:bmenu_wait = 1
	"let s:bmenu_short = 0
	let s:bmenu_count = 0
	" do not show actual buffer numbers, we don't care. Instead, number consecutively.
	let s:mynum = 0

	" remove the entire Window menu, restore, THEN add buffers
	silent! unmenu &Window
	silent! unmenu! &Window

	" replace existing window menu (non-buffer portion)
	call Cream_menu_window()

	" figure out how many buffers there are
	"" TODO: don't force short style, need to count and determine prior
	"let s:bmenu_short = 0
	" count from 1
	let buf = 1
	let i = 0
	while buf <= bufnr('$')
		"let buf = buf + 1
		let i = i + 1
		if  bufexists(buf)
		\&& !isdirectory(bufname(buf))
		\&& Cream_buffer_isspecial() == 0
		" allow unlisted to pass through so we can call it '(Untitled)' if modified
		"\&& buflisted(bufname(buf)) != 0
			let s:bmenu_count = s:bmenu_count + 1
			call s:BMFilename(bufname(buf), i)
			"call <SID>BMFilename(Cream_path_fullsystem(bufname(buf)), i)
		endif
		let buf = buf + 1
	endwhile
	"if s:bmenu_count <= &menuitems
	"    let s:bmenu_short = 0
	"endif
	let s:bmenu_wait = 0

	" TODO: moved to cream-autocmd 2006-02-14
	"augroup buffer_list
	"    autocmd!
	"    "autocmd BufCreate,BufFilePost * call <SID>BMAdd()
	"    " necessary to recount menu items and refresh indicated status
	"    "autocmd BufWinEnter * call BMShow()
	"    " TODO: why isn't this in cream-autocmd ?
	"    autocmd BufWinEnter,BufEnter,BufNew,WinEnter * call BMShow()
	"augroup END

endfunction

"" s:BMAdd() {{{1
"function! s:BMAdd()
"    if s:bmenu_wait == 0
"        " when adding too many buffers, redraw in short format
"        if  s:bmenu_count == &menuitems
"        "\ && s:bmenu_short == 0
"            call BMShow()
"        else
"            call s:BMFilename(expand("<afile>"), expand("<abuf>"))
"            let s:bmenu_count = s:bmenu_count + 1
"        endif
"    endif
"endfunction

" s:BMHash() {{{1
function! s:BMHash(name)
" Make name all upper case, so that chars are between 32 and 96
	let nm = substitute(a:name, ".*", '\U\0', "")
	if has("ebcdic")
		" HACK: Replace all non alphabetics with 'Z' just to make it work for now.
		let nm = substitute(nm, "[^A-Z]", 'Z', "g")
		let sp = char2nr('A') - 1
	else
		let sp = char2nr(' ')
	endif
	" convert first six chars into a number for sorting:
	return (char2nr(nm[0]) - sp) * 0x800000 + (char2nr(nm[1]) - sp) * 0x20000 + (char2nr(nm[2]) - sp) * 0x1000 + (char2nr(nm[3]) - sp) * 0x80 + (char2nr(nm[4]) - sp) * 0x20 + (char2nr(nm[5]) - sp)
endfunction

"" s:BMHash2() {{{1
"function! s:BMHash2(name)
"" list overload alphabetization scheme
"" * Only called if s:bmenu_short != 0
"
"    let nm = substitute(a:name, ".", '\L\0', "")
"    " Not exactly right for EBCDIC...
"    if nm[0] < 'a' || nm[0] > 'z'
"        return '&others.'
"    elseif nm[0] <= 'd'
"        return '&abcd.'
"    elseif nm[0] <= 'h'
"        return '&efgh.'
"    elseif nm[0] <= 'l'
"        return '&ijkl.'
"    elseif nm[0] <= 'p'
"        return '&mnop.'
"    elseif nm[0] <= 't'
"        return '&qrst.'
"    else
"        return '&u-z.'
"    endif
"endfunction

" s:BMFilename() {{{1
function! s:BMFilename(bufname, bufnum)
" insert a buffer name into the buffer menu

	" can't use "a:" arg in "if" statement for some reason
	let mybufname = a:bufname
	let mybufnum = a:bufnum

	" test if we want to list it
	if s:Cream_buffer_islistable(mybufname, mybufnum) == "0"
		return
	endif

	let munge = s:BMMunge(mybufname, mybufnum)
	let hash = s:BMHash(munge)

	" consecutively number buffers

	" indicate modified buffers
	if getbufvar(mybufnum, "&modified") == 1
		let mymod = "*"
	else
		let mymod = '\ \ '
	endif

	" indicate current buffer
	let curbufnr = bufnr("%")
	if has("win32")
		if curbufnr == mybufnum
			let mycurrent = nr2char(187)   " requires 2 spaces (in else) to balance
		else
			let mycurrent = '\ \ '
		endif
	elseif   &encoding == "latin1"
		\ || &encoding == "utf-8"
		if curbufnr == mybufnum
			let mycurrent = nr2char(187)   " requires 2 spaces (in else) to balance
		else
			let mycurrent = '\ \ '
		endif
	else
		if curbufnr == mybufnum
			let mycurrent = '>' 	       " requires 5 spaces (in else) to balance
		else
			let mycurrent = '\ \ '
		endif
	endif

	" if unnamed and modified, name '(Untitled)'
	if  munge == ""
	\&& getbufvar(mybufnum, "&modified") == 1
		let munge = '[untitled]'
	endif

	if munge != ""
		" use false count number, not actual buffer number
		let s:mynum = s:mynum + 1
		" put space before single digits (to align with two-digit numbers)
		if s:mynum < 10
			let mymenunum = mycurrent . '\ \ &' . s:mynum . mymod
		else
			let mymenunum = mycurrent . '' . s:mynum . mymod
		endif
		"if s:bmenu_short == 0
			let name = 'anoremenu <silent> ' . g:bmenu_priority . '.' . s:mynum . ' &Window.' . mymenunum . munge
		"else
		"    let name = 'anoremenu <silent> ' . g:bmenu_priority . '.' . s:mynum . ' &Window.' . mymenunum . s:BMHash2(munge) . munge
		"endif
		" add menu name to edit command, check not in special
		execute name . ' :call Cream_buffer_edit(' . mybufnum . ')<CR>'
	else
		" do nothing (don't add menu and don't increment)
	endif

	" set 'cpo' to include the <CR>
	let cpo_save = &cpo
	set cpo&vim

endfunction

" s:Cream_buffer_islistable() {{{1
function! s:Cream_buffer_islistable(bufname, bufnr)
" return 0 if we don't want to list the buffer name

	" TODO: Don't we have another function to do this?

	" can't use "a:" arg in "if" statement for some reason
	let myname = a:bufname
	let mynr = a:bufnr

	" ignore unlisted, unmodified buffer
	if !buflisted(bufname(myname))
	\&& getbufvar(mynr, "&modified") == 0
		return 0
	endif

	"" ignore help file
	"if getbufvar(bufname(myname), "&buftype") == "help"
	"    return 0
	"endif
	"
	"" OBSOLETE
	""" ignore if a directory (explorer)
	""if isdirectory(myname)
	""    return 0
	""endif
	"
	"" ignore opsplorer
	"let tempname = fnamemodify(myname, ":t")
	"if myname == "_opsplorer"
	"    return 0
	"endif
	"
	"" ignore calendar
	"if myname == "__Calendar"
	"    return 0
	"endif
	"
	"" ignore calendar
	"if myname == "__Tag_List__"
	"    return 0
	"endif
	"
	"" ignore calendar
	"if myname == "-- EasyHtml --"
	"    return 0
	"endif
	if Cream_buffer_isspecial(mynr)
		return 0
	endif

	return myname

endfunction

" s:BMMunge() {{{1
function! s:BMMunge(fname, bnum)
" Return menu item name for given buffer
	let name = a:fname
	if name == ''
		return ""
	else
		" TODO: why do this?
		" change to relative to home directory if possible
		let name = Cream_path_fullsystem(name)
		let name = fnamemodify(name, ':p:~')
	endif
	" get file name alone
	let name2 = fnamemodify(name, ':t')
	let name = name2 . "\t" . s:BMTruncName(fnamemodify(name,':h'))
	let name = escape(name, "\\. \t|")
	let name = substitute(name, "\n", "^@", "g")
	return name
endfunction

" s:BMTruncName() {{{1
function! s:BMTruncName(fname)
	let name = a:fname
	if g:bmenu_max_pathlen < 5
		let name = ""
	else
		let len = strlen(name)
		if len > g:bmenu_max_pathlen
			let amount = (g:bmenu_max_pathlen / 2) - 2
			let left = strpart(name, 0, amount)
			let amount = g:bmenu_max_pathlen - amount - 3
			let right = strpart(name, len - amount, amount)
			let name = left . '...' . right
		endif
	endif
	return name
endfunction

" 1}}}
" vim:foldmethod=marker
